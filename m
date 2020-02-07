Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3802C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9674217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581085703;
	bh=iz5zV16s2f272NMQl/vxFhP8LUNRD+nowmnZoRO8tH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E/KbhSvoobTH+ARHkQ9Jg2Lj5uDZDozB8tQzt3xthEVhgvpXe4UcKsOzLLpJW3Fcr
	 i/doOLzRkXzViuvvk+US7a9FvH+aiNTUJ5iEuj2EKMFOAXPh1lYnlhKqHwmPmPGso+
	 GpuurF2Arnz+v1MdKdU1NZgTJ8Ulw1/DqcDD9dN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgBGO2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:28:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbgBGO2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 09:28:22 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B517E20838;
        Fri,  7 Feb 2020 14:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581085701;
        bh=iz5zV16s2f272NMQl/vxFhP8LUNRD+nowmnZoRO8tH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rRhzmwGWlJLiiyn3SYctnDpvf1n1/YzO+4nLbYz45iLAYGFlRJA1gwVVjUyXaTKXn
         OVTUa5bt56FKlc+PupZh1O4QtmULDt489rxXEQAsoK0aYbDn/egCgVgASn/7v1655c
         a+LUGKZiWG3zskmiW9aHT2EqK/3Giftwf+jh9noQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] bootconfig: Allocate xbc_nodes array dynamically
Date:   Fri,  7 Feb 2020 23:28:17 +0900
Message-Id: <158108569699.3187.6512834527603883707.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207221728.b79eecfe98b99bb4b2f4cc42@kernel.org>
References: <20200207221728.b79eecfe98b99bb4b2f4cc42@kernel.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce the large static array from kernel data, allocate
xbc_nodes array dynamically only if the kernel loads a
bootconfig.

Note that this also add dummy memblock.h for user-spacae
bootconfig tool.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/bootconfig.c                          |   15 ++++++++++++---
 tools/bootconfig/include/linux/memblock.h |   12 ++++++++++++
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

