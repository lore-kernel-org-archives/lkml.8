Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F56AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F9121897
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgE0IME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbgE0IL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:11:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30BCC03E97A;
        Wed, 27 May 2020 01:11:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAK-0002Xv-UI; Wed, 27 May 2020 10:11:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6AA971C04D6;
        Wed, 27 May 2020 10:11:51 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:51 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Add IRQENTRY_IRQ macro
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202118.984573165@linutronix.de>
References: <20200521202118.984573165@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711131.17951.5568268752047363963.tip-bot2@tip-bot2>
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

Commit-ID:     f7376b1a72bb4bcfe2212150e3cf79f21cf88912
Gitweb:        https://git.kernel.org/tip/f7376b1a72bb4bcfe2212150e3cf79f21cf88912
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:28 +02:00

x86/entry: Add IRQENTRY_IRQ macro

Provide a seperate IDTENTRY macro for device interrupts. Similar to
IDTENTRY_ERRORCODE with the addition of invoking irq_enter/exit_rcu() and
providing the errorcode as a 'u8' argument to the C function, which
truncates the sign extended vector number.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202118.984573165@linutronix.de
---
 arch/x86/entry/entry_32.S       | 14 +++++++++-
 arch/x86/entry/entry_64.S       | 14 +++++++++-
 arch/x86/include/asm/idtentry.h | 48 ++++++++++++++++++++++++++++++++-
 3 files changed, 76 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 53a6447..6930ec1 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -751,6 +751,20 @@ SYM_CODE_START(\asmsym)
 SYM_CODE_END(\asmsym)
 .endm
 
+.macro idtentry_irq vector cfunc
+	.p2align CONFIG_X86_L1_CACHE_SHIFT
+SYM_CODE_START_LOCAL(asm_\cfunc)
+	ASM_CLAC
+	SAVE_ALL switch_stacks=1
+	ENCODE_FRAME_POINTER
+	movl	%esp, %eax
+	movl	PT_ORIG_EAX(%esp), %edx		/* get the vector from stack */
+	movl	$-1, PT_ORIG_EAX(%esp)		/* no syscall to restart */
+	call	\cfunc
+	jmp	handle_exception_return
+SYM_CODE_END(asm_\cfunc)
+.endm
+
 /*
  * Include the defines which emit the idt entries which are shared
  * shared between 32 and 64 bit.
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e7434cd..9162a07 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -528,6 +528,20 @@ SYM_CODE_END(\asmsym)
 .endm
 
 /*
+ * Interrupt entry/exit.
+ *
+ + The interrupt stubs push (vector) onto the stack, which is the error_code
+ * position of idtentry exceptions, and jump to one of the two idtentry points
+ * (common/spurious).
+ *
+ * common_interrupt is a hotpath, align it to a cache line
+ */
+.macro idtentry_irq vector cfunc
+	.p2align CONFIG_X86_L1_CACHE_SHIFT
+	idtentry \vector asm_\cfunc \cfunc has_error_code=1
+.endm
+
+/*
  * MCE and DB exceptions
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b089997..6e00055 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -165,6 +165,50 @@ __visible noinstr void func(struct pt_regs *regs)
 #define DEFINE_IDTENTRY_RAW_ERRORCODE(func)				\
 __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
 
+/**
+ * DECLARE_IDTENTRY_IRQ - Declare functions for device interrupt IDT entry
+ *			  points (common/spurious)
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Maps to DECLARE_IDTENTRY_ERRORCODE()
+ */
+#define DECLARE_IDTENTRY_IRQ(vector, func)				\
+	DECLARE_IDTENTRY_ERRORCODE(vector, func)
+
+/**
+ * DEFINE_IDTENTRY_IRQ - Emit code for device interrupt IDT entry points
+ * @func:	Function name of the entry point
+ *
+ * The vector number is pushed by the low level entry stub and handed
+ * to the function as error_code argument which needs to be truncated
+ * to an u8 because the push is sign extending.
+ *
+ * On 64-bit idtentry_enter/exit() are invoked in the ASM entry code before
+ * and after switching to the interrupt stack. On 32-bit this happens in C.
+ *
+ * irq_enter/exit_rcu() are invoked before the function body and the
+ * KVM L1D flush request is set.
+ */
+#define DEFINE_IDTENTRY_IRQ(func)					\
+static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
+									\
+__visible noinstr void func(struct pt_regs *regs,			\
+			    unsigned long error_code)			\
+{									\
+	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+									\
+	instrumentation_begin();					\
+	irq_enter_rcu();						\
+	kvm_set_cpu_l1tf_flush_l1d();					\
+	__##func (regs, (u8)error_code);				\
+	irq_exit_rcu();							\
+	lockdep_hardirq_exit();						\
+	instrumentation_end();						\
+	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+}									\
+									\
+static __always_inline void __##func(struct pt_regs *regs, u8 vector)
 
 #ifdef CONFIG_X86_64
 /**
@@ -297,6 +341,10 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #define DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func)			\
 	DECLARE_IDTENTRY_ERRORCODE(vector, func)
 
+/* Entries for common/spurious (device) interrupts */
+#define DECLARE_IDTENTRY_IRQ(vector, func)				\
+	idtentry_irq vector func
+
 #ifdef CONFIG_X86_64
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	idtentry_mce_db vector asm_##func func
