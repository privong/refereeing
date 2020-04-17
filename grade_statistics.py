#!/bin/env python
"""
Do some simple statistics for the scored proposals.
"""

import argparse
import glob
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns


def getargs():
    """
    Parse and return command line arguments
    """

    parser = argparse.ArgumentParser(description="Plot some statistics for \
proposal grades.")
    parser.add_argument('dir', default=None,
                        help='Directory containing grades.')
    parser.add_argument('-n', '--n-scores', default=1, type=int,
                        help='Number of score types to look for. One per \
line, starting at the beginning of the file.')
    parser.add_argument('-o', '--output', default='score_histograms.png',
                        help='Filename for figure.')

    return parser.parse_args()


def main():
    """
    do main things
    """

    args = getargs()

    gradefiles = glob.glob(args.dir + '/*.txt')

    scores = []
    scorenames = [None for x in range(args.n_scores)]

    for gradef in gradefiles:
        inf = open(gradef, 'r')

        thisscores = []
        for i in range(args.n_scores):
            line = inf.readline().rstrip('\n')
            if line[0] == '*':
                line = inf.readline().rstrip('\n')
            parts = line.split(': ')

            thisscores.append(float(parts[1]))

            if scorenames[i] is None:
                scorenames[i] = ''.join(parts[0].split(' '))

        scores.append(thisscores)

        inf.close()

    scores = np.array(scores)

    plo, ax = plt.subplots(1, 1)
    for i in range(args.n_scores):
        sns.distplot(scores[:, i],
                     kde=False,
                     rug=True,
                     bins=np.arange(1, 5.1, 0.2),
                     label=scorenames[i],
                     ax=ax)
    ax.legend(loc='upper left')
    ax.set_xlabel('Score')
    ax.set_ylabel('N')
    plo.savefig(args.output)


if __name__ == "__main__":
    main()
