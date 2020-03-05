Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A39C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674CF20848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgCERuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:50:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:24953 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgCERuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:50:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 09:50:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="320276072"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 05 Mar 2020 09:50:53 -0800
Subject: [RFC][PATCH 2/2] x86: add extra serialization for non-serializing MSRs
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, jan.kiszka@siemens.com,
        x86@kernel.org, peterz@infradead.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 05 Mar 2020 09:47:08 -0800
References: <20200305174706.0D6B8EE4@viggo.jf.intel.com>
In-Reply-To: <20200305174706.0D6B8EE4@viggo.jf.intel.com>
Message-Id: <20200305174708.F77040DD@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jan Kiszka reported that the x2apic_wrmsr_fence() function uses a
plain "mfence" while the Intel SDM (10.12.3 MSR Access in x2APIC
Mode) calls for "mfence;lfence".

Short summary: we have special MSRs that have weaker ordering
than all the rest.  Add fencing consistent with current SDM
recommendatrions.

This is not known to cause any issues in practice, only in
theory.

Longer story below:

The reason the kernel uses a different semantic is that the SDM
changed (roughly in late 2017).  The SDM changed because folks at
Intel were auditing all of the recommended fences in the SDM and
realized that the x2apic fences were insufficient.

Why was the pain "mfence" judged insufficient?

WRMSR itself is normally a serializing instruction.  No fences
are needed because because the instruction itself serializes
everything.

But, there are explicit exceptions for this serializing behavior
written into the WRMSR instruction documentation for two classes
of MSRs: IA32_TSC_DEADLINE and the X2APIC MSRs.

Back to x2apic: WRMSR is *not* serializing in this specific case.
But why is MFENCE insufficient?  MFENCE makes writes visible, but
only affects load/store instructions.  WRMSR is unfortunately not
a load/store instruction and is unaffected by MEFNCE.  This means
that a non-serializing WRMSR could be reordered by the CPU to
execute before the writes made visible by the MFENCE have even
occurred in the first place.

This mean that an x2apic IPI could theoretically be triggered
before there is any (visible) data to process.

Does this affect anything in practice?  I honestly don't know.
It seems quite possible that by the time an interrupt gets to
consume the (not yet) MFENCE'd data, it has become visible,
mostly by accident.

To be safe, add the SDM-recommended fences for all x2apic WRMSRs.

This also leaves open the question of the _other_ weakly-ordered
WRMSR: MSR_IA32_TSC_DEADLINE.  While it has the same ordering
architecture as the x2APIC MSRs, it seems substantially less
likely to be a problem in practice.  While writes to the
in-memory Local Vector Table (LVT) might theoretically be
reordered with respect to a weakly-ordered WRMSR like
TSC_DEADLINE, the SDM has this to say:

	In x2APIC mode, the WRMSR instruction is used to write to
	the LVT entry. The processor ensures the ordering of this
	write and any subsequent WRMSR to the deadline; no
	fencing is required.

But, that might still leave xAPIC exposed.  The safest thing to
do for now is to add the extra, recommended LFENCE.

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Cc: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>

---

 b/arch/x86/include/asm/apic.h           |   10 ----------
 b/arch/x86/include/asm/barrier.h        |   18 ++++++++++++++++++
 b/arch/x86/kernel/apic/apic.c           |    4 ++++
 b/arch/x86/kernel/apic/x2apic_cluster.c |    6 ++++--
 b/arch/x86/kernel/apic/x2apic_phys.c    |    9 ++++++---
 b/tools/arch/x86/include/asm/barrier.h  |    1 +
 6 files changed, 33 insertions(+), 15 deletions(-)

diff -puN arch/x86/include/asm/apic.h~x2apic-wrmsr-serialization arch/x86/include/asm/apic.h
--- a/arch/x86/include/asm/apic.h~x2apic-wrmsr-serialization	2020-03-05 09:42:38.876901038 -0800
+++ b/arch/x86/include/asm/apic.h	2020-03-05 09:42:38.891901038 -0800
@@ -195,16 +195,6 @@ static inline bool apic_needs_pit(void)
 #endif /* !CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_X2APIC
