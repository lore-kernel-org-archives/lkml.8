Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90440C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638BC24673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582201159;
	bh=85lQHUpjZh6+SeIsl6ntkgQfMW1eJY7MisoqWGvUHDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WTrqC6M5jcBS9dNGDef1uLy+ubd+Wg4Y3OKE9sSx1aKg5GE38gHOLp0qrHorAJ/az
	 OGECfTwmVdYdBGkyZ2ZcWhCqZdHvAJTHIlIdTFwR0q19u7cxjMeoQqAGo6JPYbtaYS
	 mk1xkLKDSwTxwzcKxdT1wV/PFp47ie+qniH0GkMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgBTMTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:19:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgBTMTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:19:17 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1846D207FD;
        Thu, 20 Feb 2020 12:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582201157;
        bh=85lQHUpjZh6+SeIsl6ntkgQfMW1eJY7MisoqWGvUHDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxgYpuqH8ad80rY13wXS23qUwX7VJidhNYZ+4fXD09tcHp60LKGJBMg7JFbCw8PpB
         JnI1m9Z0nxkyC5ZTQoSYPyiUFDQjjOVVq3air5KBxSOTlHXALLYq7GVLLDm2CK5EY6
         t08xN/6XYeEpKSTzyxgOvImn4v1TNT752KdjG4sU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 5/8] bootconfig: Reject subkey and value on same parent key
Date:   Thu, 20 Feb 2020 21:19:12 +0900
Message-Id: <158220115232.26565.7792340045009731803.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158220110257.26565.4812934676257459744.stgit@devnote2>
References: <158220110257.26565.4812934676257459744.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reject if a value node is mixed with subkey node on same
parent key node.

A value node can not co-exist with subkey node under some key
node, e.g.

key = value
key.subkey = another-value

This is not be allowed because bootconfig API is not designed
to handle such case.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/admin-guide/bootconfig.rst     |    7 +++++++
 lib/bootconfig.c                             |   16 ++++++++++++----
 tools/bootconfig/samples/bad-mixed-kv1.bconf |    3 +++
 tools/bootconfig/samples/bad-mixed-kv2.bconf |    3 +++
 4 files changed, 25 insertions(+), 4 deletions(-)
 create mode 100644 tools/bootconfig/samples/bad-mixed-kv1.bconf
 create mode 100644 tools/bootconfig/samples/bad-mixed-kv2.bconf

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 48675052c963..4a106584eb21 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -62,6 +62,13 @@ Or more shorter, written as following::
 In both styles, same key words are automatically merged when parsing it
 at boot time. So you can append similar trees or key-values.
 
+Note that a sub-key and a value can not co-exist under a parent key.
+For example, following config is NOT allowed.::
+
+ foo = value1
+ foo.bar = value2 # !ERROR! subkey "bar" and value "value1" can NOT co-exist
+
+
 Comments
 --------
 
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 3ea601a2eba5..54ac623ca781 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -533,7 +533,7 @@ struct xbc_node *find_match_node(struct xbc_node *node, char *k)
 
 static int __init __xbc_add_key(char *k)
 {
-	struct xbc_node *node;
+	struct xbc_node *node, *child;
 
 	if (!xbc_valid_keyword(k))
 		return xbc_parse_error("Invalid keyword", k);
@@ -543,8 +543,12 @@ static int __init __xbc_add_key(char *k)
 
 	if (!last_parent)	/* the first level */
 		node = find_match_node(xbc_nodes, k);
-	else
-		node = find_match_node(xbc_node_get_child(last_parent), k);
+	else {
+		child = xbc_node_get_child(last_parent);
+		if (child && xbc_node_is_value(child))
+			return xbc_parse_error("Subkey is mixed with value", k);
+		node = find_match_node(child, k);
+	}
 
 	if (node)
 		last_parent = node;
@@ -577,7 +581,7 @@ static int __init __xbc_parse_keys(char *k)
 static int __init xbc_parse_kv(char **k, char *v)
 {
 	struct xbc_node *prev_parent = last_parent;
-	struct xbc_node *node;
+	struct xbc_node *node, *child;
 	char *next;
 	int c, ret;
 
@@ -585,6 +589,10 @@ static int __init xbc_parse_kv(char **k, char *v)
 	if (ret)
 		return ret;
 
+	child = xbc_node_get_child(last_parent);
+	if (child && xbc_node_is_key(child))
+		return xbc_parse_error("Value is mixed with subkey", v);
+
 	c = __xbc_parse_value(&v, &next);
 	if (c < 0)
 		return c;
diff --git a/tools/bootconfig/samples/bad-mixed-kv1.bconf b/tools/bootconfig/samples/bad-mixed-kv1.bconf
new file mode 100644
index 000000000000..1761547dd05c
--- /dev/null
+++ b/tools/bootconfig/samples/bad-mixed-kv1.bconf
@@ -0,0 +1,3 @@
+# value -> subkey pattern
+key = value
+key.subkey = another-value
diff --git a/tools/bootconfig/samples/bad-mixed-kv2.bconf b/tools/bootconfig/samples/bad-mixed-kv2.bconf
new file mode 100644
index 000000000000..6b32e0c3878c
--- /dev/null
+++ b/tools/bootconfig/samples/bad-mixed-kv2.bconf
@@ -0,0 +1,3 @@
+# subkey -> value pattern
+key.subkey = value
+key = another-value

