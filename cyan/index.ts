import { GlobType, StartTemplateWithLambda } from '@atomicloud/cyan-sdk';

StartTemplateWithLambda(async (i, d) => {
  const desc = await i.text('Description', 'desc', 'Description of the helm chart');
  const platform = await i.text('Platform', 'platform', 'LPSM Service Tree Platform');
  const service = await i.text('Service', 'service', 'LPSM Service Tree Service');

  const files = [
    {
      root: 'templates/base',
      glob: '**/*.*',
      type: GlobType.Template,
      exclude: [],
    },
  ];

  const deployment = await i.confirm('Enable deployment (y/n)', 'atomi/helm/deployment');

  if (deployment) {
    files.push({
      root: 'templates/deployment',
      glob: '**/*.*',
      type: GlobType.Template,
      exclude: [],
    });
  }

  const vars = { platform, service, desc };
  return {
    processors: [
      {
        name: 'cyan/default',
        files: [
          {
            root: 'templates/base',
            glob: '**/*.*',
            type: GlobType.Template,
            exclude: [],
          },
        ],
        config: {
          vars,
          parser: {
            varSyntax: [['let___', '___']],
          },
        },
      },
    ],
    plugins: [],
  };
});
