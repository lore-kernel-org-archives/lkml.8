Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664D4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABD3208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgEUUcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbgEUUcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:32:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98855C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:32:09 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrr2-0000kh-Q5; Thu, 21 May 2020 22:31:49 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 3E2E4100C2D;
        Thu, 21 May 2020 22:31:48 +0200 (CEST)
Message-Id: <20200521202119.464812973@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:41 +0200
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
Subject: [patch V9 28/39] x86/entry: Convert various system vectors
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

Convert various system vectors to IDTENTRY_SYSVEC
  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64bit
  - Remove the BUILD_INTERRUPT entries in 32bit
  - Remove the old prototypes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64.S             |   19 -------------------
 arch/x86/include/asm/apic.h           |   13 -------------
 arch/x86/include/asm/entry_arch.h     |   25 -------------------------
 arch/x86/include/asm/hw_irq.h         |    6 ------
 arch/x86/include/asm/idtentry.h       |   22 ++++++++++++++++++++++
 arch/x86/include/asm/irq_work.h       |    1 -
 arch/x86/include/asm/traps.h          |    5 -----
 arch/x86/include/asm/uv/uv_bau.h      |    8 ++------
 arch/x86/kernel/cpu/mce/amd.c         |    5 ++---
 arch/x86/kernel/cpu/mce/therm_throt.c |    5 ++---
 arch/x86/kernel/cpu/mce/threshold.c   |    5 ++---
 arch/x86/kernel/idt.c                 |   28 ++++++++++++++--------------
 arch/x86/kernel/irq_work.c            |    6 +++---
 arch/x86/platform/uv/tlb_uv.c         |    2 +-
 14 files changed, 48 insertions(+), 102 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -956,9 +956,6 @@ apicinterrupt3 \num \sym \do_sym
 POP_SECTION_IRQENTRY
 .endm
 
-#ifdef CONFIG_X86_UV
-apicinterrupt3 UV_BAU_MESSAGE			uv_bau_message_intr1		uv_bau_message_interrupt
-#endif
 
 #ifdef CONFIG_HAVE_KVM
 apicinterrupt3 POSTED_INTR_VECTOR		kvm_posted_intr_ipi		smp_kvm_posted_intr_ipi
@@ -966,26 +963,10 @@ apicinterrupt3 POSTED_INTR_WAKEUP_VECTOR
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
 #ifdef CONFIG_SMP
 apicinterrupt RESCHEDULE_VECTOR			reschedule_interrupt		smp_reschedule_interrupt
 #endif
 
-#ifdef CONFIG_IRQ_WORK
-apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
-#endif
-
 /*
  * Reload gs selector with exception handling
  * edi:  new selector
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -534,24 +534,11 @@ static inline void entering_ack_irq(void
 	ack_APIC_irq();
 }
 
-static inline void ipi_entering_ack_irq(void)
-{
-	irq_enter();
-	ack_APIC_irq();
-	kvm_set_cpu_l1tf_flush_l1d();
-}
-
 static inline void exiting_irq(void)
 {
 	irq_exit();
 }
 
-static inline void exiting_ack_irq(void)
-{
-	ack_APIC_irq();
-	irq_exit();
-}
-
 extern void ioapic_zap_locks(void);
 
 #endif /* _ASM_X86_APIC_H */
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -20,28 +20,3 @@ BUILD_INTERRUPT(kvm_posted_intr_wakeup_i
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
@@ -32,15 +32,9 @@
 extern asmlinkage void kvm_posted_intr_ipi(void);
 extern asmlinkage void kvm_posted_intr_wakeup_ipi(void);
 extern asmlinkage void kvm_posted_intr_nested_ipi(void);
-extern asmlinkage void irq_work_interrupt(void);
-extern asmlinkage void uv_bau_message_intr1(void);
 
-extern asmlinkage void thermal_interrupt(void);
 extern asmlinkage void reschedule_interrupt(void);
 
-extern asmlinkage void threshold_interrupt(void);
-extern asmlinkage void deferred_error_interrupt(void);
-
 #ifdef	CONFIG_X86_LOCAL_APIC
 struct irq_data;
 struct pci_dev;
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -580,6 +580,28 @@ DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_SI
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_VECTOR,		sysvec_call_function);
 #endif
 
