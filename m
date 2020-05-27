Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAF8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306B521531
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgE0IL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgE0ILy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:11:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC0BC03E97A;
        Wed, 27 May 2020 01:11:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAG-0002Wf-Ub; Wed, 27 May 2020 10:11:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6D7861C0481;
        Wed, 27 May 2020 10:11:49 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:49 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert SMP system vectors to IDTENTRY_SYSVEC
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202119.372234635@linutronix.de>
References: <20200521202119.372234635@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056710932.17951.6595893833651848484.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     8f2d02673efc50ad7075fbbfce465766cf8f1a20
Gitweb:        https://git.kernel.org/tip/8f2d02673efc50ad7075fbbfce465766cf8f1a20
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:40 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:28 +02:00

x86/entry: Convert SMP system vectors to IDTENTRY_SYSVEC

Convert SMP system vectors to IDTENTRY_SYSVEC:

  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64-bit
  - Remove the BUILD_INTERRUPT entries in 32-bit
  - Remove the old prototypes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202119.372234635@linutronix.de
---
 arch/x86/entry/entry_64.S         |  7 -------
 arch/x86/include/asm/entry_arch.h |  4 ----
 arch/x86/include/asm/hw_irq.h     |  5 -----
 arch/x86/include/asm/idtentry.h   |  7 +++++++
 arch/x86/include/asm/traps.h      |  2 --
 arch/x86/kernel/apic/vector.c     |  5 ++---
 arch/x86/kernel/idt.c             | 10 +++++-----
 arch/x86/kernel/smp.c             | 18 +++++++-----------
 8 files changed, 21 insertions(+), 37 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 25f71a0..f3ccb27 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -956,11 +956,6 @@ apicinterrupt3 \num \sym \do_sym
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
@@ -984,8 +979,6 @@ apicinterrupt THERMAL_APIC_VECTOR		thermal_interrupt		smp_thermal_interrupt
 #endif
 
 #ifdef CONFIG_SMP
-apicinterrupt CALL_FUNCTION_SINGLE_VECTOR	call_function_single_interrupt	smp_call_function_single_interrupt
-apicinterrupt CALL_FUNCTION_VECTOR		call_function_interrupt		smp_call_function_interrupt
 apicinterrupt RESCHEDULE_VECTOR			reschedule_interrupt		smp_reschedule_interrupt
 #endif
 
diff --git a/arch/x86/include/asm/entry_arch.h b/arch/x86/include/asm/entry_arch.h
index d10d6d8..2e2055b 100644
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -12,10 +12,6 @@
  */
 #ifdef CONFIG_SMP
 BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
-BUILD_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
-BUILD_INTERRUPT(call_function_single_interrupt,CALL_FUNCTION_SINGLE_VECTOR)
-BUILD_INTERRUPT(irq_move_cleanup_interrupt, IRQ_MOVE_CLEANUP_VECTOR)
-BUILD_INTERRUPT(reboot_interrupt, REBOOT_VECTOR)
 #endif
 
 #ifdef CONFIG_HAVE_KVM
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 1765993..36a3869 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -38,14 +38,9 @@ extern asmlinkage void uv_bau_message_intr1(void);
 extern asmlinkage void thermal_interrupt(void);
 extern asmlinkage void reschedule_interrupt(void);
 
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
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 3e58480..82cca1f 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -577,6 +577,13 @@ DECLARE_IDTENTRY_SYSVEC(LOCAL_TIMER_VECTOR,		sysvec_apic_timer_interrupt);
 DECLARE_IDTENTRY_SYSVEC(X86_PLATFORM_IPI_VECTOR,	sysvec_x86_platform_ipi);
 #endif
 
+#ifdef CONFIG_SMP
+DECLARE_IDTENTRY_SYSVEC(IRQ_MOVE_CLEANUP_VECTOR,	sysvec_irq_move_cleanup);
+DECLARE_IDTENTRY_SYSVEC(REBOOT_VECTOR,			sysvec_reboot);
+DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	sysvec_call_function_single);
+DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_VECTOR,		sysvec_call_function);
+#endif
+
 #undef X86_TRAP_OTHER
 
 #endif
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 933934c..0c40f37 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -40,8 +40,6 @@ asmlinkage void smp_threshold_interrupt(struct pt_regs *regs);
 asmlinkage void smp_deferred_error_interrupt(struct pt_regs *regs);
 #endif
 
