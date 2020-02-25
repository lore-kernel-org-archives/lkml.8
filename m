Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0CDC4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B3E24680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgBYX2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:28:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55976 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbgBYX0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:48 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jav-00054D-VJ; Wed, 26 Feb 2020 00:26:31 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C974C1040C4;
        Wed, 26 Feb 2020 00:25:52 +0100 (CET)
Message-Id: <20200225231609.730479367@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:27 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 08/15] x86/entry: Convert various system vectors
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

Convert various system vectors to IDTENTRY_SYSVEC
  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64bit
  - Remove the BUILD_INTERRUPT entries in 32bit
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S             |   19 -------------------
 arch/x86/include/asm/entry_arch.h     |   25 -------------------------
 arch/x86/include/asm/hw_irq.h         |    8 --------
 arch/x86/include/asm/idtentry.h       |   20 ++++++++++++++++++++
 arch/x86/include/asm/irq_work.h       |    1 -
 arch/x86/include/asm/traps.h          |    5 -----
 arch/x86/include/asm/uv/uv_bau.h      |    6 +++---
 arch/x86/kernel/cpu/mce/amd.c         |    2 +-
 arch/x86/kernel/cpu/mce/therm_throt.c |    2 +-
 arch/x86/kernel/cpu/mce/threshold.c   |    2 +-
 arch/x86/kernel/idt.c                 |   24 ++++++++++++------------
 arch/x86/kernel/irq_work.c            |    3 ++-
 arch/x86/platform/uv/tlb_uv.c         |    2 +-
 13 files changed, 41 insertions(+), 78 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -994,9 +994,6 @@ apicinterrupt3 \num \sym \do_sym
 POP_SECTION_IRQENTRY
 .endm
 
-#ifdef CONFIG_X86_UV
-apicinterrupt3 UV_BAU_MESSAGE			uv_bau_message_intr1		uv_bau_message_interrupt
-#endif
 
 #ifdef CONFIG_HAVE_KVM
 apicinterrupt3 POSTED_INTR_VECTOR		kvm_posted_intr_ipi		smp_kvm_posted_intr_ipi
@@ -1004,22 +1001,6 @@ apicinterrupt3 POSTED_INTR_WAKEUP_VECTOR
 apicinterrupt3 POSTED_INTR_NESTED_VECTOR	kvm_posted_intr_nested_ipi	smp_kvm_posted_intr_nested_ipi
 #endif
 
-#ifdef CONFIG_X86_MCE_THRESHOLD
-apicinterrupt THRESHOLD_APIC_VECTOR		threshold_interrupt		smp_threshold_interrupt
-#endif
-
-#ifdef CONFIG_X86_MCE_AMD
-apicinterrupt DEFERRED_ERROR_VECTOR		deferred_error_interrupt	smp_deferred_error_interrupt
-#endif
-
-#ifdef CONFIG_X86_THERMAL_VECTOR
-apicinterrupt THERMAL_APIC_VECTOR		thermal_interrupt		smp_thermal_interrupt
-#endif
-
-#ifdef CONFIG_IRQ_WORK
-apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
-#endif
-
 /*
  * Reload gs selector with exception handling
  * edi:  new selector
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -17,28 +17,3 @@ BUILD_INTERRUPT(kvm_posted_intr_wakeup_i
 BUILD_INTERRUPT(kvm_posted_intr_nested_ipi, POSTED_INTR_NESTED_VECTOR)
 #endif
 
-/*
- * every pentium local APIC has two 'local interrupts', with a
- * soft-definable vector attached to both interrupts, one of
- * which is a timer interrupt, the other one is error counter
- * overflow. Linux uses the local APIC timer interrupt to get
- * a much simpler SMP time architecture:
- */
-#ifdef CONFIG_X86_LOCAL_APIC
-
-#ifdef CONFIG_IRQ_WORK
-BUILD_INTERRUPT(irq_work_interrupt, IRQ_WORK_VECTOR)
-#endif
-
-#ifdef CONFIG_X86_THERMAL_VECTOR
-BUILD_INTERRUPT(thermal_interrupt,THERMAL_APIC_VECTOR)
-#endif
-
-#ifdef CONFIG_X86_MCE_THRESHOLD
-BUILD_INTERRUPT(threshold_interrupt,THRESHOLD_APIC_VECTOR)
-#endif
-
-#ifdef CONFIG_X86_MCE_AMD
-BUILD_INTERRUPT(deferred_error_interrupt, DEFERRED_ERROR_VECTOR)
-#endif
-#endif
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -32,14 +32,6 @@
 extern asmlinkage void kvm_posted_intr_ipi(void);
 extern asmlinkage void kvm_posted_intr_wakeup_ipi(void);
 extern asmlinkage void kvm_posted_intr_nested_ipi(void);
