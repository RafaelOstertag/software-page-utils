#!/bin/sh
#
# Create a fragment from a xhtml page by extracting the body using xsltproc.
# The script assumes its current working directory is the repository
# root.
#
# The output goes to stdout.

set -e
set -u

if [ $# -ne 2 ]
then
    echo "`basename $0` <XHTML> <PAGETITLE>" >&2
    exit 1
fi

xhtml_file=$1
pagetitle=$2
content=`xsltproc -nonet xslt/htmlbody.xslt "${xhtml_file}" | sed -e s/type=\"disc\"//g`

cat <<EOF
<?xml version="1.0" encoding="utf-8"?>
<fragment>
  <title>
    ${pagetitle}
  </title>
  <content>
    <![CDATA[
    <main class="container">
      <section class="mt-4">
	${content}
      </section>
    </main>
      ]]>
  </content>
</fragment>
EOF
exit 0
