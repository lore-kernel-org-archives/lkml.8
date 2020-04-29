Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B5CC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752AC206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=narfindustries.com header.i=@narfindustries.com header.b="Q7TnTET0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgD2TeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2Td6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:33:58 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADED4C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:33:57 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id f5so1429971ual.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=narfindustries.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YLO12Ti3QjiQ/wVEEYbLej+NXubI0UXR6kgIxbnnIC8=;
        b=Q7TnTET0lUXmwi/gGwQVk1W63vKj8bzUEMfbV5GJ5W6P5lqoH82qI6OUOrAPdUGtvZ
         q3Bx2ib7zWv6PpyxiQAfvIObaKTm15JJVwPHtZz/JAS7e3BESnTopwRrfNv9gtZ1EUDy
         rLI/SvyXmwUotasVDHtQleV7meelDu1i8xJUxLQJpqQVFPw665gInaAlr6LAPpu03jgG
         3ACy234Wq4JOqTACLk1VTUOKH5cKKp5pcpJDgCR6aShtHbQ77nARWNlpbB69CYssjcw3
         WCUeX9ZXWkrjv80f4juBDhja59rP1S0mDd4RKOHqcCGfWv7CYpJ0IFiKxub4XOcRCb2w
         5YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YLO12Ti3QjiQ/wVEEYbLej+NXubI0UXR6kgIxbnnIC8=;
        b=ozy9vgudgcU01GbJi97CwvW5b9KKH9019BVQ0HvQxUo9eqDmXRjjRPL+wxKL38s5xF
         f1ykb6soItKD6/lJP96rUUy5ipvWt7rE2mGTzFLUdWd4x0/ICtNnq53/manfTRXVIaoA
         B1gA1WJhgqMcjtGDdnIxW/Izj5Exox58z/BG61LrJ7KddTBVJ8LQmDQX6fMZkd/W6oxA
         l18GrD1nqSOnbhITUDqPnTS5JSuGQEjSWTht3sqkUgqPHu9udPZ5cpYqtdAy+LFQT3UY
         osBe3o+lPZTdY8Aj6XA4sMCY/HXr7wt83qtFIWfyNN9OOlfvUzP9M/NMtRkPUXCVUMSY
         5ozg==
X-Gm-Message-State: AGi0PubajkumpfctrDPlmr41DqkquMWxQVF8gI4skSjVbIdQVRS1GmFp
        pRpEh3ATxbf/eqtN7rO1JQalEg==
X-Google-Smtp-Source: APiQypKmxl3NAMSWIa4Jn2yItUw5iU9cx3UaqDhKSK4hBonIPZ5cYzxWP+QLJGnk18S3rfBtZIb6Pg==
X-Received: by 2002:ab0:628:: with SMTP id f37mr12988053uaf.29.1588188836220;
        Wed, 29 Apr 2020 12:33:56 -0700 (PDT)
Received: from localhost.localdomain ([24.171.221.68])
        by smtp.gmail.com with ESMTPSA id k26sm76764uag.10.2020.04.29.12.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:33:55 -0700 (PDT)
From:   Javier Malave <javier.malave@narfindustries.com>
To:     bx@narfindustries.com
Cc:     Javier Malave <javier.malave@narfindustries.com>,
        linux-kernel@vger.kernel.org, ah@narfindustries.com
Subject: [RFC 5/9] Popcorn Utility
Date:   Wed, 29 Apr 2020 15:32:52 -0400
Message-Id: <13ff496d1a679147c5790437c8c1b1f0d5ed178e.1588127445.git.javier.malave@narfindustries.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1588127445.git.javier.malave@narfindustries.com>
References: <0>
 <cover.1588127445.git.javier.malave@narfindustries.com>
In-Reply-To: <cover.1588127445.git.javier.malave@narfindustries.com>
References: <cover.1588127445.git.javier.malave@narfindustries.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains utility and other
Popcorn supplementary modules, including
initialization routines.
---
 include/popcorn/bundle.h      |  38 ++++
 include/popcorn/debug.h       |  38 ++++
 include/popcorn/regset.h      |  96 +++++++++
 include/popcorn/stat.h        |  16 ++
 include/popcorn/types.h       |  20 ++
 kernel/popcorn/Makefile       |   7 +
 kernel/popcorn/bundle.c       | 115 +++++++++++
 kernel/popcorn/init.c         |  58 ++++++
 kernel/popcorn/stat.c         | 165 ++++++++++++++++
 kernel/popcorn/trace_events.h |  76 ++++++++
 kernel/popcorn/types.h        | 358 ++++++++++++++++++++++++++++++++++
 kernel/popcorn/util.c         | 121 ++++++++++++
 kernel/popcorn/util.h         |  14 ++
 kernel/popcorn/wait_station.c |  84 ++++++++
 kernel/popcorn/wait_station.h |  27 +++
 15 files changed, 1233 insertions(+)
 create mode 100644 include/popcorn/bundle.h
 create mode 100644 include/popcorn/debug.h
 create mode 100644 include/popcorn/regset.h
 create mode 100644 include/popcorn/stat.h
 create mode 100644 include/popcorn/types.h
 create mode 100644 kernel/popcorn/Makefile
 create mode 100644 kernel/popcorn/bundle.c
 create mode 100644 kernel/popcorn/init.c
 create mode 100644 kernel/popcorn/stat.c
 create mode 100644 kernel/popcorn/trace_events.h
 create mode 100644 kernel/popcorn/types.h
 create mode 100644 kernel/popcorn/util.c
 create mode 100644 kernel/popcorn/util.h
 create mode 100644 kernel/popcorn/wait_station.c
 create mode 100644 kernel/popcorn/wait_station.h

