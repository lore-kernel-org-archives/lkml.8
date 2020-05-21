Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3313C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FB420874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgEUUcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbgEUUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:32:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FA5C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:32:14 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrr5-0000nN-JJ; Thu, 21 May 2020 22:31:51 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id B4639100606;
        Thu, 21 May 2020 22:31:50 +0200 (CEST)
Message-Id: <20200521202119.647997594@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:43 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V9 30/39] x86/entry: Convert various hypervisor vectors to
 IDTENTRY_SYSVEC
References: <20200521200513.656533920@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Convert various hypervisor vectors to IDTENTRY_SYSVEC
  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64bit
  - Remove the BUILD_INTERRUPT entries in 32bit
  - Remove the old prototypes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_32.S       |   14 --------------
 arch/x86/entry/entry_64.S       |   17 -----------------
 arch/x86/hyperv/hv_init.c       |    9 +++------
 arch/x86/include/asm/acrn.h     |   11 -----------
 arch/x86/include/asm/apic.h     |   20 --------------------
 arch/x86/include/asm/idtentry.h |   10 ++++++++++
 arch/x86/include/asm/mshyperv.h |   13 -------------
 arch/x86/kernel/cpu/acrn.c      |    9 ++++-----
 arch/x86/kernel/cpu/mshyperv.c  |   22 ++++++++++------------
 9 files changed, 27 insertions(+), 98 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1342,20 +1342,6 @@ BUILD_INTERRUPT3(xen_hvm_callback_vector
 		 xen_evtchn_do_upcall)
 #endif
 
-
-#if IS_ENABLED(CONFIG_HYPERV)
-
-BUILD_INTERRUPT3(hyperv_callback_vector, HYPERVISOR_CALLBACK_VECTOR,
-		 hyperv_vector_handler)
-
-BUILD_INTERRUPT3(hyperv_reenlightenment_vector, HYPERV_REENLIGHTENMENT_VECTOR,
-		 hyperv_reenlightenment_intr)
-
-BUILD_INTERRUPT3(hv_stimer0_callback_vector, HYPERV_STIMER0_VECTOR,
-		 hv_stimer0_vector_handler)
-
-#endif /* CONFIG_HYPERV */
-
 SYM_CODE_START_LOCAL_NOALIGN(handle_exception)
 	/* the function address is in %gs's slot on the stack */
 	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1116,23 +1116,6 @@ apicinterrupt3 HYPERVISOR_CALLBACK_VECTO
 	xen_hvm_callback_vector xen_evtchn_do_upcall
 #endif
 
-
-#if IS_ENABLED(CONFIG_HYPERV)
-apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
-	hyperv_callback_vector hyperv_vector_handler
-
-apicinterrupt3 HYPERV_REENLIGHTENMENT_VECTOR \
-	hyperv_reenlightenment_vector hyperv_reenlightenment_intr
-
-apicinterrupt3 HYPERV_STIMER0_VECTOR \
-	hv_stimer0_callback_vector hv_stimer0_vector_handler
-#endif /* CONFIG_HYPERV */
-
-#if IS_ENABLED(CONFIG_ACRN_GUEST)
-apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
-	acrn_hv_callback_vector acrn_hv_vector_handler
-#endif
-
 /*
  * Save all registers in pt_regs, and switch gs if needed.
  * Use slow, but surefire "are we in kernel?" check.
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -15,6 +15,7 @@
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
+#include <asm/idtentry.h>
 #include <linux/version.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
@@ -153,15 +154,11 @@ static inline bool hv_reenlightenment_av
 		ms_hyperv.features & HV_X64_ACCESS_REENLIGHTENMENT;
 }
 
-__visible void __irq_entry hyperv_reenlightenment_intr(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_reenlightenment)
 {
-	entering_ack_irq();
-
+	ack_APIC_irq();
 	inc_irq_stat(irq_hv_reenlightenment_count);
-
 	schedule_delayed_work(&hv_reenlightenment_work, HZ/10);
-
-	exiting_irq();
 }
 
 void set_hv_tscchange_cb(void (*cb)(void))
--- a/arch/x86/include/asm/acrn.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_ACRN_H
-#define _ASM_X86_ACRN_H
-
-extern void acrn_hv_callback_vector(void);
-#ifdef CONFIG_TRACING
-#define trace_acrn_hv_callback_vector acrn_hv_callback_vector
-#endif
-
-extern void acrn_hv_vector_handler(struct pt_regs *regs);
-#endif /* _ASM_X86_ACRN_H */
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -519,26 +519,6 @@ static inline bool apic_id_is_primary_th
 static inline void apic_smt_update(void) { }
 #endif
 
-extern void irq_enter(void);
-extern void irq_exit(void);
-
-static inline void entering_irq(void)
-{
-	irq_enter();
-	kvm_set_cpu_l1tf_flush_l1d();
-}
-
-static inline void entering_ack_irq(void)
-{
-	entering_irq();
-	ack_APIC_irq();
-}
-
-static inline void exiting_irq(void)
-{
-	irq_exit();
-}
-
 extern void ioapic_zap_locks(void);
 
 #endif /* _ASM_X86_APIC_H */
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -608,6 +608,16 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_WAKE
 DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested_ipi);
 #endif
 
