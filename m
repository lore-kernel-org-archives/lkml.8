Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6300C4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69B624680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgBYX1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:27:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55977 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgBYX0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:48 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaw-00053I-VT; Wed, 26 Feb 2020 00:26:32 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 566EC104090;
        Wed, 26 Feb 2020 00:25:52 +0100 (CET)
Message-Id: <20200225231609.517749281@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:25 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 06/15] x86/entry: Convert APIC interrupts to IDTENTRY_SYSVEC
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

Convert APIC interrupts to IDTENTRY_SYSVEC
  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64bit
  - Remove the BUILD_INTERRUPT entries in 32bit
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S         |    6 ------
 arch/x86/include/asm/entry_arch.h |    5 -----
 arch/x86/include/asm/hw_irq.h     |    3 ---
 arch/x86/include/asm/idtentry.h   |    8 ++++++++
 arch/x86/include/asm/irq.h        |    1 -
 arch/x86/include/asm/traps.h      |    3 ---
 arch/x86/kernel/apic/apic.c       |    8 ++++----
 arch/x86/kernel/idt.c             |    8 ++++----
 arch/x86/kernel/irq.c             |    3 ++-
 9 files changed, 18 insertions(+), 27 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1003,9 +1003,6 @@ apicinterrupt3 REBOOT_VECTOR			reboot_in
 apicinterrupt3 UV_BAU_MESSAGE			uv_bau_message_intr1		uv_bau_message_interrupt
 #endif
 
-apicinterrupt LOCAL_TIMER_VECTOR		apic_timer_interrupt		smp_apic_timer_interrupt
-apicinterrupt X86_PLATFORM_IPI_VECTOR		x86_platform_ipi		smp_x86_platform_ipi
-
 #ifdef CONFIG_HAVE_KVM
 apicinterrupt3 POSTED_INTR_VECTOR		kvm_posted_intr_ipi		smp_kvm_posted_intr_ipi
 apicinterrupt3 POSTED_INTR_WAKEUP_VECTOR	kvm_posted_intr_wakeup_ipi	smp_kvm_posted_intr_wakeup_ipi
@@ -1030,9 +1027,6 @@ apicinterrupt CALL_FUNCTION_VECTOR		call
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
@@ -29,12 +29,9 @@
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
 
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -479,6 +479,14 @@ DECLARE_IDTENTRY_CR2(X86_TRAP_PF,	exc_as
 DECLARE_IDTENTRY_IRQ(X6_TRAP_OTHER,	common_interrupt);
 DECLARE_IDTENTRY_IRQ(X6_TRAP_OTHER,	spurious_interrupt);
 
+/* System vector entry points */
+#ifdef CONFIG_X86_LOCAL_APIC
+DECLARE_IDTENTRY_SYSVEC(ERROR_APIC_VECTOR,		sysvec_error_interrupt);
+DECLARE_IDTENTRY_SYSVEC(SPURIOUS_APIC_VECTOR,		sysvec_spurious_apic_interrupt);
+DECLARE_IDTENTRY_SYSVEC(LOCAL_TIMER_VECTOR,		sysvec_apic_timer_interrupt);
+DECLARE_IDTENTRY_SYSVEC(X86_PLATFORM_IPI_VECTOR,	sysvec_x86_platform_ipi);
+#endif
+
 #ifdef CONFIG_X86_MCE
 /* Machine check */
 DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -44,7 +44,6 @@ extern void __init init_IRQ(void);
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
 				    bool exclude_self);
 
-extern __visible void smp_x86_platform_ipi(struct pt_regs *regs);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
 
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -38,9 +38,6 @@ asmlinkage void smp_threshold_interrupt(
 asmlinkage void smp_deferred_error_interrupt(struct pt_regs *regs);
 #endif
 
-void smp_apic_timer_interrupt(struct pt_regs *regs);
-void smp_error_interrupt(struct pt_regs *regs);
-void smp_spurious_apic_interrupt(struct pt_regs *regs);
 asmlinkage void smp_irq_move_cleanup_interrupt(void);
 
 extern void ist_enter(struct pt_regs *regs);
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1127,7 +1127,7 @@ static void local_apic_timer_interrupt(v
  * [ if a single-CPU system runs an SMP kernel then we call the local
  *   interrupt as well. Thus we cannot inline the local irq ... ]
  */
-__visible void __irq_entry smp_apic_timer_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_apic_timer_interrupt)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
@@ -2167,7 +2167,7 @@ void __init register_lapic_address(unsig
  * trigger on an entry which is routed to the common_spurious idtentry
  * point.
  *
- * Also called from smp_spurious_apic_interrupt().
+ * Also called from sysvec_spurious_apic_interrupt().
  */
 DEFINE_IDTENTRY_IRQ(spurious_interrupt)
 {
@@ -2206,7 +2206,7 @@ DEFINE_IDTENTRY_IRQ(spurious_interrupt)
 	exiting_irq();
 }
 
-__visible void smp_spurious_apic_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_spurious_apic_interrupt)
 {
 	__spurious_interrupt(regs, SPURIOUS_APIC_VECTOR);
 }
@@ -2214,7 +2214,7 @@ DEFINE_IDTENTRY_IRQ(spurious_interrupt)
 /*
  * This interrupt should never happen with our APIC/SMP architecture
  */
-__visible void __irq_entry smp_error_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_error_interrupt)
 {
 	static const char * const error_interrupt_reason[] = {
 		"Send CS error",		/* APIC Error Bit 0 */
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -129,8 +129,8 @@ static const __initconst struct idt_data
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	INTG(LOCAL_TIMER_VECTOR,	apic_timer_interrupt),
-	INTG(X86_PLATFORM_IPI_VECTOR,	x86_platform_ipi),
+	INTG(LOCAL_TIMER_VECTOR,	asm_sysvec_apic_timer_interrupt),
+	INTG(X86_PLATFORM_IPI_VECTOR,	asm_sysvec_x86_platform_ipi),
 # ifdef CONFIG_HAVE_KVM
 	INTG(POSTED_INTR_VECTOR,	kvm_posted_intr_ipi),
 	INTG(POSTED_INTR_WAKEUP_VECTOR, kvm_posted_intr_wakeup_ipi),
@@ -142,8 +142,8 @@ static const __initconst struct idt_data
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
@@ -14,6 +14,7 @@
 #include <linux/irq.h>
 
 #include <asm/apic.h>
+#include <asm/traps.h>
 #include <asm/io_apic.h>
 #include <asm/irq.h>
 #include <asm/mce.h>
@@ -269,7 +270,7 @@ void (*x86_platform_ipi_callback)(void)
 /*
  * Handler for X86_PLATFORM_IPI_VECTOR.
  */
-__visible void __irq_entry smp_x86_platform_ipi(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_x86_platform_ipi)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 