diff --git a/include/popcorn/bundle.h b/include/popcorn/bundle.h
new file mode 100644
index 000000000..280325e10
--- /dev/null
+++ b/include/popcorn/bundle.h
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0, 3-clause BSD
+#ifndef __POPCORN_RACK_H__
+#define __POPCORN_RACK_H__
+
+#define MAX_POPCORN_NODES 32
+#if (MAX_POPCORN_NODES > 62)
+#error Currently support up to 62 nodes
+#endif
+
+enum popcorn_arch {
+	POPCORN_ARCH_UNKNOWN = -1,
+	POPCORN_ARCH_X86 = 1,
+	POPCORN_ARCH_PPC = 2,
+	POPCORN_ARCH_MAX,
+};
+
+extern int my_nid;
+extern const enum popcorn_arch my_arch;
+
+bool get_popcorn_node_online(int nid);
+int get_popcorn_node_arch(int nid);
+int popcorn_nodes_init(void);
+void set_popcorn_node_online(int nid, bool online);
+void broadcast_my_node_info(int nr_nodes);
+
+struct popcorn_thread_status {
+	int current_nid;
+	int peer_nid;
+	pid_t peer_pid;
+};
+
+struct popcorn_node_info {
+	unsigned int status;
+	int arch;
+	int distance;
+};
+
+#endif
diff --git a/include/popcorn/debug.h b/include/popcorn/debug.h
new file mode 100644
index 000000000..4a12a7ba7
--- /dev/null
+++ b/include/popcorn/debug.h
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0, 3-clause BSD
+#ifndef __INCLUDE_POPCORN_DEBUG_H__
+#define __INCLUDE_POPCORN_DEBUG_H__
+
+#define PCNPRINTK(...) printk(KERN_INFO "popcorn: " __VA_ARGS__)
+#define PCNPRINTK_ERR(...) printk(KERN_ERR "popcorn: " __VA_ARGS__)
+
+#ifdef CONFIG_POPCORN_DEBUG
+#define PRINTK(...) printk(KERN_INFO __VA_ARGS__)
+#else
+#define PRINTK(...)
+#endif
+
+#ifdef CONFIG_POPCORN_DEBUG_PROCESS_SERVER
+#define PSPRINTK(...) printk(KERN_INFO __VA_ARGS__)
+#else
+#define PSPRINTK(...)
+#endif
+
+#ifdef CONFIG_POPCORN_DEBUG_VMA_SERVER
+#define VSPRINTK(...) printk(KERN_INFO __VA_ARGS__)
+#else
+#define VSPRINTK(...)
+#endif
+
+#ifdef CONFIG_POPCORN_DEBUG_PAGE_SERVER
+#define PGPRINTK(...) printk(KERN_INFO __VA_ARGS__)
+#else
+#define PGPRINTK(...)
+#endif
+
+#ifdef CONFIG_POPCORN_DEBUG_MSG_LAYER
+#define MSGPRINTK(...) printk(KERN_INFO __VA_ARGS__)
+#else
+#define MSGPRINTK(...)
+#endif
+
+#endif /*  __INCLUDE_POPCORN_DEBUG_H__ */
diff --git a/include/popcorn/regset.h b/include/popcorn/regset.h
new file mode 100644
index 000000000..c13c90525
--- /dev/null
+++ b/include/popcorn/regset.h
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0, 3-clause BSD
+/*
+ * /include/popcorn/regset.h
+ *
+ *  This file provides the architecture specific macro and structures of the
+ *  helper functionality implementation of the process server
+ *
+ * author, Sharath Kumar Bhat, SSRG, VirginiaTech 2014
+ *
+ */
+
+#ifndef PROCESS_SERVER_ARCH_MACROS_H_
+#define PROCESS_SERVER_ARCH_MACROS_H_
+
+#include <popcorn/bundle.h>
+
+struct regset_x86_64 {
+	/* Program counter/instruction pointer */
+	uint64_t rip;
+
+	/* General purpose registers */
+	uint64_t rax, rdx, rcx, rbx,
+			 rsi, rdi, rbp, rsp,
+			 r8, r9, r10, r11,
+			 r12, r13, r14, r15;
+
+	/* Multimedia-extension (MMX) registers */
+	uint64_t mmx[8];
+
+	/* Streaming SIMD Extension (SSE) registers */
+	unsigned __int128 xmm[16];
+
+	/* x87 floating point registers */
+	long double st[8];
+
+	/* Segment registers */
+	uint32_t cs, ss, ds, es, fs, gs;
+
+	/* Flag register */
+	uint64_t rflags;
+};
+
+struct regset_aarch64 {
+	/* Stack pointer & program counter */
+	uint64_t sp;
+	uint64_t pc;
+
+	/* General purpose registers */
+	uint64_t x[31];
+
+	/* FPU/SIMD registers */
+	unsigned __int128 v[32];
+};
+
+struct regset_powerpc {
+	unsigned long nip;
+	unsigned long msr;
+	unsigned long ctr;
+	unsigned long link;
+	unsigned long xer;
+	unsigned long ccr;
+
+	unsigned long gpr[32];
+	uint64_t fpr[32];
+
+	unsigned long orig_gpr3;	/* Used for restarting system calls */
+	unsigned long softe;		/* Soft enabled/disabled */
+};
+
+struct field_arch {
+	unsigned long tls;
+	unsigned long oob[4];
+	bool fpu_active;
+
+	union {
+		unsigned long regsets;
+		struct regset_x86_64 regs_x86;
+		struct regset_aarch64 regs_aarch;
+		struct regset_powerpc regs_ppc;
+	};
+};
+
+static inline size_t regset_size(int arch) {
+	const size_t sizes[] = {
+		sizeof(struct regset_aarch64),
+		sizeof(struct regset_x86_64),
+		sizeof(struct regset_powerpc),
+	};
+
+	if(arch <= POPCORN_ARCH_UNKNOWN || arch >= POPCORN_ARCH_MAX)
+		return -EINVAL;
+
+	return sizes[arch];
+}
+
+#endif
diff --git a/include/popcorn/stat.h b/include/popcorn/stat.h
new file mode 100644
index 000000000..cbd024314
--- /dev/null
+++ b/include/popcorn/stat.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0, 3-clause BSD
+#ifndef __KERNEL_POPCORN_STAT_H__
+#define __KERNEL_POPCORN_STAT_H__
+
+struct pcn_kmsg_message;
+
+void account_pcn_message_sent(struct pcn_kmsg_message *msg);
+void account_pcn_message_recv(struct pcn_kmsg_message *msg);
+
+void account_pcn_rdma_write(size_t size);
+void account_pcn_rdma_read(size_t size);
+
+#define POPCORN_STAT_FMT  "%12llu  %12llu  %s\n"
+#define POPCORN_STAT_FMT2 "%8llu.%03llu  %8llu.%03llu  %s\n"
+
+#endif /* KERNEL_POPCORN_STAT_H_ */
diff --git a/include/popcorn/types.h b/include/popcorn/types.h
new file mode 100644
index 000000000..aaab9d923
--- /dev/null
+++ b/include/popcorn/types.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0, 3-clause BSD
+#ifndef __INCLUDE_POPCORN_TYPES_H__
+#define __INCLUDE_POPCORN_TYPES_H__
+
+#include <linux/sched.h>
+
+static inline bool distributed_process(struct task_struct *tsk)
+{
+	if (!tsk->mm) return false;
+	return !!tsk->mm->remote;
+}
+
+static inline bool distributed_remote_process(struct task_struct *tsk)
+{
+	return distributed_process(tsk) && tsk->at_remote;
+}
+
+#include <popcorn/debug.h>
+
+#endif /* __INCLUDE_POPCORN_TYPES_H__ */
diff --git a/kernel/popcorn/Makefile b/kernel/popcorn/Makefile
new file mode 100644
index 000000000..6821ec217
--- /dev/null
+++ b/kernel/popcorn/Makefile
@@ -0,0 +1,7 @@
+obj-$(CONFIG_POPCORN)	+= init.o util.o
+obj-$(CONFIG_POPCORN)	+= wait_station.o
+obj-$(CONFIG_POPCORN)	+= process_server.o vma_server.o
+obj-$(CONFIG_POPCORN)	+= page_server.o fh_action.o
+obj-$(CONFIG_POPCORN)	+= bundle.o
+obj-$(CONFIG_POPCORN)	+= pcn_kmsg.o
+obj-$(CONFIG_POPCORN)	+= stat.o
diff --git a/kernel/popcorn/bundle.c b/kernel/popcorn/bundle.c
new file mode 100644
index 000000000..54ffb59e1
--- /dev/null
+++ b/kernel/popcorn/bundle.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+/*
+ * /kernel/popcorn/bundle.c
+ *
+ * Popcorn node init
+ *
+ * Original file developed by SSRG at Virginia Tech.
+ *
+ * author, Javier Malave, Rebecca Shapiro, Andrew Hughes,
+ * Narf Industries 2020 (modifications for upstream RFC)
+ */
+
+#include <asm/bug.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+
+#include <popcorn/pcn_kmsg.h>
+#include <popcorn/bundle.h>
+#include <popcorn/debug.h>
+#include "types.h"
+
+struct popcorn_node {
+	enum popcorn_arch arch;
+	int bundle_id;
+
+	bool is_connected;
+};
+
+static struct popcorn_node popcorn_nodes[MAX_POPCORN_NODES];
+
+bool get_popcorn_node_online(int nid)
+{
+	return popcorn_nodes[nid].is_connected;
+}
+EXPORT_SYMBOL(get_popcorn_node_online);
+
+void set_popcorn_node_online(int nid, bool online)
+{
+        popcorn_nodes[nid].is_connected = online;
+}
+EXPORT_SYMBOL(set_popcorn_node_online);
+
+int my_nid __read_mostly = -1;
+EXPORT_SYMBOL(my_nid);
+
+const enum popcorn_arch my_arch = POPCORN_ARCH_X86;
+EXPORT_SYMBOL(my_arch);
+
+int get_popcorn_node_arch(int nid)
+{
+	return popcorn_nodes[nid].arch;
+}
+EXPORT_SYMBOL(get_popcorn_node_arch);
+
+const char *archs_sz[] = {
+	"aarch64",
+	"x86_64",
+	"ppc64le",
+};
+
+void broadcast_my_node_info(int nr_nodes)
+{
+	int i;
+	node_info_t info = {
+		.nid = my_nid,
+		.arch = my_arch,
+	};
+	for (i = 0; i < nr_nodes; i++) {
+		if (i == my_nid)
+                        continue;
+		pcn_kmsg_send(PCN_KMSG_TYPE_NODE_INFO, i, &info, sizeof(info));
+	}
+}
+EXPORT_SYMBOL(broadcast_my_node_info);
+
+static bool my_node_info_printed = false;
+
+static int handle_node_info(struct pcn_kmsg_message *msg)
+{
+	node_info_t *info = (node_info_t *)msg;
+
+	if (my_nid != -1 && !my_node_info_printed) {
+		popcorn_nodes[my_nid].arch = my_arch;
+		my_node_info_printed = true;
+	}
+
+	PCNPRINTK("   %d joined, %s\n", info->nid, archs_sz[info->arch]);
+	popcorn_nodes[info->nid].arch = info->arch;
+	smp_mb();
+
+	pcn_kmsg_done(msg);
+	return 0;
+}
+
+int __init popcorn_nodes_init(void)
+{
+	int i;
+	BUG_ON(my_arch == POPCORN_ARCH_UNKNOWN);
+
+	for (i = 0; i < MAX_POPCORN_NODES; i++) {
+		struct popcorn_node *pn = popcorn_nodes + i;
+
+		pn->is_connected = false;
+		pn->arch = POPCORN_ARCH_UNKNOWN;
+		pn->bundle_id = -1;
+	}
+
+	REGISTER_KMSG_HANDLER(PCN_KMSG_TYPE_NODE_INFO, node_info);
+
+	return 0;
+}
diff --git a/kernel/popcorn/init.c b/kernel/popcorn/init.c
new file mode 100644
index 000000000..a0cc9796f
--- /dev/null
+++ b/kernel/popcorn/init.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+/*
+ * /kernel/popcorn/init.c
+ *
+ * Popcorn node init
+ *
+ * Copyright (c) 2013 - 2014 Akshay Giridhar
+ *
+ * author, Javier Malave, Rebecca Shapiro, Andrew Hughes,
+ * Narf Industries 2020 (modifications for upstream RFC)
+ * author, rewritten by Sang-Hoon Kim, 2016-2017
+ * author, modified by Antonio Barbalace, 2014
+ */
+
+#include <linux/kernel.h>
+#include <linux/workqueue.h>
+
+#include <popcorn/debug.h>
+#include "types.h"
+
+#define CREATE_TRACE_POINTS
+#include "trace_events.h"
+
+struct workqueue_struct *popcorn_wq;
+struct workqueue_struct *popcorn_ordered_wq;
+EXPORT_SYMBOL(popcorn_wq);
+EXPORT_SYMBOL(popcorn_ordered_wq);
+
+extern int pcn_kmsg_init(void);
+extern int popcorn_nodes_init(void);
+extern int process_server_init(void);
+extern int vma_server_init(void);
+extern int page_server_init(void);
+extern int statistics_init(void);
+
+static int __init popcorn_init(void)
+{
+	PRINTK("Initialize Popcorn subsystems...\n");
+
+	/*
+	 * Create work queues so that we can do bottom side
+	 * processing on data that was brought in by the
+	 * communications module interrupt handlers.
+	 */
+	popcorn_ordered_wq = create_singlethread_workqueue("pcn_wq_ordered");
+	popcorn_wq = alloc_workqueue("pcn_wq", WQ_MEM_RECLAIM, 0);
+
+	pcn_kmsg_init();
+
+	popcorn_nodes_init();
+	vma_server_init();
+	process_server_init();
+	page_server_init();
+
+	statistics_init();
+	return 0;
+}
+late_initcall(popcorn_init);
diff --git a/kernel/popcorn/stat.c b/kernel/popcorn/stat.c
new file mode 100644
index 000000000..55f05caf4
--- /dev/null
+++ b/kernel/popcorn/stat.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+/*
+ * /kernel/popcorn/stat.c
+ *
+ * Original file developed by SSRG at Virginia Tech.
+ *
+ * author , Javier Malave, Rebecca Shapiro, Andrew Hughes,
+ * Narf Industries 2020 (modifications for upstream RFC)
+ */
+
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/slab.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/percpu.h>
+#include <asm/uaccess.h>
+
+#include <popcorn/pcn_kmsg.h>
+#include <popcorn/stat.h>
+
+static unsigned long long sent_stats[PCN_KMSG_TYPE_MAX] = {0};
+static unsigned long long recv_stats[PCN_KMSG_TYPE_MAX] = {0};
+
+static DEFINE_PER_CPU(unsigned long long, bytes_sent) = 0;
+static DEFINE_PER_CPU(unsigned long long, bytes_recv) = 0;
+static DEFINE_PER_CPU(unsigned long long, bytes_rdma_written) = 0;
+static DEFINE_PER_CPU(unsigned long long, bytes_rdma_read) = 0;
+
+static unsigned long long last_bytes_sent = 0;
+static unsigned long long last_bytes_recv = 0;
+static unsigned long long last_bytes_rdma_written = 0;
+static unsigned long long last_bytes_rdma_read = 0;
+static ktime_t last_stat = 0;
+
+const char *pcn_kmsg_type_name[PCN_KMSG_TYPE_MAX] = {
+	[PCN_KMSG_TYPE_TASK_MIGRATE] = "migration",
+	[PCN_KMSG_TYPE_VMA_INFO_REQUEST] = "VMA info",
+	[PCN_KMSG_TYPE_VMA_OP_REQUEST] = "VMA op",
+	[PCN_KMSG_TYPE_REMOTE_PAGE_REQUEST] = "remote page",
+	[PCN_KMSG_TYPE_PAGE_INVALIDATE_REQUEST] = "invalidate",
+	[PCN_KMSG_TYPE_FUTEX_REQUEST] = "futex",
+};
+
+void account_pcn_message_sent(struct pcn_kmsg_message *msg)
+{
+	struct pcn_kmsg_hdr *h = (struct pcn_kmsg_hdr *)msg;
+	this_cpu_add(bytes_sent, h->size);
+}
+
+void account_pcn_message_recv(struct pcn_kmsg_message *msg)
+{
+	struct pcn_kmsg_hdr *h = (struct pcn_kmsg_hdr *)msg;
+	this_cpu_add(bytes_recv, h->size);
+}
+
+void account_pcn_rdma_write(size_t size)
+{
+	this_cpu_add(bytes_rdma_written, size);
+}
+
+void account_pcn_rdma_read(size_t size)
+{
+	this_cpu_add(bytes_rdma_read, size);
+}
+
+void fh_action_stat(struct seq_file *seq, void *);
+
+static int __show_stats(struct seq_file *seq, void *v)
+{
+	int i;
+	unsigned long long sent = 0;
+	unsigned long long recv = 0;
+	ktime_t now;
+	unsigned long long rate_sent, rate_recv;
+	unsigned long elapsed;
+
+	now = ktime_get_real();
+	elapsed = last_stat - now;
+	last_stat = now;
+
+	for_each_present_cpu(i) {
+		sent += per_cpu(bytes_sent, i);
+		recv += per_cpu(bytes_recv, i);
+	}
+	seq_printf(seq, POPCORN_STAT_FMT, sent, recv, "Total network I/O");
+
+	rate_sent = (sent - last_bytes_sent);
+	rate_recv = (recv - last_bytes_recv);
+	seq_printf(seq, POPCORN_STAT_FMT2,
+			rate_sent / elapsed, (rate_sent % elapsed) * 1000 / elapsed,
+			rate_recv / elapsed, (rate_recv % elapsed) * 1000 / elapsed,
+			"MB/s");
+	last_bytes_sent = sent;
+	last_bytes_recv = recv;
+
+	if (pcn_kmsg_has_features(PCN_KMSG_FEATURE_RDMA) && elapsed) {
+		recv = sent = 0;
+		for_each_present_cpu(i) {
+			sent += per_cpu(bytes_rdma_written, i);
+			recv += per_cpu(bytes_rdma_read, i);
+		}
+		seq_printf(seq, POPCORN_STAT_FMT, sent, recv, "RDMA");
+
+		rate_sent = (sent - last_bytes_rdma_written);
+		rate_recv = (recv - last_bytes_rdma_read);
+		seq_printf(seq, POPCORN_STAT_FMT2,
+				rate_sent / elapsed, (rate_sent % elapsed) * 1000 / elapsed,
+				rate_recv / elapsed, (rate_recv % elapsed) * 1000 / elapsed,
+				"MB/s");
+		last_bytes_rdma_written = sent;
+		last_bytes_rdma_read = recv;
+	}
+
+	pcn_kmsg_stat(seq, NULL);
+
+	return 0;
+}
+
+static ssize_t __write_stats(struct file *file, const char __user *buffer,
+			     size_t size, loff_t *offset)
+{
+	int i;
+	for_each_present_cpu(i) {
+		per_cpu(bytes_sent, i) = 0;
+		per_cpu(bytes_recv, i) = 0;
+		per_cpu(bytes_rdma_written, i) = 0;
+		per_cpu(bytes_rdma_read, i) = 0;
+	}
+	pcn_kmsg_stat(NULL, NULL);
+
+	for (i = 0 ; i < PCN_KMSG_TYPE_MAX; i++) {
+		sent_stats[i] = 0;
+		recv_stats[i] = 0;
+	}
+	fh_action_stat(NULL, NULL);
+
+	return size;
+}
+
+static int __open_stats(struct inode *inode, struct file *file)
+{
+	return single_open(file, __show_stats, inode->i_private);
+}
+
+static struct file_operations stats_ops = {
+	.owner = THIS_MODULE,
+	.open = __open_stats,
+	.read = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
+	.write = __write_stats,
+};
+
+static struct proc_dir_entry *proc_entry = NULL;
+
+int statistics_init(void)
+{
+	proc_entry = proc_create("popcorn_stat", S_IRUGO | S_IWUGO, NULL, &stats_ops);
+	if (proc_entry == NULL) {
+		printk(KERN_ERR"cannot create proc_fs entry for popcorn stats\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
diff --git a/kernel/popcorn/trace_events.h b/kernel/popcorn/trace_events.h
new file mode 100644
index 000000000..7ea5e8b6a
--- /dev/null
+++ b/kernel/popcorn/trace_events.h
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM popcorn
+
+#if !defined(_TRACE_EVENTS_POPCORN_H_) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_EVENTS_POPCORN_H_
+
+#include <linux/tracepoint.h>
+
+
+TRACE_EVENT(pgfault,
+	TP_PROTO(const int nid, const int pid, const char rw,
+		const unsigned long instr_addr, const unsigned long addr,
+		const int result),
+
+	TP_ARGS(nid, pid, rw, instr_addr, addr, result),
+
+	TP_STRUCT__entry(
+		__field(int, nid)
+		__field(int, pid)
+		__field(char, rw)
+		__field(unsigned long, instr_addr)
+		__field(unsigned long, addr)
+		__field(int, result)
+	),
+
+	TP_fast_assign(
+		__entry->nid = nid;
+		__entry->pid = pid;
+		__entry->rw = rw;
+		__entry->instr_addr = instr_addr;
+		__entry->addr = addr;
+		__entry->result = result;
+	),
+
+	TP_printk("%d %d %c %lx %lx %d",
+		__entry->nid, __entry->pid, __entry->rw,
+		__entry->instr_addr, __entry->addr, __entry->result)
+);
+
+
+TRACE_EVENT(pgfault_stat,
+	TP_PROTO(const unsigned long instr_addr, const unsigned long addr,
+		const int result, const int retries, const unsigned long time_us),
+
+	TP_ARGS(instr_addr, addr, result, retries, time_us),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, instr_addr)
+		__field(unsigned long, addr)
+		__field(int, result)
+		__field(int, retries)
+		__field(unsigned long, time_us)
+	),
+
+	TP_fast_assign(
+		__entry->instr_addr = instr_addr;
+		__entry->addr = addr;
+		__entry->result = result;
+		__entry->retries = retries;
+		__entry->time_us = time_us;
+	),
+
+	TP_printk("%lx %lx %d %d %lu",
+		__entry->instr_addr, __entry->addr, __entry->result,
+		__entry->retries, __entry->time_us)
+);
+
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+
+#define TRACE_INCLUDE_PATH ../../kernel/popcorn
+#define TRACE_INCLUDE_FILE trace_events
+#include <trace/define_trace.h>
diff --git a/kernel/popcorn/types.h b/kernel/popcorn/types.h
new file mode 100644
index 000000000..bd6f3db0e
--- /dev/null
+++ b/kernel/popcorn/types.h
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+#ifndef __INTERNAL_POPCORN_TYPES_H__
+#define __INTERNAL_POPCORN_TYPES_H__
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/workqueue.h>
+#include <linux/signal.h>
+#include <linux/slab.h>
+#include <linux/radix-tree.h>
+#include <linux/sched/task.h>
+#include <popcorn/pcn_kmsg.h>
+#include <popcorn/regset.h>
+#include <linux/sched.h>
+#include <popcorn/types.h>
+
+#define FAULTS_HASH 31
+
+/*
+ * Remote execution context
+ */
+struct remote_context {
+	struct list_head list;
+	atomic_t count;
+	struct mm_struct *mm;
+
+	int tgid;
+	bool for_remote;
+
+	/* Tracking page status */
+	struct radix_tree_root pages;
+
+	/* For page replication protocol */
+	spinlock_t faults_lock[FAULTS_HASH];
+	struct hlist_head faults[FAULTS_HASH];
+
+	/* For VMA management */
+	spinlock_t vmas_lock;
+	struct list_head vmas;
+
+	/* Remote worker */
+	bool stop_remote_worker;
+
+	struct task_struct *remote_worker;
+	struct completion remote_works_ready;
+	spinlock_t remote_works_lock;
+	struct list_head remote_works;
+
+	pid_t remote_tgids[MAX_POPCORN_NODES];
+};
+
+struct remote_context *__get_mm_remote(struct mm_struct *mm);
+struct remote_context *get_task_remote(struct task_struct *tsk);
+bool put_task_remote(struct task_struct *tsk);
+bool __put_task_remote(struct remote_context *rc);
+
+
+/*
+ * Process migration
+ */
+#define BACK_MIGRATION_FIELDS \
+	int remote_nid;\
+	pid_t remote_pid;\
+	pid_t origin_pid;\
+	unsigned int personality;\
+	struct field_arch arch;
+DEFINE_PCN_KMSG(back_migration_request_t, BACK_MIGRATION_FIELDS);
+
+#define CLONE_FIELDS \
+	pid_t origin_tgid;\
+	pid_t origin_pid;\
+	unsigned long task_size; \
+	unsigned long stack_start; \
+	unsigned long env_start;\
+	unsigned long env_end;\
+	unsigned long arg_start;\
+	unsigned long arg_end;\
+	unsigned long start_brk;\
+	unsigned long brk;\
+	unsigned long start_code ;\
+	unsigned long end_code;\
+	unsigned long start_data;\
+	unsigned long end_data;\
+	unsigned int personality;\
+	unsigned long def_flags;\
+	char exe_path[512];\
+	struct field_arch arch;
+DEFINE_PCN_KMSG(clone_request_t, CLONE_FIELDS);
+
+
+/*
+ * This message is sent in response to a clone request.
+ * Its purpose is to notify the requesting cpu that make
+ * the specified pid is executing on behalf of the
+ * requesting cpu.
+ */
+#define REMOTE_TASK_PAIRING_FIELDS \
+	pid_t my_tgid; \
+	pid_t my_pid; \
+	pid_t your_pid;
+DEFINE_PCN_KMSG(remote_task_pairing_t, REMOTE_TASK_PAIRING_FIELDS);
+
+
+#define REMOTE_TASK_EXIT_FIELDS  \
+	pid_t origin_pid; \
+	pid_t remote_pid; \
+	int exit_code;
+DEFINE_PCN_KMSG(remote_task_exit_t, REMOTE_TASK_EXIT_FIELDS);
+
+#define ORIGIN_TASK_EXIT_FIELDS \
+	pid_t origin_pid; \
+	pid_t remote_pid; \
+	int exit_code;
+DEFINE_PCN_KMSG(origin_task_exit_t, ORIGIN_TASK_EXIT_FIELDS);
+
+
+/*
+ * VMA management
+ */
+#define VMA_INFO_REQUEST_FIELDS \
+	pid_t origin_pid;	\
+	pid_t remote_pid;	\
+	unsigned long addr;
+DEFINE_PCN_KMSG(vma_info_request_t, VMA_INFO_REQUEST_FIELDS);
+
+#define VMA_INFO_RESPONSE_FIELDS \
+	pid_t remote_pid;	 \
+	int result;		 \
+	unsigned long addr;	 \
+	unsigned long vm_start;	 \
+	unsigned long vm_end;	 \
+	unsigned long vm_flags;	 \
+	unsigned long vm_pgoff;	 \
+	char vm_file_path[512];
+DEFINE_PCN_KMSG(vma_info_response_t, VMA_INFO_RESPONSE_FIELDS);
+
+#define vma_info_anon(x) ((x)->vm_file_path[0] == '\0' ? true : false)
+
+
+#define VMA_OP_REQUEST_FIELDS \
+	pid_t origin_pid; \
+	pid_t remote_pid; \
+	int remote_ws; \
+	int operation; \
+	union { \
+		unsigned long addr; \
+		unsigned long start; \
+		unsigned long brk; \
+	}; \
+	union { \
+		unsigned long len;		/* mmap */ \
+		unsigned long old_len;	/* mremap */ \
+	}; \
+	union { \
+		unsigned long prot;		/* mmap */ \
+		int behavior;			/* madvise */ \
+		unsigned long new_len;	/* mremap */ \
+	}; \
+	unsigned long flags;		/* mmap, remap */ \
+	union { \
+		unsigned long pgoff;	/* mmap */ \
+		unsigned long new_addr;	/* mremap */ \
+	}; \
+	char path[512];
+DEFINE_PCN_KMSG(vma_op_request_t, VMA_OP_REQUEST_FIELDS);
+
+#define VMA_OP_RESPONSE_FIELDS \
+	pid_t origin_pid;      \
+	pid_t remote_pid;      \
+	int remote_ws;	       \
+	int operation;	       \
+	long ret;	       \
+	union {			    \
+		unsigned long addr; \
+		unsigned long start; \
+		unsigned long brk; \
+	}; \
+	unsigned long len;
+DEFINE_PCN_KMSG(vma_op_response_t, VMA_OP_RESPONSE_FIELDS);
+
+
+/*
+ * Page management
+ */
+#define REMOTE_PAGE_REQUEST_FIELDS \
+	pid_t origin_pid;	   \
+	int origin_ws;		   \
+	pid_t remote_pid;	   \
+	unsigned long addr;	   \
+	unsigned long fault_flags; \
+	unsigned long instr_addr;  \
+	dma_addr_t rdma_addr;	   \
+	u32 rdma_key;
+DEFINE_PCN_KMSG(remote_page_request_t, REMOTE_PAGE_REQUEST_FIELDS);
+
+#define REMOTE_PAGE_RESPONSE_COMMON_FIELDS \
+	pid_t remote_pid;		   \
+	pid_t origin_pid;		   \
+	int origin_ws;			   \
+	unsigned long addr;		   \
+	int result;
+
+#define REMOTE_PAGE_RESPONSE_FIELDS \
+	REMOTE_PAGE_RESPONSE_COMMON_FIELDS \
+	unsigned char page[PAGE_SIZE];
+DEFINE_PCN_KMSG(remote_page_response_t, REMOTE_PAGE_RESPONSE_FIELDS);
+
+#define REMOTE_PAGE_GRANT_FIELDS \
+	REMOTE_PAGE_RESPONSE_COMMON_FIELDS
+DEFINE_PCN_KMSG(remote_page_response_short_t, REMOTE_PAGE_GRANT_FIELDS);
+
+
+#define REMOTE_PAGE_FLUSH_COMMON_FIELDS \
+	pid_t origin_pid;		\
+	int remote_nid;			\
+	pid_t remote_pid;		\
+	int remote_ws;			\
+	unsigned long addr;		\
+	unsigned long flags;
+
+#define REMOTE_PAGE_FLUSH_FIELDS \
+	REMOTE_PAGE_FLUSH_COMMON_FIELDS \
+	unsigned char page[PAGE_SIZE];
+DEFINE_PCN_KMSG(remote_page_flush_t, REMOTE_PAGE_FLUSH_FIELDS);
+
+#define REMOTE_PAGE_RELEASE_FIELDS \
+	REMOTE_PAGE_FLUSH_COMMON_FIELDS
+DEFINE_PCN_KMSG(remote_page_release_t, REMOTE_PAGE_RELEASE_FIELDS);
+
+#define REMOTE_PAGE_FLUSH_ACK_FIELDS \
+	int remote_ws; \
+	unsigned long flags;
+DEFINE_PCN_KMSG(remote_page_flush_ack_t, REMOTE_PAGE_FLUSH_ACK_FIELDS);
+
+
+#define PAGE_INVALIDATE_REQUEST_FIELDS \
+	pid_t origin_pid; \
+	int origin_ws; \
+	pid_t remote_pid; \
+	unsigned long addr;
+DEFINE_PCN_KMSG(page_invalidate_request_t, PAGE_INVALIDATE_REQUEST_FIELDS);
+
+#define PAGE_INVALIDATE_RESPONSE_FIELDS \
+	pid_t origin_pid; \
+	int origin_ws; \
+	pid_t remote_pid;
+DEFINE_PCN_KMSG(page_invalidate_response_t, PAGE_INVALIDATE_RESPONSE_FIELDS);
+
+
+/*
+ * Futex
+ */
+#define REMOTE_FUTEX_REQ_FIELDS \
+	pid_t origin_pid;	\
+	int remote_ws;		\
+	int op;			\
+	u32 val;		\
+	struct timespec64 ts;	\
+	void *uaddr;		\
+	void *uaddr2;		\
+	u32 val2;		\
+	u32 val3;
+DEFINE_PCN_KMSG(remote_futex_request, REMOTE_FUTEX_REQ_FIELDS);
+
+#define REMOTE_FUTEX_RES_FIELDS \
+	int remote_ws;		\
+	long ret;
+DEFINE_PCN_KMSG(remote_futex_response, REMOTE_FUTEX_RES_FIELDS);
+
+/*
+ * Node information
+ */
+#define NODE_INFO_FIELDS \
+	int nid;	 \
+	int bundle_id;	 \
+	int arch;
+DEFINE_PCN_KMSG(node_info_t, NODE_INFO_FIELDS);
+
+
+/*
+ * Schedule server. Not yet completely ported though
+ */
+#define SCHED_PERIODIC_FIELDS \
+	int power_1;	      \
+	int power_2;	      \
+	int power_3;
+DEFINE_PCN_KMSG(sched_periodic_req, SCHED_PERIODIC_FIELDS);
+
+/*
+ * Message routing using work queues
+ */
+extern struct workqueue_struct *popcorn_wq;
+extern struct workqueue_struct *popcorn_ordered_wq;
+
+struct pcn_kmsg_work {
+	struct work_struct work;
+	void *msg;
+};
+
+static inline int __handle_popcorn_work(struct pcn_kmsg_message *msg,
+					void (*handler)(struct work_struct *),
+					struct workqueue_struct *wq)
+{
+	struct pcn_kmsg_work *w = kmalloc(sizeof(*w), GFP_ATOMIC);
+	BUG_ON(!w);
+
+	w->msg = msg;
+	INIT_WORK(&w->work, handler);
+	smp_wmb();
+	queue_work(wq, &w->work);
+
+	return 0;
+}
+
+int request_remote_work(pid_t pid, struct pcn_kmsg_message *req);
+
+#define DEFINE_KMSG_WQ_HANDLER(x) \
+static inline int handle_##x(struct pcn_kmsg_message *msg) {\
+	return __handle_popcorn_work(msg, process_##x, popcorn_wq);\
+}
+#define DEFINE_KMSG_ORDERED_WQ_HANDLER(x) \
+static inline int handle_##x(struct pcn_kmsg_message *msg) {\
+	return __handle_popcorn_work(msg, process_##x, popcorn_ordered_wq);\
+}
+#define DEFINE_KMSG_RW_HANDLER(x,type,member) \
+static inline int handle_##x(struct pcn_kmsg_message *msg) {\
+	type *req = (type *)msg; \
+	return request_remote_work(req->member, msg); \
+}
+
+#define REGISTER_KMSG_WQ_HANDLER(x, y) \
+	pcn_kmsg_register_callback(x, handle_##y)
+
+#define REGISTER_KMSG_HANDLER(x, y) \
+	pcn_kmsg_register_callback(x, handle_##y)
+
+#define START_KMSG_WORK(type, name, work) \
+	struct pcn_kmsg_work *__pcn_kmsg_work__ = (struct pcn_kmsg_work *)(work); \
+	type *name = __pcn_kmsg_work__->msg
+
+#define END_KMSG_WORK(name) \
+	pcn_kmsg_done(name); \
+	kfree(__pcn_kmsg_work__);
+
+static inline struct task_struct *__get_task_struct(pid_t pid)
+{
+	struct task_struct *tsk = NULL;
+	rcu_read_lock();
+	tsk = find_task_by_vpid(pid);
+	if (likely(tsk)) {
+		get_task_struct(tsk);
+	}
+	rcu_read_unlock();
+	return tsk;
+}
+
+#endif /* __INTERNAL_POPCORN_TYPES_H__ */
diff --git a/kernel/popcorn/util.c b/kernel/popcorn/util.c
new file mode 100644
index 000000000..cb031200b
--- /dev/null
+++ b/kernel/popcorn/util.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+/*
+ * /kernel/popcorn/util.c
+ *
+ * General Utility Functions
+ *
+ * Original file developed by SSRG at Virginia Tech.
+ *
+ * author, Javier Malave, Rebecca Shapiro, Andrew Hughes,
+ * Narf Industries 2020 (modifications for upstream RFC)
+ */
+
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/sched/task_stack.h>
+#include <popcorn/bundle.h>
+
+void print_page_data(unsigned char *addr)
+{
+	int i;
+	for (i = 0; i < PAGE_SIZE; i++) {
+		if (i % 16 == 0) {
+			printk(KERN_INFO"%08lx:", (unsigned long)(addr + i));
+		}
+		if (i % 4 == 0) {
+			printk(" ");
+		}
+		printk("%02x", *(addr + i));
+	}
+	printk("\n");
+}
+
+void print_page_signature(unsigned char *addr)
+{
+	unsigned char *p = addr;
+	int i, j;
+	for (i = 0; i < PAGE_SIZE / 128; i++) {
+		unsigned char signature = 0;
+		for (j = 0; j < 32; j++) {
+			signature = (signature + *p++) & 0xff;
+		}
+		printk("%02x", signature);
+	}
+	printk("\n");
+}
+
+void print_page_signature_pid(pid_t pid, unsigned char *addr)
+{
+	printk("  [%d] ", pid);
+	print_page_signature(addr);
+}
+
+static DEFINE_SPINLOCK(__print_lock);
+static char *__print_buffer = NULL;
+
+void print_page_owner(unsigned long addr, unsigned long *owners, pid_t pid)
+{
+	if (unlikely(!__print_buffer)) {
+		__print_buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	}
+	spin_lock(&__print_lock);
+	bitmap_print_to_pagebuf(
+			true, __print_buffer, owners, MAX_POPCORN_NODES);
+	printk("  [%d] %lx %s", pid, addr, __print_buffer);
+	spin_unlock(&__print_lock);
+}
+
+#include <linux/fs.h>
+
+static DEFINE_SPINLOCK(__file_path_lock);
+static char *__file_path_buffer = NULL;
+
+int get_file_path(struct file *file, char *sz, size_t size)
+{
+	char *ppath;
+	int retval = 0;
+
+	if (!file) {
+		BUG_ON(size < 1);
+		sz[0] = '\0';
+		return -EINVAL;
+	}
+
+	if (unlikely(!__file_path_buffer)) {
+		__file_path_buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	}
+
+	spin_lock(&__file_path_lock);
+	ppath = file_path(file, __file_path_buffer, PAGE_SIZE);
+	if (IS_ERR(ppath)) {
+		retval = -ESRCH;
+		goto out_unlock;
+	}
+
+	strncpy(sz, ppath, size);
+
+out_unlock:
+	spin_unlock(&__file_path_lock);
+	return 0;
+}
+
+
+static const char *__comm_to_trace[] = {
+};
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/ptrace.h>
+
+void trace_task_status(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(__comm_to_trace); i++) {
+		const char *comm = __comm_to_trace[i];
+		if (memcmp(current->comm, comm, strlen(comm)) == 0) {
+			printk("@@[%d] %s %lx\n", current->pid,
+					current->comm, instruction_pointer(current_pt_regs()));
+			break;
+		}
+	}
+}
diff --git a/kernel/popcorn/util.h b/kernel/popcorn/util.h
new file mode 100644
index 000000000..b94fb192a
--- /dev/null
+++ b/kernel/popcorn/util.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+#ifndef __POPCORN_KERNEL_UTIL_H__
+#define __POPCORN_KERNEL_UTIL_H__
+struct page;
+
+void print_page_data(unsigned char *addr);
+void print_page_signature(unsigned char *addr);
+void print_page_signature_pid(pid_t pid, unsigned char *addr);
+void print_page_owner(unsigned long addr, unsigned long *owners, pid_t pid);
+
+int get_file_path(struct file *file, char *sz, size_t size);
+
+void trace_task_status(void);
+#endif
diff --git a/kernel/popcorn/wait_station.c b/kernel/popcorn/wait_station.c
new file mode 100644
index 000000000..3367222f4
--- /dev/null
+++ b/kernel/popcorn/wait_station.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+/*
+ * /kernel/popcorn/wait_station.c
+ *
+ * Waiting stations allows threads to be waited for a given
+ * number of events are completed
+ *
+ * Original file developed by SSRG at Virginia Tech.
+ *
+ * author, Javier Malave, Rebecca Shapiro, Andrew Hughes,
+ * Narf Industries 2020 (modifications for upstream RFC)
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/err.h>
+
+#include "wait_station.h"
+
+#define MAX_WAIT_STATIONS 1024
+
+static struct wait_station wait_stations[MAX_WAIT_STATIONS];
+
+static DEFINE_SPINLOCK(wait_station_lock);
+static DECLARE_BITMAP(wait_station_available, MAX_WAIT_STATIONS) = { 0 };
+
+struct wait_station *get_wait_station_multiple(struct task_struct *tsk,
+					       int count)
+{
+	int id;
+	struct wait_station *ws;
+
+	spin_lock(&wait_station_lock);
+	id = find_first_zero_bit(wait_station_available, MAX_WAIT_STATIONS);
+	BUG_ON(id >= MAX_WAIT_STATIONS);
+	ws = wait_stations + id;
+	set_bit(id, wait_station_available);
+	spin_unlock(&wait_station_lock);
+
+	ws->id = id;
+	ws->pid = tsk->pid;
+	ws->private = (void *)0xbad0face;
+	init_completion(&ws->pendings);
+	atomic_set(&ws->pendings_count, count);
+	smp_wmb();
+
+	return ws;
+}
+EXPORT_SYMBOL_GPL(get_wait_station_multiple);
+
+struct wait_station *wait_station(int id)
+{
+	smp_rmb();
+	return wait_stations + id;
+}
+EXPORT_SYMBOL_GPL(wait_station);
+
+void put_wait_station(struct wait_station *ws)
+{
+	int id = ws->id;
+	spin_lock(&wait_station_lock);
+	BUG_ON(!test_bit(id, wait_station_available));
+	clear_bit(id, wait_station_available);
+	spin_unlock(&wait_station_lock);
+}
+EXPORT_SYMBOL_GPL(put_wait_station);
+
+void *wait_at_station(struct wait_station *ws)
+{
+	void *ret;
+	if (!try_wait_for_completion(&ws->pendings)) {
+		if (wait_for_completion_io_timeout(&ws->pendings, 300 * HZ) == 0) {
+			ret = ERR_PTR(-ETIMEDOUT);
+			goto out;
+		}
+	}
+	smp_rmb();
+	ret = (void *)ws->private;
+out:
+	put_wait_station(ws);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(wait_at_station);
diff --git a/kernel/popcorn/wait_station.h b/kernel/popcorn/wait_station.h
new file mode 100644
index 000000000..3ced49b84
--- /dev/null
+++ b/kernel/popcorn/wait_station.h
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+#ifndef _POPCORN_WAIT_STATION_H_
+#define _POPCORN_WAIT_STATION_H_
+
+#include <linux/completion.h>
+#include <linux/atomic.h>
+
+struct wait_station {
+	int id;
+	pid_t pid;
+	volatile void *private;
+	struct completion pendings;
+	atomic_t pendings_count;
+};
+
+struct task_struct;
+
+struct wait_station *get_wait_station_multiple(struct task_struct *tsk,
+					int count);
+static inline struct wait_station *get_wait_station(struct task_struct *tsk)
+{
+	return get_wait_station_multiple(tsk, 1);
+}
+struct wait_station *wait_station(int id);
+void put_wait_station(struct wait_station *ws);
+void *wait_at_station(struct wait_station *ws);
+#endif
-- 
2.17.1

