Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C848FC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1E920773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yn9lc2uw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgIBPAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgIBNr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:47:28 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B64C06121A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=GGXP0Z1hCwRfr4rgeIowl4ybef3PBebTvLF8FOk4lEA=; b=Yn9lc2uwGfsN/+w+OdLy7Fk5Wv
        oZSx405qMf+wWO6psdiW/rwbkBI7tOiGzsrxFIdRfWqjORMIaJpq2/WfOHqKUqIZpdqQXs6ReaoXu
        lXWovqDTE2BxfADYkG4zJHOCK0C/NYiX1E/72aR4sqn7KDcJMcrglDwFCXY69xCmq/hWrhHHsrmHp
        jqwsG3j4CqBtOIBIv9BlWd1MIxyPoO0rB+PtDnMO8avLHX7im25iJ5HzutVSfNZdEctjnmIQOjAUP
        +NIMwHHfP4x5tm4dTYAuiId5ECH5LKj4R0vZSxU5DHSh6vK/mRRTZw7/oy3VS74r+BeW3ed8ZwdPC
        tsT2Ffvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDSxr-0002df-Ki; Wed, 02 Sep 2020 13:38:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A04FE307590;
        Wed,  2 Sep 2020 15:38:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CC6E029A82C24; Wed,  2 Sep 2020 15:38:11 +0200 (CEST)
Message-ID: <20200902133201.031099736@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Sep 2020 15:25:56 +0200
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
Subject: [PATCH 07/13] x86/debug: Move historical SYSENTER junk into exc_debug_kernel()
References: <20200902132549.496605622@infradead.org>
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
 arch/x86/kernel/traps.c |   49 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -783,7 +783,7 @@ static __always_inline unsigned long deb
  *
  * May run on IST stack.
  */
-static void handle_debug(struct pt_regs *regs, unsigned long dr6)
+static bool handle_debug(struct pt_regs *regs, unsigned long *dr6)
 {
 	struct task_struct *tsk = current;
 	bool icebp;
@@ -793,15 +793,13 @@ static void handle_debug(struct pt_regs
 	 * then it's very likely the result of an icebp/int01 trap.
 	 * User wants a sigtrap for that.
 	 */
-	icebp = !dr6;
+	icebp = !*dr6;
 
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
@@ -815,25 +813,15 @@ static void handle_debug(struct pt_regs
 	/*
 	 * Reload dr6, the notifier might have changed it.
 	 */
-	dr6 = tsk->thread.debugreg6;
+	*dr6 = tsk->thread.debugreg6;
 
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
-
-	if (dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
-		send_sigtrap(regs, 0, get_si_code(dr6));
+	if (*dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
+		send_sigtrap(regs, 0, get_si_code(*dr6));
 
 out:
 	cond_local_irq_disable(regs);
+
+	return false;
 }
 
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
@@ -876,7 +864,20 @@ static __always_inline void exc_debug_ke
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
@@ -906,7 +907,7 @@ static __always_inline void exc_debug_us
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
-	handle_debug(regs, dr6);
+	handle_debug(regs, &dr6);
 
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);


