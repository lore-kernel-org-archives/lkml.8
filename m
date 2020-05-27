Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7690C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C340C21531
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgE0IMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbgE0IL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:11:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC62C061A0F;
        Wed, 27 May 2020 01:11:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAH-0002WC-RF; Wed, 27 May 2020 10:11:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 779061C00ED;
        Wed, 27 May 2020 10:11:48 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:48 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert KVM vectors to IDTENTRY_SYSVEC*
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202119.555715519@linutronix.de>
References: <20200521202119.555715519@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056710836.17951.11787567096424657905.tip-bot2@tip-bot2>
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

Commit-ID:     79e5785846099b7f48c92ffa299a4ddc1e4a98f6
Gitweb:        https://git.kernel.org/tip/79e5785846099b7f48c92ffa299a4ddc1e4a98f6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:28 +02:00

x86/entry: Convert KVM vectors to IDTENTRY_SYSVEC*

Convert KVM specific system vectors to IDTENTRY_SYSVEC*:

The two empty stub handlers which only increment the stats counter do no
need to run on the interrupt stack. Use IDTENTRY_SYSVEC_SIMPLE for them.

The wakeup handler does more work and runs on the interrupt stack.

None of these handlers need to save and restore the irq_regs pointer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202119.555715519@linutronix.de
---
 arch/x86/entry/entry_64.S         |  7 -------
 arch/x86/include/asm/entry_arch.h |  7 -------
 arch/x86/include/asm/hw_irq.h     |  4 ----
 arch/x86/include/asm/idtentry.h   |  6 ++++++
 arch/x86/include/asm/irq.h        |  3 ---
 arch/x86/kernel/idt.c             |  6 +++---
 arch/x86/kernel/irq.c             | 24 ++++++------------------
 7 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 2301f62..ea1f293 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -956,13 +956,6 @@ apicinterrupt3 \num \sym \do_sym
 POP_SECTION_IRQENTRY
 .endm
 
-
-#ifdef CONFIG_HAVE_KVM
-apicinterrupt3 POSTED_INTR_VECTOR		kvm_posted_intr_ipi		smp_kvm_posted_intr_ipi
-apicinterrupt3 POSTED_INTR_WAKEUP_VECTOR	kvm_posted_intr_wakeup_ipi	smp_kvm_posted_intr_wakeup_ipi
-apicinterrupt3 POSTED_INTR_NESTED_VECTOR	kvm_posted_intr_nested_ipi	smp_kvm_posted_intr_nested_ipi
-#endif
-
 #ifdef CONFIG_SMP
 apicinterrupt RESCHEDULE_VECTOR			reschedule_interrupt		smp_reschedule_interrupt
 #endif
diff --git a/arch/x86/include/asm/entry_arch.h b/arch/x86/include/asm/entry_arch.h
index 69a5320..a01bb74 100644
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -13,10 +13,3 @@
 #ifdef CONFIG_SMP
 BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
 #endif
-
-#ifdef CONFIG_HAVE_KVM
-BUILD_INTERRUPT(kvm_posted_intr_ipi, POSTED_INTR_VECTOR)
-BUILD_INTERRUPT(kvm_posted_intr_wakeup_ipi, POSTED_INTR_WAKEUP_VECTOR)
-BUILD_INTERRUPT(kvm_posted_intr_nested_ipi, POSTED_INTR_NESTED_VECTOR)
-#endif
-
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 7281c7e..fd5e7c8 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -29,10 +29,6 @@
 #include <asm/sections.h>
 
 /* Interrupt handlers registered during init_IRQ */
-extern asmlinkage void kvm_posted_intr_ipi(void);
-extern asmlinkage void kvm_posted_intr_wakeup_ipi(void);
-extern asmlinkage void kvm_posted_intr_nested_ipi(void);
-
 extern asmlinkage void reschedule_interrupt(void);
 
 #ifdef	CONFIG_X86_LOCAL_APIC
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 0eedfca..7212eaf 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -606,6 +606,12 @@ DECLARE_IDTENTRY_SYSVEC(IRQ_WORK_VECTOR,		sysvec_irq_work);
 # endif
 #endif
 
+#ifdef CONFIG_HAVE_KVM
+DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_VECTOR,		sysvec_kvm_posted_intr_ipi);
+DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	sysvec_kvm_posted_intr_wakeup_ipi);
+DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested_ipi);
+#endif
+
 #undef X86_TRAP_OTHER
 
 #endif
diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index c7c43e8..f73dd3f 100644
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
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 3d811d0..faaadd4 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -135,9 +135,9 @@ static const __initconst struct idt_data apic_idts[] = {
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
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 7e30052..1810602 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -298,41 +298,29 @@ EXPORT_SYMBOL_GPL(kvm_set_posted_intr_wakeup_handler);
 /*
  * Handler for POSTED_INTERRUPT_VECTOR.
  */
-__visible void smp_kvm_posted_intr_ipi(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_ipi)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
-
-	entering_ack_irq();
+	ack_APIC_irq();
 	inc_irq_stat(kvm_posted_intr_ipis);
-	exiting_irq();
-	set_irq_regs(old_regs);
 }
 
 /*
  * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
  */
-__visible void smp_kvm_posted_intr_wakeup_ipi(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_posted_intr_wakeup_ipi)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
-
-	entering_ack_irq();
+	ack_APIC_irq();
 	inc_irq_stat(kvm_posted_intr_wakeup_ipis);
 	kvm_posted_intr_wakeup_handler();
-	exiting_irq();
-	set_irq_regs(old_regs);
 }
 
 /*
  * Handler for POSTED_INTERRUPT_NESTED_VECTOR.
  */
-__visible void smp_kvm_posted_intr_nested_ipi(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_nested_ipi)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
-
-	entering_ack_irq();
+	ack_APIC_irq();
 	inc_irq_stat(kvm_posted_intr_nested_ipis);
-	exiting_irq();
-	set_irq_regs(old_regs);
 }
 #endif
 
