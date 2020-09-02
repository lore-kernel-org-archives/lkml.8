Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E637BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC30F20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nMlEKVdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgIBNtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbgIBNlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:41:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57CDC06123A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Jm5W6Bhlyz+QD3Dt1kXcPyaSnX+tRmS5JwK1bk3RLus=; b=nMlEKVdOu2x71VESBUn5Z3AZh9
        rqPhu0HmWs67yrnWyYzZzhWNBBjYDQAOrv6yiPVeOOwH5sE88759e8i10HizuHJNmQ7e2NjVFhyQA
        yAHn3B+LNkcrPQERid5M7o4EDRL8IFW2dz/PSnO6ki+bt9gSGukrZ7Sj7EVK442gy+sDYABEzEZEY
        P1N+iwoJxIYG6JT+nAMIVUOy7b+eNfxw/JCuKA3jS8uL0a3z3Cuww3w8xTtIRAGiTmDMUeXf/Usg/
        lx7oUXYserxzmDpEpBhWcQYcw3oaMwyLARe3gTga+Mk1vUtbdeMjl34WL/WJ5LTlgfktmPy3jkDlS
        iJXwcPAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDSxr-0003Zh-JY; Wed, 02 Sep 2020 13:38:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA3263077E1;
        Wed,  2 Sep 2020 15:38:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E60ED29A82C28; Wed,  2 Sep 2020 15:38:11 +0200 (CEST)
Message-ID: <20200902133201.415372940@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Sep 2020 15:26:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 13/13] x86/debug: Change thread.debugreg6 to thread.virtual_dr6
References: <20200902132549.496605622@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current usage of thread.debugreg6 is convoluted at best. It starts
life as a copy of the hardware DR6 value, but then we clear and set
various bits.

Replace this with a new variable thread.virtual_dr6 that is
initialized to 0 when we read DR6 and only gains bits, at the same
time the actual (on stack) dr6 value we read from the hardware only
gets bits cleared.

Again, I'm not sure what the expected effect of
ptrace_{set,get}debugreg(6) would be.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/processor.h |    2 +-
 arch/x86/kernel/hw_breakpoint.c  |   12 +++---------
 arch/x86/kernel/kgdb.c           |    5 +++--
 arch/x86/kernel/ptrace.c         |    6 +++---
 arch/x86/kernel/traps.c          |   25 ++++++++++++++++---------
 5 files changed, 26 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -517,7 +517,7 @@ struct thread_struct {
 	/* Save middle states of ptrace breakpoints */
 	struct perf_event	*ptrace_bps[HBP_NUM];
 	/* Debug status used for traps, single steps, etc... */
-	unsigned long           debugreg6;
+	unsigned long           virtual_dr6;
 	/* Keep track of the exact dr7 value set by the user */
 	unsigned long           ptrace_dr7;
 	/* Fault info: */
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -454,7 +454,7 @@ void flush_ptrace_hw_breakpoint(struct t
 		t->ptrace_bps[i] = NULL;
 	}
 
-	t->debugreg6 = 0;
+	t->virtual_dr6 = 0;
 	t->ptrace_dr7 = 0;
 }
 