-/*
- * Make previous memory operations globally visible before
- * sending the IPI through x2apic wrmsr. We need a serializing instruction or
- * mfence for this.
- */
-static inline void x2apic_wrmsr_fence(void)
-{
-	asm volatile("mfence" : : : "memory");
-}
-
 static inline void native_apic_msr_write(u32 reg, u32 v)
 {
 	if (reg == APIC_DFR || reg == APIC_ID || reg == APIC_LDR ||
diff -puN arch/x86/include/asm/barrier.h~x2apic-wrmsr-serialization arch/x86/include/asm/barrier.h
--- a/arch/x86/include/asm/barrier.h~x2apic-wrmsr-serialization	2020-03-05 09:42:38.878901038 -0800
+++ b/arch/x86/include/asm/barrier.h	2020-03-05 09:42:38.893901038 -0800
@@ -84,4 +84,22 @@ do {									\
 
 #include <asm-generic/barrier.h>
 
+/*
+ * Make previous memory operations globally visible before
+ * a WRMSR.
+ *
+ * MFENCE makes writes visible, but only affects load/store
+ * instructions.  WRMSR is unfortunately not a load/store
+ * instruction and is unaffected by MEFNCE.  The LFENCE ensures
+ * that the WRMSR is not reordered.
+ *
+ * Most WRMSRs are full serializing instructions themselves and
+ * do not require this barrier.  This is only required for the
+ * IA32_TSC_DEADLINE and X2APIC MSRs.
+ */
+static inline void weak_wrmsr_fence(void)
+{
+	asm volatile("mfence; lfence" : : : "memory");
+}
+
 #endif /* _ASM_X86_BARRIER_H */
diff -puN arch/x86/kernel/apic/apic.c~x2apic-wrmsr-serialization arch/x86/kernel/apic/apic.c
--- a/arch/x86/kernel/apic/apic.c~x2apic-wrmsr-serialization	2020-03-05 09:42:38.880901038 -0800
+++ b/arch/x86/kernel/apic/apic.c	2020-03-05 09:42:38.892901038 -0800
@@ -42,6 +42,7 @@
 #include <asm/x86_init.h>
 #include <asm/pgalloc.h>
 #include <linux/atomic.h>
+#include <asm/barrier.h>
 #include <asm/mpspec.h>
 #include <asm/i8259.h>
 #include <asm/proto.h>
@@ -474,6 +475,9 @@ static int lapic_next_deadline(unsigned
 {
 	u64 tsc;
 
+	/* This MSR is special and need a special fence: */
+	weak_wrmsr_fence();
+
 	tsc = rdtsc();
 	wrmsrl(MSR_IA32_TSC_DEADLINE, tsc + (((u64) delta) * TSC_DIVISOR));
 	return 0;
diff -puN arch/x86/kernel/apic/x2apic_cluster.c~x2apic-wrmsr-serialization arch/x86/kernel/apic/x2apic_cluster.c
--- a/arch/x86/kernel/apic/x2apic_cluster.c~x2apic-wrmsr-serialization	2020-03-05 09:42:38.882901038 -0800
+++ b/arch/x86/kernel/apic/x2apic_cluster.c	2020-03-05 09:42:38.892901038 -0800
@@ -29,7 +29,8 @@ static void x2apic_send_IPI(int cpu, int
 {
 	u32 dest = per_cpu(x86_cpu_to_logical_apicid, cpu);
 
-	x2apic_wrmsr_fence();
+	/* x2apic MSRs are special and need a special fence: */
+	weak_wrmsr_fence();
 	__x2apic_send_IPI_dest(dest, vector, APIC_DEST_LOGICAL);
 }
 
@@ -41,7 +42,8 @@ __x2apic_send_IPI_mask(const struct cpum
 	unsigned long flags;
 	u32 dest;
 
-	x2apic_wrmsr_fence();
+	/* x2apic MSRs are special and need a special fence: */
+	weak_wrmsr_fence();
 	local_irq_save(flags);
 
 	tmpmsk = this_cpu_cpumask_var_ptr(ipi_mask);
diff -puN arch/x86/kernel/apic/x2apic_phys.c~x2apic-wrmsr-serialization arch/x86/kernel/apic/x2apic_phys.c
--- a/arch/x86/kernel/apic/x2apic_phys.c~x2apic-wrmsr-serialization	2020-03-05 09:42:38.885901038 -0800
+++ b/arch/x86/kernel/apic/x2apic_phys.c	2020-03-05 09:42:38.892901038 -0800
@@ -37,7 +37,8 @@ static void x2apic_send_IPI(int cpu, int
 {
 	u32 dest = per_cpu(x86_cpu_to_apicid, cpu);
 
-	x2apic_wrmsr_fence();
+	/* x2apic MSRs are special and need a special fence: */
+	weak_wrmsr_fence();
 	__x2apic_send_IPI_dest(dest, vector, APIC_DEST_PHYSICAL);
 }
 
@@ -48,7 +49,8 @@ __x2apic_send_IPI_mask(const struct cpum
 	unsigned long this_cpu;
 	unsigned long flags;
 
-	x2apic_wrmsr_fence();
+	/* x2apic MSRs are special and need a special fence: */
+	weak_wrmsr_fence();
 
 	local_irq_save(flags);
 
@@ -116,7 +118,8 @@ void __x2apic_send_IPI_shorthand(int vec
 {
 	unsigned long cfg = __prepare_ICR(which, vector, 0);
 
-	x2apic_wrmsr_fence();
+	/* x2apic MSRs are special and need a special fence: */
+	weak_wrmsr_fence();
 	native_x2apic_icr_write(cfg, 0);
 }
 
diff -puN tools/arch/x86/include/asm/barrier.h~x2apic-wrmsr-serialization tools/arch/x86/include/asm/barrier.h
--- a/tools/arch/x86/include/asm/barrier.h~x2apic-wrmsr-serialization	2020-03-05 09:42:38.887901038 -0800
+++ b/tools/arch/x86/include/asm/barrier.h	2020-03-05 09:42:38.892901038 -0800
@@ -43,4 +43,5 @@ do {						\
 	___p1;					\
 })
 #endif /* defined(__x86_64__) */
+
 #endif /* _TOOLS_LINUX_ASM_X86_BARRIER_H */
_
