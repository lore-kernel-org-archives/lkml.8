Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3694FC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1BC2495E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgEEOOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729511AbgEEOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781BCC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:08 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKU-0000iC-As; Tue, 05 May 2020 16:13:50 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id D42831001F5;
        Tue,  5 May 2020 16:13:49 +0200 (CEST)
Message-Id: <20200505134100.957390899@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:31 +0200
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V4 part 1 29/36] x86/mce: Send #MC singal from task work
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

From: Peter Zijlstra <peterz@infradead.org>

Convert #MC over to using task_work_add(); it will run the same code
slightly later, on the return to user path of the same exception.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/kernel/cpu/mce/core.c |   56 ++++++++++++++++++++++-------------------
 include/linux/sched.h          |    6 ++++
 2 files changed, 37 insertions(+), 25 deletions(-)

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -42,6 +42,7 @@
 #include <linux/export.h>
 #include <linux/jump_label.h>
 #include <linux/set_memory.h>
+#include <linux/task_work.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -1086,23 +1087,6 @@ static void mce_clear_state(unsigned lon
 	}
 }
 
-static int do_memory_failure(struct mce *m)
-{
-	int flags = MF_ACTION_REQUIRED;
-	int ret;
-
-	pr_err("Uncorrected hardware memory error in user-access at %llx", m->addr);
-	if (!(m->mcgstatus & MCG_STATUS_RIPV))
-		flags |= MF_MUST_KILL;
-	ret = memory_failure(m->addr >> PAGE_SHIFT, flags);
-	if (ret)
-		pr_err("Memory error not recovered");
-	else
-		set_mce_nospec(m->addr >> PAGE_SHIFT);
-	return ret;
-}
-
-
 /*
  * Cases where we avoid rendezvous handler timeout:
  * 1) If this CPU is offline.
@@ -1204,6 +1188,29 @@ static void __mc_scan_banks(struct mce *
 	*m = *final;
 }
 
+static void kill_me_now(struct callback_head *ch)
+{
+	force_sig(SIGBUS);
+}
+
+static void kill_me_maybe(struct callback_head *cb)
+{
+	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
+	int flags = MF_ACTION_REQUIRED;
+
+	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
+	if (!(p->mce_status & MCG_STATUS_RIPV))
+		flags |= MF_MUST_KILL;
+
+	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags)) {
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
+		return;
+	}
+
+	pr_err("Memory error not recovered");
+	kill_me_now(cb);
+}
+
 /*
  * The actual machine check handler. This only handles real
  * exceptions when something got corrupted coming in through int 18.
@@ -1222,7 +1229,7 @@ static void __mc_scan_banks(struct mce *
  * backing the user stack, tracing that reads the user stack will cause
  * potentially infinite recursion.
  */
-void notrace do_machine_check(struct pt_regs *regs, long error_code)
+void noinstr do_machine_check(struct pt_regs *regs, long error_code)
 {
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
@@ -1354,13 +1361,13 @@ void notrace do_machine_check(struct pt_
 	if ((m.cs & 3) == 3) {
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
-		local_irq_enable();
-		preempt_enable();
 
-		if (kill_it || do_memory_failure(&m))
-			force_sig(SIGBUS);
-		preempt_disable();
-		local_irq_disable();
+		current->mce_addr = m.addr;
+		current->mce_status = m.mcgstatus;
+		current->mce_kill_me.func = kill_me_maybe;
+		if (kill_it)
+			current->mce_kill_me.func = kill_me_now;
+		task_work_add(current, &current->mce_kill_me, true);
 	} else {
 		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
 			mce_panic("Failed kernel mode recovery", &m, msg);
@@ -1370,7 +1377,6 @@ void notrace do_machine_check(struct pt_
 	ist_exit(regs);
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
-NOKPROBE_SYMBOL(do_machine_check);
 
 #ifndef CONFIG_MEMORY_FAILURE
 int memory_failure(unsigned long pfn, int flags)
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1290,6 +1290,12 @@ struct task_struct {
 	unsigned long			prev_lowest_stack;
 #endif
 
+#ifdef CONFIG_X86_MCE
+	u64				mce_addr;
+	u64				mce_status;
+	struct callback_head		mce_kill_me;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.

