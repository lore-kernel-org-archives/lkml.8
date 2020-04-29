Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30231C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54D82082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=narfindustries.com header.i=@narfindustries.com header.b="NcBPZ9kC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgD2TeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727801AbgD2TeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:34:07 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE5FC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:34:07 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a5so2194932vsm.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=narfindustries.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=wbBWFzpxKUQCcuI8cGMTvj2o6yc3lIo1XhO1kVVvlK0=;
        b=NcBPZ9kCYnbz3eJ5UFqIdDZ15bhaYCtIsJyfwQUWCaP0uNYrBF2Jme3FL34J3q6X9R
         Pm2gLWRVaZez6FxzPupaGqhOTC8OMShtmxNUnlI8DPl1A74AGzsP2Xe2R1WxT6dMgXlW
         SR0O4FqptnAq7qNtLHNyR94G/3bZo7Lwp2UIXdh8jZk2AlE4MlkNQSvc/idN5FNPdeqq
         TPXT23VRD9pLRdUEtE5rVfj2CjZWs2AgbXpPwrvPtArKGBltqKx706LSY4lw2fit3Tj1
         0i4otJH4oK5RIFQuqn6w6maifh7f1TQtY+IMEiEqtdpoqqWp4nS6P47zAwGNVp9apcu6
         ypjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=wbBWFzpxKUQCcuI8cGMTvj2o6yc3lIo1XhO1kVVvlK0=;
        b=rxbz1bIcB4jiBHgOt1MCh9OOQNaxiI/lv8bOaMAL9AR2fokexn1YyfMhekJ1tNrh0C
         uoH25aqOvdMjZBxJZDFo+O/bCVepovv0MABctOPEwcjXM+SkbN6ovGL4HgaOoytIqyYD
         PBabALJbaZxT6whEkeOZvqKyvRWTCKul5vV9qyS/rLj7jxLumG8A69NBMu3KQGm18fY/
         Y8VB5vqpb0o0VaXQ24/70NSJ9Ar2OORSV3uaDqS59jvLBVwtaZv2fOBLZiMzC+gB+yR8
         Dh5avpNQ3xzzkl2OpTAYaOWo6Z4R7hDrg3y2oA/lgomeDycOrvQOa99ByEkMbnpejnqm
         imcw==
X-Gm-Message-State: AGi0PuahdRkZZMujcp6GxyGwpgtdtRKkd+mpxfc1XXze1ZI62a3ogx4c
        DoocVsrLY7+6G5xFiu4g5vOzxg==
X-Google-Smtp-Source: APiQypLyJmM+4SlmNT7Xx6aiCdAauBpP8UmDteLmZFVERWDpcwy3cCcBtc99wRxCamBbwZ5JlrzL7g==
X-Received: by 2002:a67:e350:: with SMTP id s16mr27763707vsm.173.1588188845806;
        Wed, 29 Apr 2020 12:34:05 -0700 (PDT)
Received: from localhost.localdomain ([24.171.221.68])
        by smtp.gmail.com with ESMTPSA id k26sm76764uag.10.2020.04.29.12.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:34:05 -0700 (PDT)
From:   Javier Malave <javier.malave@narfindustries.com>
To:     bx@narfindustries.com
Cc:     Javier Malave <javier.malave@narfindustries.com>,
        linux-kernel@vger.kernel.org, ah@narfindustries.com
Subject: [RFC 8/9] Page Server for Distributed Thread Execution
Date:   Wed, 29 Apr 2020 15:32:55 -0400
Message-Id: <24eeb40cd40e776b402ec5f9b26771231fe5bab8.1588127445.git.javier.malave@narfindustries.com>
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

Popcorn threads execute in a distributed manner,
thus pages may fall into an inconsistent state.
A few examples may be,

A) A new page is created in a remote node, and is needed
at the origin node, after back migration.

B) A page has been changed in one node, the thread
migrates to a previous node where it had executed code,
and attempts to read the remotely modified page.

As part of the coherent VMA space, the page server takes
care of managing page consistency. Page server must mark
pages invalid when applicable, handle faults and verify
ownership.
---
 include/popcorn/page_server.h |   34 +
 kernel/popcorn/fh_action.c    |  207 ++++
 kernel/popcorn/fh_action.h    |   34 +
 kernel/popcorn/page_server.c  | 2019 +++++++++++++++++++++++++++++++++
 kernel/popcorn/page_server.h  |   16 +
 kernel/popcorn/pgtable.h      |   31 +
 6 files changed, 2341 insertions(+)
 create mode 100644 include/popcorn/page_server.h
 create mode 100644 kernel/popcorn/fh_action.c
 create mode 100644 kernel/popcorn/fh_action.h
 create mode 100644 kernel/popcorn/page_server.c
 create mode 100644 kernel/popcorn/page_server.h
 create mode 100644 kernel/popcorn/pgtable.h