-extern asmlinkage void irq_work_interrupt(void);
-extern asmlinkage void uv_bau_message_intr1(void);
-
-extern asmlinkage void spurious_apic_interrupt(void);
-extern asmlinkage void thermal_interrupt(void);
-
-extern asmlinkage void threshold_interrupt(void);
-extern asmlinkage void deferred_error_interrupt(void);
 
 #ifdef	CONFIG_X86_LOCAL_APIC
 struct irq_data;
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -497,6 +497,26 @@ DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_VE
 DECLARE_IDTENTRY_SYSVEC(RESCHEDULE_VECTOR,		sysvec_reschedule);
 #endif
 
+#ifdef CONFIG_X86_UV
+DECLARE_IDTENTRY_SYSVEC(UV_BAU_MESSAGE,			sysvec_uv_bau_message);
+#endif
+
+#ifdef CONFIG_X86_MCE_THRESHOLD
+DECLARE_IDTENTRY_SYSVEC(THRESHOLD_APIC_VECTOR,		sysvec_threshold);
+#endif
+
+#ifdef CONFIG_X86_MCE_AMD
+DECLARE_IDTENTRY_SYSVEC(DEFERRED_ERROR_VECTOR,		sysvec_deferred_error);
+#endif
+
+#ifdef CONFIG_X86_THERMAL_VECTOR
+DECLARE_IDTENTRY_SYSVEC(THERMAL_APIC_VECTOR,		sysvec_thermal);
+#endif
+
+#ifdef CONFIG_IRQ_WORK
+DECLARE_IDTENTRY_SYSVEC(IRQ_WORK_VECTOR,		sysvec_irq_work);
+#endif
+
 #ifdef CONFIG_X86_MCE
 /* Machine check */
 DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
--- a/arch/x86/include/asm/irq_work.h
+++ b/arch/x86/include/asm/irq_work.h
@@ -10,7 +10,6 @@ static inline bool arch_irq_work_has_int
 	return boot_cpu_has(X86_FEATURE_APIC);
 }
 extern void arch_irq_work_raise(void);
