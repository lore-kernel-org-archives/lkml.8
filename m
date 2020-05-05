Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B353AC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C61C20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbgEEOXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729502AbgEEOOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0739FC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:07 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKB-0000TD-Nb; Tue, 05 May 2020 16:13:31 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 3ABFCFFC8D;
        Tue,  5 May 2020 16:13:31 +0200 (CEST)
Message-Id: <20200505134059.462640294@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:16 +0200
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
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 1 14/36] x86/entry: Get rid of ist_begin/end_non_atomic()
References: <20200505131602.633487962@linutronix.de>
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

This is completely overengineered and definitely not an interface which
should be made available to anything else than this particular MCE case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/traps.h   |    2 --
 arch/x86/kernel/cpu/mce/core.c |    6 ++++--
 arch/x86/kernel/traps.c        |   37 -------------------------------------
 3 files changed, 4 insertions(+), 41 deletions(-)

--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -120,8 +120,6 @@ asmlinkage void smp_irq_move_cleanup_int
 
 extern void ist_enter(struct pt_regs *regs);
 extern void ist_exit(struct pt_regs *regs);
-extern void ist_begin_non_atomic(struct pt_regs *regs);
-extern void ist_end_non_atomic(void);
 
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1352,13 +1352,15 @@ void notrace do_machine_check(struct pt_
 
 	/* Fault was in user mode and we need to take some action */
 	if ((m.cs & 3) == 3) {
-		ist_begin_non_atomic(regs);
+		/* If this triggers there is no way to recover. Die hard. */
+		BUG_ON(!on_thread_stack() || !user_mode(regs));
 		local_irq_enable();
+		preempt_enable();
 
 		if (kill_it || do_memory_failure(&m))
 			force_sig(SIGBUS);
+		preempt_disable();
 		local_irq_disable();
-		ist_end_non_atomic();
 	} else {
 		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
 			mce_panic("Failed kernel mode recovery", &m, msg);
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -117,43 +117,6 @@ void ist_exit(struct pt_regs *regs)
 		rcu_nmi_exit();
 }
 
-/**
- * ist_begin_non_atomic() - begin a non-atomic section in an IST exception
- * @regs:	regs passed to the IST exception handler
- *
- * IST exception handlers normally cannot schedule.  As a special
- * exception, if the exception interrupted userspace code (i.e.
- * user_mode(regs) would return true) and the exception was not
- * a double fault, it can be safe to schedule.  ist_begin_non_atomic()
- * begins a non-atomic section within an ist_enter()/ist_exit() region.
- * Callers are responsible for enabling interrupts themselves inside
- * the non-atomic section, and callers must call ist_end_non_atomic()
- * before ist_exit().
- */
-void ist_begin_non_atomic(struct pt_regs *regs)
-{
-	BUG_ON(!user_mode(regs));
-
-	/*
-	 * Sanity check: we need to be on the normal thread stack.  This
-	 * will catch asm bugs and any attempt to use ist_preempt_enable
-	 * from double_fault.
-	 */
-	BUG_ON(!on_thread_stack());
-
-	preempt_enable_no_resched();
-}
-
-/**
- * ist_end_non_atomic() - begin a non-atomic section in an IST exception
- *
- * Ends a non-atomic section started with ist_begin_non_atomic().
- */
-void ist_end_non_atomic(void)
-{
-	preempt_disable();
-}
-
 int is_valid_bugaddr(unsigned long addr)
 {
 	unsigned short ud;

