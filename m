Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89BBC4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E31124680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgBYX1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:27:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56031 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbgBYX1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:27:00 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaz-00055g-VU; Wed, 26 Feb 2020 00:26:34 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 46CCF10408E;
        Wed, 26 Feb 2020 00:25:53 +0100 (CET)
Message-Id: <20200225231609.926703522@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:29 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 10/15] x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC
References: <20200225224719.950376311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert various hypervisor vectors to IDTENTRY_SYSVEC
  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64bit
  - Remove the BUILD_INTERRUPT entries in 32bit
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |   14 --------------
 arch/x86/entry/entry_64.S       |   17 -----------------
 arch/x86/hyperv/hv_init.c       |    3 ++-
 arch/x86/include/asm/acrn.h     |   11 -----------
 arch/x86/include/asm/idtentry.h |   13 +++++++++++++
 arch/x86/include/asm/mshyperv.h |   14 --------------
 arch/x86/kernel/cpu/acrn.c      |    6 +++---
 arch/x86/kernel/cpu/mshyperv.c  |   18 ++++++++++--------
 8 files changed, 28 insertions(+), 68 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1380,20 +1380,6 @@ BUILD_INTERRUPT3(xen_hvm_callback_vector
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
 SYM_CODE_START_LOCAL_NOALIGN(common_exception)
 	/* the function address is in %gs's slot on the stack */
 	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1130,23 +1130,6 @@ apicinterrupt3 HYPERVISOR_CALLBACK_VECTO
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
@@ -151,7 +152,7 @@ static inline bool hv_reenlightenment_av
 		ms_hyperv.features & HV_X64_ACCESS_REENLIGHTENMENT;
 }
 
-__visible void __irq_entry hyperv_reenlightenment_intr(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_reenlightenment)
 {
 	entering_ack_irq();
 
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
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -523,6 +523,19 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_WAKE
 DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested_ipi);
 #endif
 
+#if IS_ENABLED(CONFIG_HYPERV)
+DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_hyperv_callback);
+DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
+DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
+#ifdef CONFIG_TRACING
+#define trace_hyperv_callback_vector asm_sysvec_hyperv_callback
+#endif
+#endif
+
+#if IS_ENABLED(CONFIG_ACRN_GUEST)
+DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_acrn_hv_callback);
+#endif
+
 #ifdef CONFIG_X86_MCE
 /* Machine check */
 DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -49,24 +49,11 @@ typedef int (*hyperv_fill_flush_list_fun
 	((val).archdata.vclock_mode = VCLOCK_HVCLOCK)
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
 
-
 #if IS_ENABLED(CONFIG_HYPERV)
 extern void *hv_hypercall_pg;
 extern void  __percpu  **hyperv_pcpu_input_arg;
@@ -221,7 +208,6 @@ void hyperv_setup_mmu_ops(void);
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
@@ -40,7 +41,7 @@ static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
 static void (*hv_crash_handler)(struct pt_regs *regs);
 
-__visible void __irq_entry hyperv_vector_handler(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
@@ -73,8 +74,7 @@ EXPORT_SYMBOL_GPL(hv_remove_vmbus_irq);
  * Routines to do per-architecture handling of stimer0
  * interrupts when in Direct Mode
  */
-
-__visible void __irq_entry hv_stimer0_vector_handler(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_stimer0)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
@@ -321,17 +321,19 @@ static void __init ms_hyperv_init_platfo
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

