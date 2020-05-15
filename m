Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE363C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A663D207C4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgEPAMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 20:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728028AbgEPAK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:10:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5BAC05BD0A
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 17:10:59 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZkPV-0002Q1-79; Sat, 16 May 2020 02:10:37 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 9DFC6100605;
        Sat, 16 May 2020 02:10:36 +0200 (CEST)
Message-Id: <20200515235126.818063410@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 May 2020 01:46:11 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: [patch V6 24/37] x86/entry: Convert APIC interrupts to IDTENTRY_SYSVEC
References: <20200515234547.710474468@linutronix.de>
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


Convert APIC interrupts to IDTENTRY_SYSVEC
  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64bit
  - Remove the BUILD_INTERRUPT entries in 32bit
  - Remove the old prototypes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 2c0eb5c2100a..6e629e5d5047 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -965,9 +965,6 @@ apicinterrupt3 REBOOT_VECTOR			reboot_interrupt		smp_reboot_interrupt
 apicinterrupt3 UV_BAU_MESSAGE			uv_bau_message_intr1		uv_bau_message_interrupt
 #endif
 
-apicinterrupt LOCAL_TIMER_VECTOR		apic_timer_interrupt		smp_apic_timer_interrupt
-apicinterrupt X86_PLATFORM_IPI_VECTOR		x86_platform_ipi		smp_x86_platform_ipi
-
 #ifdef CONFIG_HAVE_KVM
 apicinterrupt3 POSTED_INTR_VECTOR		kvm_posted_intr_ipi		smp_kvm_posted_intr_ipi
 apicinterrupt3 POSTED_INTR_WAKEUP_VECTOR	kvm_posted_intr_wakeup_ipi	smp_kvm_posted_intr_wakeup_ipi
@@ -992,9 +989,6 @@ apicinterrupt CALL_FUNCTION_VECTOR		call_function_interrupt		smp_call_function_i
 apicinterrupt RESCHEDULE_VECTOR			reschedule_interrupt		smp_reschedule_interrupt
 #endif
 
-apicinterrupt ERROR_APIC_VECTOR			error_interrupt			smp_error_interrupt
-apicinterrupt SPURIOUS_APIC_VECTOR		spurious_apic_interrupt		smp_spurious_apic_interrupt
-
 #ifdef CONFIG_IRQ_WORK
 apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 #endif
diff --git a/arch/x86/include/asm/entry_arch.h b/arch/x86/include/asm/entry_arch.h
index cd57ce6134c9..d10d6d807e73 100644
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -33,11 +33,6 @@ BUILD_INTERRUPT(kvm_posted_intr_nested_ipi, POSTED_INTR_NESTED_VECTOR)
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
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 3213d36b92d3..1765993360e7 100644
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
 
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 43658fcedae8..6154d1e75fce 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -567,6 +567,14 @@ DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,	common_interrupt);
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
diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index ae10083b7631..112c85673179 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -44,7 +44,6 @@ extern void __init init_IRQ(void);
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
 				    bool exclude_self);
 
-extern __visible void smp_x86_platform_ipi(struct pt_regs *regs);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
 
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 97e6945bfce8..933934c3e173 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -40,9 +40,6 @@ asmlinkage void smp_threshold_interrupt(struct pt_regs *regs);
 asmlinkage void smp_deferred_error_interrupt(struct pt_regs *regs);
 #endif
 
-void smp_apic_timer_interrupt(struct pt_regs *regs);
-void smp_error_interrupt(struct pt_regs *regs);
-void smp_spurious_apic_interrupt(struct pt_regs *regs);
 asmlinkage void smp_irq_move_cleanup_interrupt(void);
 
 #ifdef CONFIG_VMAP_STACK
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 66c3cfcd6d47..6a8e9f343a29 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1121,23 +1121,14 @@ static void local_apic_timer_interrupt(void)
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
@@ -2162,7 +2153,7 @@ void __init register_lapic_address(unsigned long address)
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
@@ -2223,7 +2212,6 @@ __visible void __irq_entry smp_error_interrupt(struct pt_regs *regs)
 	};
 	u32 v, i = 0;
 
-	entering_irq();
 	trace_error_apic_entry(ERROR_APIC_VECTOR);
 
 	/* First tickle the hardware, only then report what went on. -- REW */
@@ -2247,7 +2235,6 @@ __visible void __irq_entry smp_error_interrupt(struct pt_regs *regs)
 	apic_printk(APIC_DEBUG, KERN_CONT "\n");
 
 	trace_error_apic_exit(ERROR_APIC_VECTOR);
-	exiting_irq();
 }
 
 /**
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 3e49e1fac1c6..7e38af51480d 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -129,8 +129,8 @@ static const __initconst struct idt_data apic_idts[] = {
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	INTG(LOCAL_TIMER_VECTOR,	apic_timer_interrupt),
-	INTG(X86_PLATFORM_IPI_VECTOR,	x86_platform_ipi),
+	INTG(LOCAL_TIMER_VECTOR,	asm_sysvec_apic_timer_interrupt),
+	INTG(X86_PLATFORM_IPI_VECTOR,	asm_sysvec_x86_platform_ipi),
 # ifdef CONFIG_HAVE_KVM
 	INTG(POSTED_INTR_VECTOR,	kvm_posted_intr_ipi),
 	INTG(POSTED_INTR_WAKEUP_VECTOR, kvm_posted_intr_wakeup_ipi),
@@ -142,8 +142,8 @@ static const __initconst struct idt_data apic_idts[] = {
 #ifdef CONFIG_X86_UV
 	INTG(UV_BAU_MESSAGE,		uv_bau_message_intr1),
 #endif
-	INTG(SPURIOUS_APIC_VECTOR,	spurious_apic_interrupt),
-	INTG(ERROR_APIC_VECTOR,		error_interrupt),
+	INTG(SPURIOUS_APIC_VECTOR,	asm_sysvec_spurious_apic_interrupt),
+	INTG(ERROR_APIC_VECTOR,		asm_sysvec_error_interrupt),
 #endif
 };
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 63b848e1fe68..43f95ec5f131 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -14,6 +14,7 @@
 #include <linux/irq.h>
 
 #include <asm/apic.h>
+#include <asm/traps.h>
 #include <asm/io_apic.h>
 #include <asm/irq.h>
 #include <asm/mce.h>
@@ -259,17 +260,16 @@ void (*x86_platform_ipi_callback)(void) = NULL;
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

