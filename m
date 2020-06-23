Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF90CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C432D20707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZCnnFJXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgFWIji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731904AbgFWIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:39:25 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4E1C061797;
        Tue, 23 Jun 2020 01:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VmsXkGtiwXTh7dLc7lmby3THcx4SlWKLDBgj5xEab/Q=; b=ZCnnFJXhmdbrxezor0AQsUZNr2
        OLTWxDrskPKJumQ7ciFbr4gvbyCFH948otuF/xIyzGpYgJmfR5xioOPFT7KJg1Jrh6GxWV1HsQblG
        fq+Bqsw0yu68A6mucw2UfC0hHIGJDqq9EO/9VWAZtf8+bSoCkdEbQ9Ylt6hslcdpI4b8FxUrddSmn
        q6r+ZbniKdaTRAm1XNjsIQX6xe36EaOmKeLZ2Sn7Y18uBrEvh4ppL4WJJMoj2XwH0cuRjtDFaDMTM
        lDh9NCdtQ0lZjBFHhas4ZdblXKA/oR6GoDprnK6kPZZ7ukARpQy743zIb4+u9k3fneLNXKnbT1pDV
        mCOswYrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jneS3-0000fv-Qh; Tue, 23 Jun 2020 08:38:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9610C307634;
        Tue, 23 Jun 2020 10:38:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E6A3C237095FB; Tue, 23 Jun 2020 10:38:39 +0200 (CEST)
Message-ID: <20200623083721.336906073@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 23 Jun 2020 10:36:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: [PATCH v4 4/8] powerpc64: Break asm/percpu.h vs spinlock_types.h dependency
References: <20200623083645.277342609@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use <asm/percpu.h> in lockdep.h, we need to make sure
asm/percpu.h does not itself depend on lockdep.

The below seems to make that so and builds powerpc64-defconfig +
PROVE_LOCKING.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/powerpc/include/asm/dtl.h         |   52 +++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/lppaca.h      |   44 ---------------------------
 arch/powerpc/include/asm/paca.h        |    2 -
 arch/powerpc/kernel/time.c             |    2 +
 arch/powerpc/kvm/book3s_hv.c           |    1 
 arch/powerpc/platforms/pseries/dtl.c   |    1 
 arch/powerpc/platforms/pseries/lpar.c  |    1 
 arch/powerpc/platforms/pseries/setup.c |    1 
 arch/powerpc/platforms/pseries/svm.c   |    1 
 9 files changed, 60 insertions(+), 45 deletions(-)

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
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -29,7 +29,6 @@
 #include <asm/hmi.h>
 #include <asm/cpuidle.h>
 #include <asm/atomic.h>
-#include <asm/rtas-types.h>
 
 #include <asm-generic/mmiowb_types.h>
 
@@ -53,6 +52,7 @@ extern unsigned int debug_smp_processor_
 #define get_slb_shadow()	(get_paca()->slb_shadow_ptr)
 
 struct task_struct;
+struct rtas_args;
 
 /*
  * Defines the layout of the paca.
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -183,6 +183,8 @@ static inline unsigned long read_spurr(u
 
 #ifdef CONFIG_PPC_SPLPAR
 
+#include <asm/dtl.h>
+
 /*
  * Scan the dispatch trace log and count up the stolen time.
  * Should be called with interrupts disabled.
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -74,6 +74,7 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/kvm_book3s_uvmem.h>
 #include <asm/ultravisor.h>
+#include <asm/dtl.h>
 
 #include "book3s.h"
 
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
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -40,6 +40,7 @@
 #include <asm/fadump.h>
 #include <asm/asm-prototypes.h>
 #include <asm/debugfs.h>
+#include <asm/dtl.h>
 
 #include "pseries.h"
 
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -70,6 +70,7 @@
 #include <asm/idle.h>
 #include <asm/swiotlb.h>
 #include <asm/svm.h>
+#include <asm/dtl.h>
 
 #include "pseries.h"
 #include "../../../../drivers/pci/pci.h"
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -11,6 +11,7 @@
 #include <asm/svm.h>
 #include <asm/swiotlb.h>
 #include <asm/ultravisor.h>
+#include <asm/dtl.h>
 
 static int __init init_svm(void)
 {


