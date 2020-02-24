Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C33C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6DB20732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgBXRWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:22:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbgBXRVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:21:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40EAD222C3;
        Mon, 24 Feb 2020 17:21:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j6HPy-001AiE-66; Mon, 24 Feb 2020 12:21:18 -0500
Message-Id: <20200224172118.055465343@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 12:20:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-linus][PATCH 14/15] bootconfig: Prohibit re-defining value on same key
References: <20200224172022.330525468@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Currently, bootconfig adds a new value on the existing key to the tail of an
array. But this looks a bit confusing because an admin can easily rewrite
the original value in the same config file.

This rejects the following value re-definition.

  key = value1
  ...
  key = value2

You should rewrite value1 to value2 in this case.

Link: http://lkml.kernel.org/r/158227282199.12842.10110929876059658601.stgit@devnote2

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
[ Fixed spelling of arraies to arrays ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/bootconfig.rst   | 11 ++++++++++-
 lib/bootconfig.c                           | 13 ++++++++-----
 tools/bootconfig/samples/bad-samekey.bconf |  6 ++++++
 3 files changed, 24 insertions(+), 6 deletions(-)
 create mode 100644 tools/bootconfig/samples/bad-samekey.bconf

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index dfeffa73dca3..57119fb69d36 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -62,7 +62,16 @@ Or more shorter, written as following::
 In both styles, same key words are automatically merged when parsing it
 at boot time. So you can append similar trees or key-values.
 
-Note that a sub-key and a value can not co-exist under a parent key.
+Same-key Values
+---------------
+
+It is prohibited that two or more values or arrays share a same-key.
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
-- 
2.25.0


