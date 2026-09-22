const fs = require('fs');

describe('Application tests', () => {
  test('app.js exists', () => {
    expect(fs.existsSync('app.js')).toBe(true);
  });

  test('package.json exists', () => {
    expect(fs.existsSync('package.json')).toBe(true);
  });
});
