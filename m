Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0E5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1796220658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594828940;
	bh=VtIMfIM/hkEfvdAqmgTSfG9XQPMenAU/Ls/4ox2Up1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QMtlkKUAvipNlNhz8be3d7msKmdajcuPK1700ZztZct13V0k4CYn7vJ9dOSjfpv2F
	 hV6qAMtDNaAvgsgvneul/eYb3uFf7CLmc7zS5otUzwSnOZOK/IywYu569HnVBzQkXt
	 dO1NVzw/rOs5YaW1A8E+PfnHpLyWs75adS92hq7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGOQCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgGOQAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:00:41 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B43632065E;
        Wed, 15 Jul 2020 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594828832;
        bh=VtIMfIM/hkEfvdAqmgTSfG9XQPMenAU/Ls/4ox2Up1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ONLYWEWfpJNrC+wtBiHRvkkohOCUEryo76ytpYsVZwpdJT6EU3AYv6HbW8YWHL1AM
         6Ab/Lpt09Kp95yXcdGB+YcM+z/IDdiMvibsWQaP87Slu1LvkJGbT6s2mxyWmfUFyNO
         miploGCXevEVwFfGpV7bqtSxa9u8+ih/1e5rITsg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alistair Delva <adelva@google.com>, mhiramat@kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] lib/bootconfig: Add override operator support
Date:   Thu, 16 Jul 2020 01:00:29 +0900
Message-Id: <159482882954.126704.16209517125614438640.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159482882056.126704.15508672095852220119.stgit@devnote2>
References: <159482882056.126704.15508672095852220119.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/bootconfig.c |   33 +++++++++++++++++++++++----------
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

