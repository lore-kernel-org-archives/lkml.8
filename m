Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1DCC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015A52077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=national.shitposting.agency header.i=@national.shitposting.agency header.b="VL1t9syW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgDVUKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:10:47 -0400
Received: from mail.cock.li ([37.120.193.124]:36688 "EHLO mail.cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgDVUKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:10:46 -0400
Date:   Wed, 22 Apr 2020 22:10:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=national.shitposting.agency; s=mail; t=1587586243;
        bh=zotRwtlkRnjxrTqO4ZjJddMzOpEG/wCSIPY2YTo8VNY=;
        h=Date:From:To:Subject:From;
        b=VL1t9syWCukD0pAaaLxUbqU5SeozqoEK8msroPWu9GP3FEoDmtAdqTOiOFlnl102Q
         qAQHEgZOcgJCeZ34l54xQWX2QqnEveejDZEol7+HMCRyjj1k+gc9HNyxbXufs5tyrm
         fQ3EHdyZsvhvaJ0f/TnEQ8fCVsxlCxvjBDfFOAyQ5BG4M6TONa72VEleWrXHz8RZVF
         mE1DU/Nlo7Y0o2aCtSc7F/ey6lcRDxqlNeBydaNlFZj/xY4+JTx6el6JOs0ufxXmR1
         YQGVDY852Lg7nQObXkcirWkvimMcVb3doKsxZoPGlRy/y+c9Yt6juweOQmz6oWZbSf
         QHx4P1qTMubnw==
From:   zsugabubus <zsugabubus@national.shitposting.agency>
To:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH] scripts/prettify: add script to prettify code
Message-ID: <20200422201039.ghwdjwwmesiwnwts@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mix and mess of tabs and spaces are all around in the code. This script
is for here to correct those >1.5 million lines where code does not match
kernel coding style.

Usage of `prettify` is pretty simple: It expects a directory you would
like to prettify (default: .) then watch it go.

---
 scripts/prettify | 94 ++++++++++++++++++++++++++++++++++++++++++++++++
 scripts/retab    | 28 +++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100755 scripts/prettify
 create mode 100755 scripts/retab

