Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253EDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C60207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgESTxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgESTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:52:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D55BC08C5C4;
        Tue, 19 May 2020 12:52:40 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Hy-0007qD-Nv; Tue, 19 May 2020 21:52:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4625F1C0480;
        Tue, 19 May 2020 21:52:34 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:34 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] x86/entry: Get rid of ist_begin/end_non_atomic()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134059.462640294@linutronix.de>
References: <20200505134059.462640294@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795420.17951.1071064271217628063.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b052df3da821adfd6be26a6eb16624fb50e90e56
Gitweb:        https://git.kernel.org/tip/b052df3da821adfd6be26a6eb16624fb50e90e56
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 05 Mar 2020 00:52:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:51:19 +02:00

x86/entry: Get rid of ist_begin/end_non_atomic()

This is completely overengineered and definitely not an interface which
should be made available to anything else than this particular MCE case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134059.462640294@linutronix.de


---
 arch/x86/include/asm/traps.h   |  2 +--
 arch/x86/kernel/cpu/mce/core.c |  6 +++--
 arch/x86/kernel/traps.c        | 37 +---------------------------------
 3 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index c26a7e1..fe109fc 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -120,8 +120,6 @@ asmlinkage void smp_irq_move_cleanup_interrupt(void);
 
 extern void ist_enter(struct pt_regs *regs);
 extern void ist_exit(struct pt_regs *regs);
-extern void ist_begin_non_atomic(struct pt_regs *regs);
-extern void ist_end_non_atomic(void);
 
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 54165f3..98bf91c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1352,13 +1352,15 @@ void notrace do_machine_check(struct pt_regs *regs, long error_code)
 
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
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d54cffd..6740e83 100644
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
