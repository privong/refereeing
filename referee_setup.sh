#!/bin/bash
#
# referee_setup.sh
#
# Set up a directory of PDFs for peer review.
#
# Copyright 2017 George C. Privon
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


mkdir grades
mkdir finished
for i in $(ls *.pdf); do
    touch grades/$i.txt
done
rename .pdf.txt .txt grades/*.txt
for i in $(ls grades/*.txt); do
    printf "Score:\n\nStrengths:\n\n\n\nWeaknesses:\n\n\n\nOverall Evaluation:\n\n\n" > $i
done