@@ -489,8 +489,8 @@ static int hw_breakpoint_handler(struct
 {
 	int i, rc = NOTIFY_STOP;
 	struct perf_event *bp;
-	unsigned long dr6;
 	unsigned long *dr6_p;
+	unsigned long dr6;
 
 	/* The DR6 value is pointed by args->err */
 	dr6_p = (unsigned long *)ERR_PTR(args->err);
@@ -504,12 +504,6 @@ static int hw_breakpoint_handler(struct
 	if ((dr6 & DR_TRAP_BITS) == 0)
 		return NOTIFY_DONE;
 
-	/*
-	 * Reset the DRn bits in the virtualized register value.
-	 * The ptrace trigger routine will add in whatever is needed.
-	 */
-	current->thread.debugreg6 &= ~DR_TRAP_BITS;
-
 	/* Handle all the breakpoints that were triggered */
 	for (i = 0; i < HBP_NUM; ++i) {
 		if (likely(!(dr6 & (DR_TRAP0 << i))))
@@ -554,7 +548,7 @@ static int hw_breakpoint_handler(struct
 	 * breakpoints (to generate signals) and b) when the system has
 	 * taken exception due to multiple causes
 	 */
-	if ((current->thread.debugreg6 & DR_TRAP_BITS) ||
+	if ((current->thread.virtual_dr6 & DR_TRAP_BITS) ||
 	    (dr6 & (~DR_TRAP_BITS)))
 		rc = NOTIFY_DONE;
 
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -629,9 +629,10 @@ static void kgdb_hw_overflow_handler(str
 	struct task_struct *tsk = current;
 	int i;
 
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < 4; i++) {
 		if (breakinfo[i].enabled)
-			tsk->thread.debugreg6 |= (DR_TRAP0 << i);
+			tsk->thread.virtual_dr6 |= (DR_TRAP0 << i);
+	}
 }
 
 void kgdb_arch_late(void)
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -465,7 +465,7 @@ static void ptrace_triggered(struct perf
 			break;
 	}
 
-	thread->debugreg6 |= (DR_TRAP0 << i);
+	thread->virtual_dr6 |= (DR_TRAP0 << i);
 }
 
 /*
@@ -601,7 +601,7 @@ static unsigned long ptrace_get_debugreg
 		if (bp)
 			val = bp->hw.info.address;
 	} else if (n == 6) {
-		val = thread->debugreg6 ^ DR6_RESERVED; /* Flip back to arch polarity */
+		val = thread->virtual_dr6 ^ DR6_RESERVED; /* Flip back to arch polarity */
 	} else if (n == 7) {
 		val = thread->ptrace_dr7;
 	}
@@ -657,7 +657,7 @@ static int ptrace_set_debugreg(struct ta
 	if (n < HBP_NUM) {
 		rc = ptrace_set_breakpoint_addr(tsk, n, val);
 	} else if (n == 6) {
-		thread->debugreg6 = val ^ DR6_RESERVED; /* Flip to positive polarity */
+		thread->virtual_dr6 = val ^ DR6_RESERVED; /* Flip to positive polarity */
 		rc = 0;
 	} else if (n == 7) {
 		rc = ptrace_write_dr7(tsk, val);
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -749,6 +749,12 @@ static __always_inline unsigned long deb
 	dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
 
 	/*
+	 * Clear the virtual DR6 value, ptrace routines will set bits here for
+	 * things we want signals for.
+	 */
+	current->thread.virtual_dr6 = 0;
+
+	/*
 	 * The SDM says "The processor clears the BTF flag when it
 	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
 	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
@@ -785,17 +791,16 @@ static __always_inline unsigned long deb
 
 static bool notify_debug(struct pt_regs *regs, unsigned long *dr6)
 {
-	struct task_struct *tsk = current;
-
-	/* Store the virtualized DR6 value */
-	tsk->thread.debugreg6 = *dr6;
-
+	/*
+	 * Notifiers will clear bits in @dr6 to indicate the event has been
+	 * consumed - hw_breakpoint_handler(), single_stop_cont().
+	 *
+	 * Notifiers will set bits in @virtual_dr6 to indicate the desire
+	 * for signals - ptrace_triggered(), kgdb_hw_overflow_handler().
+	 */
 	if (notify_die(DIE_DEBUG, "debug", regs, (long)dr6, 0, SIGTRAP) == NOTIFY_STOP)
 		return true;
 
-	/* Reload the DR6 value, the notifier might have changed it */
-	*dr6 = tsk->thread.debugreg6;
-
 	return false;
 }
 
@@ -853,7 +858,7 @@ static __always_inline void exc_debug_ke
 	 * A known way to trigger this is through QEMU's GDB stub,
 	 * which leaks #DB into the guest and causes IST recursion.
 	 */
-	if (WARN_ON_ONCE(current->thread.debugreg6 & DR_STEP))
+	if (WARN_ON_ONCE(dr6 & DR_STEP))
 		regs->flags &= ~X86_EFLAGS_TF;
 out:
 	instrumentation_end();
@@ -903,6 +908,8 @@ static __always_inline void exc_debug_us
 		goto out_irq;
 	}
 
+	/* Add the virtual_dr6 bits for signals. */
+	dr6 |= current->thread.virtual_dr6;
 	if (dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
 		send_sigtrap(regs, 0, get_si_code(dr6));
 