+#if IS_ENABLED(CONFIG_HYPERV)
+DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_hyperv_callback);
+DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
+DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
+#endif
+
+#if IS_ENABLED(CONFIG_ACRN_GUEST)
+DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_acrn_hv_callback);
+#endif
+
 #undef X86_TRAP_OTHER
 
 #endif
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -54,20 +54,8 @@ typedef int (*hyperv_fill_flush_list_fun
 	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
 #define hv_get_raw_timer() rdtsc_ordered()
 
-void hyperv_callback_vector(void);
-void hyperv_reenlightenment_vector(void);
-#ifdef CONFIG_TRACING
-#define trace_hyperv_callback_vector hyperv_callback_vector
-#endif
 void hyperv_vector_handler(struct pt_regs *regs);
 
-/*
- * Routines for stimer0 Direct Mode handling.
- * On x86/x64, there are no percpu actions to take.
- */
-void hv_stimer0_vector_handler(struct pt_regs *regs);
-void hv_stimer0_callback_vector(void);
-
 static inline void hv_enable_stimer0_percpu_irq(int irq) {}
 static inline void hv_disable_stimer0_percpu_irq(int irq) {}
 
@@ -226,7 +214,6 @@ void hyperv_setup_mmu_ops(void);
 void *hv_alloc_hyperv_page(void);
 void *hv_alloc_hyperv_zeroed_page(void);
 void hv_free_hyperv_page(unsigned long addr);
-void hyperv_reenlightenment_intr(struct pt_regs *regs);
 void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
 void hyperv_stop_tsc_emulation(void);
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -10,10 +10,10 @@
  */
 
 #include <linux/interrupt.h>
-#include <asm/acrn.h>
 #include <asm/apic.h>
 #include <asm/desc.h>
 #include <asm/hypervisor.h>
+#include <asm/idtentry.h>
 #include <asm/irq_regs.h>
 
 static uint32_t __init acrn_detect(void)
@@ -24,7 +24,7 @@ static uint32_t __init acrn_detect(void)
 static void __init acrn_init_platform(void)
 {
 	/* Setup the IDT for ACRN hypervisor callback */
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, acrn_hv_callback_vector);
+	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_acrn_hv_callback);
 }
 
 static bool acrn_x2apic_available(void)
@@ -39,7 +39,7 @@ static bool acrn_x2apic_available(void)
 
 static void (*acrn_intr_handler)(void);
 
-__visible void __irq_entry acrn_hv_vector_handler(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_acrn_hv_callback)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
@@ -50,13 +50,12 @@ static void (*acrn_intr_handler)(void);
 	 * will block the interrupt whose vector is lower than
 	 * HYPERVISOR_CALLBACK_VECTOR.
 	 */
-	entering_ack_irq();
+	ack_APIC_irq();
 	inc_irq_stat(irq_hv_callback_count);
 
 	if (acrn_intr_handler)
 		acrn_intr_handler();
 
-	exiting_irq();
 	set_irq_regs(old_regs);
 }
 
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -23,6 +23,7 @@
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 #include <asm/desc.h>
+#include <asm/idtentry.h>
 #include <asm/irq_regs.h>
 #include <asm/i8259.h>
 #include <asm/apic.h>
@@ -40,11 +41,10 @@ static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
 static void (*hv_crash_handler)(struct pt_regs *regs);
 
-__visible void __irq_entry hyperv_vector_handler(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	entering_irq();
 	inc_irq_stat(irq_hv_callback_count);
 	if (vmbus_handler)
 		vmbus_handler();
@@ -52,7 +52,6 @@ static void (*hv_crash_handler)(struct p
 	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
 		ack_APIC_irq();
 
-	exiting_irq();
 	set_irq_regs(old_regs);
 }
 
@@ -73,19 +72,16 @@ EXPORT_SYMBOL_GPL(hv_remove_vmbus_irq);
  * Routines to do per-architecture handling of stimer0
  * interrupts when in Direct Mode
  */
-
-__visible void __irq_entry hv_stimer0_vector_handler(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_stimer0)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	entering_irq();
 	inc_irq_stat(hyperv_stimer0_count);
 	if (hv_stimer0_handler)
 		hv_stimer0_handler();
 	add_interrupt_randomness(HYPERV_STIMER0_VECTOR, 0);
 	ack_APIC_irq();
 
-	exiting_irq();
 	set_irq_regs(old_regs);
 }
 
@@ -331,17 +327,19 @@ static void __init ms_hyperv_init_platfo
 	x86_platform.apic_post_init = hyperv_init;
 	hyperv_setup_mmu_ops();
 	/* Setup the IDT for hypervisor callback */
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, hyperv_callback_vector);
+	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, sysvec_hyperv_callback);
 
 	/* Setup the IDT for reenlightenment notifications */
-	if (ms_hyperv.features & HV_X64_ACCESS_REENLIGHTENMENT)
+	if (ms_hyperv.features & HV_X64_ACCESS_REENLIGHTENMENT) {
 		alloc_intr_gate(HYPERV_REENLIGHTENMENT_VECTOR,
-				hyperv_reenlightenment_vector);
+				asm_sysvec_hyperv_reenlightenment);
+	}
 
 	/* Setup the IDT for stimer0 */
-	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
+	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE) {
 		alloc_intr_gate(HYPERV_STIMER0_VECTOR,
-				hv_stimer0_callback_vector);
+				asm_sysvec_hyperv_stimer0);
+	}
 
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;

