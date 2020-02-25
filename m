Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D443C4BA09
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BCA24680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgBYX11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:27:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56046 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbgBYX1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:27:07 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jb2-00057X-Sp; Wed, 26 Feb 2020 00:26:37 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 343421040C7;
        Wed, 26 Feb 2020 00:25:54 +0100 (CET)
Message-Id: <20200225231610.312478926@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:33 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 14/15] x86/entry: Provide return_from exception()
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

Now that all exceptions, interrupts and system vectors are using the
IDTENTRY machinery, the return from exception handling in ASM can be lifted
to C.

Provide a C function which:

  - Invokes prepare_exit_to_user_mode() when the exception hit user mode
  - Checks for preemption when the exception hit kernel mode
  - Has the interrupt tracing in C

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c         |   43 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/idtentry.h |    2 +
 2 files changed, 45 insertions(+)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -480,3 +480,46 @@ static __always_inline long do_fast_sysc
 NOKPROBE_SYMBOL(do_fast_syscall_32);
 
 #endif /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
+
+/**
+ * return_from_exception - Common code to handle return from exceptions
+ * @regs	- Pointer to pt_regs (exception entry regs)
+ *
+ * Depending on the return target (kernel/user) this runs the necessary
+ * preemption and work checks if possible and reguired and returns to
+ * the caller with interrupts disabled and no further work pending.
+ *
+ * This is the last action before returning to the low level ASM code which
+ * just needs to return to the appropriate context.
+ *
+ * Invoked by all exception/interrupt IDTENTRY handlers which are not
+ * returning through the paranoid exit path (all except NMI, MCE, DF).
+ */
+void notrace return_from_exception(struct pt_regs *regs)
+{
+	/*
+	 * Unconditionally disable interrupts as some handlers like
+	 * the fault handler are not guaranteeing to return with
+	 * interrupts disabled.
+	 */
+	local_irq_disable();
+
+	/* Check whether this returns to user mode */
+	if (user_mode(regs)) {
+		prepare_exit_to_usermode(regs);
+	} else {
+		/* Interrupts stay disabled on return? */
+		if (!(regs->flags & X86_EFLAGS_IF))
+			return;
+
+		/* Check kernel preemption, if enabled */
+		if (IS_ENABLED(CONFIG_PREEMPTION)) {
+			/* Check for preemption */
+			if (!preempt_count() && need_resched())
+				preempt_schedule_irq();
+		}
+	}
+	/* Make sure the tracer knows that IRET will enable interrupts */
+	trace_hardirqs_on();
+}
+NOKPROBE_SYMBOL(return_from_exception);
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -19,6 +19,8 @@ static __always_inline void enter_from_u
 static __always_inline void enter_from_user_context(void) { }
 #endif
 
+void return_from_exception(struct pt_regs *regs);
+
 /**
  * idtentry_enter - Handle state tracking on idtentry
  * @regs:	Pointer to pt_regs of interrupted context

