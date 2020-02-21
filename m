Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF70C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2649520637
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273903;
	bh=LQpL70j41yHihpZBbpvoHeSzMS5MnRoF3jE4khH+cqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KvFxpHqTtqPTpfJbFIWwkqFExWIoEr7xQy8+j0dCunXMrMnUGKb4Hf4QTsq8lpeXH
	 ID4PVlJ3y10K6zBGTrgkKPRuriatz22JLemrIsxRFrzGmqvugFdCDTo6rcCa/BVWzk
	 q6MuuuNmXogwIJY1VQu3beB683nCqu8mLLIaCObk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbgBUINu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:13:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732447AbgBUINr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:13:47 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BEF72467A;
        Fri, 21 Feb 2020 08:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272826;
        bh=LQpL70j41yHihpZBbpvoHeSzMS5MnRoF3jE4khH+cqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mc4be+IPmDpTPUMR4nWhxD/txDc+qnnKilhsSJGH+14PGPIv9LKca/ReZGW7vB+Ph
         DTSQJtezspEvXjyL5nkzN248MHicuFy/Dl5ZPNA1XMr6SoN6YwuSIwXxLGf6qnGFrD
         vFn/AC+5b5GSYMKM3komguwv47rlz2Tkxoh7/+ak=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 1/2] bootconfig: Prohibit re-defining value on same key
Date:   Fri, 21 Feb 2020 17:13:42 +0900
Message-Id: <158227282199.12842.10110929876059658601.stgit@devnote2>
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

Currently, bootconfig adds new value on the existing key
to the tail of an array. But this looks a bit confusing
because admin can rewrite original value in same config
file easily.

This rejects following value re-definition.

  key = value1
  ...
  key = value2

You should rewrite value1 to value2 in this case.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/admin-guide/bootconfig.rst   |   11 ++++++++++-
 lib/bootconfig.c                           |   13 ++++++++-----
 tools/bootconfig/samples/bad-samekey.bconf |    6 ++++++
 3 files changed, 24 insertions(+), 6 deletions(-)
 create mode 100644 tools/bootconfig/samples/bad-samekey.bconf

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index dfeffa73dca3..9ee7650b7817 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -62,7 +62,16 @@ Or more shorter, written as following::
 In both styles, same key words are automatically merged when parsing it
 at boot time. So you can append similar trees or key-values.
 
-Note that a sub-key and a value can not co-exist under a parent key.
+Same-key Values
+---------------
+
+It is prohibited that two or more values or arraies share a same-key.
+For example,::
+
+ foo = bar, baz
+ foo = qux  # !ERROR! we can not re-define same key
+
+Also, a sub-key and a value can not co-exist under a parent key.
 For example, following config is NOT allowed.::
 
  foo = value1
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 54ac623ca781..2ef304db31f2 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -581,7 +581,7 @@ static int __init __xbc_parse_keys(char *k)
 static int __init xbc_parse_kv(char **k, char *v)
 {
 	struct xbc_node *prev_parent = last_parent;
-	struct xbc_node *node, *child;
+	struct xbc_node *child;
 	char *next;
 	int c, ret;
 
@@ -590,15 +590,18 @@ static int __init xbc_parse_kv(char **k, char *v)
 		return ret;
 
 	child = xbc_node_get_child(last_parent);
-	if (child && xbc_node_is_key(child))
-		return xbc_parse_error("Value is mixed with subkey", v);
+	if (child) {
+		if (xbc_node_is_key(child))
+			return xbc_parse_error("Value is mixed with subkey", v);
+		else
+			return xbc_parse_error("Value is redefined", v);
+	}
 
 	c = __xbc_parse_value(&v, &next);
 	if (c < 0)
 		return c;
 
-	node = xbc_add_sibling(v, XBC_VALUE);
-	if (!node)
+	if (!xbc_add_sibling(v, XBC_VALUE))
 		return -ENOMEM;
 
 	if (c == ',') {	/* Array */
diff --git a/tools/bootconfig/samples/bad-samekey.bconf b/tools/bootconfig/samples/bad-samekey.bconf
new file mode 100644
index 000000000000..e8d983a4563c
--- /dev/null
+++ b/tools/bootconfig/samples/bad-samekey.bconf
@@ -0,0 +1,6 @@
+# Same key value is not allowed
+key {
+	foo = value
+	bar = value2
+}
+key.foo = value