-extern __visible void smp_irq_work_interrupt(struct pt_regs *regs);
 #else
 static inline bool arch_irq_work_has_interrupt(void)
 {
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -32,11 +32,6 @@ static inline int get_si_code(unsigned l
 extern int panic_on_unrecovered_nmi;
 
 void math_emulate(struct math_emu_info *);
-#ifndef CONFIG_X86_32
-asmlinkage void smp_thermal_interrupt(struct pt_regs *regs);
-asmlinkage void smp_threshold_interrupt(struct pt_regs *regs);
-asmlinkage void smp_deferred_error_interrupt(struct pt_regs *regs);
-#endif
 
 extern void ist_enter(struct pt_regs *regs);
 extern void ist_exit(struct pt_regs *regs);
--- a/arch/x86/include/asm/uv/uv_bau.h
+++ b/arch/x86/include/asm/uv/uv_bau.h
@@ -12,6 +12,8 @@
 #define _ASM_X86_UV_UV_BAU_H
 
 #include <linux/bitmap.h>
+#include <asm/idtentry.h>
+
 #define BITSPERBYTE 8
 
 /*
@@ -799,11 +801,9 @@ static inline void bau_cpubits_clear(str
 	bitmap_zero(&dstp->bits, nbits);
 }
 
-extern void uv_bau_message_intr1(void);
 #ifdef CONFIG_TRACING
-#define trace_uv_bau_message_intr1 uv_bau_message_intr1
+#define trace_uv_bau_message_intr1 sysvec_uv_bau_message
 #endif
-extern void uv_bau_timeout_intr1(void);
 
 struct atomic_short {
 	short counter;
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -907,7 +907,7 @@ static void __log_error(unsigned int ban
 	mce_log(&m);
 }
 
-asmlinkage __visible void __irq_entry smp_deferred_error_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 {
 	entering_irq();
 	trace_deferred_error_apic_entry(DEFERRED_ERROR_VECTOR);
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -609,7 +609,7 @@ static void unexpected_thermal_interrupt
 
 static void (*smp_thermal_vector)(void) = unexpected_thermal_interrupt;
 
-asmlinkage __visible void __irq_entry smp_thermal_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
 {
 	entering_irq();
 	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -21,7 +21,7 @@ static void default_threshold_interrupt(
 
 void (*mce_threshold_vector)(void) = default_threshold_interrupt;
 
-asmlinkage __visible void __irq_entry smp_threshold_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_threshold)
 {
 	entering_irq();
 	trace_threshold_apic_entry(THRESHOLD_APIC_VECTOR);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -117,33 +117,33 @@ static const __initconst struct idt_data
 #endif
 
 #ifdef CONFIG_X86_THERMAL_VECTOR
-	INTG(THERMAL_APIC_VECTOR,	thermal_interrupt),
+	INTG(THERMAL_APIC_VECTOR,		asm_sysvec_thermal),
 #endif
 
 #ifdef CONFIG_X86_MCE_THRESHOLD
-	INTG(THRESHOLD_APIC_VECTOR,	threshold_interrupt),
+	INTG(THRESHOLD_APIC_VECTOR,		asm_sysvec_threshold),
 #endif
 
 #ifdef CONFIG_X86_MCE_AMD
-	INTG(DEFERRED_ERROR_VECTOR,	deferred_error_interrupt),
+	INTG(DEFERRED_ERROR_VECTOR,		asm_sysvec_deferred_error),
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	INTG(LOCAL_TIMER_VECTOR,	asm_sysvec_apic_timer_interrupt),
-	INTG(X86_PLATFORM_IPI_VECTOR,	asm_sysvec_x86_platform_ipi),
+	INTG(LOCAL_TIMER_VECTOR,		asm_sysvec_apic_timer_interrupt),
+	INTG(X86_PLATFORM_IPI_VECTOR,		asm_sysvec_x86_platform_ipi),
 # ifdef CONFIG_HAVE_KVM
-	INTG(POSTED_INTR_VECTOR,	kvm_posted_intr_ipi),
-	INTG(POSTED_INTR_WAKEUP_VECTOR, kvm_posted_intr_wakeup_ipi),
-	INTG(POSTED_INTR_NESTED_VECTOR, kvm_posted_intr_nested_ipi),
+	INTG(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
+	INTG(POSTED_INTR_WAKEUP_VECTOR,		kvm_posted_intr_wakeup_ipi),
+	INTG(POSTED_INTR_NESTED_VECTOR,		kvm_posted_intr_nested_ipi),
 # endif
 # ifdef CONFIG_IRQ_WORK
-	INTG(IRQ_WORK_VECTOR,		irq_work_interrupt),
+	INTG(IRQ_WORK_VECTOR,			asm_sysvec_irq_work),
 # endif
 #ifdef CONFIG_X86_UV
-	INTG(UV_BAU_MESSAGE,		uv_bau_message_intr1),
+	INTG(UV_BAU_MESSAGE,			asm_sysvec_uv_bau_message),
 #endif
-	INTG(SPURIOUS_APIC_VECTOR,	asm_sysvec_spurious_apic_interrupt),
-	INTG(ERROR_APIC_VECTOR,		asm_sysvec_error_interrupt),
+	INTG(SPURIOUS_APIC_VECTOR,		asm_sysvec_spurious_apic_interrupt),
+	INTG(ERROR_APIC_VECTOR,			asm_sysvec_error_interrupt),
 #endif
 };
 
--- a/arch/x86/kernel/irq_work.c
+++ b/arch/x86/kernel/irq_work.c
@@ -9,11 +9,12 @@
 #include <linux/irq_work.h>
 #include <linux/hardirq.h>
 #include <asm/apic.h>
+#include <asm/idtentry.h>
 #include <asm/trace/irq_vectors.h>
 #include <linux/interrupt.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
-__visible void __irq_entry smp_irq_work_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_irq_work)
 {
 	ipi_entering_ack_irq();
 	trace_irq_work_entry(IRQ_WORK_VECTOR);
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -1272,7 +1272,7 @@ static void process_uv2_message(struct m
  * (the resource will not be freed until noninterruptable cpus see this
  *  interrupt; hardware may timeout the s/w ack and reply ERROR)
  */
-void uv_bau_message_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_uv_bau_message)
 {
 	int count = 0;
 	cycles_t time_start;

