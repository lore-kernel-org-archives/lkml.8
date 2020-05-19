Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B32C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CAF621508
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgEST7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbgEST6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C44C08C5C0;
        Tue, 19 May 2020 12:58:48 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nv-0008Rd-8a; Tue, 19 May 2020 21:58:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BC4AB1C0178;
        Tue, 19 May 2020 21:58:35 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:35 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/common: Provide idtentry_enter/exit()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134904.457578656@linutronix.de>
References: <20200505134904.457578656@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831562.17951.6216563865898704227.tip-bot2@tip-bot2>
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

Commit-ID:     eadb831607477ba774b3314bdc956331b41817d6
Gitweb:        https://git.kernel.org/tip/eadb831607477ba774b3314bdc956331b41817d6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 26 Mar 2020 16:28:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:57 +02:00

x86/entry/common: Provide idtentry_enter/exit()

Provide functions which handle the low level entry and exit similar to
enter/exit from user mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505134904.457578656@linutronix.de


---
 arch/x86/entry/common.c         |  99 +++++++++++++++++++++++++++++++-
 arch/x86/include/asm/idtentry.h |   3 +-
 2 files changed, 102 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index e4f9f5f..9ebe334 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -510,3 +510,102 @@ SYSCALL_DEFINE0(ni_syscall)
 {
 	return -ENOSYS;
 }
+
+/**
+ * idtentry_enter - Handle state tracking on idtentry
+ * @regs:	Pointer to pt_regs of interrupted context
+ *
+ * Invokes:
+ *  - lockdep irqflag state tracking as low level ASM entry disabled
+ *    interrupts.
+ *
+ *  - Context tracking if the exception hit user mode.
+ *
+ *  - RCU notification if the exception hit kernel mode.
+ *
+ *  - The hardirq tracer to keep the state consistent as low level ASM
+ *    entry disabled interrupts.
+ */
+void noinstr idtentry_enter(struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		enter_from_user_mode();
+	} else {
+		lockdep_hardirqs_off(CALLER_ADDR0);
+		rcu_irq_enter();
+		instrumentation_begin();
+		trace_hardirqs_off_prepare();
+		instrumentation_end();
+	}
+}
+
+/**
+ * idtentry_exit - Common code to handle return from exceptions
+ * @regs:	Pointer to pt_regs (exception entry regs)
+ *
+ * Depending on the return target (kernel/user) this runs the necessary
+ * preemption and work checks if possible and required and returns to
+ * the caller with interrupts disabled and no further work pending.
+ *
+ * This is the last action before returning to the low level ASM code which
+ * just needs to return to the appropriate context.
+ *
+ * Invoked by all exception/interrupt IDTENTRY handlers which are not
+ * returning through the paranoid exit path (all except NMI, #DF and the IST
+ * variants of #MC and #DB) and are therefore on the thread stack.
+ */
+void noinstr idtentry_exit(struct pt_regs *regs)
+{
+	lockdep_assert_irqs_disabled();
+
+	/* Check whether this returns to user mode */
+	if (user_mode(regs)) {
+		prepare_exit_to_usermode(regs);
+	} else if (regs->flags & X86_EFLAGS_IF) {
+		/* Check kernel preemption, if enabled */
+		if (IS_ENABLED(CONFIG_PREEMPTION)) {
+			/*
+			 * This needs to be done very carefully.
+			 * idtentry_enter() invoked rcu_irq_enter(). This
+			 * needs to be undone before scheduling.
+			 *
+			 * Preemption is disabled inside of RCU idle
+			 * sections. When the task returns from
+			 * preempt_schedule_irq(), RCU is still watching.
+			 *
+			 * rcu_irq_exit_preempt() has additional state
+			 * checking if CONFIG_PROVE_RCU=y
+			 */
+			if (!preempt_count()) {
+				if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
+					WARN_ON_ONCE(!on_thread_stack());
+				instrumentation_begin();
+				rcu_irq_exit_preempt();
+				if (need_resched())
+					preempt_schedule_irq();
+				/* Covers both tracing and lockdep */
+				trace_hardirqs_on();
+				instrumentation_end();
+				return;
+			}
+		}
+		/*
+		 * If preemption is disabled then this needs to be done
+		 * carefully with respect to RCU. The exception might come
+		 * from a RCU idle section in the idle task due to the fact
+		 * that safe_halt() enables interrupts. So this needs the
+		 * same ordering of lockdep/tracing and RCU as the return
+		 * to user mode path.
+		 */
+		instrumentation_begin();
+		/* Tell the tracer that IRET will enable interrupts */
+		trace_hardirqs_on_prepare();
+		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+		instrumentation_end();
+		rcu_irq_exit();
+		lockdep_hardirqs_on(CALLER_ADDR0);
+	} else {
+		/* IRQ flags state is correct already. Just tell RCU */
+		rcu_irq_exit();
+	}
+}
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index bbd81e2..2adfd80 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -7,6 +7,9 @@
 
 #ifndef __ASSEMBLY__
 
+void idtentry_enter(struct pt_regs *regs);
+void idtentry_exit(struct pt_regs *regs);
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