+#ifdef CONFIG_X86_LOCAL_APIC
+# ifdef CONFIG_X86_UV
+DECLARE_IDTENTRY_SYSVEC(UV_BAU_MESSAGE,			sysvec_uv_bau_message);
+# endif
+
+# ifdef CONFIG_X86_MCE_THRESHOLD
+DECLARE_IDTENTRY_SYSVEC(THRESHOLD_APIC_VECTOR,		sysvec_threshold);
+# endif
+
+# ifdef CONFIG_X86_MCE_AMD
+DECLARE_IDTENTRY_SYSVEC(DEFERRED_ERROR_VECTOR,		sysvec_deferred_error);
+# endif
+
+# ifdef CONFIG_X86_THERMAL_VECTOR
+DECLARE_IDTENTRY_SYSVEC(THERMAL_APIC_VECTOR,		sysvec_thermal);
+# endif
+
+# ifdef CONFIG_IRQ_WORK
+DECLARE_IDTENTRY_SYSVEC(IRQ_WORK_VECTOR,		sysvec_irq_work);
+# endif
+#endif
+
 #undef X86_TRAP_OTHER
 
 #endif
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
@@ -34,11 +34,6 @@ static inline int get_si_code(unsigned l
 extern int panic_on_unrecovered_nmi;
 
 void math_emulate(struct math_emu_info *);
-#ifndef CONFIG_X86_32
-asmlinkage void smp_thermal_interrupt(struct pt_regs *regs);
-asmlinkage void smp_threshold_interrupt(struct pt_regs *regs);
-asmlinkage void smp_deferred_error_interrupt(struct pt_regs *regs);
-#endif
 
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
--- a/arch/x86/include/asm/uv/uv_bau.h
+++ b/arch/x86/include/asm/uv/uv_bau.h
@@ -12,6 +12,8 @@
 #define _ASM_X86_UV_UV_BAU_H
 
 #include <linux/bitmap.h>
+#include <asm/idtentry.h>
+
 #define BITSPERBYTE 8
 
 /*
@@ -799,12 +801,6 @@ static inline void bau_cpubits_clear(str
 	bitmap_zero(&dstp->bits, nbits);
 }
 
-extern void uv_bau_message_intr1(void);
-#ifdef CONFIG_TRACING
-#define trace_uv_bau_message_intr1 uv_bau_message_intr1
-#endif
-extern void uv_bau_timeout_intr1(void);
-
 struct atomic_short {
 	short counter;
 };
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -907,14 +907,13 @@ static void __log_error(unsigned int ban
 	mce_log(&m);
 }
 
-asmlinkage __visible void __irq_entry smp_deferred_error_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 {
-	entering_irq();
 	trace_deferred_error_apic_entry(DEFERRED_ERROR_VECTOR);
 	inc_irq_stat(irq_deferred_error_count);
 	deferred_error_int_vector();
 	trace_deferred_error_apic_exit(DEFERRED_ERROR_VECTOR);
-	exiting_ack_irq();
+	ack_APIC_irq();
 }
 
 /*
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -614,14 +614,13 @@ static void unexpected_thermal_interrupt
 
 static void (*smp_thermal_vector)(void) = unexpected_thermal_interrupt;
 
-asmlinkage __visible void __irq_entry smp_thermal_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
 {
-	entering_irq();
 	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
 	inc_irq_stat(irq_thermal_count);
 	smp_thermal_vector();
 	trace_thermal_apic_exit(THERMAL_APIC_VECTOR);
-	exiting_ack_irq();
+	ack_APIC_irq();
 }
 
 /* Thermal monitoring depends on APIC, ACPI and clock modulation */
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -21,12 +21,11 @@ static void default_threshold_interrupt(
 
 void (*mce_threshold_vector)(void) = default_threshold_interrupt;
 
-asmlinkage __visible void __irq_entry smp_threshold_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_threshold)
 {
-	entering_irq();
 	trace_threshold_apic_entry(THRESHOLD_APIC_VECTOR);
 	inc_irq_stat(irq_threshold_count);
 	mce_threshold_vector();
 	trace_threshold_apic_exit(THRESHOLD_APIC_VECTOR);
-	exiting_ack_irq();
+	ack_APIC_irq();
 }
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -120,33 +120,33 @@ static const __initconst struct idt_data
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
-#ifdef CONFIG_X86_UV
-	INTG(UV_BAU_MESSAGE,		uv_bau_message_intr1),
-#endif
-	INTG(SPURIOUS_APIC_VECTOR,	asm_sysvec_spurious_apic_interrupt),
-	INTG(ERROR_APIC_VECTOR,		asm_sysvec_error_interrupt),
+# ifdef CONFIG_X86_UV
+	INTG(UV_BAU_MESSAGE,			asm_sysvec_uv_bau_message),
+# endif
+	INTG(SPURIOUS_APIC_VECTOR,		asm_sysvec_spurious_apic_interrupt),
+	INTG(ERROR_APIC_VECTOR,			asm_sysvec_error_interrupt),
 #endif
 };
 
--- a/arch/x86/kernel/irq_work.c
+++ b/arch/x86/kernel/irq_work.c
@@ -9,18 +9,18 @@
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
-	ipi_entering_ack_irq();
+	ack_APIC_irq();
 	trace_irq_work_entry(IRQ_WORK_VECTOR);
 	inc_irq_stat(apic_irq_work_irqs);
 	irq_work_run();
 	trace_irq_work_exit(IRQ_WORK_VECTOR);
-	exiting_irq();
 }
 
 void arch_irq_work_raise(void)
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

