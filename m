Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491BDC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224C82075F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="42qFGIpU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IWvf4pz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGKKKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 06:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgGKKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 06:09:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A43C08C5DD;
        Sat, 11 Jul 2020 03:09:57 -0700 (PDT)
Date:   Sat, 11 Jul 2020 10:09:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594462196;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pDkrlrM00qvT7UF2BhaTXlmL2vW/Jq7q6TwQl6OzQPk=;
        b=42qFGIpUHxd2IrQ7AQLUhTbM7nwOdTTA+G21xCYFVjlieB75OYwbsNiXNpOajgHxOCS7uV
        W5/hm4t8pkSVzTAfjUVV9Tk1emE2tqP448Vr09ihM4bpGr5RBN3Ablt0oeywqOtDouL69Q
        RWtVQGpQ+kW4jMhUT7EurnEcc20Zj8D1fwHsAd1K44pSxzqRgcM3WSjn4hsRDfCd0mjlab
        r0zk1sAPJHCcUpberHoPRo+Gn3zbiS6YouLJ4DiUyS/KKKMTBfY80mwqoFtzIl6NtXYLW1
        Ml5lgJORbCtYcXpfeXwFb4/LEVQTSlU4/aVo2XEXscJwCWdqpGri0Kyq6xWiJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594462196;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pDkrlrM00qvT7UF2BhaTXlmL2vW/Jq7q6TwQl6OzQPk=;
        b=IWvf4pz3nPF05RzkU9IVSHee1j4Vz/6XpGIFgVYfh3HOaiTho79D68Z9+KlrBSoFrfRhNR
        TQ3ZdxHjL3d/4DCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] powerpc64: Break asm/percpu.h vs spinlock_types.h
 dependency
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159446219548.4006.7485001842794216727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d6bdceb6c2276276c0392b926ccd2e5991d5cb9a
Gitweb:        https://git.kernel.org/tip/d6bdceb6c2276276c0392b926ccd2e5991d5cb9a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 29 May 2020 22:41:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jul 2020 12:00:01 +02:00

powerpc64: Break asm/percpu.h vs spinlock_types.h dependency

In order to use <asm/percpu.h> in lockdep.h, we need to make sure
asm/percpu.h does not itself depend on lockdep.

The below seems to make that so and builds powerpc64-defconfig +
PROVE_LOCKING.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
https://lkml.kernel.org/r/20200623083721.336906073@infradead.org
---
 arch/powerpc/include/asm/dtl.h         | 52 +++++++++++++++++++++++++-
 arch/powerpc/include/asm/lppaca.h      | 44 +---------------------
 arch/powerpc/include/asm/paca.h        |  2 +-
 arch/powerpc/kernel/time.c             |  2 +-
 arch/powerpc/kvm/book3s_hv.c           |  1 +-
 arch/powerpc/platforms/pseries/dtl.c   |  1 +-
 arch/powerpc/platforms/pseries/lpar.c  |  1 +-
 arch/powerpc/platforms/pseries/setup.c |  1 +-
 arch/powerpc/platforms/pseries/svm.c   |  1 +-
 9 files changed, 60 insertions(+), 45 deletions(-)
 create mode 100644 arch/powerpc/include/asm/dtl.h

diff --git a/arch/powerpc/include/asm/dtl.h b/arch/powerpc/include/asm/dtl.h
new file mode 100644
index 0000000..1625888
--- /dev/null
+++ b/arch/powerpc/include/asm/dtl.h
@@ -0,0 +1,52 @@
+#ifndef _ASM_POWERPC_DTL_H
+#define _ASM_POWERPC_DTL_H
+
+#include <asm/lppaca.h>
+#include <linux/spinlock_types.h>
+
+/*
+ * Layout of entries in the hypervisor's dispatch trace log buffer.
+ */
+struct dtl_entry {
+	u8	dispatch_reason;
+	u8	preempt_reason;
+	__be16	processor_id;
+	__be32	enqueue_to_dispatch_time;
+	__be32	ready_to_enqueue_time;
+	__be32	waiting_to_ready_time;
+	__be64	timebase;
+	__be64	fault_addr;
+	__be64	srr0;
+	__be64	srr1;
+};
+
+#define DISPATCH_LOG_BYTES	4096	/* bytes per cpu */
+#define N_DISPATCH_LOG		(DISPATCH_LOG_BYTES / sizeof(struct dtl_entry))
+
+/*
+ * Dispatch trace log event enable mask:
+ *   0x1: voluntary virtual processor waits
+ *   0x2: time-slice preempts
+ *   0x4: virtual partition memory page faults
+ */
+#define DTL_LOG_CEDE		0x1
+#define DTL_LOG_PREEMPT		0x2
+#define DTL_LOG_FAULT		0x4
+#define DTL_LOG_ALL		(DTL_LOG_CEDE | DTL_LOG_PREEMPT | DTL_LOG_FAULT)
+
+extern struct kmem_cache *dtl_cache;
+extern rwlock_t dtl_access_lock;
+
+/*
+ * When CONFIG_VIRT_CPU_ACCOUNTING_NATIVE = y, the cpu accounting code controls
+ * reading from the dispatch trace log.  If other code wants to consume
+ * DTL entries, it can set this pointer to a function that will get
+ * called once for each DTL entry that gets processed.
+ */
+extern void (*dtl_consumer)(struct dtl_entry *entry, u64 index);
+
+extern void register_dtl_buffer(int cpu);
+extern void alloc_dtl_buffers(unsigned long *time_limit);
+extern long hcall_vphn(unsigned long cpu, u64 flags, __be32 *associativity);
+
+#endif /* _ASM_POWERPC_DTL_H */
diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 3b4b305..c390ec3 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -42,7 +42,6 @@
  */
 #include <linux/cache.h>
 #include <linux/threads.h>
