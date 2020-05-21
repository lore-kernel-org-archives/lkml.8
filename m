Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A495CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73375208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgEUUcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730073AbgEUUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:32:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47815C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:32:15 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrr0-0000i4-Fz; Thu, 21 May 2020 22:31:46 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id B992F100C2D;
        Thu, 21 May 2020 22:31:45 +0200 (CEST)
Message-Id: <20200521202119.280728850@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:39 +0200
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
Subject: [patch V9 26/39] x86/entry: Convert APIC interrupts to IDTENTRY_SYSVEC
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

Convert APIC interrupts to IDTENTRY_SYSVEC
  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64bit
  - Remove the BUILD_INTERRUPT entries in 32bit
  - Remove the old prototypes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64.S         |    6 ------
 arch/x86/include/asm/entry_arch.h |    5 -----
 arch/x86/include/asm/hw_irq.h     |    4 ----
 arch/x86/include/asm/idtentry.h   |    8 ++++++++
 arch/x86/include/asm/irq.h        |    1 -
 arch/x86/include/asm/traps.h      |    3 ---
 arch/x86/kernel/apic/apic.c       |   23 +++++------------------
 arch/x86/kernel/idt.c             |    8 ++++----
 arch/x86/kernel/irq.c             |    5 ++---
 9 files changed, 19 insertions(+), 44 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -965,9 +965,6 @@ apicinterrupt3 REBOOT_VECTOR			reboot_in
 apicinterrupt3 UV_BAU_MESSAGE			uv_bau_message_intr1		uv_bau_message_interrupt
 #endif
 
-apicinterrupt LOCAL_TIMER_VECTOR		apic_timer_interrupt		smp_apic_timer_interrupt
-apicinterrupt X86_PLATFORM_IPI_VECTOR		x86_platform_ipi		smp_x86_platform_ipi
-
 #ifdef CONFIG_HAVE_KVM
 apicinterrupt3 POSTED_INTR_VECTOR		kvm_posted_intr_ipi		smp_kvm_posted_intr_ipi
 apicinterrupt3 POSTED_INTR_WAKEUP_VECTOR	kvm_posted_intr_wakeup_ipi	smp_kvm_posted_intr_wakeup_ipi
@@ -992,9 +989,6 @@ apicinterrupt CALL_FUNCTION_VECTOR		call
 apicinterrupt RESCHEDULE_VECTOR			reschedule_interrupt		smp_reschedule_interrupt
 #endif
 
-apicinterrupt ERROR_APIC_VECTOR			error_interrupt			smp_error_interrupt
-apicinterrupt SPURIOUS_APIC_VECTOR		spurious_apic_interrupt		smp_spurious_apic_interrupt
-
 #ifdef CONFIG_IRQ_WORK
 apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 #endif
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -33,11 +33,6 @@ BUILD_INTERRUPT(kvm_posted_intr_nested_i
  */
 #ifdef CONFIG_X86_LOCAL_APIC
 
-BUILD_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
-BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
-BUILD_INTERRUPT(spurious_apic_interrupt,SPURIOUS_APIC_VECTOR)
-BUILD_INTERRUPT(x86_platform_ipi, X86_PLATFORM_IPI_VECTOR)
-
 #ifdef CONFIG_IRQ_WORK
 BUILD_INTERRUPT(irq_work_interrupt, IRQ_WORK_VECTOR)
 #endif
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -29,16 +29,12 @@
 #include <asm/sections.h>
 
 /* Interrupt handlers registered during init_IRQ */
-extern asmlinkage void apic_timer_interrupt(void);
-extern asmlinkage void x86_platform_ipi(void);
 extern asmlinkage void kvm_posted_intr_ipi(void);
 extern asmlinkage void kvm_posted_intr_wakeup_ipi(void);
 extern asmlinkage void kvm_posted_intr_nested_ipi(void);
-extern asmlinkage void error_interrupt(void);
 extern asmlinkage void irq_work_interrupt(void);
 extern asmlinkage void uv_bau_message_intr1(void);
 
-extern asmlinkage void spurious_apic_interrupt(void);
 extern asmlinkage void thermal_interrupt(void);
 extern asmlinkage void reschedule_interrupt(void);
 
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -565,6 +565,14 @@ DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,	com
 DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,	spurious_interrupt);
 #endif
 
+/* System vector entry points */
+#ifdef CONFIG_X86_LOCAL_APIC
+DECLARE_IDTENTRY_SYSVEC(ERROR_APIC_VECTOR,		sysvec_error_interrupt);
+DECLARE_IDTENTRY_SYSVEC(SPURIOUS_APIC_VECTOR,		sysvec_spurious_apic_interrupt);
+DECLARE_IDTENTRY_SYSVEC(LOCAL_TIMER_VECTOR,		sysvec_apic_timer_interrupt);
+DECLARE_IDTENTRY_SYSVEC(X86_PLATFORM_IPI_VECTOR,	sysvec_x86_platform_ipi);
+#endif
+
 #undef X86_TRAP_OTHER
 
 #endif
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -46,7 +46,6 @@ extern void __init init_IRQ(void);
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
 				    bool exclude_self);
 
