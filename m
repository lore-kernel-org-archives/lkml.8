Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC8CCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11973206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgELQuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgELQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:50:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C3DC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:50:20 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYY6O-0000ay-Br; Tue, 12 May 2020 18:49:56 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 864491004DE; Tue, 12 May 2020 18:49:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Will Deacon <will@kernel.org>
Subject: [patch V6 part 3 12/29] x86/entry/common: Provide idtentry_enter/exit()
In-Reply-To: <87o8qu5n5l.fsf@nanos.tec.linutronix.de>
References: <20200505134354.774943181@linutronix.de> <20200505134904.457578656@linutronix.de> <CALCETrXwuxtZgniJxKZOy5ryqXSbbGMHMBwgEb400Pn9XpynzQ@mail.gmail.com> <874ksm7n5d.fsf@nanos.tec.linutronix.de> <CALCETrX6p6o0NJszjon7R8Tb+fFa=Jw5=CQQ56yZi+YVggopiQ@mail.gmail.com> <87o8qu5n5l.fsf@nanos.tec.linutronix.de>
Date:   Tue, 12 May 2020 18:49:55 +0200
Message-ID: <875zd15c98.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Andy Lutomirski <luto@kernel.org> writes:
>> WARN_ON_ONCE(!on_thread_stack() && (regs->flags & X86_FLAGS_IF) &&
>> preempt_count() == 0);
>>
>> IOW, the actual condition we want is that, if the idtenter_entry/exit
>> code might schedule or if a cond_local_irq_enable() path might
>> schedule, we had better be on the correct stack.
>>
>> Sorry for causing confusion.
>
> Nothing to be sorry about. I could have thought about it myself :)
> Let me try again.

Move it into the actual preemption condition. Most natural place.

Thanks,

        tglx

8<--------------------

Subject: x86/entry/common: Provide idtentry_enter/exit()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 26 Mar 2020 16:28:52 +0100

Provide functions which handle the low level entry and exit similar to
enter/exit from user mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134904.457578656@linutronix.de
---
 arch/x86/entry/common.c         |   99 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/idtentry.h |    3 +
 2 files changed, 102 insertions(+)

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
+ *  - RCU notification if the exception hit kernel mode
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
+			 * needs to undone before scheduling.
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