diff --git a/include/popcorn/page_server.h b/include/popcorn/page_server.h
new file mode 100644
index 000000000..f4b25970c
--- /dev/null
+++ b/include/popcorn/page_server.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0, 3-clause BSD
+#ifndef INCLUDE_POPCORN_PAGE_SERVER_H_
+#define INCLUDE_POPCORN_PAGE_SERVER_H_
+
+struct fault_handle;
+
+/*
+ * Entry points for dealing with page fault in Popcorn Rack
+ */
+int page_server_handle_pte_fault(struct vm_fault *vmf);
+
+void page_server_zap_pte(struct vm_area_struct *vma, unsigned long addr,
+			 pte_t *pte, pte_t *pteval);
+
+int page_server_get_userpage(u32 __user *uaddr, struct fault_handle **handle,
+			     char *mode);
+void page_server_put_userpage(struct fault_handle *fh, char *mode);
+
+void page_server_panic(bool condition, struct mm_struct *mm,
+		       unsigned long address, pte_t *pte,
+		       pte_t pte_val);
+
+int page_server_release_page_ownership(struct vm_area_struct *vma,
+				       unsigned long addr);
+
+/* Implemented in mm/memory.c */
+int handle_pte_fault_origin(struct mm_struct *, struct vm_area_struct *,
+			    unsigned long, pte_t *, pmd_t *, unsigned int);
+struct page *get_normal_page(struct vm_area_struct *vma, unsigned long addr,
+			     pte_t *pte);
+int cow_file_at_origin(struct mm_struct *mm, struct vm_area_struct *vma,
+		       unsigned long addr, pte_t *pte);
+
+#endif /* INCLUDE_POPCORN_PAGE_SERVER_H_ */
diff --git a/kernel/popcorn/fh_action.c b/kernel/popcorn/fh_action.c
new file mode 100644
index 000000000..0ba0aea90
--- /dev/null
+++ b/kernel/popcorn/fh_action.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+/*
+ * /kernel/popcorn/fh_action.c
+ *
+ * Original file developed by SSRG at Virginia Tech.
+ *
+ * Fault handling statistics.
+ *
+ * author, Javier Malave, Rebecca Shapiro, Andrew Hughes,
+ * Narf Industries 2020 (modifications for upstream RFC)
+ */
+
+#include <linux/kernel.h>
+#include <linux/seq_file.h>
+
+#include "fh_action.h"
+
+/*
+ * Current fault handling type
+ *   (L/R) For local or remote
+ *   (-/i) Ownership revocation pending
+ *   (R/W) For read or write
+ *
+ * Current fault type
+ *   (L/R) For local or remote
+ *   (R/W) For read or write
+ *
+ * e.g., at origin, L-WRW means the page is currently locked for handling
+ * local "fault for write" and "request to handle" remote fault for write.
+ * In this case, just retry immediately.
+ */
+
+static unsigned long __fh_action_stat[64] = { 0 };
+static const unsigned short fh_action_table[64] = {
+	/* L - R, LR (at origin) */
+	FH_ACTION_FOLLOW,
+	/* L - R, RR */
+	FH_ACTION_RETRY | FH_ACTION_WAIT | FH_ACTION_LOCAL,
+	/* L - R, LW */
+	FH_ACTION_RETRY | FH_ACTION_WAIT,
+	/* L - R, RW */
+	FH_ACTION_RETRY,
+        /* L - W, LR */
+	FH_ACTION_FOLLOW,
+	/* L - W, RR */
+	FH_ACTION_RETRY,
+	/* L - W, LW */
+	FH_ACTION_FOLLOW,
+	/* L - W, RW */
+	FH_ACTION_RETRY,
+	/* L i R, LR */
+	FH_ACTION_INVALID,
+	/* L i R, RR (at origin) */
+	FH_ACTION_INVALID,
+	/* L i R, LW */
+	FH_ACTION_INVALID,
+	/* L i R, RW */
+	FH_ACTION_INVALID,
+	/* L i W, LR */
+	FH_ACTION_INVALID,
+	/* L i W, RR */
+	FH_ACTION_INVALID,
+	/* L i W, LW */
+	FH_ACTION_INVALID,
+	/* L i W, RW */
+	FH_ACTION_INVALID,
+
+	/* R - R, LR */
+	FH_ACTION_FOLLOW,
+	/* R - R, RR */
+	FH_ACTION_RETRY | FH_ACTION_WAIT | FH_ACTION_LOCAL,
+	/* R - R, LW */
+	FH_ACTION_RETRY | FH_ACTION_WAIT,
+	/* R - R, RW */
+	FH_ACTION_RETRY | FH_ACTION_WAIT,
+	/* R - W, LR */
+	FH_ACTION_RETRY | FH_ACTION_WAIT,
+	/* R - W, RR */
+	FH_ACTION_RETRY,
+	/* R - W, LW */
+	FH_ACTION_RETRY | FH_ACTION_WAIT,
+	/* R - W, RW */
+	FH_ACTION_RETRY,
+	/* R i R, LR */
+	FH_ACTION_INVALID,
+	/* R i R, RR (at origin) */
+	FH_ACTION_INVALID,
+        /* R i R, LW */
+	FH_ACTION_INVALID,
+	/* R i R, RW */
+	FH_ACTION_INVALID,
+	/* R i W, LR */
+	FH_ACTION_INVALID,
+	/* R i W, RR */
+	FH_ACTION_INVALID,
+	/* R i W, LW */
+	FH_ACTION_INVALID,
+	/* R i W, RW */
+	FH_ACTION_INVALID,
+
+	/*
+	 * At remote
+	 *      - *i*R* are impossible since the origin never asks remotes for
+	 *        pages while an ownership revocation is pended.
+	 *      - R**R* are impossible since the origin never asks a page twice.
+	 *      - Ri*** are impossible henceforth.
+	 */
+
+	/* L - R, LR */
+	FH_ACTION_FOLLOW,
+	/* L - R, RR, implies remote doesn't own this page */
+	FH_ACTION_INVALID,
+	/* L - R, LW */
+	FH_ACTION_RETRY  | FH_ACTION_WAIT,
+	/* L - R, RW */
+	FH_ACTION_INVALID,
+	/* L - W, LR */
+	FH_ACTION_FOLLOW,
+	/* L - W, RR */
+	FH_ACTION_RETRY  | FH_ACTION_WAIT | FH_ACTION_LOCAL | FH_ACTION_DELAY,
+	/* L - W, LW */
+	FH_ACTION_FOLLOW,
+	/* L - W, RW */
+	FH_ACTION_RETRY  | FH_ACTION_WAIT | FH_ACTION_LOCAL | FH_ACTION_DELAY,
+	/* L i R, LR, no waiter should exist when finishing ownership revocation */
+	FH_ACTION_FOLLOW | FH_ACTION_RETRY | FH_ACTION_DELAY,
+	/* L i R, RR */
+	FH_ACTION_INVALID,
+	/* L i R, LW */
+	FH_ACTION_RETRY  | FH_ACTION_WAIT | FH_ACTION_DELAY,
+	/* L i R, RW */
+	FH_ACTION_INVALID,
+	/* L i W, LR (same to LiRLR) */
+	FH_ACTION_FOLLOW | FH_ACTION_RETRY | FH_ACTION_DELAY,
+	/* L i W, RR */
+	FH_ACTION_INVALID,
+	/* L i W, LW (same to LiRLR) */
+	FH_ACTION_FOLLOW | FH_ACTION_RETRY | FH_ACTION_DELAY,
+	/* L i W, RW */
+	FH_ACTION_INVALID,
+	/* R - R, LR */
+	FH_ACTION_INVALID,
+	/* R - R, RR */
+	FH_ACTION_INVALID,
+	/* R - R, LW */
+	FH_ACTION_RETRY | FH_ACTION_WAIT,
+	/* R - R, RW */
+	FH_ACTION_INVALID,
+	/* R - W, LR */
+	FH_ACTION_RETRY | FH_ACTION_WAIT,
+	/* R - W, RR */
+	FH_ACTION_INVALID,
+	/* R - W, LW */
+	FH_ACTION_RETRY | FH_ACTION_WAIT,
+	/* R - W, RW */
+	FH_ACTION_INVALID,
+	/* R i R, LR */
+	FH_ACTION_INVALID,
+	/* R i R, RR */
+	FH_ACTION_INVALID,
+	/* R i R, LW */
+	FH_ACTION_INVALID,
+	/* R i R, RW */
+	FH_ACTION_INVALID,
+	/* R i W, LR */
+	FH_ACTION_INVALID,
+	/* R i W, RR */
+	FH_ACTION_INVALID,
+	/* R i W, LW */
+	FH_ACTION_INVALID,
+	/* R i W, RW */
+	FH_ACTION_INVALID,
+};
+
+unsigned short get_fh_action(bool at_remote,
+                             unsigned long fh_flags,
+                             unsigned fault_flags)
+{
+	unsigned short i;
+	i  = (at_remote << 5);
+	i |= (fh_flags & 0x07) << 2;
+	i |= !!(fault_for_write(fault_flags)) << 1;
+	i |= !!(fault_flags & PC_FAULT_FLAG_REMOTE) << 0;
+
+	return fh_action_table[i];
+}
+
+void fh_action_stat(struct seq_file *seq, void *v)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(__fh_action_stat) / 4; i++) {
+		if (seq) {
+			seq_printf(seq,
+                       "%2d %-12lu %2d %-12lu %2d %-12lu %2d %-12lu\n",
+				       i,
+					   __fh_action_stat[i], i + 16,
+                       __fh_action_stat[i + 16], i + 32,
+                       __fh_action_stat[i + 32], i + 48,
+                       __fh_action_stat[i + 48]);
+		} else {
+			__fh_action_stat[i] = 0;
+			__fh_action_stat[i + 16] = 0;
+			__fh_action_stat[i + 32] = 0;
+			__fh_action_stat[i + 48] = 0;
+		}
+	}
+}
diff --git a/kernel/popcorn/fh_action.h b/kernel/popcorn/fh_action.h
new file mode 100644
index 000000000..ac9183d0d
--- /dev/null
+++ b/kernel/popcorn/fh_action.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+#ifndef __POPCORN_FAULT_HANDLING_ACTION_H__
+#define __POPCORN_FAULT_HANDLING_ACTION_H__
+
+#include <linux/mm.h>
+
+enum {
+	FH_ACTION_INVALID = 0x00,
+	FH_ACTION_FOLLOW = 0x10,
+	FH_ACTION_RETRY = 0x20,
+	FH_ACTION_WAIT = 0x01,
+	FH_ACTION_LOCAL = 0x02,
+	FH_ACTION_DELAY = 0x04,
+
+	PC_FAULT_FLAG_REMOTE = 0x200,
+
+	FH_ACTION_MAX_FOLLOWER = 8,
+};
+
+static inline bool fault_for_write(unsigned long flags)
+{
+	return !!(flags & FAULT_FLAG_WRITE);
+}
+
+static inline bool fault_for_read(unsigned long flags)
+{
+	return !fault_for_write(flags);
+}
+
+unsigned short get_fh_action(bool at_remote,
+                             unsigned long fh_flags,
+                             unsigned fault_flags
+                             );
+#endif
diff --git a/kernel/popcorn/page_server.c b/kernel/popcorn/page_server.c
new file mode 100644
index 000000000..ace549be1
--- /dev/null
+++ b/kernel/popcorn/page_server.c
@@ -0,0 +1,2019 @@
+// SPDX-License-Identifier: GPL-2.0, 3-clause BSD
+/*
+ * /kernel/popcorn/page_server.c
+ *
+ * Popcorn Linux page server implementation.
+ * As part of the coherent VMA space, the page server takes
+ * care of managing page consistency.
+ *
+ * This work was an extension of Marina Sadini's MS Thesis.
+ * It has since been modified for multi-threaded support.
+ *
+ * author, Javier Malave, Rebecca Shapiro, Andrew Hughes,
+ * Narf Industries 2020 (modifications for upstream RFC)
+ * author Sang-Hoon Kim, SSRG Virginia Tech 2017
+ * author Marina Sadini, SSRG Virginia 2013
+ */
+
+#include <linux/compiler.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/rmap.h>
+#include <linux/mmu_notifier.h>
+#include <linux/wait.h>
+#include <linux/ptrace.h>
+#include <linux/swap.h>
+#include <linux/pagemap.h>
+#include <linux/delay.h>
+#include <linux/random.h>
+#include <linux/radix-tree.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
+#include <linux/sched/mm.h>
+
+#include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
+#include <asm/mmu_context.h>
+
+#include <popcorn/bundle.h>
+#include <popcorn/pcn_kmsg.h>
+
+#include "types.h"
+#include "pgtable.h"
+#include "wait_station.h"
+#include "page_server.h"
+#include "fh_action.h"
+
+#include "trace_events.h"
+
+static inline int __fault_hash_key(unsigned long address)
+{
+	return (address >> PAGE_SHIFT) % FAULTS_HASH;
+}
+
+/**************************************************************************
+ * Page ownership tracking mechanism
+ */
+#define PER_PAGE_INFO_SIZE \
+		(sizeof(unsigned long) * BITS_TO_LONGS(MAX_POPCORN_NODES))
+#define PAGE_INFO_PER_REGION (PAGE_SIZE / PER_PAGE_INFO_SIZE)
+
+static inline void __get_page_info_key(unsigned long addr, unsigned long *key,
+				       unsigned long *offset)
+{
+	unsigned long paddr = addr >> PAGE_SHIFT;
+	*key = paddr / PAGE_INFO_PER_REGION;
+	*offset = (paddr % PAGE_INFO_PER_REGION) *
+			(PER_PAGE_INFO_SIZE / sizeof(unsigned long));
+}
+
+static inline struct page *__get_page_info_page(struct mm_struct *mm,
+						unsigned long addr,
+						unsigned long *offset)
+{
+	unsigned long key;
+	struct page *page;
+	struct remote_context *rc = mm->remote;
+	__get_page_info_key(addr, &key, offset);
+
+	page = radix_tree_lookup(&rc->pages, key);
+	if (!page)
+		return NULL;
+
+	return page;
+}
+
+static inline unsigned long *__get_page_info_mapped(struct mm_struct *mm,
+						    unsigned long addr,
+						    unsigned long *offset)
+{
+	unsigned long key;
+	struct page *page;
+	struct remote_context *rc = mm->remote;
+	__get_page_info_key(addr, &key, offset);
+
+	page = radix_tree_lookup(&rc->pages, key);
+	if (!page)
+		return NULL;
+
+	return (unsigned long *)kmap_atomic(page) + *offset;
+}
+
+#define FREE_BATCH 16
+void free_remote_context_pages(struct remote_context *rc)
+{
+	int nr_pages;
+	struct page *pages[FREE_BATCH];
+
+	do {
+		int i;
+		nr_pages = radix_tree_gang_lookup(&rc->pages,
+				(void **)pages, 0, FREE_BATCH);
+
+		for (i = 0; i < nr_pages; i++) {
+			struct page *page = pages[i];
+			radix_tree_delete(&rc->pages, page_private(page));
+			__free_page(page);
+		}
+	} while (nr_pages == FREE_BATCH);
+}
+
+#define PI_FLAG_COWED 62
+#define PI_FLAG_DISTRIBUTED 63
+
+static struct page *__lookup_page_info_page(struct remote_context *rc,
+					    unsigned long key)
+{
+	struct page *page = radix_tree_lookup(&rc->pages, key);
+	if (!page) {
+		int ret;
+		page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
+		BUG_ON(!page);
+		set_page_private(page, key);
+
+		ret = radix_tree_insert(&rc->pages, key, page);
+		BUG_ON(ret);
+	}
+	return page;
+}
+
+static inline void SetPageDistributed(struct mm_struct *mm, unsigned long addr)
+{
+	unsigned long key, offset;
+	unsigned long *region;
+	struct page *page;
+	struct remote_context *rc = mm->remote;
+	__get_page_info_key(addr, &key, &offset);
+
+	page = __lookup_page_info_page(rc, key);
+	region = kmap_atomic(page);
+	set_bit(PI_FLAG_DISTRIBUTED, region + offset);
+	kunmap_atomic(region);
+}
+
+static inline void SetPageCowed(struct mm_struct *mm, unsigned long addr)
+{
+	unsigned long key, offset;
+	unsigned long *region;
+	struct page *page;
+	struct remote_context *rc = mm->remote;
+	__get_page_info_key(addr, &key, &offset);
+
+	page = __lookup_page_info_page(rc, key);
+	region = kmap_atomic(page);
+	set_bit(PI_FLAG_COWED, region + offset);
+	kunmap_atomic(region);
+}
+
+static inline void ClearPageInfo(struct mm_struct *mm, unsigned long addr)
+{
+	unsigned long offset;
+	unsigned long *pi = __get_page_info_mapped(mm, addr, &offset);
+
+	if (!pi)
+		return;
+	clear_bit(PI_FLAG_DISTRIBUTED, pi);
+	clear_bit(PI_FLAG_COWED, pi);
+	bitmap_clear(pi, 0, MAX_POPCORN_NODES);
+	kunmap_atomic(pi - offset);
+}
+
+static inline bool PageDistributed(struct mm_struct *mm, unsigned long addr)
+{
+	unsigned long offset;
+	unsigned long *pi = __get_page_info_mapped(mm, addr, &offset);
+	bool ret;
+
+	if (!pi)
+		return false;
+	ret = test_bit(PI_FLAG_DISTRIBUTED, pi);
+	kunmap_atomic(pi - offset);
+	return ret;
+}
+
+static inline bool PageCowed(struct mm_struct *mm, unsigned long addr)
+{
+	unsigned long offset;
+	unsigned long *pi = __get_page_info_mapped(mm, addr, &offset);
+	bool ret;
+
+	if (!pi)
+		return false;
+	ret = test_bit(PI_FLAG_COWED, pi);
+	kunmap_atomic(pi - offset);
+	return ret;
+}
+
+static inline bool page_is_mine(struct mm_struct *mm, unsigned long addr)
+{
+	unsigned long offset;
+	unsigned long *pi = __get_page_info_mapped(mm, addr, &offset);
+	bool ret = true;
+
+	if (!pi)
+		return true;
+	if (!test_bit(PI_FLAG_DISTRIBUTED, pi))
+		goto out;
+	ret = test_bit(my_nid, pi);
+out:
+	kunmap_atomic(pi - offset);
+	return ret;
+}
+
+static inline bool test_page_owner(int nid, struct mm_struct *mm,
+				   unsigned long addr)
+{
+	unsigned long offset;
+	unsigned long *pi = __get_page_info_mapped(mm, addr, &offset);
+	bool ret;
+
+	if (!pi)
+		return false;
+	ret = test_bit(nid, pi);
+	kunmap_atomic(pi - offset);
+	return ret;
+}
+
+static inline void set_page_owner(int nid, struct mm_struct *mm,
+				  unsigned long addr)
+{
+	unsigned long offset;
+	unsigned long *pi = __get_page_info_mapped(mm, addr, &offset);
+	set_bit(nid, pi);
+	kunmap_atomic(pi - offset);
+}
+
+static inline void clear_page_owner(int nid, struct mm_struct *mm,
+				    unsigned long addr)
+{
+	unsigned long offset;
+	unsigned long *pi = __get_page_info_mapped(mm, addr, &offset);
+	if (!pi)
+		return;
+
+	clear_bit(nid, pi);
+	kunmap_atomic(pi - offset);
+}
+
+/*
+ * Fault tracking mechanism
+ */
+enum {
+	FAULT_HANDLE_WRITE = 0x01,
+	FAULT_HANDLE_INVALIDATE = 0x02,
+	FAULT_HANDLE_REMOTE = 0x04,
+};
+
+static struct kmem_cache *__fault_handle_cache = NULL;
+
+struct fault_handle {
+	struct hlist_node list;
+
+	unsigned long addr;
+	unsigned long flags;
+
+	unsigned int limit;
+	pid_t pid;
+	int ret;
+
+	atomic_t pendings;
+	atomic_t pendings_retry;
+	wait_queue_head_t waits;
+	wait_queue_head_t waits_retry;
+	struct remote_context *rc;
+
+	struct completion *complete;
+};
+
+static struct fault_handle *__alloc_fault_handle(struct task_struct *tsk,
+						 unsigned long addr)
+{
+	struct fault_handle *fh =
+			kmem_cache_alloc(__fault_handle_cache, GFP_ATOMIC);
+	int fk = __fault_hash_key(addr);
+	BUG_ON(!fh);
+
+	INIT_HLIST_NODE(&fh->list);
+
+	fh->addr = addr;
+	fh->flags = 0;
+
+	init_waitqueue_head(&fh->waits);
+	init_waitqueue_head(&fh->waits_retry);
+	atomic_set(&fh->pendings, 1);
+	atomic_set(&fh->pendings_retry, 0);
+	fh->limit = 0;
+	fh->ret = 0;
+	fh->rc = get_task_remote(tsk);
+	fh->pid = tsk->pid;
+	fh->complete = NULL;
+
+	hlist_add_head(&fh->list, &fh->rc->faults[fk]);
+	return fh;
+}
+
+
+static struct fault_handle *__start_invalidation(struct task_struct *tsk,
+						 unsigned long addr,
+						 spinlock_t *ptl)
+{
+	unsigned long flags;
+	struct remote_context *rc = get_task_remote(tsk);
+	struct fault_handle *fh;
+	bool found = false;
+	DECLARE_COMPLETION_ONSTACK(complete);
+	int fk = __fault_hash_key(addr);
+
+	spin_lock_irqsave(&rc->faults_lock[fk], flags);
+	hlist_for_each_entry(fh, &rc->faults[fk], list) {
+		if (fh->addr == addr) {
+			PGPRINTK("  [%d] %s %s ongoing, wait\n", tsk->pid,
+				fh->flags & FAULT_HANDLE_REMOTE ? "remote" : "local",
+				fh->flags & FAULT_HANDLE_WRITE ? "write" : "read");
+			BUG_ON(fh->flags & FAULT_HANDLE_INVALIDATE);
+			fh->flags |= FAULT_HANDLE_INVALIDATE;
+			fh->complete = &complete;
+			found = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&rc->faults_lock[fk], flags);
+	put_task_remote(tsk);
+
+	if (found) {
+		spin_unlock(ptl);
+		PGPRINTK(" +[%d] %lx %p\n", tsk->pid, addr, fh);
+		wait_for_completion(&complete);
+		PGPRINTK(" =[%d] %lx %p\n", tsk->pid, addr, fh);
+		spin_lock(ptl);
+	} else {
+		fh = NULL;
+		PGPRINTK(" =[%d] %lx\n", tsk->pid, addr);
+	}
+	return fh;
+}
+
+static void __finish_invalidation(struct fault_handle *fh)
+{
+	unsigned long flags;
+	int fk;
+
+	if (!fh)
+		return;
+	fk = __fault_hash_key(fh->addr);
+
+	BUG_ON(atomic_read(&fh->pendings));
+	spin_lock_irqsave(&fh->rc->faults_lock[fk], flags);
+	hlist_del(&fh->list);
+	spin_unlock_irqrestore(&fh->rc->faults_lock[fk], flags);
+
+	__put_task_remote(fh->rc);
+	if (atomic_read(&fh->pendings_retry)) {
+		wake_up_all(&fh->waits_retry);
+	} else {
+		kmem_cache_free(__fault_handle_cache, fh);
+	}
+}
+
+static struct fault_handle *__start_fault_handling(struct task_struct *tsk,
+						   unsigned long addr,
+						   unsigned long fault_flags,
+						   spinlock_t *ptl, bool *leader)
+	__releases(ptl)
+{
+	unsigned long flags;
+	struct fault_handle *fh;
+	bool found = false;
+	struct remote_context *rc = get_task_remote(tsk);
+	DEFINE_WAIT(wait);
+	int fk = __fault_hash_key(addr);
+
+	spin_lock_irqsave(&rc->faults_lock[fk], flags);
+	spin_unlock(ptl);
+
+	hlist_for_each_entry(fh, &rc->faults[fk], list) {
+		if (fh->addr == addr) {
+			found = true;
+			break;
+		}
+	}
+
+	if (found) {
+		unsigned long action =
+				get_fh_action(tsk->at_remote, fh->flags, fault_flags);
+
+#ifdef CONFIG_POPCORN_CHECK_SANITY
+		BUG_ON(action == FH_ACTION_INVALID);
+#endif
+		if (action & FH_ACTION_RETRY) {
+			if (action & FH_ACTION_WAIT) {
+				goto out_wait_retry;
+			}
+			goto out_retry;
+		}
+#ifdef CONFIG_POPCORN_CHECK_SANITY
+		BUG_ON(action != FH_ACTION_FOLLOW);
+#endif
+
+		if (fh->limit++ > FH_ACTION_MAX_FOLLOWER) {
+			goto out_wait_retry;
+		}
+
+		atomic_inc(&fh->pendings);
+#ifndef CONFIG_POPCORN_DEBUG_PAGE_SERVER
+		prepare_to_wait(&fh->waits, &wait, TASK_UNINTERRUPTIBLE);
+#else
+		prepare_to_wait_exclusive(&fh->waits, &wait, TASK_UNINTERRUPTIBLE);
+#endif
+		spin_unlock_irqrestore(&rc->faults_lock[fk], flags);
+		PGPRINTK(" +[%d] %lx %p\n", tsk->pid, addr, fh);
+		put_task_remote(tsk);
+
+		io_schedule();
+		finish_wait(&fh->waits, &wait);
+
+		fh->pid = tsk->pid;
+		*leader = false;
+		return fh;
+	}
+
+	fh = __alloc_fault_handle(tsk, addr);
+	fh->flags |= fault_for_write(fault_flags) ? FAULT_HANDLE_WRITE : 0;
+	fh->flags |= (fault_flags & PC_FAULT_FLAG_REMOTE) ? FAULT_HANDLE_REMOTE : 0;
+
+	spin_unlock_irqrestore(&rc->faults_lock[fk], flags);
+	put_task_remote(tsk);
+
+	*leader = true;
+	return fh;
+
+out_wait_retry:
+	atomic_inc(&fh->pendings_retry);
+	prepare_to_wait(&fh->waits_retry, &wait, TASK_UNINTERRUPTIBLE);
+	spin_unlock_irqrestore(&rc->faults_lock[fk], flags);
+	put_task_remote(tsk);
+
+	PGPRINTK("  [%d] waits %p\n", tsk->pid, fh);
+	io_schedule();
+	finish_wait(&fh->waits_retry, &wait);
+	if (atomic_dec_and_test(&fh->pendings_retry)) {
+		kmem_cache_free(__fault_handle_cache, fh);
+	}
+	return NULL;
+
+out_retry:
+	spin_unlock_irqrestore(&rc->faults_lock[fk], flags);
+	put_task_remote(tsk);
+
+	PGPRINTK("  [%d] locked. retry %p\n", tsk->pid, fh);
+	return NULL;
+}
+
+static bool __finish_fault_handling(struct fault_handle *fh)
+{
+	unsigned long flags;
+	bool last = false;
+	int fk = __fault_hash_key(fh->addr);
+
+	spin_lock_irqsave(&fh->rc->faults_lock[fk], flags);
+	if (atomic_dec_return(&fh->pendings)) {
+		PGPRINTK(" >[%d] %lx %p\n", fh->pid, fh->addr, fh);
+#ifndef CONFIG_POPCORN_DEBUG_PAGE_SERVER
+		wake_up_all(&fh->waits);
+#else
+		wake_up(&fh->waits);
+#endif
+	} else {
+		PGPRINTK(">>[%d] %lx %p\n", fh->pid, fh->addr, fh);
+		if (fh->complete) {
+			complete(fh->complete);
+		} else {
+			hlist_del(&fh->list);
+			last = true;
+		}
+	}
+	spin_unlock_irqrestore(&fh->rc->faults_lock[fk], flags);
+
+	if (last) {
+		__put_task_remote(fh->rc);
+		if (atomic_read(&fh->pendings_retry)) {
+			wake_up_all(&fh->waits_retry);
+		} else {
+			kmem_cache_free(__fault_handle_cache, fh);
+		}
+	}
+	return last;
+}
+
+
+/*
+ * Helper functions for PTE following
+ */
+static pte_t *__get_pte_at(struct mm_struct *mm, unsigned long addr,
+			   pmd_t **ppmd,
+			   spinlock_t **ptlp)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd = pgd_offset(mm, addr);
+	if (!pgd || pgd_none(*pgd))
+		return NULL;
+
+	p4d = p4d_offset(pgd, addr);
+	if (!p4d || p4d_none(*p4d))
+		return NULL;
+
+	pud = pud_offset(p4d, addr);
+	if (!pud || pud_none(*pud))
+		return NULL;
+
+	pmd = pmd_offset(pud, addr);
+	if (!pmd || pmd_none(*pmd))
+		return NULL;
+
+	*ppmd = pmd;
+	*ptlp = pte_lockptr(mm, pmd);
+
+	return pte_offset_map(pmd, addr);
+}
+
+static pte_t *__get_pte_at_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
+				 unsigned long addr, pmd_t **ppmd,
+				 spinlock_t **ptlp)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset(mm, addr);
+	if (!pgd)
+		return NULL;
+
+	p4d = p4d_alloc(mm, pgd, addr);
+	if (!p4d)
+		return NULL;
+
+	pud = pud_alloc(mm, p4d, addr);
+	if (!pud)
+		return NULL;
+
+	pmd = pmd_alloc(mm, pud, addr);
+	if (!pmd)
+		return NULL;
+
+	pte = pte_alloc_map(mm, pmd, addr);
+
+	*ppmd = pmd;
+	*ptlp = pte_lockptr(mm, pmd);
+	return pte;
+}
+
+static struct page *__find_page_at(struct mm_struct *mm, unsigned long addr,
+				   pte_t **ptep, spinlock_t **ptlp)
+{
+	pmd_t *pmd;
+	pte_t *pte = NULL;
+	spinlock_t *ptl = NULL;
+	struct page *page = ERR_PTR(-ENOMEM);
+
+	pte = __get_pte_at(mm, addr, &pmd, &ptl);
+
+	if (pte == NULL) {
+		pte = NULL;
+		ptl = NULL;
+		page = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	if (pte_none(*pte)) {
+		pte_unmap(pte);
+		pte = NULL;
+		ptl = NULL;
+		page = ERR_PTR(-ENOENT);
+		goto out;
+	}
+
+	spin_lock(ptl);
+	page = pte_page(*pte);
+	get_page(page);
+
+out:
+	*ptep = pte;
+	*ptlp = ptl;
+	return page;
+}
+
+
+/*
+ * Panicked by bug!!!!!
+ */
+void page_server_panic(bool condition, struct mm_struct *mm,
+		       unsigned long address, pte_t *pte,
+		       pte_t pte_val)
+{
+	unsigned long *pi;
+	unsigned long pi_val = -1;
+	unsigned long offset;
+
+	if (!condition)
+		return;
+
+	pi = __get_page_info_mapped(mm, address, &offset);
+	if (pi) {
+		pi_val = *pi;
+		kunmap_atomic(pi - offset);
+	}
+
+	printk(KERN_ERR "------------------ Start panicking -----------------\n");
+	printk(KERN_ERR "%s: %lx %p %lx %p %lx\n", __func__,
+			address, pi, pi_val, pte, pte_flags(pte_val));
+	show_regs(current_pt_regs());
+	BUG_ON("Page server panicked!!");
+}
+
+
+/*
+ * Flush pages to the origin
+ */
+enum {
+	FLUSH_FLAG_START = 0x01,
+	FLUSH_FLAG_FLUSH = 0x02,
+	FLUSH_FLAG_RELEASE = 0x04,
+	FLUSH_FLAG_LAST = 0x10,
+};
+
+
+static void process_remote_page_flush(struct work_struct *work)
+{
+	START_KMSG_WORK(remote_page_flush_t, req, work);
+	unsigned long addr = req->addr;
+	struct task_struct *tsk;
+	struct mm_struct *mm;
+	struct remote_context *rc;
+	struct page *page;
+	pte_t *pte, entry;
+	spinlock_t *ptl;
+	void *paddr;
+	struct vm_area_struct *vma;
+	remote_page_flush_ack_t res = {
+		.remote_ws = req->remote_ws,
+	};
+
+	PGPRINTK("  [%d] flush ->[%d/%d] %lx\n",
+			req->origin_pid, req->remote_pid, req->remote_nid, addr);
+
+	tsk = __get_task_struct(req->origin_pid);
+	if (!tsk)
+		goto out_free;
+
+	mm = get_task_mm(tsk);
+	rc = get_task_remote(tsk);
+
+	if (req->flags & FLUSH_FLAG_START) {
+		res.flags = FLUSH_FLAG_START;
+		pcn_kmsg_send(PCN_KMSG_TYPE_REMOTE_PAGE_FLUSH_ACK,
+				req->remote_nid, &res, sizeof(res));
+		goto out_put;
+	} else if (req->flags & FLUSH_FLAG_LAST) {
+		res.flags = FLUSH_FLAG_LAST;
+		pcn_kmsg_send(PCN_KMSG_TYPE_REMOTE_PAGE_FLUSH_ACK,
+				req->remote_nid, &res, sizeof(res));
+		goto out_put;
+	}
+
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, addr);
+	BUG_ON(!vma || vma->vm_start > addr);
+
+	page = __find_page_at(mm, addr, &pte, &ptl);
+	BUG_ON(IS_ERR(page));
+
+	/* XXX should be outside of ptl lock */
+	if (req->flags & FLUSH_FLAG_FLUSH) {
+		paddr = kmap(page);
+		copy_to_user_page(vma, page, addr, paddr, req->page, PAGE_SIZE);
+		kunmap(page);
+	}
+
+	SetPageDistributed(mm, addr);
+	set_page_owner(my_nid, mm, addr);
+	clear_page_owner(req->remote_nid, mm, addr);
+
+	/* XXX Should update through clear_flush and set */
+	entry = pte_make_valid(*pte);
+
+	set_pte_at_notify(mm, addr, pte, entry);
+	update_mmu_cache(vma, addr, pte);
+	flush_tlb_page(vma, addr);
+
+	put_page(page);
+
+	pte_unmap_unlock(pte, ptl);
+	up_read(&mm->mmap_sem);
+
+out_put:
+	put_task_remote(tsk);
+	put_task_struct(tsk);
+	mmput(mm);
+
+out_free:
+	END_KMSG_WORK(req);
+}
+
+
+static int __do_pte_flush(pte_t *pte, unsigned long addr, unsigned long next,
+			  struct mm_walk *walk)
+{
+	remote_page_flush_t *req = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	struct page *page;
+	int req_size;
+	enum pcn_kmsg_type req_type;
+	char type;
+
+	if (pte_none(*pte))
+		return 0;
+
+	page = pte_page(*pte);
+	BUG_ON(!page);
+
+	if (test_page_owner(my_nid, vma->vm_mm, addr)) {
+		req->addr = addr;
+		if ((vma->vm_flags & VM_WRITE) && pte_write(*pte)) {
+			void *paddr;
+			flush_cache_page(vma, addr, page_to_pfn(page));
+			paddr = kmap_atomic(page);
+			copy_from_user_page(walk->vma, page, addr, req->page, paddr, PAGE_SIZE);
+			kunmap_atomic(paddr);
+
+			req_type = PCN_KMSG_TYPE_REMOTE_PAGE_FLUSH;
+			req_size = sizeof(remote_page_flush_t);
+			req->flags = FLUSH_FLAG_FLUSH;
+			type = '*';
+		} else {
+			req_type = PCN_KMSG_TYPE_REMOTE_PAGE_RELEASE;
+			req_size = sizeof(remote_page_release_t);
+			req->flags = FLUSH_FLAG_RELEASE;
+			type = '+';
+		}
+		clear_page_owner(my_nid, vma->vm_mm, addr);
+
+		pcn_kmsg_send(req_type, current->origin_nid, req, req_size);
+	} else {
+		*pte = pte_make_valid(*pte);
+		type = '-';
+	}
+	PGPRINTK("  [%d] %c %lx\n", current->pid, type, addr);
+
+	return 0;
+}
+
+
+int page_server_flush_remote_pages(struct remote_context *rc)
+{
+	remote_page_flush_t *req = kmalloc(sizeof(*req), GFP_KERNEL);
+	struct mm_struct *mm = rc->mm;
+	struct mm_walk walk = {
+		.pte_entry = __do_pte_flush,
+		.mm = mm,
+		.private = req,
+	};
+	struct vm_area_struct *vma;
+	struct wait_station *ws = get_wait_station(current);
+
+	BUG_ON(!req);
+
+	PGPRINTK("FLUSH_REMOTE_PAGES [%d]\n", current->pid);
+
+	req->remote_nid = my_nid;
+	req->remote_pid = current->pid;
+	req->remote_ws = ws->id;
+	req->origin_pid = current->origin_pid;
+	req->addr = 0;
+
+	/* Notify the start synchronously */
+	req->flags = FLUSH_FLAG_START;
+	pcn_kmsg_send(PCN_KMSG_TYPE_REMOTE_PAGE_RELEASE,
+			current->origin_nid, req, sizeof(*req));
+	wait_at_station(ws);
+
+	/* Send pages asynchronously */
+	ws = get_wait_station(current);
+	down_read(&mm->mmap_sem);
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		walk.vma = vma;
+		walk_page_vma(vma, &walk);
+	}
+	up_read(&mm->mmap_sem);
+
+	/* Notify the completion synchronously */
+	req->flags = FLUSH_FLAG_LAST;
+	pcn_kmsg_send(PCN_KMSG_TYPE_REMOTE_PAGE_FLUSH,
+			current->origin_nid, req, sizeof(*req));
+	wait_at_station(ws);
+
+	kfree(req);
+
+	// XXX: make sure there is no backlog.
+	msleep(1000);
+
+	return 0;
+}
+
+static int handle_remote_page_flush_ack(struct pcn_kmsg_message *msg)
+{
+	remote_page_flush_ack_t *req = (remote_page_flush_ack_t *)msg;
+	struct wait_station *ws = wait_station(req->remote_ws);
+
+	complete(&ws->pendings);
+
+	pcn_kmsg_done(req);
+	return 0;
+}
+
+
+/*
+ * Page invalidation protocol
+ */
+static void __do_invalidate_page(struct task_struct *tsk,
+				 page_invalidate_request_t *req)
+{
+	struct mm_struct *mm = get_task_mm(tsk);
+	struct vm_area_struct *vma;
+	pmd_t *pmd;
+	pte_t *pte, entry;
+	spinlock_t *ptl;
+	int ret = 0;
+	unsigned long addr = req->addr;
+	struct fault_handle *fh;
+
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, addr);
+	if (!vma || vma->vm_start > addr) {
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
+
+	PGPRINTK("\nINVALIDATE_PAGE [%d] %lx [%d/%d]\n", tsk->pid, addr,
+			req->origin_pid, PCN_KMSG_FROM_NID(req));
+
+	pte = __get_pte_at(mm, addr, &pmd, &ptl);
+	if (!pte)
+		goto out;
+
+	spin_lock(ptl);
+	fh = __start_invalidation(tsk, addr, ptl);
+
+	clear_page_owner(my_nid, mm, addr);
+
+	BUG_ON(!pte_present(*pte));
+	entry = ptep_clear_flush(vma, addr, pte);
+	entry = pte_make_invalid(entry);
+
+	set_pte_at_notify(mm, addr, pte, entry);
+	update_mmu_cache(vma, addr, pte);
+
+	__finish_invalidation(fh);
+	pte_unmap_unlock(pte, ptl);
+
+out:
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+}
+
+static void process_page_invalidate_request(struct work_struct *work)
+{
+	START_KMSG_WORK(page_invalidate_request_t, req, work);
+	page_invalidate_response_t *res;
+	struct task_struct *tsk;
+
+	res = pcn_kmsg_get(sizeof(*res));
+	res->origin_pid = req->origin_pid;
+	res->origin_ws = req->origin_ws;
+	res->remote_pid = req->remote_pid;
+
+	/* Only home issues invalidate requests. Hence, I am a remote */
+	tsk = __get_task_struct(req->remote_pid);
+	if (!tsk) {
+		PGPRINTK("%s: no such process %d %d %lx\n", __func__,
+				req->origin_pid, req->remote_pid, req->addr);
+		pcn_kmsg_put(res);
+		goto out_free;
+	}
+
+	__do_invalidate_page(tsk, req);
+
+	PGPRINTK(">>[%d] ->[%d/%d]\n", req->remote_pid, res->origin_pid,
+			PCN_KMSG_FROM_NID(req));
+	pcn_kmsg_post(PCN_KMSG_TYPE_PAGE_INVALIDATE_RESPONSE,
+			PCN_KMSG_FROM_NID(req), res, sizeof(*res));
+
+	put_task_struct(tsk);
+
+out_free:
+	END_KMSG_WORK(req);
+}
+
+
+static int handle_page_invalidate_response(struct pcn_kmsg_message *msg)
+{
+	page_invalidate_response_t *res = (page_invalidate_response_t *)msg;
+	struct wait_station *ws = wait_station(res->origin_ws);
+
+	if (atomic_dec_and_test(&ws->pendings_count)) {
+		complete(&ws->pendings);
+	}
+
+	pcn_kmsg_done(res);
+	return 0;
+}
+
+
+static void __revoke_page_ownership(struct task_struct *tsk, int nid, pid_t pid,
+				    unsigned long addr, int ws_id)
+{
+	page_invalidate_request_t *req = pcn_kmsg_get(sizeof(*req));
+
+	req->addr = addr;
+	req->origin_pid = tsk->pid;
+	req->origin_ws = ws_id;
+	req->remote_pid = pid;
+
+	PGPRINTK("  [%d] revoke %lx [%d/%d]\n", tsk->pid, addr, pid, nid);
+	pcn_kmsg_post(PCN_KMSG_TYPE_PAGE_INVALIDATE_REQUEST, nid, req, sizeof(*req));
+}
+
+
+/*
+ * Voluntarily release page ownership
+ */
+int process_madvise_release_from_remote(int from_nid, unsigned long start,
+					unsigned long end)
+{
+	struct mm_struct *mm;
+	unsigned long addr;
+	int nr_pages = 0;
+
+	mm = get_task_mm(current);
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
+		pmd_t *pmd;
+		pte_t *pte;
+		spinlock_t *ptl;
+		pte = __get_pte_at(mm, addr, &pmd, &ptl);
+		if (!pte)
+			continue;
+		spin_lock(ptl);
+		if (!pte_none(*pte)) {
+			clear_page_owner(from_nid, mm, addr);
+			nr_pages++;
+		}
+		pte_unmap_unlock(pte, ptl);
+	}
+	mmput(mm);
+	VSPRINTK("  [%d] %d %d / %ld %lx-%lx\n", current->pid, from_nid,
+			nr_pages, (end - start) / PAGE_SIZE, start, end);
+	return 0;
+}
+
+int page_server_release_page_ownership(struct vm_area_struct *vma,
+				       unsigned long addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pmd_t *pmd;
+	pte_t *pte;
+	pte_t pte_val;
+	spinlock_t *ptl;
+
+	pte = __get_pte_at(mm, addr, &pmd, &ptl);
+	if (!pte)
+		return 0;
+
+	spin_lock(ptl);
+	if (pte_none(*pte) || !pte_present(*pte)) {
+		pte_unmap_unlock(pte, ptl);
+		return 0;
+	}
+
+	clear_page_owner(my_nid, mm, addr);
+	pte_val = ptep_clear_flush(vma, addr, pte);
+	pte_val = pte_make_invalid(pte_val);
+
+	set_pte_at_notify(mm, addr, pte, pte_val);
+	update_mmu_cache(vma, addr, pte);
+	pte_unmap_unlock(pte, ptl);
+	return 1;
+}
+
+
+/*
+ * Handle page faults happened at remote nodes.
+ */
+static int handle_remote_page_response(struct pcn_kmsg_message *msg)
+{
+	remote_page_response_t *res = (remote_page_response_t *)msg;
+	struct wait_station *ws = wait_station(res->origin_ws);
+
+	PGPRINTK("  [%d] <-[%d/%d] %lx %x\n",
+			ws->pid, res->remote_pid, PCN_KMSG_FROM_NID(res),
+			res->addr, res->result);
+	ws->private = res;
+
+	if (atomic_dec_and_test(&ws->pendings_count))
+		complete(&ws->pendings);
+	return 0;
+}
+
+#define TRANSFER_PAGE_WITH_RDMA \
+		pcn_kmsg_has_features(PCN_KMSG_FEATURE_RDMA)
+
+static int __request_remote_page(struct task_struct *tsk, int from_nid,
+				 pid_t from_pid, unsigned long addr,
+				 unsigned long fault_flags, int ws_id,
+				 struct pcn_kmsg_rdma_handle **rh)
+{
+	remote_page_request_t *req;
+
+	*rh = NULL;
+
+	req = pcn_kmsg_get(sizeof(*req));
+	req->addr = addr;
+	req->fault_flags = fault_flags;
+
+	req->origin_pid = tsk->pid;
+	req->origin_ws = ws_id;
+
+	req->remote_pid = from_pid;
+	req->instr_addr = instruction_pointer(current_pt_regs());
+
+	if (TRANSFER_PAGE_WITH_RDMA) {
+		struct pcn_kmsg_rdma_handle *handle =
+				pcn_kmsg_pin_rdma_buffer(NULL, PAGE_SIZE);
+		if (IS_ERR(handle)) {
+			pcn_kmsg_put(req);
+			return PTR_ERR(handle);
+		}
+		*rh = handle;
+		req->rdma_addr = handle->dma_addr;
+		req->rdma_key = handle->rkey;
+	} else {
+		req->rdma_addr = 0;
+		req->rdma_key = 0;
+	}
+
+	PGPRINTK("  [%d] ->[%d/%d] %lx %lx\n", tsk->pid,
+			from_pid, from_nid, addr, req->instr_addr);
+
+	pcn_kmsg_post(PCN_KMSG_TYPE_REMOTE_PAGE_REQUEST,
+			from_nid, req, sizeof(*req));
+	return 0;
+}
+
+static remote_page_response_t *__fetch_page_from_origin(struct task_struct *tsk,
+							struct vm_area_struct *vma,
+							unsigned long addr,
+							unsigned long fault_flags,
+							struct page *page)
+{
+	remote_page_response_t *rp;
+	struct wait_station *ws = get_wait_station(tsk);
+	struct pcn_kmsg_rdma_handle *rh;
+
+	__request_remote_page(tsk, tsk->origin_nid, tsk->origin_pid,
+			addr, fault_flags, ws->id, &rh);
+
+	rp = wait_at_station(ws);
+	if (rp->result == 0) {
+		void *paddr = kmap(page);
+		if (TRANSFER_PAGE_WITH_RDMA) {
+			copy_to_user_page(vma, page, addr, paddr, rh->addr, PAGE_SIZE);
+		} else {
+			copy_to_user_page(vma, page, addr, paddr, rp->page, PAGE_SIZE);
+		}
+		kunmap(page);
+		flush_dcache_page(page);
+		__SetPageUptodate(page);
+	}
+
+	if (rh)
+		pcn_kmsg_unpin_rdma_buffer(rh);
+
+	return rp;
+}
+
+static int __claim_remote_page(struct task_struct *tsk, struct mm_struct *mm,
+			       struct vm_area_struct *vma, unsigned long addr,
+			       unsigned long fault_flags, struct page *page)
+{
+	int peers;
+	unsigned int random = prandom_u32();
+	struct wait_station *ws;
+	struct remote_context *rc = __get_mm_remote(mm);
+	remote_page_response_t *rp;
+	int from, from_nid = 0;
+	/* Read when @from becomes zero and save the nid to @from_nid */
+	int nid;
+	struct pcn_kmsg_rdma_handle *rh = NULL;
+	unsigned long offset;
+	struct page *pip = __get_page_info_page(mm, addr, &offset);
+	unsigned long *pi = (unsigned long *)kmap(pip) + offset;
+	BUG_ON(!pip);
+
+	peers = bitmap_weight(pi, MAX_POPCORN_NODES);
+
+	if (test_bit(my_nid, pi)) {
+		peers--;
+	}
+#ifdef CONFIG_POPCORN_CHECK_SANITY
+	page_server_panic(peers == 0, mm, addr, NULL, __pte(0));
+#endif
+	from = random % peers;
+
+	if (fault_for_read(fault_flags)) {
+		peers = 1;
+	}
+	ws = get_wait_station_multiple(tsk, peers);
+
+	for_each_set_bit(nid, pi, MAX_POPCORN_NODES) {
+		pid_t pid = rc->remote_tgids[nid];
+		if (nid == my_nid) continue;
+		if (from-- == 0) {
+			from_nid = nid;
+			__request_remote_page(tsk, nid, pid, addr, fault_flags, ws->id, &rh);
+		} else {
+			if (fault_for_write(fault_flags)) {
+				clear_bit(nid, pi);
+				__revoke_page_ownership(tsk, nid, pid, addr, ws->id);
+			}
+		}
+		if (--peers == 0) break;
+	}
+
+	rp = wait_at_station(ws);
+
+	if (fault_for_write(fault_flags)) {
+		clear_bit(from_nid, pi);
+	}
+
+	if (rp->result == 0) {
+		void *paddr = kmap(page);
+		if (TRANSFER_PAGE_WITH_RDMA) {
+			copy_to_user_page(vma, page, addr, paddr, rh->addr, PAGE_SIZE);
+		} else {
+			copy_to_user_page(vma, page, addr, paddr, rp->page, PAGE_SIZE);
+		}
+		kunmap(page);
+		flush_dcache_page(page);
+		__SetPageUptodate(page);
+	}
+	pcn_kmsg_done(rp);
+
+	if (rh)
+		pcn_kmsg_unpin_rdma_buffer(rh);
+	__put_task_remote(rc);
+	kunmap(pip);
+	return 0;
+}
+
+static void __claim_local_page(struct task_struct *tsk, unsigned long addr,
+			       int except_nid)
+{
+	struct mm_struct *mm = tsk->mm;
+	unsigned long offset;
+	struct page *pip = __get_page_info_page(mm, addr, &offset);
+	unsigned long *pi;
+	int peers;
+
+	if (!pip) return; /* skip claiming non-distributed page */
+	pi = (unsigned long *)kmap(pip) + offset;
+	peers = bitmap_weight(pi, MAX_POPCORN_NODES);
+	if (!peers) {
+		kunmap(pip);
+		return;	/* skip claiming the page that is not distributed */
+	}
+
+	BUG_ON(!test_bit(except_nid, pi));
+	peers--;	/* exclude except_nid from peers */
+
+	if (test_bit(my_nid, pi) && except_nid != my_nid)
+		peers--;
+
+	if (peers > 0) {
+		int nid;
+		struct remote_context *rc = get_task_remote(tsk);
+		struct wait_station *ws = get_wait_station_multiple(tsk, peers);
+
+		for_each_set_bit(nid, pi, MAX_POPCORN_NODES) {
+			pid_t pid = rc->remote_tgids[nid];
+			if (nid == except_nid || nid == my_nid)
+				continue;
+
+			clear_bit(nid, pi);
+			__revoke_page_ownership(tsk, nid, pid, addr, ws->id);
+		}
+		put_task_remote(tsk);
+
+		wait_at_station(ws);
+	}
+	kunmap(pip);
+}
+
+void page_server_zap_pte(struct vm_area_struct *vma, unsigned long addr,
+			 pte_t *pte, pte_t *pteval)
+{
+	if (!vma->vm_mm->remote) return;
+
+	ClearPageInfo(vma->vm_mm, addr);
+
+	*pteval = pte_make_valid(*pte);
+	*pteval = pte_mkyoung(*pteval);
+	if (ptep_set_access_flags(vma, addr, pte, *pteval, 1)) {
+		update_mmu_cache(vma, addr, pte);
+	}
+#ifdef CONFIG_POPCORN_DEBUG_VERBOSE
+	PGPRINTK("  [%d] zap %lx\n", current->pid, addr);
+#endif
+}
+
+static void __make_pte_valid(struct mm_struct *mm,
+		struct vm_area_struct *vma, unsigned long addr,
+		unsigned long fault_flags, pte_t *pte)
+{
+	pte_t entry;
+
+	entry = ptep_clear_flush(vma, addr, pte);
+	entry = pte_make_valid(entry);
+
+	if (fault_for_write(fault_flags)) {
+		entry = pte_mkwrite(entry);
+		entry = pte_mkdirty(entry);
+	} else {
+		entry = pte_wrprotect(entry);
+	}
+	entry = pte_mkyoung(entry);
+
+	set_pte_at_notify(mm, addr, pte, entry);
+	update_mmu_cache(vma, addr, pte);
+
+	SetPageDistributed(mm, addr);
+	set_page_owner(my_nid, mm, addr);
+}
+
+
+/*
+ * Remote fault handler at a remote location
+ */
+static int __handle_remotefault_at_remote(struct task_struct *tsk,
+					  struct mm_struct *mm,
+					  struct vm_area_struct *vma,
+					  remote_page_request_t *req,
+					  remote_page_response_t *res)
+{
+	unsigned long addr = req->addr & PAGE_MASK;
+	unsigned fault_flags = req->fault_flags | PC_FAULT_FLAG_REMOTE;
+	unsigned char *paddr;
+	struct page *page;
+
+	spinlock_t *ptl;
+	pmd_t *pmd;
+	pte_t *pte;
+	pte_t entry;
+
+	struct fault_handle *fh;
+	bool leader;
+	bool present;
+
+	pte = __get_pte_at(mm, addr, &pmd, &ptl);
+	if (!pte) {
+		PGPRINTK("  [%d] No PTE!!\n", tsk->pid);
+		return VM_FAULT_OOM;
+	}
+
+	spin_lock(ptl);
+	fh = __start_fault_handling(tsk, addr, fault_flags, ptl, &leader);
+	if (!fh) {
+		pte_unmap(pte);
+		return VM_FAULT_LOCKED;
+	}
+
+	if (pte_none(*pte)) {
+		pte_unmap(pte);
+		return VM_FAULT_SIGSEGV;
+	}
+
+#ifdef CONFIG_POPCORN_CHECK_SANITY
+	BUG_ON(!page_is_mine(mm, addr));
+#endif
+
+	spin_lock(ptl);
+	SetPageDistributed(mm, addr);
+	entry = ptep_clear_flush(vma, addr, pte);
+
+	if (fault_for_write(fault_flags)) {
+		clear_page_owner(my_nid, mm, addr);
+		entry = pte_make_invalid(entry);
+	} else {
+		entry = pte_wrprotect(entry);
+	}
+
+	set_pte_at_notify(mm, addr, pte, entry);
+	update_mmu_cache(vma, addr, pte);
+	pte_unmap_unlock(pte, ptl);
+	present = pte_is_present(*pte);
+	page = vm_normal_page(vma, addr, *pte);
+	BUG_ON(!page);
+	flush_cache_page(vma, addr, page_to_pfn(page));
+	if (TRANSFER_PAGE_WITH_RDMA) {
+		paddr = kmap(page);
+		pcn_kmsg_rdma_write(PCN_KMSG_FROM_NID(req),
+				req->rdma_addr, paddr, PAGE_SIZE, req->rdma_key);
+		kunmap(page);
+	} else {
+		paddr = kmap_atomic(page);
+		copy_from_user_page(vma, page, addr, res->page, paddr, PAGE_SIZE);
+		kunmap_atomic(paddr);
+	}
+
+	__finish_fault_handling(fh);
+	return 0;
+}
+
+
+
+/*
+ * Remote fault handler at the origin
+ */
+static int __handle_remotefault_at_origin(struct task_struct *tsk,
+					  struct mm_struct *mm,
+					  struct vm_area_struct *vma,
+					  remote_page_request_t *req,
+					  remote_page_response_t *res)
+{
+	int from_nid = PCN_KMSG_FROM_NID(req);
+	unsigned long addr = req->addr;
+	unsigned long fault_flags = req->fault_flags | PC_FAULT_FLAG_REMOTE;
+	unsigned char *paddr;
+	struct page *page;
+
+	spinlock_t *ptl;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	struct fault_handle *fh;
+	bool leader;
+	bool grant = false;
+
+again:
+	pte = __get_pte_at_alloc(mm, vma, addr, &pmd, &ptl);
+	if (!pte) {
+		PGPRINTK("  [%d] No PTE!!\n", tsk->pid);
+		return VM_FAULT_OOM;
+	}
+
+	spin_lock(ptl);
+	if (pte_none(*pte)) {
+		int ret;
+		spin_unlock(ptl);
+		PGPRINTK("  [%d] handle local fault at origin\n", tsk->pid);
+		ret = handle_pte_fault_origin(mm, vma, addr, pte, pmd, fault_flags);
+		/* returned with pte unmapped */
+		if (ret & VM_FAULT_RETRY) {
+			/* mmap_sem is released during do_fault */
+			return VM_FAULT_RETRY;
+		}
+		if (fault_for_write(fault_flags) && !vma_is_anonymous(vma))
+			SetPageCowed(mm, addr);
+		goto again;
+	}
+
+	fh = __start_fault_handling(tsk, addr, fault_flags, ptl, &leader);
+
+	/*
+	 * Indicates the same page is handled at the origin and it might cause
+	 * this node to be blocked recursively. This prevents forming the loop
+	 * by releasing everything from remote.
+	 */
+	if (!fh) {
+		pte_unmap(pte);
+		up_read(&mm->mmap_sem);
+		return VM_FAULT_RETRY;
+	}
+	page = get_normal_page(vma, addr, pte);
+	BUG_ON(!page);
+
+	if (leader) {
+		pte_t entry;
+
+		/* Prepare the page if it is not mine. This should be leader */
+		PGPRINTK(" =[%d] %s%s %p\n",
+				tsk->pid, page_is_mine(mm, addr) ? "origin " : "",
+				test_page_owner(from_nid, mm, addr) ? "remote": "", fh);
+
+		if (test_page_owner(from_nid, mm, addr)) {
+			BUG_ON(fault_for_read(fault_flags) && "Read fault from owner??");
+			__claim_local_page(tsk, addr, from_nid);
+			grant = true;
+		} else {
+			if (!page_is_mine(mm, addr)) {
+				__claim_remote_page(tsk, mm, vma, addr, fault_flags, page);
+			} else {
+				if (fault_for_write(fault_flags))
+					__claim_local_page(tsk, addr, my_nid);
+			}
+		}
+		spin_lock(ptl);
+
+		SetPageDistributed(mm, addr);
+		set_page_owner(from_nid, mm, addr);
+
+		entry = ptep_clear_flush(vma, addr, pte);
+		if (fault_for_write(fault_flags)) {
+			clear_page_owner(my_nid, mm, addr);
+			entry = pte_make_invalid(entry);
+		} else {
+			/* For remote-claimed case */
+			entry = pte_make_valid(entry);
+			entry = pte_wrprotect(entry);
+			set_page_owner(my_nid, mm, addr);
+		}
+		set_pte_at_notify(mm, addr, pte, entry);
+		update_mmu_cache(vma, addr, pte);
+
+		spin_unlock(ptl);
+	}
+	pte_unmap(pte);
+
+	if (!grant) {
+		flush_cache_page(vma, addr, page_to_pfn(page));
+		if (TRANSFER_PAGE_WITH_RDMA) {
+			paddr = kmap(page);
+			pcn_kmsg_rdma_write(PCN_KMSG_FROM_NID(req),
+					req->rdma_addr, paddr, PAGE_SIZE, req->rdma_key);
+			kunmap(page);
+		} else {
+			paddr = kmap_atomic(page);
+			copy_from_user_page(vma, page, addr, res->page, paddr, PAGE_SIZE);
+			kunmap_atomic(paddr);
+		}
+	}
+
+	__finish_fault_handling(fh);
+	return grant ? VM_FAULT_CONTINUE : 0;
+}
+
+
+/*
+ * Entry point to remote fault handler
+ *
+ * To accelerate the ownership grant by skipping transferring page data,
+ * the response might be multiplexed between remote_page_response_short_t and
+ * remote_page_response_t.
+ */
+static void process_remote_page_request(struct work_struct *work)
+{
+	START_KMSG_WORK(remote_page_request_t, req, work);
+	remote_page_response_t *res;
+	int from_nid = PCN_KMSG_FROM_NID(req);
+	struct task_struct *tsk;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	int res_size;
+	enum pcn_kmsg_type res_type;
+	int down_read_retry = 0;
+
+	if (TRANSFER_PAGE_WITH_RDMA) {
+		res = pcn_kmsg_get(sizeof(remote_page_response_short_t));
+	} else {
+		res = pcn_kmsg_get(sizeof(*res));
+	}
+
+	do {
+		tsk = __get_task_struct(req->remote_pid);
+		if (!tsk) {
+			res->result = VM_FAULT_SIGBUS;
+			PGPRINTK("  [%d] not found\n", req->remote_pid);
+			break;
+		}
+		mm = get_task_mm(tsk);
+
+		PGPRINTK("\nREMOTE_PAGE_REQUEST [%d] %lx %c %lx from [%d/%d]\n",
+			 req->remote_pid, req->addr,
+			 fault_for_write(req->fault_flags) ? 'W' : 'R',
+			 req->instr_addr, req->origin_pid, from_nid);
+
+		while (!down_read_trylock(&mm->mmap_sem)) {
+			if (!tsk->at_remote && down_read_retry++ > 4) {
+				res->result = VM_FAULT_RETRY;
+				goto out_up;
+			}
+			schedule();
+		}
+		vma = find_vma(mm, req->addr);
+		if (!vma || vma->vm_start > req->addr) {
+			res->result = VM_FAULT_SIGBUS;
+			goto out_up;
+		}
+
+#ifdef CONFIG_POPCORN_CHECK_SANITY
+		BUG_ON(vma->vm_flags & VM_EXEC);
+#endif
+
+		if (tsk->at_remote) {
+			res->result = __handle_remotefault_at_remote(tsk, mm, vma, req, res);
+		} else {
+			res->result = __handle_remotefault_at_origin(tsk, mm, vma, req, res);
+		}
+
+		out_up:
+		if (res->result != VM_FAULT_RETRY) {
+			up_read(&mm->mmap_sem);
+		}
+		mmput(mm);
+		put_task_struct(tsk);
+
+	} while (res->result == VM_FAULT_LOCKED);
+
+	if (res->result != 0 || TRANSFER_PAGE_WITH_RDMA) {
+		res_type = PCN_KMSG_TYPE_REMOTE_PAGE_RESPONSE_SHORT;
+		res_size = sizeof(remote_page_response_short_t);
+	} else {
+		res_type = PCN_KMSG_TYPE_REMOTE_PAGE_RESPONSE;
+		res_size = sizeof(remote_page_response_t);
+	}
+	res->addr = req->addr;
+	res->remote_pid = req->remote_pid;
+
+	res->origin_pid = req->origin_pid;
+	res->origin_ws = req->origin_ws;
+
+	PGPRINTK("  [%d] ->[%d/%d] %x\n", req->remote_pid,
+			res->origin_pid, from_nid, res->result);
+
+	trace_pgfault(from_nid, req->remote_pid,
+			fault_for_write(req->fault_flags) ? 'W' : 'R',
+			req->instr_addr, req->addr, res->result);
+
+	pcn_kmsg_post(res_type, from_nid, res, res_size);
+
+	END_KMSG_WORK(req);
+}
+
+/*
+ * Exclusively keep a user page to the current node. Should put the user
+ * page after use. This routine is similar to localfault handler at origin
+ * thus may be refactored.
+ */
+int page_server_get_userpage(u32 __user *uaddr, struct fault_handle **handle,
+			     char *mode)
+{
+	unsigned long addr = (unsigned long)uaddr & PAGE_MASK;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+
+	const unsigned long fault_flags = 0;
+	struct fault_handle *fh = NULL;
+	spinlock_t *ptl;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	bool leader;
+	int ret = 0;
+
+	*handle = NULL;
+	if (!distributed_process(current))
+		return 0;
+
+	mm = get_task_mm(current);
+retry:
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, addr);
+	if (!vma || vma->vm_start > addr) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	pte = __get_pte_at(mm, addr, &pmd, &ptl);
+	if (!pte) {
+		ret = -EINVAL;
+		goto out;
+	}
+	spin_lock(ptl);
+	fh = __start_fault_handling(current, addr, fault_flags, ptl, &leader);
+
+	if (!fh) {
+		pte_unmap(pte);
+		up_read(&mm->mmap_sem);
+		io_schedule();
+		goto retry;
+	}
+
+	if (leader && !page_is_mine(mm, addr)) {
+		struct page *page = get_normal_page(vma, addr, pte);
+		__claim_remote_page(current, mm, vma, addr, fault_flags, page);
+
+		spin_lock(ptl);
+		__make_pte_valid(mm, vma, addr, fault_flags, pte);
+		spin_unlock(ptl);
+	}
+	pte_unmap(pte);
+	ret = 0;
+
+out:
+	*handle = fh;
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+	return ret;
+}
+
+void page_server_put_userpage(struct fault_handle *fh, char *mode)
+{
+	if (!fh)
+		return;
+
+	__finish_fault_handling(fh);
+}
+
+
+/*
+ * Local fault handler at the remote
+ */
+static int __handle_localfault_at_remote(struct vm_fault *vmf)
+{
+	spinlock_t *ptl;
+	struct page *page;
+	bool populated = false;
+	struct mem_cgroup *memcg;
+	int ret = 0;
+
+	struct fault_handle *fh;
+	bool leader;
+	remote_page_response_t *rp;
+	unsigned long addr = vmf->address & PAGE_MASK;
+	bool present;
+
+	if (anon_vma_prepare(vmf->vma)) {
+		BUG_ON("Cannot prepare vma for anonymous page");
+		pte_unmap(vmf->pte);
+		return VM_FAULT_SIGBUS;
+	}
+
+	ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
+	spin_lock(ptl);
+
+	if (!vmf->pte) {
+		vmf->pte = pte_alloc_map(vmf->vma->vm_mm, vmf->pmd, vmf->address);
+	}
+
+	/* setup and populate pte entry */
+	if (!pte_same(*vmf->pte, vmf->orig_pte)) {
+		pte_unmap_unlock(vmf->pte, ptl);
+		PGPRINTK("  [%d] %lx already handled\n", current->pid, addr);
+		return 0;
+	}
+	fh = __start_fault_handling(current, addr, vmf->flags, ptl, &leader);
+	if (!fh) {
+		pte_unmap(vmf->pte);
+		up_read(&vmf->vma->vm_mm->mmap_sem);
+		return VM_FAULT_RETRY;
+	}
+
+	PGPRINTK(" %c[%d] %lx %p\n", leader ? '=' : '-', current->pid, addr, fh);
+	if (!leader) {
+		pte_unmap(vmf->pte);
+		ret = fh->ret;
+		if (ret) up_read(&vmf->vma->vm_mm->mmap_sem);
+		goto out_follower;
+	}
+
+	present = pte_is_present(*vmf->pte);
+	if (!present) {
+		pte_make_valid(*vmf->pte);
+	}
+	page = vm_normal_page(vmf->vma, addr, *vmf->pte);
+	if (!present) {
+		pte_make_invalid(*vmf->pte);
+	}
+	if (pte_none(*vmf->pte) || !page) {
+		page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vmf->vma, addr);
+		BUG_ON(!page);
+
+		if (mem_cgroup_try_charge(page, vmf->vma->vm_mm, GFP_KERNEL, &memcg, false)) {
+			BUG();
+		}
+		populated = true;
+	}
+
+	get_page(page);
+
+	rp = __fetch_page_from_origin(current, vmf->vma, addr, vmf->flags, page);
+
+	if (rp->result && rp->result != VM_FAULT_CONTINUE) {
+		if (rp->result != VM_FAULT_RETRY)
+			PGPRINTK("  [%d] failed 0x%x\n", current->pid, rp->result);
+		ret = rp->result;
+		pte_unmap(vmf->pte);
+		up_read(&vmf->vma->vm_mm->mmap_sem);
+		goto out_free;
+	}
+
+	if (rp->result == VM_FAULT_CONTINUE) {
+		/*
+		 * Page ownership is granted without transferring the page data
+		 * since this node already owns the up-to-dated page
+		 */
+		pte_t entry;
+		BUG_ON(populated);
+
+		spin_lock(ptl);
+		entry = pte_make_valid(*vmf->pte);
+		if (fault_for_write(vmf->flags)) {
+			entry = pte_mkwrite(entry);
+			entry = pte_mkdirty(entry);
+		} else {
+			entry = pte_wrprotect(entry);
+		}
+		entry = pte_mkyoung(entry);
+
+		if (ptep_set_access_flags(vmf->vma, addr, vmf->pte, entry, 1)) {
+			update_mmu_cache(vmf->vma, addr, vmf->pte);
+		}
+	} else {
+		spin_lock(ptl);
+		if (populated) {
+			alloc_set_pte(vmf, memcg, page);
+		} else {
+			__make_pte_valid(vmf->vma->vm_mm, vmf->vma, addr, vmf->flags, vmf->pte);
+		}
+	}
+	SetPageDistributed(vmf->vma->vm_mm, addr);
+	set_page_owner(my_nid, vmf->vma->vm_mm, addr);
+	pte_unmap_unlock(vmf->pte, ptl);
+	ret = 0;	/* The leader squashes both 0 and VM_FAULT_CONTINUE to 0 */
+
+out_free:
+	put_page(page);
+	pcn_kmsg_done(rp);
+	fh->ret = ret;
+
+out_follower:
+	__finish_fault_handling(fh);
+	return ret;
+}
+
+static bool __handle_copy_on_write(struct mm_struct *mm,
+		struct vm_area_struct *vma, unsigned long addr,
+		pte_t *pte, pte_t *pte_val, unsigned int fault_flags)
+{
+	if (vma_is_anonymous(vma) || fault_for_read(fault_flags)) return false;
+	BUG_ON(vma->vm_flags & VM_SHARED);
+
+	/*
+	 * We need to determine whether the page is already cowed or not to
+	 * avoid unnecessary cows. But there is no explicit data structure that
+	 * bookkeeping such information. Also, explicitly tracking every CoW
+	 * including non-distributed processes is not desirable due to the
+	 * high frequency of CoW.
+	 * Fortunately, private vma is not flushed, implying the PTE dirty bit
+	 * is not cleared but kept throughout its lifetime. If the dirty bit is
+	 * set for a page, the page is written previously, which implies the page
+	 * is CoWed!!!
+	 */
+	if (pte_dirty(*pte_val)) return false;
+
+	if (PageCowed(mm, addr)) return false;
+
+	if (cow_file_at_origin(mm, vma, addr, pte)) return false;
+
+	*pte_val = *pte;
+	SetPageCowed(mm, addr);
+
+	return true;
+}
+
+/*
+ * Local fault handler at the origin
+ */
+static int __handle_localfault_at_origin(struct vm_fault *vmf)
+{
+	spinlock_t *ptl;
+	unsigned long addr = vmf->address & PAGE_MASK;
+	struct fault_handle *fh;
+	bool leader;
+
+	ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
+	spin_lock(ptl);
+
+	if (!vmf->pte) {
+		spin_unlock(ptl);
+		PGPRINTK("  [%d] %lx fresh at origin, continue\n", current->pid, addr);
+		return VM_FAULT_CONTINUE;
+	}
+
+	if (!pte_same(*vmf->pte, vmf->orig_pte)) {
+		pte_unmap_unlock(vmf->pte, ptl);
+		PGPRINTK("  [%d] %lx already handled\n", current->pid, addr);
+		return 0;
+	}
+
+	/* Fresh access to the address. Handle locally since we are at the origin */
+	if (pte_none(vmf->orig_pte)) {
+		BUG_ON(pte_present(vmf->orig_pte));
+		spin_unlock(ptl);
+		PGPRINTK("  [%d] fresh at origin. continue\n", current->pid);
+		return VM_FAULT_CONTINUE;
+	}
+
+	/* Nothing to do with DSM (e.g. COW). Handle locally */
+	if (!PageDistributed(vmf->vma->vm_mm, addr)) {
+		spin_unlock(ptl);
+		PGPRINTK("  [%d] local at origin. continue\n", current->pid);
+		return VM_FAULT_CONTINUE;
+	}
+
+	fh = __start_fault_handling(current, addr, vmf->flags, ptl, &leader);
+	if (!fh) {
+		pte_unmap(vmf->pte);
+		up_read(&vmf->vma->vm_mm->mmap_sem);
+		return VM_FAULT_RETRY;
+	}
+
+	/* Handle replicated page via the memory consistency protocol */
+	PGPRINTK(" %c[%d] %lx replicated %smine %p\n",
+			leader ? '=' : ' ', current->pid, addr,
+			page_is_mine(vmf->vma->vm_mm, addr) ? "" : "not ", fh);
+
+	if (!leader) {
+		pte_unmap(vmf->pte);
+		goto out_wakeup;
+	}
+
+	__handle_copy_on_write(vmf->vma->vm_mm, vmf->vma, addr, vmf->pte, &(vmf->orig_pte), vmf->flags);
+
+	if (page_is_mine(vmf->vma->vm_mm, addr)) {
+		if (fault_for_read(vmf->flags)) {
+			/* Racy exit */
+			pte_unmap(vmf->pte);
+			goto out_wakeup;
+		}
+
+		__claim_local_page(current, addr, my_nid);
+
+		spin_lock(ptl);
+		vmf->orig_pte = pte_mkwrite(vmf->orig_pte);
+		vmf->orig_pte = pte_mkdirty(vmf->orig_pte);
+		vmf->orig_pte = pte_mkyoung(vmf->orig_pte);
+
+		if (ptep_set_access_flags(vmf->vma, addr, vmf->pte, vmf->orig_pte, 1)) {
+			update_mmu_cache(vmf->vma, addr, vmf->pte);
+		}
+	} else {
+		struct page *page;
+		bool present;
+		present = pte_is_present(vmf->orig_pte);
+		if (!present) {
+			pte_make_valid(vmf->orig_pte);
+		}
+		page = vm_normal_page(vmf->vma, addr, vmf->orig_pte);
+		if (!present) {
+			pte_make_invalid(vmf->orig_pte);
+		}
+		BUG_ON(!page);
+
+		__claim_remote_page(current, vmf->vma->vm_mm, vmf->vma, addr, vmf->flags, page);
+
+		spin_lock(ptl);
+		__make_pte_valid(vmf->vma->vm_mm, vmf->vma, addr, vmf->flags, vmf->pte);
+	}
+#ifdef CONFIG_POPCORN_CHECK_SANITY
+	BUG_ON(!test_page_owner(my_nid, vmf->vma->vm_mm, addr));
+#endif
+	pte_unmap_unlock(vmf->pte, ptl);
+
+out_wakeup:
+	__finish_fault_handling(fh);
+
+	return 0;
+}
+
+/*
+ * Function:
+ *	page_server_handle_pte_fault
+ *
+ * Description:
+ *	Handle PTE faults with Popcorn page replication protocol.
+ *  down_read(&mm->mmap_sem) is already held when getting in.
+ *  DO NOT FORGET to unmap pte before returning non-VM_FAULT_CONTINUE.
+ *
+ * Input:
+ *	All are from the PTE handler
+ *
+ * Return values:
+ *	VM_FAULT_CONTINUE when the page fault can be handled locally.
+ *	0 if the fault is fetched remotely and fixed.
+ *  ERROR otherwise
+ */
+int page_server_handle_pte_fault(struct vm_fault *vmf)
+{
+	unsigned long addr = vmf->address & PAGE_MASK;
+	int ret = 0;
+
+	might_sleep();
+
+	PGPRINTK("\n## PAGEFAULT [%d] %lx %c %lx %x %lx\n",
+			current->pid, vmf->address,
+			fault_for_write(vmf->flags) ? 'W' : 'R',
+			instruction_pointer(current_pt_regs()),
+		 vmf->flags, pte_flags(vmf->orig_pte));
+
+	/*
+	 * Thread at the origin
+	 */
+	if (!current->at_remote) {
+		ret = __handle_localfault_at_origin(vmf);
+		goto out;
+	}
+
+	/*
+	 * Thread running at a remote
+	 *
+	 * Fault handling at the remote side is simpler than at the origin.
+	 * There will be no copy-on-write case at the remote since no thread
+	 * creation is allowed at the remote side.
+	 */
+	if (pte_none(vmf->orig_pte)) {
+		/* Can we handle the fault locally? */
+		if (vmf->vma->vm_flags & VM_EXEC) {
+			PGPRINTK("  [%d] VM_EXEC. continue\n", current->pid);
+			ret = VM_FAULT_CONTINUE;
+			goto out;
+		}
+		if (!vma_is_anonymous(vmf->vma) &&
+				((vmf->vma->vm_flags & (VM_WRITE | VM_SHARED)) == 0)) {
+			PGPRINTK("  [%d] locally file-mapped read-only. continue\n",
+					current->pid);
+			ret = VM_FAULT_CONTINUE;
+			goto out;
+		}
+	}
+
+	if (!pte_present(vmf->orig_pte)) {
+		/* Remote page fault */
+		ret = __handle_localfault_at_remote(vmf);
+		goto out;
+	}
+
+	if ((vmf->vma->vm_flags & VM_WRITE) &&
+			fault_for_write(vmf->flags) && !pte_write(vmf->orig_pte)) {
+		/* wr-protected for keeping page consistency */
+		ret = __handle_localfault_at_remote(vmf);
+		goto out;
+	}
+
+	pte_unmap(vmf->pte);
+	PGPRINTK("  [%d] might be fixed by others???\n", current->pid);
+	ret = 0;
+
+out:
+	trace_pgfault(my_nid, current->pid,
+			fault_for_write(vmf->flags) ? 'W' : 'R',
+			instruction_pointer(current_pt_regs()), addr, ret);
+
+	return ret;
+}
+
+
+/*
+ * Routing popcorn messages to workers
+ */
+DEFINE_KMSG_WQ_HANDLER(remote_page_request);
+DEFINE_KMSG_WQ_HANDLER(page_invalidate_request);
+DEFINE_KMSG_ORDERED_WQ_HANDLER(remote_page_flush);
+
+int __init page_server_init(void)
+{
+	REGISTER_KMSG_WQ_HANDLER(
+			PCN_KMSG_TYPE_REMOTE_PAGE_REQUEST, remote_page_request);
+	REGISTER_KMSG_HANDLER(
+			PCN_KMSG_TYPE_REMOTE_PAGE_RESPONSE, remote_page_response);
+	REGISTER_KMSG_HANDLER(
+			PCN_KMSG_TYPE_REMOTE_PAGE_RESPONSE_SHORT, remote_page_response);
+	REGISTER_KMSG_WQ_HANDLER(
+			PCN_KMSG_TYPE_PAGE_INVALIDATE_REQUEST, page_invalidate_request);
+	REGISTER_KMSG_HANDLER(
+			PCN_KMSG_TYPE_PAGE_INVALIDATE_RESPONSE, page_invalidate_response);
+	REGISTER_KMSG_WQ_HANDLER(
+			PCN_KMSG_TYPE_REMOTE_PAGE_FLUSH, remote_page_flush);
+	REGISTER_KMSG_WQ_HANDLER(
+			PCN_KMSG_TYPE_REMOTE_PAGE_RELEASE, remote_page_flush);
+	REGISTER_KMSG_HANDLER(
+			PCN_KMSG_TYPE_REMOTE_PAGE_FLUSH_ACK, remote_page_flush_ack);
+
+	__fault_handle_cache = kmem_cache_create("fault_handle",
+			sizeof(struct fault_handle), 0, 0, NULL);
+
+	return 0;
+}
diff --git a/kernel/popcorn/page_server.h b/kernel/popcorn/page_server.h
new file mode 100644
index 000000000..49eb1022a
--- /dev/null
+++ b/kernel/popcorn/page_server.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+#ifndef __INTERNAL_PAGE_SERVER_H__
+#define __INTERNAL_PAGE_SERVER_H__
+
+#include <popcorn/page_server.h>
+
+/*
+ * Flush pages in remote to the origin
+ */
+int page_server_flush_remote_pages(struct remote_context *rc);
+
+void free_remote_context_pages(struct remote_context *rc);
+int process_madvise_release_from_remote(int from_nid, unsigned long start,
+					unsigned long end);
+
+#endif /* __INTERNAL_PAGE_SERVER_H_ */
diff --git a/kernel/popcorn/pgtable.h b/kernel/popcorn/pgtable.h
new file mode 100644
index 000000000..b266b14f8
--- /dev/null
+++ b/kernel/popcorn/pgtable.h
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+#ifndef __KERNEL_POPCORN_PGTABLE_H__
+#define __KERNEL_POPCORN_PGTABLE_H__
+
+#include <asm/pgtable.h>
+
+#ifdef CONFIG_X86
+static inline pte_t pte_make_invalid(pte_t entry)
+{
+	entry = pte_modify(entry, __pgprot(pte_flags(entry) & ~_PAGE_PRESENT));
+
+	return entry;
+}
+
+static inline pte_t pte_make_valid(pte_t entry)
+{
+	entry = pte_modify(entry, __pgprot(pte_flags(entry) | _PAGE_PRESENT));
+
+	return entry;
+}
+
+static inline bool pte_is_present(pte_t entry)
+{
+	return (pte_val(entry) & _PAGE_PRESENT) == _PAGE_PRESENT;
+}
+
+#else
+#error "The architecture is not supported yet."
+#endif
+
+#endif
-- 
2.17.1

