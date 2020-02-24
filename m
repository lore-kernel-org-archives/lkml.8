Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F42CC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24F920732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgBXRWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:22:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgBXRVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:21:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6663218AC;
        Mon, 24 Feb 2020 17:21:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j6HPx-001AhG-SH; Mon, 24 Feb 2020 12:21:17 -0500
Message-Id: <20200224172117.740406645@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 12:20:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-linus][PATCH 12/15] bootconfig: Reject subkey and value on same parent key
References: <20200224172022.330525468@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Reject if a value node is mixed with subkey node on same
parent key node.

A value node can not co-exist with subkey node under some key
node, e.g.

key = value
key.subkey = another-value

This is not be allowed because bootconfig API is not designed
to handle such case.

Link: http://lkml.kernel.org/r/158220115232.26565.7792340045009731803.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/bootconfig.rst     |  7 +++++++
 lib/bootconfig.c                             | 16 ++++++++++++----
 tools/bootconfig/samples/bad-mixed-kv1.bconf |  3 +++
 tools/bootconfig/samples/bad-mixed-kv2.bconf |  3 +++
 4 files changed, 25 insertions(+), 4 deletions(-)
 create mode 100644 tools/bootconfig/samples/bad-mixed-kv1.bconf
 create mode 100644 tools/bootconfig/samples/bad-mixed-kv2.bconf

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 5e7609936507..dfeffa73dca3 100644
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
-- 
2.25.0


