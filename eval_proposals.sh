#!/bin/bash
#
# eval_proposals.sh
#
# Load pdf files and open the evaluation text files for matched proposals.
#
# Copyright 2019 George C. Privon
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

PDFREADER='zathura'

for i in $(ls *.pdf); do
    $PDFREADER $i &
    vim "grades/${i/pdf/txt}"
    echo -n "Review of ${i/pdf/} finished? (y/n)"
    read -n 1 finished
    if [ "$finished" == "y" ]
    then
        mv $i finished/
        echo ""
    fi
done