-#include <linux/spinlock_types.h>
 #include <asm/types.h>
 #include <asm/mmu.h>
 #include <asm/firmware.h>
@@ -146,49 +145,6 @@ struct slb_shadow {
 	} save_area[SLB_NUM_BOLTED];
 } ____cacheline_aligned;
 
-/*
- * Layout of entries in the hypervisor's dispatch trace log buffer.
- */
-struct dtl_entry {
-	u8	dispatch_reason;
-	u8	preempt_reason;
-	__be16	processor_id;
-	__be32	enqueue_to_dispatch_time;
-	__be32	ready_to_enqueue_time;
-	__be32	waiting_to_ready_time;
-	__be64	timebase;
-	__be64	fault_addr;
-	__be64	srr0;
-	__be64	srr1;
-};
-
-#define DISPATCH_LOG_BYTES	4096	/* bytes per cpu */
-#define N_DISPATCH_LOG		(DISPATCH_LOG_BYTES / sizeof(struct dtl_entry))
-
-/*
- * Dispatch trace log event enable mask:
- *   0x1: voluntary virtual processor waits
- *   0x2: time-slice preempts
- *   0x4: virtual partition memory page faults
- */
-#define DTL_LOG_CEDE		0x1
-#define DTL_LOG_PREEMPT		0x2
-#define DTL_LOG_FAULT		0x4
-#define DTL_LOG_ALL		(DTL_LOG_CEDE | DTL_LOG_PREEMPT | DTL_LOG_FAULT)
-
-extern struct kmem_cache *dtl_cache;
-extern rwlock_t dtl_access_lock;
-
-/*
- * When CONFIG_VIRT_CPU_ACCOUNTING_NATIVE = y, the cpu accounting code controls
- * reading from the dispatch trace log.  If other code wants to consume
- * DTL entries, it can set this pointer to a function that will get
- * called once for each DTL entry that gets processed.
- */
-extern void (*dtl_consumer)(struct dtl_entry *entry, u64 index);
-
-extern void register_dtl_buffer(int cpu);
-extern void alloc_dtl_buffers(unsigned long *time_limit);
 extern long hcall_vphn(unsigned long cpu, u64 flags, __be32 *associativity);
 
 #endif /* CONFIG_PPC_BOOK3S */
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 45a839a..84b2564 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -29,7 +29,6 @@
 #include <asm/hmi.h>
 #include <asm/cpuidle.h>
 #include <asm/atomic.h>
-#include <asm/rtas-types.h>
 
 #include <asm-generic/mmiowb_types.h>
 
@@ -53,6 +52,7 @@ extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
 #define get_slb_shadow()	(get_paca()->slb_shadow_ptr)
 
 struct task_struct;
+struct rtas_args;
 
 /*
  * Defines the layout of the paca.
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 6fcae43..f85539e 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -183,6 +183,8 @@ static inline unsigned long read_spurr(unsigned long tb)
 
 #ifdef CONFIG_PPC_SPLPAR
 
+#include <asm/dtl.h>
+
 /*
  * Scan the dispatch trace log and count up the stolen time.
  * Should be called with interrupts disabled.
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 6bf6664..ebb04f3 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -74,6 +74,7 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/kvm_book3s_uvmem.h>
 #include <asm/ultravisor.h>
+#include <asm/dtl.h>
 
 #include "book3s.h"
 
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index eab8aa2..982f069 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -12,6 +12,7 @@
 #include <asm/smp.h>
 #include <linux/uaccess.h>
 #include <asm/firmware.h>
+#include <asm/dtl.h>
 #include <asm/lppaca.h>
 #include <asm/debugfs.h>
 #include <asm/plpar_wrappers.h>
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index fd26f3d..f71ff2c 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -40,6 +40,7 @@
 #include <asm/fadump.h>
 #include <asm/asm-prototypes.h>
 #include <asm/debugfs.h>
+#include <asm/dtl.h>
 
 #include "pseries.h"
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 2db8469..27094c8 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -70,6 +70,7 @@
 #include <asm/idle.h>
 #include <asm/swiotlb.h>
 #include <asm/svm.h>
+#include <asm/dtl.h>
 
 #include "pseries.h"
 #include "../../../../drivers/pci/pci.h"
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 40c0637..e6d7a34 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -11,6 +11,7 @@
 #include <asm/svm.h>
 #include <asm/swiotlb.h>
 #include <asm/ultravisor.h>
+#include <asm/dtl.h>
 
 static int __init init_svm(void)
 {