-asmlinkage void smp_irq_move_cleanup_interrupt(void);
-
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
 				      struct pt_regs *regs,
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 67768e5..c48be6e 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -861,13 +861,13 @@ static void free_moved_vector(struct apic_chip_data *apicd)
 	apicd->move_in_progress = 0;
 }
 
-asmlinkage __visible void __irq_entry smp_irq_move_cleanup_interrupt(void)
+DEFINE_IDTENTRY_SYSVEC(sysvec_irq_move_cleanup)
 {
 	struct hlist_head *clhead = this_cpu_ptr(&cleanup_list);
 	struct apic_chip_data *apicd;
 	struct hlist_node *tmp;
 
-	entering_ack_irq();
+	ack_APIC_irq();
 	/* Prevent vectors vanishing under us */
 	raw_spin_lock(&vector_lock);
 
@@ -892,7 +892,6 @@ asmlinkage __visible void __irq_entry smp_irq_move_cleanup_interrupt(void)
 	}
 
 	raw_spin_unlock(&vector_lock);
-	exiting_irq();
 }
 
 static void __send_cleanup_vector(struct apic_chip_data *apicd)
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 93c1b27..018a542 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -112,11 +112,11 @@ static const __initconst struct idt_data def_idts[] = {
  */
 static const __initconst struct idt_data apic_idts[] = {
 #ifdef CONFIG_SMP
-	INTG(RESCHEDULE_VECTOR,		reschedule_interrupt),
-	INTG(CALL_FUNCTION_VECTOR,	call_function_interrupt),
-	INTG(CALL_FUNCTION_SINGLE_VECTOR, call_function_single_interrupt),
-	INTG(IRQ_MOVE_CLEANUP_VECTOR,	irq_move_cleanup_interrupt),
-	INTG(REBOOT_VECTOR,		reboot_interrupt),
+	INTG(RESCHEDULE_VECTOR,			reschedule_interrupt),
+	INTG(CALL_FUNCTION_VECTOR,		asm_sysvec_call_function),
+	INTG(CALL_FUNCTION_SINGLE_VECTOR,	asm_sysvec_call_function_single),
+	INTG(IRQ_MOVE_CLEANUP_VECTOR,		asm_sysvec_irq_move_cleanup),
+	INTG(REBOOT_VECTOR,			asm_sysvec_reboot),
 #endif
 
 #ifdef CONFIG_X86_THERMAL_VECTOR
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index b8d4e9c..e5647da 100644
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
@@ -130,13 +131,11 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 /*
  * this function calls the 'stop' function on all other CPUs in the system.
  */
-
-asmlinkage __visible void smp_reboot_interrupt(void)
+DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
 {
-	ipi_entering_ack_irq();
+	ack_APIC_irq();
 	cpu_emergency_vmxoff();
 	stop_this_cpu(NULL);
-	irq_exit();
 }
 
 static int register_stop_handler(void)
@@ -227,7 +226,6 @@ __visible void __irq_entry smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
 	inc_irq_stat(irq_resched_count);
-	kvm_set_cpu_l1tf_flush_l1d();
 
 	if (trace_resched_ipi_enabled()) {
 		/*
@@ -244,24 +242,22 @@ __visible void __irq_entry smp_reschedule_interrupt(struct pt_regs *regs)
 	scheduler_ipi();
 }
 
-__visible void __irq_entry smp_call_function_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_call_function)
 {
-	ipi_entering_ack_irq();
+	ack_APIC_irq();
 	trace_call_function_entry(CALL_FUNCTION_VECTOR);
 	inc_irq_stat(irq_call_count);
 	generic_smp_call_function_interrupt();
 	trace_call_function_exit(CALL_FUNCTION_VECTOR);
-	exiting_irq();
 }
 
-__visible void __irq_entry smp_call_function_single_interrupt(struct pt_regs *r)
+DEFINE_IDTENTRY_SYSVEC(sysvec_call_function_single)
 {
-	ipi_entering_ack_irq();
+	ack_APIC_irq();
 	trace_call_function_single_entry(CALL_FUNCTION_SINGLE_VECTOR);
 	inc_irq_stat(irq_call_count);
 	generic_smp_call_function_single_interrupt();
 	trace_call_function_single_exit(CALL_FUNCTION_SINGLE_VECTOR);
-	exiting_irq();
 }
 
 static int __init nonmi_ipi_setup(char *str)
