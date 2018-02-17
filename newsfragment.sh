#!/bin/sh
#
# Create a fragment from a software NEWS file using pandoc.
#
# The script assumes its current working directory is the repository
# root, and `work/tmp` already exists

set -e
set -u

if [ $# -ne 3 ]
then
    echo "`basename $0` <PAGETITLE> <NEWSFILE> <OUTPUTDIRECTORY>" >&2
    exit 1
fi

page_title=$1
news_file=$2
output_dir=$3

# The fragment below provides the section header, so we don't need the
# first line of the HTMLized NEWS file, which also happens to be a
# `<h1>`
content=`pandoc -t html5 "${news_file}" | sed -e 1d`
cat > "${output_dir}/news.xml" <<EOF
<?xml version="1.0" encoding="utf-8"?>
<fragment>
  <title>
    ${page_title}
  </title>
  <content>
    <![CDATA[
    <main class="container">
      <section>
        <header>
          <h1 class="mt-4">NEWS</h1>
        </header>
	${content}
      </section>
    </main>
      ]]>
  </content>
</fragment>
EOF
exit 0
