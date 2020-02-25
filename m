Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D73EC4BA09
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A4024680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgBYX1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:27:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56033 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbgBYX1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:27:01 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jay-00053p-E3; Wed, 26 Feb 2020 00:26:33 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 9008B1040C2;
        Wed, 26 Feb 2020 00:25:52 +0100 (CET)
Message-Id: <20200225231609.623068964@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:26 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 07/15] x86/entry: Convert SMP system vectors to IDTENTRY_SYSVEC
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

Convert SMP system vectors to IDTENTRY_SYSVEC
  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64bit
  - Remove the BUILD_INTERRUPT entries in 32bit
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S         |   11 -----------
 arch/x86/include/asm/entry_arch.h |    7 -------
 arch/x86/include/asm/hw_irq.h     |    6 ------
 arch/x86/include/asm/idtentry.h   |   10 ++++++++++
 arch/x86/include/asm/traps.h      |    2 --
 arch/x86/kernel/apic/vector.c     |    2 +-
 arch/x86/kernel/idt.c             |   10 +++++-----
 arch/x86/kernel/smp.c             |   10 +++++-----
 8 files changed, 21 insertions(+), 37 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -994,11 +994,6 @@ apicinterrupt3 \num \sym \do_sym
 POP_SECTION_IRQENTRY
 .endm
 
-#ifdef CONFIG_SMP
-apicinterrupt3 IRQ_MOVE_CLEANUP_VECTOR		irq_move_cleanup_interrupt	smp_irq_move_cleanup_interrupt
-apicinterrupt3 REBOOT_VECTOR			reboot_interrupt		smp_reboot_interrupt
-#endif
-
 #ifdef CONFIG_X86_UV
 apicinterrupt3 UV_BAU_MESSAGE			uv_bau_message_intr1		uv_bau_message_interrupt
 #endif
@@ -1021,12 +1016,6 @@ apicinterrupt DEFERRED_ERROR_VECTOR		def
 apicinterrupt THERMAL_APIC_VECTOR		thermal_interrupt		smp_thermal_interrupt
 #endif
 
-#ifdef CONFIG_SMP
-apicinterrupt CALL_FUNCTION_SINGLE_VECTOR	call_function_single_interrupt	smp_call_function_single_interrupt
-apicinterrupt CALL_FUNCTION_VECTOR		call_function_interrupt		smp_call_function_interrupt
-apicinterrupt RESCHEDULE_VECTOR			reschedule_interrupt		smp_reschedule_interrupt
-#endif
-
 #ifdef CONFIG_IRQ_WORK
 apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 #endif
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -10,13 +10,6 @@
  * is no hardware IRQ pin equivalent for them, they are triggered
  * through the ICC by us (IPIs)
  */
-#ifdef CONFIG_SMP
-BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
-BUILD_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
-BUILD_INTERRUPT(call_function_single_interrupt,CALL_FUNCTION_SINGLE_VECTOR)
-BUILD_INTERRUPT(irq_move_cleanup_interrupt, IRQ_MOVE_CLEANUP_VECTOR)
-BUILD_INTERRUPT(reboot_interrupt, REBOOT_VECTOR)
-#endif
 
 #ifdef CONFIG_HAVE_KVM
 BUILD_INTERRUPT(kvm_posted_intr_ipi, POSTED_INTR_VECTOR)
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -37,16 +37,10 @@ extern asmlinkage void uv_bau_message_in
 
 extern asmlinkage void spurious_apic_interrupt(void);
 extern asmlinkage void thermal_interrupt(void);
-extern asmlinkage void reschedule_interrupt(void);
 
-extern asmlinkage void irq_move_cleanup_interrupt(void);
-extern asmlinkage void reboot_interrupt(void);
 extern asmlinkage void threshold_interrupt(void);
 extern asmlinkage void deferred_error_interrupt(void);
 
