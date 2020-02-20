Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F190C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050BA24673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582183667;
	bh=g09eWAq+ZPGg1WTVfAAG0QWbptpBF9XSfGLKxydLU6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JXFBk18uLu5wchPitZz2ZUVCB6jJaCDAeB/9qhmOHi5141vXn/sZ0zaoVQW14drYI
	 I2of6ULz62uHgR7WwiHvbc7QhPSfxGLp72AFR1sM6WmWhxLpOPYVHEzDnwtq3Vyv4y
	 hPpyz50h6RL4mh8M1nXhfJCWZpK635UosfJFm0Ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgBTH1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:27:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgBTH1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:27:39 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE49624654;
        Thu, 20 Feb 2020 07:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582183658;
        bh=g09eWAq+ZPGg1WTVfAAG0QWbptpBF9XSfGLKxydLU6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=agKlFUTadqnj0pIo1+4ZezAda8JsGz7e8Yoak5Z5Gsmj0bnVnwcoRiFmdrNDoacFu
         KbN6iQ+4WZv97cYizLHUQXfkmRnkHhO1D5OIC7ft1MBV6qHsIZzaw+X8I2NcgW7jzR
         JWH4oPL/oV+mqDVkeHAglyELu6C+X3DfTPo0yKPU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 7/8] bootconfig: Add append value operator support
Date:   Thu, 20 Feb 2020 16:27:33 +0900
Message-Id: <158218365319.6940.463995421395321587.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158218358363.6940.18380270211351882136.stgit@devnote2>
References: <158218358363.6940.18380270211351882136.stgit@devnote2>
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
 Documentation/admin-guide/bootconfig.rst |    8 ++++++++
 lib/bootconfig.c                         |   14 ++++++++++----
 tools/bootconfig/test-bootconfig.sh      |   13 +++++++++++++
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 0c18e3f540e6..abe2432b8eec 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -74,6 +74,14 @@ For example,::
 In this case ``bar`` and ``baz`` is overwritten by ``qux``, and ``foo = qux``
 remains.
 
+If you want to append the value to existing key as an array member,
+you can use ``+=`` operator. For example::
+
+ foo = bar, baz
+ foo += qux
+
+In this case, the key ``foo`` has ``bar``, ``baz`` and ``qux``.
+
 Note that a sub-key and a value can not co-exist under a parent key.
 For example, following config is NOT allowed.::
 
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 9a094162ea3e..4afc768489cd 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -586,7 +586,7 @@ static void xbc_node_overwrite(struct xbc_node *node, char *v)
 	node->next = 0;
 }
 
-static int __init xbc_parse_kv(char **k, char *v)
+static int __init xbc_parse_kv(char **k, char *v, int op)
 {
 	struct xbc_node *prev_parent = last_parent;
 	struct xbc_node *child;
@@ -605,7 +605,7 @@ static int __init xbc_parse_kv(char **k, char *v)
 	if (c < 0)
 		return c;
 
-	if (!child) {
+	if (op == '+' || !child) {
 		if (!xbc_add_sibling(v, XBC_VALUE))
 			return -ENOMEM;
 	} else
@@ -781,7 +781,7 @@ int __init xbc_init(char *buf)
 
 	p = buf;
 	do {
-		q = strpbrk(p, "{}=;\n#");
+		q = strpbrk(p, "{}=+;\n#");
 		if (!q) {
 			p = skip_spaces(p);
 			if (*p != '\0')
@@ -792,8 +792,14 @@ int __init xbc_init(char *buf)
 		c = *q;
 		*q++ = '\0';
 		switch (c) {
+		case '+':
+			if (*q++ != '=') {
+				ret = xbc_parse_error("Wrong + operator", q - 2);
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
index f6948790c693..04f65548ca1e 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -108,6 +108,19 @@ xfail grep -q "bar" $OUTFILE
 xfail grep -q "baz" $OUTFILE
 xpass grep -q "qux" $OUTFILE
 
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

