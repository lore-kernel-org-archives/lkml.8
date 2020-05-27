Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45BDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC23215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgE0IMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbgE0IMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:12:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA04C03E97A;
        Wed, 27 May 2020 01:12:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAJ-0002XN-PM; Wed, 27 May 2020 10:11:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 642081C04D5;
        Wed, 27 May 2020 10:11:50 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:50 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Provide IDTENTRY_SYSVEC
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202119.185317067@linutronix.de>
References: <20200521202119.185317067@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711028.17951.1057625567928404926.tip-bot2@tip-bot2>
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

Commit-ID:     8c3d969a5352c3e68a42311852e20ee7530492c6
Gitweb:        https://git.kernel.org/tip/8c3d969a5352c3e68a42311852e20ee7530492c6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:28 +02:00

x86/entry: Provide IDTENTRY_SYSVEC

Provide IDTENTRY variants for system vectors to consolidate the different
mechanisms to emit the ASM stubs for 32- and 64-bit.

On 64-bit this also moves the stack switching from ASM to C code. 32-bit will
excute the system vectors w/o stack switching as before.

The simple variant is meant for "empty" system vectors like scheduler IPI
and KVM posted interrupt vectors. These do not need the full glory of irq
enter/exit handling with softirq processing and more.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202119.185317067@linutronix.de
---
 arch/x86/entry/entry_32.S       |  4 ++-
 arch/x86/entry/entry_64.S       |  8 +++-
 arch/x86/include/asm/idtentry.h | 79 ++++++++++++++++++++++++++++++++-
 3 files changed, 91 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d86e056..e59ad4b 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -765,6 +765,10 @@ SYM_CODE_START_LOCAL(asm_\cfunc)
 SYM_CODE_END(asm_\cfunc)
 .endm
 
+.macro idtentry_sysvec vector cfunc
+	idtentry \vector asm_\cfunc \cfunc has_error_code=0
+.endm
+
 /*
  * Include the defines which emit the idt entries which are shared
  * shared between 32 and 64 bit.
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e54bcd3..9b7183d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -542,6 +542,14 @@ SYM_CODE_END(\asmsym)
 .endm
 
 /*
+ * System vectors which invoke their handlers directly and are not
+ * going through the regular common device interrupt handling code.
+ */
+.macro idtentry_sysvec vector cfunc
+	idtentry \vector asm_\cfunc \cfunc has_error_code=0
+.endm
+
+/*
  * MCE and DB exceptions
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 32035d1..31948e6 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -6,6 +6,9 @@
 #include <asm/trapnr.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/hardirq.h>
+
+#include <asm/irq_stack.h>
 
 void idtentry_enter_user(struct pt_regs *regs);
 void idtentry_exit_user(struct pt_regs *regs);
@@ -210,6 +213,78 @@ __visible noinstr void func(struct pt_regs *regs,			\
 									\
 static __always_inline void __##func(struct pt_regs *regs, u8 vector)
 
+/**
+ * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Declares three functions:
+ * - The ASM entry point: asm_##func
+ * - The XEN PV trap entry point: xen_##func (maybe unused)
+ * - The C handler called from the ASM entry point
+ *
+ * Maps to DECLARE_IDTENTRY().
+ */
+#define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
+	DECLARE_IDTENTRY(vector, func)
+
+/**
+ * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
+ * @func:	Function name of the entry point
+ *
+ * idtentry_enter/exit() and irq_enter/exit_rcu() are invoked before the
+ * function body. KVM L1D flush request is set.
+ *
+ * Runs the function on the interrupt stack if the entry hit kernel mode
+ */
+#define DEFINE_IDTENTRY_SYSVEC(func)					\
+static void __##func(struct pt_regs *regs);				\
+									\
+__visible noinstr void func(struct pt_regs *regs)			\
+{									\
+	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+									\
+	instrumentation_begin();					\
+	irq_enter_rcu();						\
+	kvm_set_cpu_l1tf_flush_l1d();					\
+	run_on_irqstack_cond(__##func, regs, regs);			\
+	irq_exit_rcu();							\
+	lockdep_hardirq_exit();						\
+	instrumentation_end();						\
+	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+}									\
+									\
+static noinline void __##func(struct pt_regs *regs)
+
+/**
+ * DEFINE_IDTENTRY_SYSVEC_SIMPLE - Emit code for simple system vector IDT
+ *				   entry points
+ * @func:	Function name of the entry point
+ *
+ * Runs the function on the interrupted stack. No switch to IRQ stack and
+ * only the minimal __irq_enter/exit() handling.
+ *
+ * Only use for 'empty' vectors like reschedule IPI and KVM posted
+ * interrupt vectors.
+ */
+#define DEFINE_IDTENTRY_SYSVEC_SIMPLE(func)				\
+static __always_inline void __##func(struct pt_regs *regs);		\
+									\
+__visible noinstr void func(struct pt_regs *regs)			\
+{									\
+	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+									\
+	instrumentation_begin();					\
+	__irq_enter_raw();						\
+	kvm_set_cpu_l1tf_flush_l1d();					\
+	__##func (regs);						\
+	__irq_exit_raw();						\
+	instrumentation_end();						\
+	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+}									\
+									\
+static __always_inline void __##func(struct pt_regs *regs)
+
 #ifdef CONFIG_X86_64
 /**
  * DECLARE_IDTENTRY_IST - Declare functions for IST handling IDT entry points
@@ -345,6 +420,10 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #define DECLARE_IDTENTRY_IRQ(vector, func)				\
 	idtentry_irq vector func
 
+/* System vector entries */
+#define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
+	idtentry_sysvec vector func
+
 #ifdef CONFIG_X86_64
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	idtentry_mce_db vector asm_##func func
