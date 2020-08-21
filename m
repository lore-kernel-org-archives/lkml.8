Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDD7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E46207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nkteX0mG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgHUKVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgHUKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:21:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC46C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=89BOS8Xfm6MesTdxPgzj6ElZtckhCmB4aelY19U2HWU=; b=nkteX0mGbgnag6vGtkcrTJwkSZ
        6PKiPxiC1zTu+9elSmVm3S6802HORn7HVcV/kUZ9qdsFJEJVr/BGAFfp3tE0Pgj8tY7ZKTCo+3MNG
        Bd4m7ErGf1XYauxuvXIgZR1NFQ6yTKXBaoEPr5qmTeupJtzpHLAfDd+v1AlRmlrjhdPtb6xzaAUgL
        qhHvcj7Yns8Y4LJYED1da4Jc6wi6rrfb6sOnD4Gwuyn1McQ67shhKfeB/6eNXoQ7mk+71xRSUlwgJ
        BBbX27fRUEE4l8kgL24nHEaMLwHnRI+aJNdv106mEZeRzqe2673eUFnzhsfmZhwyylpxYIdhBT31F
        sjPJNjsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k94An-0003G2-2v; Fri, 21 Aug 2020 10:21:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8CE34306099;
        Fri, 21 Aug 2020 12:21:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6281E2C8FF36A; Fri, 21 Aug 2020 12:21:24 +0200 (CEST)
Message-ID: <20200821102053.102084073@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 11:39:18 +0200
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
Subject: [PATCH v2 6/8] x86/debug: Move historical SYSENTER junk into exc_debug_kernel()
References: <20200821093912.815135402@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The historical SYSENTER junk is explicitly for from-kernel, so move it
to the #DB-from-kernel handler.

It is ordered after the notifier, this is important for KGDB which
uses TF single-step and needs to consume the event before we get here.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -783,17 +783,15 @@ static __always_inline unsigned long deb
  *
  * May run on IST stack.
  */
-static void handle_debug(struct pt_regs *regs, unsigned long dr6)
+static bool handle_debug(struct pt_regs *regs, unsigned long *dr6)
 {
 	struct task_struct *tsk = current;
 
 	/* Store the virtualized DR6 value */
-	tsk->thread.debugreg6 = dr6;
+	tsk->thread.debugreg6 = *dr6;
 
-	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
-		       SIGTRAP) == NOTIFY_STOP) {
-		return;
-	}
+	if (notify_die(DIE_DEBUG, "debug", regs, (long)dr6, 0, SIGTRAP) == NOTIFY_STOP)
+		return true;
 
 	/* It's safe to allow irq's after DR6 has been saved */
 	cond_local_irq_enable(regs);
@@ -807,30 +805,20 @@ static void handle_debug(struct pt_regs
 	/*
 	 * Reload dr6, the notifier might have changed it.
 	 */
-	dr6 = tsk->thread.debugreg6;
-
-	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
-		/*
-		 * Historical junk that used to handle SYSENTER single-stepping.
-		 * This should be unreachable now.  If we survive for a while
-		 * without anyone hitting this warning, we'll turn this into
-		 * an oops.
-		 */
-		tsk->thread.debugreg6 &= ~DR_STEP;
-		set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
-		regs->flags &= ~X86_EFLAGS_TF;
-	}
+	*dr6 = tsk->thread.debugreg6;
 
 	/*
 	 * If dr6 has no reason to give us about the origin of this trap,
 	 * then it's very likely the result of an icebp/int01 trap.
 	 * User wants a sigtrap for that.
 	 */
-	if (dr6 & (DR_STEP | DR_TRAP_BITS) || !dr6)
-		send_sigtrap(regs, 0, get_si_code(dr6));
+	if (*dr6 & (DR_STEP | DR_TRAP_BITS) || !*dr6)
+		send_sigtrap(regs, 0, get_si_code(*dr6));
 
 out:
 	cond_local_irq_disable(regs);
+
+	return false;
 }
 
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
@@ -873,7 +861,20 @@ static __always_inline void exc_debug_ke
 	if (!dr6)
 		goto out;
 
-	handle_debug(regs, dr6);
+	if (handle_debug(regs, &dr6))
+		goto out;
+
+	if (WARN_ON_ONCE(dr6 & DR_STEP)) {
+		/*
+		 * Historical junk that used to handle SYSENTER single-stepping.
+		 * This should be unreachable now.  If we survive for a while
+		 * without anyone hitting this warning, we'll turn this into
+		 * an oops.
+		 */
+		dr6 &= ~DR_STEP;
+		set_thread_flag(TIF_SINGLESTEP);
+		regs->flags &= ~X86_EFLAGS_TF;
+	}
 
 out:
 	instrumentation_end();
@@ -903,7 +904,7 @@ static __always_inline void exc_debug_us
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
-	handle_debug(regs, dr6);
+	handle_debug(regs, &dr6);
 
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);


