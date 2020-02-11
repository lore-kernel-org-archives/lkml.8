Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CD6C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9FA208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgBKNuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:50:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgBKNt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:49:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26F8920848;
        Tue, 11 Feb 2020 13:49:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j1VvK-001apB-0O; Tue, 11 Feb 2020 08:49:58 -0500
Message-Id: <20200211134957.890212005@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 11 Feb 2020 08:49:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 1/5] bootconfig: Allocate xbc_nodes array dynamically
References: <20200211134941.229027482@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

To reduce the large static array from kernel data, allocate
xbc_nodes array dynamically only if the kernel loads a
bootconfig.

Note that this also add dummy memblock.h for user-spacae
bootconfig tool.

Link: http://lkml.kernel.org/r/158108569699.3187.6512834527603883707.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/bootconfig.c                          | 15 ++++++++++++---
 tools/bootconfig/include/linux/memblock.h | 12 ++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)
 create mode 100644 tools/bootconfig/include/linux/memblock.h

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index afb2e767e6fe..3ea601a2eba5 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -6,12 +6,13 @@
 
 #define pr_fmt(fmt)    "bootconfig: " fmt
 
+#include <linux/bootconfig.h>
 #include <linux/bug.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/memblock.h>
 #include <linux/printk.h>
-#include <linux/bootconfig.h>
 #include <linux/string.h>
 
 /*
@@ -23,7 +24,7 @@
  * node (for array).
  */
 
-static struct xbc_node xbc_nodes[XBC_NODE_MAX] __initdata;
+static struct xbc_node *xbc_nodes __initdata;
 static int xbc_node_num __initdata;
 static char *xbc_data __initdata;
 static size_t xbc_data_size __initdata;
@@ -719,7 +720,8 @@ void __init xbc_destroy_all(void)
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
-	memset(xbc_nodes, 0, sizeof(xbc_nodes));
+	memblock_free(__pa(xbc_nodes), sizeof(struct xbc_node) * XBC_NODE_MAX);
+	xbc_nodes = NULL;
 }
 
 /**
@@ -748,6 +750,13 @@ int __init xbc_init(char *buf)
 		return -ERANGE;
 	}
 
+	xbc_nodes = memblock_alloc(sizeof(struct xbc_node) * XBC_NODE_MAX,
+				   SMP_CACHE_BYTES);
+	if (!xbc_nodes) {
+		pr_err("Failed to allocate memory for bootconfig nodes.\n");
+		return -ENOMEM;
+	}
+	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
 	xbc_data = buf;
 	xbc_data_size = ret + 1;
 	last_parent = NULL;
diff --git a/tools/bootconfig/include/linux/memblock.h b/tools/bootconfig/include/linux/memblock.h
new file mode 100644
index 000000000000..7862f217d85d
--- /dev/null
+++ b/tools/bootconfig/include/linux/memblock.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _XBC_LINUX_MEMBLOCK_H
+#define _XBC_LINUX_MEMBLOCK_H
+
+#include <stdlib.h>
+
+#define __pa(addr)	(addr)
+#define SMP_CACHE_BYTES	0
+#define memblock_alloc(size, align)	malloc(size)
+#define memblock_free(paddr, size)	free(paddr)
+
+#endif
-- 
2.24.1


