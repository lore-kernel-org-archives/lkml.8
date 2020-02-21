Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F6DC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EE120578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273892;
	bh=OIoyseCvG386GYkltNfjfT5UFZEk/Dn61NranP/rG/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eoEVWTRBHCmUIxid/Qho1AnLogDcc/nCSv7HCYrov5geyKSiSjmqvv7cBxtFoW38i
	 O/oGVy0w+5c7lcEL5bBpWARb8jpqBticNjXG8jdiBAPc+PXVnCFIfWkX5puMw5XMxu
	 gv3EyQOZeEb3xwACwRkTuT1K+/Dlj9RdeZwT3RWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbgBUIN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:13:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbgBUIN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:13:57 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF9824670;
        Fri, 21 Feb 2020 08:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272836;
        bh=OIoyseCvG386GYkltNfjfT5UFZEk/Dn61NranP/rG/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1cgdb7ZRZkAv0DbVScjybqwkHxrgpBNfiw5nE3UA0D8bB0nwkECuJ0TIHTwbpzp01
         NjQuSfMROTGwyob6Gsk52Vy3SqeDjmXSiR/OovSjEFNRKTw1ZjdVsPrcgWx76Ltn2M
         ElyWJHNLfe0KQuwEtVauJo7Q/PDnxHZxI/SRiI0U=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 2/2] bootconfig: Add append value operator support
Date:   Fri, 21 Feb 2020 17:13:52 +0900
Message-Id: <158227283195.12842.8310503105963275584.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158227281198.12842.8478910651170568606.stgit@devnote2>
References: <158227281198.12842.8478910651170568606.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add append value operator "+=" support to bootconfig syntax.
With this operator, user can add new value to the key as
an entry of array instead of overwriting.
For example,

  foo = bar
  ...
  foo += baz

Then the key "foo" has "bar" and "baz" values as an array.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 V3: update on value re-definition error patch.
---
 Documentation/admin-guide/bootconfig.rst |   10 +++++++++-
 lib/bootconfig.c                         |   15 +++++++++++----
 tools/bootconfig/test-bootconfig.sh      |   16 ++++++++++++++--
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 9ee7650b7817..82a657096ebc 100644
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

