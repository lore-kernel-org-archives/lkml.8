Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59873C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C53A20773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ac/StFTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgIBPAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgIBNrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:47:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB011C061265
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=oUkO7fX2WCJTU4/pYB1x6qlwNwBzlfvqwzYit8QR3ZE=; b=Ac/StFTHcxsphW55isgA1FXYdM
        uGJxTyLq4lGOQbFFZ1LtN5RxL9ZSMqe395GboHzGvAHqScbjYUJbzxpRUpXSOuk9Cy0E/8jFk0rfD
        n0odnqUemQOkr3Z0fPWQIPVT3ht6xWvWVsHu604SCarT4v44VM6WPnBsPIGkTtwWM2FwDDLAoPER0
        S+IKT6kIun/Ok26n3AfLMc324KKz3HM26kYil3BOC3g6pn1Qthzx8raLKACF8INOga/Y0SrYLmqXe
        qxOOyX8Ub/D8fxWhU5XgK91Eq16kuNt47paiPW8ohqTMAz80lBhjJIBVNKguf5rAqhMy/8h6/6gXy
        155ejiOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDSxr-0003Zd-9o; Wed, 02 Sep 2020 13:38:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A057A3075F1;
        Wed,  2 Sep 2020 15:38:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D26B529A82C25; Wed,  2 Sep 2020 15:38:11 +0200 (CEST)
Message-ID: <20200902133201.094265982@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Sep 2020 15:25:57 +0200
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
Subject: [PATCH 08/13] x86/debug: Move cond_local_irq_enable() block into exc_debug_user()
References: <20200902132549.496605622@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cond_local_irq_enable() block, dealing with vm86 and sending
signals is only relevant for #DB-from-user, move it there.

This then reduces handle_debug() to only the notifier call, so rename
it to notify_debug().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   58 ++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -783,17 +783,10 @@ static __always_inline unsigned long deb
  *
  * May run on IST stack.
  */
-static bool handle_debug(struct pt_regs *regs, unsigned long *dr6)
+
+static bool notify_debug(struct pt_regs *regs, unsigned long *dr6)
 {
 	struct task_struct *tsk = current;
-	bool icebp;
-
-	/*
-	 * If dr6 has no reason to give us about the origin of this trap,
-	 * then it's very likely the result of an icebp/int01 trap.
-	 * User wants a sigtrap for that.
-	 */
-	icebp = !*dr6;
 
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = *dr6;
@@ -801,26 +794,9 @@ static bool handle_debug(struct pt_regs
 	if (notify_die(DIE_DEBUG, "debug", regs, (long)dr6, 0, SIGTRAP) == NOTIFY_STOP)
 		return true;
 
-	/* It's safe to allow irq's after DR6 has been saved */
-	cond_local_irq_enable(regs);
-
-	if (v8086_mode(regs)) {
-		handle_vm86_trap((struct kernel_vm86_regs *) regs, 0,
-				 X86_TRAP_DB);
-		goto out;
-	}
-
-	/*
-	 * Reload dr6, the notifier might have changed it.
-	 */
+	/* Reload the DR6 value, the notifier might have changed it */
 	*dr6 = tsk->thread.debugreg6;
 
-	if (*dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
-		send_sigtrap(regs, 0, get_si_code(*dr6));
-
-out:
-	cond_local_irq_disable(regs);
-
 	return false;
 }
 
@@ -864,7 +840,7 @@ static __always_inline void exc_debug_ke
 	if (!dr6)
 		goto out;
 
-	if (handle_debug(regs, &dr6))
+	if (notify_debug(regs, &dr6))
 		goto out;
 
 	if (WARN_ON_ONCE(dr6 & DR_STEP)) {
@@ -889,6 +865,8 @@ static __always_inline void exc_debug_ke
 static __always_inline void exc_debug_user(struct pt_regs *regs,
 					   unsigned long dr6)
 {
+	bool icebp;
+
 	/*
 	 * If something gets miswired and we end up here for a kernel mode
 	 * #DB, we will malfunction.
@@ -907,8 +885,30 @@ static __always_inline void exc_debug_us
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
-	handle_debug(regs, &dr6);
+	/*
+	 * If dr6 has no reason to give us about the origin of this trap,
+	 * then it's very likely the result of an icebp/int01 trap.
+	 * User wants a sigtrap for that.
+	 */
+	icebp = !dr6;
 
+	if (notify_debug(regs, &dr6))
+		goto out;
+
+	/* It's safe to allow irq's after DR6 has been saved */
+	local_irq_enable();
+
+	if (v8086_mode(regs)) {
+		handle_vm86_trap((struct kernel_vm86_regs *)regs, 0, X86_TRAP_DB);
+		goto out_irq;
+	}
+
+	if (dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
+		send_sigtrap(regs, 0, get_si_code(dr6));
+
+out_irq:
+	local_irq_disable();
+out:
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);
 }


