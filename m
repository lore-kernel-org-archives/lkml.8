Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6162AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CF6207D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgEPALL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 20:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728058AbgEPALE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:11:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FDFC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 17:11:04 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZkPW-0002Rr-B8; Sat, 16 May 2020 02:10:38 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id D89F9FF834;
        Sat, 16 May 2020 02:10:37 +0200 (CEST)
Message-Id: <20200515235126.912643204@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 May 2020 01:46:12 +0200
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
Subject: [patch V6 25/37] x86/entry: Convert SMP system vectors to IDTENTRY_SYSVEC
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


Convert SMP system vectors to IDTENTRY_SYSVEC
  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64bit
  - Remove the BUILD_INTERRUPT entries in 32bit
  - Remove the old prototypes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 6e629e5d5047..c1a47d37f29e 100644
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
index d10d6d807e73..2e2055bcfeb2 100644
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
index 1765993360e7..36a38695f27f 100644
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
index 6154d1e75fce..20e47b8d4024 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -575,6 +575,13 @@ DECLARE_IDTENTRY_SYSVEC(LOCAL_TIMER_VECTOR,		sysvec_apic_timer_interrupt);
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
index 933934c3e173..0c40f37f8cb7 100644
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
index 67768e54438b..c48be6e1f676 100644
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
index 7e38af51480d..95abcd52e5be 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -109,11 +109,11 @@ static const __initconst struct idt_data def_idts[] = {
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
index b8d4e9c3c070..e5647daa7e96 100644
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