diff --git a/scripts/prettify b/scripts/prettify
new file mode 100755
index 000000000..3c725ec5c
--- /dev/null
+++ b/scripts/prettify
@@ -0,0 +1,94 @@
+#!/usr/bin/sh -eu
+# SPDX-License-Identifier: GPL-3.0-or-later
+TREE=${1:-.}
+
+XARGS="xargs -rP $(nproc 2>/dev/null || echo 2) -n 5000"
+
+export RETAB_TABWIDTH=8
+
+# Using BEGIN and END we can easily filter which lines we want to retab.
+# However, we have to hack a little bit more to ignore characters from the
+# line, e.g. ones inside comments. These space characters, we do not
+# want to retab, are substituted with '\n' (an extremal character) at
+# the beginning and after retab finished they are substituted back.
+
+trap '
+echo >&2 warning: sed temporary files may remained.  Please remove them manually:
+find >&2 "$TREE" -name "sed*"
+' INT TERM
+
+true &&
+echo 'Pass: Enforce Coding Standards' &&
+find "$TREE" -type f -name '*.[ch]' \
+| $XARGS sed -i -E '
+# Trailing white.
+s/\s{1,}$//
+# Move # to the first column.
+s/^(\s{1,})#(\s*)/#\1\2/
+
+# Spacing around keywords.
+s/^(\s{1,}(if|else if|switch|for|while))\s*\(\s*/\1 (/
+s/(sizeof|typeof|alignof|__attribute__)\s*\(\s*/\1(/
+
+# Open bracket spacing.
+/^\s*(if|\}?\s*else if|switch|for|while) / s/\s*\)$/)/;
+/^\s*(if|\}?\s*else if|switch|for|while) / s/\s*\)\s*\{$/) {/;
+s/\}else/} else/
+
+# // -> /* */ comments.
+s/((^|\s*[a-z_]{1,}:|.*;)\s*)\/\/\s*(.*)$/\1\/* \3 *\//
+'
+
+# Converts the random sequence of spaces and tabs at the first lines of
+# #defines to tabs and only keeps spaces if needed for the alignment.
+# When people did not use tabs for indentation, at 7/8 of the cases, some
+# spaces will remain, because they put their code at non-tabstop column. Hurray!
+# Maybe it could be corrected in another pass that aligns whole blocks.
+true &&
+echo 'Pass: Retab #defines' &&
+export RETAB_BEGIN='/^#\s*define\s*[A-Za-z_]{1,}.*$/ {
+:right
+  s/((\/\*|\().*) /\1\n/g
+t right;' &&
+export RETAB_END='s/\n/ /g; }' &&
+find "$TREE" -type f -name '*.h' \
+| $XARGS ./retab
+
+# Convert space indentation to tab indentation.
+true &&
+echo 'Pass: Retab Indentations' &&
+export RETAB_BEGIN='/^[ \t]{2,}[^ \t*]/ {
+:loop;
+	s/^([ \t]*[^ ]{1,}) /\1\n/g;
+t loop;' &&
+export RETAB_END='s/\n/ /g; }' &&
+find "$TREE" -type f -name '*.[ch]' \
+| $XARGS ./retab
+
+# Someone people cannot fking count to 8... or more precisely to 1 tab, so they
+# hit space 6 or 7 times (randomly) to indent their codes. Note that these
+# partial tabs could not be converted to tabs in the previous passes.
+true &&
+echo 'Pass: ++Space -> Tab at Line Starts' &&
+find "$TREE" -type f -name '*.[ch]' \
+| $XARGS sed -i -E '
+:next
+# Skip fors spanning multiple lines.
+/^\s*for .*;$/ {
+	n; n; b next
+}
+
+# Repeat replace on current line.
+:rep
+	s/^(\t{,4}) {5,7}([_a-zA-Z{}]|\/\*)/\1\t\2/g
+t rep
+
+# Skip to the next statement.
+/^$|\*\/$|[){};]$/ { n; b next }
+:skip
+/[{};]$/! { n; b skip }
+'
+
+trap '' INT TERM
+
+echo 'Done.  :)'
diff --git a/scripts/retab b/scripts/retab
new file mode 100755
index 000000000..caf1cd58a
--- /dev/null
+++ b/scripts/retab
@@ -0,0 +1,28 @@
+#!/usr/bin/sh -eu
+# SPDX-License-Identifier: GPL-3.0-or-later
+# [ RETAB_TABWIDTH=8 ] sed "[ $RETAB_BEGIN ] { retab logic } [ $RETAB_END ]" [ FILE... ]
+
+: ${RETAB_TABWIDTH:=8}
+
+IFS=
+# An extremal character.
+marker=$(printf '\x01')
+
+exec sed --in-place -E "${RETAB_BEGIN:-}"'{
+	# Mark tabstops.
+	:tabstop
+		s/^(([^\t]{'"$RETAB_TABWIDTH"'}|.*\t)*[^\t]{'"$((RETAB_TABWIDTH-1))"'}) /\1'"$marker"'/
+	t tabstop
+
+  # Do replace space with a one-width tabulator if it would be the only change
+  # in that whitespace chunk.
+	s/([^ ])'"$marker"'([ \t]*[^ \t'"$marker"'])/\1 \2/g
+
+	# Place tabulators at tabstops.
+	s/ {,'"$((RETAB_TABWIDTH-1))"'}'"$marker"'/\t/g
+
+	# Remove needless space(s) before tabulators.
+	:spc
+		s/^(([^\t]{'"$RETAB_TABWIDTH"'}|.*\t)*[^\t]{,'"$((RETAB_TABWIDTH-2))"'}) \t/\1\t/g
+	t spc
+};'"${RETAB_END:-}" -- "$@"
-- 
2.26.1