-extern __visible void smp_x86_platform_ipi(struct pt_regs *regs);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
 
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -40,9 +40,6 @@ asmlinkage void smp_threshold_interrupt(
 asmlinkage void smp_deferred_error_interrupt(struct pt_regs *regs);
 #endif
 
-void smp_apic_timer_interrupt(struct pt_regs *regs);
-void smp_error_interrupt(struct pt_regs *regs);
-void smp_spurious_apic_interrupt(struct pt_regs *regs);
 asmlinkage void smp_irq_move_cleanup_interrupt(void);
 
 #ifdef CONFIG_VMAP_STACK
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1121,23 +1121,14 @@ static void local_apic_timer_interrupt(v
  * [ if a single-CPU system runs an SMP kernel then we call the local
  *   interrupt as well. Thus we cannot inline the local irq ... ]
  */
-__visible void __irq_entry smp_apic_timer_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_apic_timer_interrupt)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	/*
-	 * NOTE! We'd better ACK the irq immediately,
-	 * because timer handling can be slow.
-	 *
-	 * update_process_times() expects us to have done irq_enter().
-	 * Besides, if we don't timer interrupts ignore the global
-	 * interrupt lock, which is the WrongThing (tm) to do.
-	 */
-	entering_ack_irq();
+	ack_APIC_irq();
 	trace_local_timer_entry(LOCAL_TIMER_VECTOR);
 	local_apic_timer_interrupt();
 	trace_local_timer_exit(LOCAL_TIMER_VECTOR);
-	exiting_irq();
 
 	set_irq_regs(old_regs);
 }
@@ -2162,7 +2153,7 @@ void __init register_lapic_address(unsig
  * trigger on an entry which is routed to the common_spurious idtentry
  * point.
  *
- * Also called from smp_spurious_apic_interrupt().
+ * Also called from sysvec_spurious_apic_interrupt().
  */
 DEFINE_IDTENTRY_IRQ(spurious_interrupt)
 {
@@ -2199,17 +2190,15 @@ DEFINE_IDTENTRY_IRQ(spurious_interrupt)
 	trace_spurious_apic_exit(vector);
 }
 
-__visible void smp_spurious_apic_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_spurious_apic_interrupt)
 {
-	entering_irq();
 	__spurious_interrupt(regs, SPURIOUS_APIC_VECTOR);
-	exiting_irq();
 }
 
 /*
  * This interrupt should never happen with our APIC/SMP architecture
  */
-__visible void __irq_entry smp_error_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_error_interrupt)
 {
 	static const char * const error_interrupt_reason[] = {
 		"Send CS error",		/* APIC Error Bit 0 */
@@ -2223,7 +2212,6 @@ DEFINE_IDTENTRY_IRQ(spurious_interrupt)
 	};
 	u32 v, i = 0;
 
-	entering_irq();
 	trace_error_apic_entry(ERROR_APIC_VECTOR);
 
 	/* First tickle the hardware, only then report what went on. -- REW */
@@ -2247,7 +2235,6 @@ DEFINE_IDTENTRY_IRQ(spurious_interrupt)
 	apic_printk(APIC_DEBUG, KERN_CONT "\n");
 
 	trace_error_apic_exit(ERROR_APIC_VECTOR);
-	exiting_irq();
 }
 
 /**
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -132,8 +132,8 @@ static const __initconst struct idt_data
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	INTG(LOCAL_TIMER_VECTOR,	apic_timer_interrupt),
-	INTG(X86_PLATFORM_IPI_VECTOR,	x86_platform_ipi),
+	INTG(LOCAL_TIMER_VECTOR,	asm_sysvec_apic_timer_interrupt),
+	INTG(X86_PLATFORM_IPI_VECTOR,	asm_sysvec_x86_platform_ipi),
 # ifdef CONFIG_HAVE_KVM
 	INTG(POSTED_INTR_VECTOR,	kvm_posted_intr_ipi),
 	INTG(POSTED_INTR_WAKEUP_VECTOR, kvm_posted_intr_wakeup_ipi),
@@ -145,8 +145,8 @@ static const __initconst struct idt_data
 #ifdef CONFIG_X86_UV
 	INTG(UV_BAU_MESSAGE,		uv_bau_message_intr1),
 #endif
-	INTG(SPURIOUS_APIC_VECTOR,	spurious_apic_interrupt),
-	INTG(ERROR_APIC_VECTOR,		error_interrupt),
+	INTG(SPURIOUS_APIC_VECTOR,	asm_sysvec_spurious_apic_interrupt),
+	INTG(ERROR_APIC_VECTOR,		asm_sysvec_error_interrupt),
 #endif
 };
 
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -268,17 +268,16 @@ void (*x86_platform_ipi_callback)(void)
 /*
  * Handler for X86_PLATFORM_IPI_VECTOR.
  */
-__visible void __irq_entry smp_x86_platform_ipi(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_x86_platform_ipi)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	entering_ack_irq();
+	ack_APIC_irq();
 	trace_x86_platform_ipi_entry(X86_PLATFORM_IPI_VECTOR);
 	inc_irq_stat(x86_platform_ipis);
 	if (x86_platform_ipi_callback)
 		x86_platform_ipi_callback();
 	trace_x86_platform_ipi_exit(X86_PLATFORM_IPI_VECTOR);
-	exiting_irq();
 	set_irq_regs(old_regs);
 }
 #endif

