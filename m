Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15656C4BA09
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E1024680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbgBYX1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:27:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56008 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730474AbgBYX0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:54 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jay-00054m-NC; Wed, 26 Feb 2020 00:26:33 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 0D71110408C;
        Wed, 26 Feb 2020 00:25:53 +0100 (CET)
Message-Id: <20200225231609.835888421@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:28 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 09/15] x86/entry: Convert KVM vectors to IDTENTRY_SYSVEC
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

Convert KVm specific system vectors to IDTENTRY_SYSVEC
  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64bit
  - Remove the BUILD_INTERRUPT entries in 32bit
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S         |    3 ---
 arch/x86/entry/entry_64.S         |    7 -------
 arch/x86/include/asm/entry_arch.h |   19 -------------------
 arch/x86/include/asm/hw_irq.h     |    5 -----
 arch/x86/include/asm/idtentry.h   |    6 ++++++
 arch/x86/include/asm/irq.h        |    3 ---
 arch/x86/kernel/idt.c             |    6 +++---
 arch/x86/kernel/irq.c             |    6 +++---
 8 files changed, 12 insertions(+), 43 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1286,9 +1286,6 @@ SYM_FUNC_END(name)
 #define BUILD_INTERRUPT(name, nr)		\
 	BUILD_INTERRUPT3(name, nr, smp_##name);	\
 
-/* The include is where all of the SMP etc. interrupts come from */
-#include <asm/entry_arch.h>
-
 #ifdef CONFIG_PARAVIRT
 SYM_CODE_START(native_iret)
 	iret
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -994,13 +994,6 @@ apicinterrupt3 \num \sym \do_sym
 POP_SECTION_IRQENTRY
 .endm
 
-
-#ifdef CONFIG_HAVE_KVM
-apicinterrupt3 POSTED_INTR_VECTOR		kvm_posted_intr_ipi		smp_kvm_posted_intr_ipi
-apicinterrupt3 POSTED_INTR_WAKEUP_VECTOR	kvm_posted_intr_wakeup_ipi	smp_kvm_posted_intr_wakeup_ipi
-apicinterrupt3 POSTED_INTR_NESTED_VECTOR	kvm_posted_intr_nested_ipi	smp_kvm_posted_intr_nested_ipi
-#endif
-
 /*
  * Reload gs selector with exception handling
  * edi:  new selector
--- a/arch/x86/include/asm/entry_arch.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This file is designed to contain the BUILD_INTERRUPT specifications for
- * all of the extra named interrupt vectors used by the architecture.
- * Usually this is the Inter Process Interrupts (IPIs)
- */
-
-/*
- * The following vectors are part of the Linux architecture, there
- * is no hardware IRQ pin equivalent for them, they are triggered
- * through the ICC by us (IPIs)
- */
-
-#ifdef CONFIG_HAVE_KVM
-BUILD_INTERRUPT(kvm_posted_intr_ipi, POSTED_INTR_VECTOR)
-BUILD_INTERRUPT(kvm_posted_intr_wakeup_ipi, POSTED_INTR_WAKEUP_VECTOR)
-BUILD_INTERRUPT(kvm_posted_intr_nested_ipi, POSTED_INTR_NESTED_VECTOR)
-#endif
-
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -28,11 +28,6 @@
 #include <asm/irq.h>
 #include <asm/sections.h>
 
-/* Interrupt handlers registered during init_IRQ */
-extern asmlinkage void kvm_posted_intr_ipi(void);
-extern asmlinkage void kvm_posted_intr_wakeup_ipi(void);
-extern asmlinkage void kvm_posted_intr_nested_ipi(void);
-
 #ifdef	CONFIG_X86_LOCAL_APIC
 struct irq_data;
 struct pci_dev;
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -517,6 +517,12 @@ DECLARE_IDTENTRY_SYSVEC(THERMAL_APIC_VEC
 DECLARE_IDTENTRY_SYSVEC(IRQ_WORK_VECTOR,		sysvec_irq_work);
 #endif
 
+#ifdef CONFIG_HAVE_KVM
+DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_VECTOR,		sysvec_kvm_posted_intr_ipi);
+DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	sysvec_kvm_posted_intr_wakeup_ipi);
+DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested_ipi);
+#endif
+
 #ifdef CONFIG_X86_MCE
 /* Machine check */
 DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -26,9 +26,6 @@ extern void fixup_irqs(void);
 
 #ifdef CONFIG_HAVE_KVM
 extern void kvm_set_posted_intr_wakeup_handler(void (*handler)(void));
-extern __visible void smp_kvm_posted_intr_ipi(struct pt_regs *regs);
-extern __visible void smp_kvm_posted_intr_wakeup_ipi(struct pt_regs *regs);
-extern __visible void smp_kvm_posted_intr_nested_ipi(struct pt_regs *regs);
 #endif
 
 extern void (*x86_platform_ipi_callback)(void);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -132,9 +132,9 @@ static const __initconst struct idt_data
 	INTG(LOCAL_TIMER_VECTOR,		asm_sysvec_apic_timer_interrupt),
 	INTG(X86_PLATFORM_IPI_VECTOR,		asm_sysvec_x86_platform_ipi),
 # ifdef CONFIG_HAVE_KVM
-	INTG(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
-	INTG(POSTED_INTR_WAKEUP_VECTOR,		kvm_posted_intr_wakeup_ipi),
-	INTG(POSTED_INTR_NESTED_VECTOR,		kvm_posted_intr_nested_ipi),
+	INTG(POSTED_INTR_VECTOR,		asm_sysvec_kvm_posted_intr_ipi),
+	INTG(POSTED_INTR_WAKEUP_VECTOR,		asm_sysvec_kvm_posted_intr_wakeup_ipi),
+	INTG(POSTED_INTR_NESTED_VECTOR,		asm_sysvec_kvm_posted_intr_nested_ipi),
 # endif
 # ifdef CONFIG_IRQ_WORK
 	INTG(IRQ_WORK_VECTOR,			asm_sysvec_irq_work),
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -301,7 +301,7 @@ EXPORT_SYMBOL_GPL(kvm_set_posted_intr_wa
 /*
  * Handler for POSTED_INTERRUPT_VECTOR.
  */
-__visible void smp_kvm_posted_intr_ipi(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_posted_intr_ipi)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
@@ -314,7 +314,7 @@ EXPORT_SYMBOL_GPL(kvm_set_posted_intr_wa
 /*
  * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
  */
-__visible void smp_kvm_posted_intr_wakeup_ipi(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_posted_intr_wakeup_ipi)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
@@ -328,7 +328,7 @@ EXPORT_SYMBOL_GPL(kvm_set_posted_intr_wa
 /*
  * Handler for POSTED_INTERRUPT_NESTED_VECTOR.
  */
-__visible void smp_kvm_posted_intr_nested_ipi(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_posted_intr_nested_ipi)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 

