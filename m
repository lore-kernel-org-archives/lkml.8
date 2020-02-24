Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15568C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8ABC21775
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBXRVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:21:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgBXRVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:21:20 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C4B2467E;
        Mon, 24 Feb 2020 17:21:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j6HPy-001Aii-BE; Mon, 24 Feb 2020 12:21:18 -0500
Message-Id: <20200224172118.216494360@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 12:20:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-linus][PATCH 15/15] bootconfig: Add append value operator support
References: <20200224172022.330525468@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add append value operator "+=" support to bootconfig syntax.
With this operator, user can add new value to the key as
an entry of array instead of overwriting.
For example,

  foo = bar
  ...
  foo += baz

Then the key "foo" has "bar" and "baz" values as an array.

Link: http://lkml.kernel.org/r/158227283195.12842.8310503105963275584.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/bootconfig.rst | 10 +++++++++-
 lib/bootconfig.c                         | 15 +++++++++++----
 tools/bootconfig/test-bootconfig.sh      | 16 ++++++++++++++--
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 57119fb69d36..cf2edcd09183 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -71,7 +71,15 @@ For example,::
  foo = bar, baz
  foo = qux  # !ERROR! we can not re-define same key
 
-Also, a sub-key and a value can not co-exist under a parent key.
+If you want to append the value to existing key as an array member,
+you can use ``+=`` operator. For example::
+
+ foo = bar, baz
+ foo += qux
+
+In this case, the key ``foo`` has ``bar``, ``baz`` and ``qux``.
+
+However, a sub-key and a value can not co-exist under a parent key.
 For example, following config is NOT allowed.::
 
  foo = value1
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 2ef304db31f2..ec3ce7fd299f 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -578,7 +578,7 @@ static int __init __xbc_parse_keys(char *k)
 	return __xbc_add_key(k);
 }
 
-static int __init xbc_parse_kv(char **k, char *v)
+static int __init xbc_parse_kv(char **k, char *v, int op)
 {
 	struct xbc_node *prev_parent = last_parent;
 	struct xbc_node *child;
@@ -593,7 +593,7 @@ static int __init xbc_parse_kv(char **k, char *v)
 	if (child) {
 		if (xbc_node_is_key(child))
 			return xbc_parse_error("Value is mixed with subkey", v);
-		else
+		else if (op == '=')
 			return xbc_parse_error("Value is redefined", v);
 	}
 
@@ -774,7 +774,7 @@ int __init xbc_init(char *buf)
 
 	p = buf;
 	do {
-		q = strpbrk(p, "{}=;\n#");
+		q = strpbrk(p, "{}=+;\n#");
 		if (!q) {
 			p = skip_spaces(p);
 			if (*p != '\0')
@@ -785,8 +785,15 @@ int __init xbc_init(char *buf)
 		c = *q;
 		*q++ = '\0';
 		switch (c) {
+		case '+':
+			if (*q++ != '=') {
+				ret = xbc_parse_error("Wrong '+' operator",
+							q - 2);
+				break;
+			}
+			/* Fall through */
 		case '=':
-			ret = xbc_parse_kv(&p, q);
+			ret = xbc_parse_kv(&p, q, c);
 			break;
 		case '{':
 			ret = xbc_open_brace(&p, q);
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index adafb7c50940..1411f4c3454f 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -9,7 +9,7 @@ TEMPCONF=`mktemp temp-XXXX.bconf`
 NG=0
 
 cleanup() {
-  rm -f $INITRD $TEMPCONF
+  rm -f $INITRD $TEMPCONF $OUTFILE
   exit $NG
 }
 
@@ -71,7 +71,6 @@ printf " \0\0\0 \0\0\0" >> $INITRD
 $BOOTCONF -a $TEMPCONF $INITRD > $OUTFILE 2>&1
 xfail grep -i "failed" $OUTFILE
 xfail grep -i "error" $OUTFILE
-rm $OUTFILE
 
 echo "Max node number check"
 
@@ -96,6 +95,19 @@ truncate -s 32764 $TEMPCONF
 echo "\"" >> $TEMPCONF	# add 2 bytes + terminal ('\"\n\0')
 xpass $BOOTCONF -a $TEMPCONF $INITRD
 
+echo "Adding same-key values"
+cat > $TEMPCONF << EOF
+key = bar, baz
+key += qux
+EOF
+echo > $INITRD
+
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF $INITRD > $OUTFILE
+xpass grep -q "bar" $OUTFILE
+xpass grep -q "baz" $OUTFILE
+xpass grep -q "qux" $OUTFILE
+
 echo "=== expected failure cases ==="
 for i in samples/bad-* ; do
   xfail $BOOTCONF -a $i $INITRD
-- 
2.25.0


