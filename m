Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D01C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC5122BED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgHDU6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbgHDU6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:58:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3897322CF7;
        Tue,  4 Aug 2020 20:58:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1k340k-006HGY-7R; Tue, 04 Aug 2020 16:58:14 -0400
Message-ID: <20200804205814.061094876@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 04 Aug 2020 16:57:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 15/17] lib/bootconfig: Add override operator support
References: <20200804205743.419135730@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add the value override operator (":=") support to the bootconfig.

This value override operator will be useful for the bootloaders
which will only update the existing bootconfig according to the
bootloader boot options.

Without this override operator, the bootloader needs to parse
the existing bootconfig and update it. However, with this
assignment, it can just append the updated (partial) bootconfig
text at the tail of existing one without parsing it.
(Of course, it must update the size, checksum and magic,
 but that will be done easily)

Link: https://lkml.kernel.org/r/159482882954.126704.16209517125614438640.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/bootconfig.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 912ef4921398..a5f701161f6b 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -329,22 +329,30 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 
 /* XBC parse and tree build */
 
+static int __init xbc_init_node(struct xbc_node *node, char *data, u32 flag)
+{
+	unsigned long offset = data - xbc_data;
+
+	if (WARN_ON(offset >= XBC_DATA_MAX))
+		return -EINVAL;
+
+	node->data = (u16)offset | flag;
+	node->child = 0;
+	node->next = 0;
+
+	return 0;
+}
+
 static struct xbc_node * __init xbc_add_node(char *data, u32 flag)
 {
 	struct xbc_node *node;
-	unsigned long offset;
 
 	if (xbc_node_num == XBC_NODE_MAX)
 		return NULL;
 
 	node = &xbc_nodes[xbc_node_num++];
-	offset = data - xbc_data;
-	node->data = (u16)offset;
-	if (WARN_ON(offset >= XBC_DATA_MAX))
+	if (xbc_init_node(node, data, flag) < 0)
 		return NULL;
-	node->data |= flag;
-	node->child = 0;
-	node->next = 0;
 
 	return node;
 }
@@ -603,7 +611,9 @@ static int __init xbc_parse_kv(char **k, char *v, int op)
 	if (c < 0)
 		return c;
 
-	if (!xbc_add_sibling(v, XBC_VALUE))
+	if (op == ':' && child) {
+		xbc_init_node(child, v, XBC_VALUE);
+	} else if (!xbc_add_sibling(v, XBC_VALUE))
 		return -ENOMEM;
 
 	if (c == ',') {	/* Array */
@@ -787,7 +797,7 @@ int __init xbc_init(char *buf, const char **emsg, int *epos)
 
 	p = buf;
 	do {
-		q = strpbrk(p, "{}=+;\n#");
+		q = strpbrk(p, "{}=+;:\n#");
 		if (!q) {
 			p = skip_spaces(p);
 			if (*p != '\0')
@@ -798,9 +808,12 @@ int __init xbc_init(char *buf, const char **emsg, int *epos)
 		c = *q;
 		*q++ = '\0';
 		switch (c) {
+		case ':':
 		case '+':
 			if (*q++ != '=') {
-				ret = xbc_parse_error("Wrong '+' operator",
+				ret = xbc_parse_error(c == '+' ?
+						"Wrong '+' operator" :
+						"Wrong ':' operator",
 							q - 2);
 				break;
 			}
-- 
2.26.2