-extern asmlinkage void call_function_interrupt(void);
-extern asmlinkage void call_function_single_interrupt(void);
-
 #ifdef	CONFIG_X86_LOCAL_APIC
 struct irq_data;
 struct pci_dev;
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -7,6 +7,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/kprobes.h>
+
 #ifdef CONFIG_CONTEXT_TRACKING
 static __always_inline void enter_from_user_context(void)
 {
@@ -487,6 +489,14 @@ DECLARE_IDTENTRY_SYSVEC(LOCAL_TIMER_VECT
 DECLARE_IDTENTRY_SYSVEC(X86_PLATFORM_IPI_VECTOR,	sysvec_x86_platform_ipi);
 #endif
 
+#ifdef CONFIG_SMP
+DECLARE_IDTENTRY_SYSVEC(IRQ_MOVE_CLEANUP_VECTOR,	sysvec_irq_move_cleanup);
+DECLARE_IDTENTRY_SYSVEC(REBOOT_VECTOR,			sysvec_reboot);
+DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	sysvec_call_function_single);
+DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_VECTOR,		sysvec_call_function);
+DECLARE_IDTENTRY_SYSVEC(RESCHEDULE_VECTOR,		sysvec_reschedule);
+#endif
+
 #ifdef CONFIG_X86_MCE
 /* Machine check */
 DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -38,8 +38,6 @@ asmlinkage void smp_threshold_interrupt(
 asmlinkage void smp_deferred_error_interrupt(struct pt_regs *regs);
 #endif
 
-asmlinkage void smp_irq_move_cleanup_interrupt(void);
-
 extern void ist_enter(struct pt_regs *regs);
 extern void ist_exit(struct pt_regs *regs);
 extern void ist_begin_non_atomic(struct pt_regs *regs);
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -853,7 +853,7 @@ static void free_moved_vector(struct api
 	apicd->move_in_progress = 0;
 }
 
-asmlinkage __visible void __irq_entry smp_irq_move_cleanup_interrupt(void)
+DEFINE_IDTENTRY_SYSVEC(sysvec_irq_move_cleanup)
 {
 	struct hlist_head *clhead = this_cpu_ptr(&cleanup_list);
 	struct apic_chip_data *apicd;
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -109,11 +109,11 @@ static const __initconst struct idt_data
  */
 static const __initconst struct idt_data apic_idts[] = {
 #ifdef CONFIG_SMP
-	INTG(RESCHEDULE_VECTOR,		reschedule_interrupt),
-	INTG(CALL_FUNCTION_VECTOR,	call_function_interrupt),
-	INTG(CALL_FUNCTION_SINGLE_VECTOR, call_function_single_interrupt),
-	INTG(IRQ_MOVE_CLEANUP_VECTOR,	irq_move_cleanup_interrupt),
-	INTG(REBOOT_VECTOR,		reboot_interrupt),
+	INTG(RESCHEDULE_VECTOR,			asm_sysvec_reschedule),
+	INTG(CALL_FUNCTION_VECTOR,		asm_sysvec_call_function),
+	INTG(CALL_FUNCTION_SINGLE_VECTOR,	asm_sysvec_call_function_single),
+	INTG(IRQ_MOVE_CLEANUP_VECTOR,		asm_sysvec_irq_move_cleanup),
+	INTG(REBOOT_VECTOR,			asm_sysvec_reboot),
 #endif
 
 #ifdef CONFIG_X86_THERMAL_VECTOR
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -27,6 +27,7 @@
 #include <asm/mmu_context.h>
 #include <asm/proto.h>
 #include <asm/apic.h>
+#include <asm/idtentry.h>
 #include <asm/nmi.h>
 #include <asm/mce.h>
 #include <asm/trace/irq_vectors.h>
@@ -130,8 +131,7 @@ static int smp_stop_nmi_callback(unsigne
 /*
  * this function calls the 'stop' function on all other CPUs in the system.
  */
-
-asmlinkage __visible void smp_reboot_interrupt(void)
+DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
 {
 	ipi_entering_ack_irq();
 	cpu_emergency_vmxoff();
@@ -223,7 +223,7 @@ static void native_stop_other_cpus(int w
  * Reschedule call back. KVM uses this interrupt to force a cpu out of
  * guest mode
  */
-__visible void __irq_entry smp_reschedule_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_reschedule)
 {
 	ack_APIC_irq();
 	inc_irq_stat(irq_resched_count);
@@ -244,7 +244,7 @@ static void native_stop_other_cpus(int w
 	scheduler_ipi();
 }
 
-__visible void __irq_entry smp_call_function_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_call_function)
 {
 	ipi_entering_ack_irq();
 	trace_call_function_entry(CALL_FUNCTION_VECTOR);
@@ -254,7 +254,7 @@ static void native_stop_other_cpus(int w
 	exiting_irq();
 }
 
-__visible void __irq_entry smp_call_function_single_interrupt(struct pt_regs *r)
+DEFINE_IDTENTRY_SYSVEC(sysvec_call_function_single)
 {
 	ipi_entering_ack_irq();
 	trace_call_function_single_entry(CALL_FUNCTION_SINGLE_VECTOR);

