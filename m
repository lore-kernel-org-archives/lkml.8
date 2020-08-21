Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F84FC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A04A207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KYxMIMoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgHUKVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgHUKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:21:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F74C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2RHV/9w9BBmlZJ222cAFXt8o60uKDv+U1v4ikGBmpTA=; b=KYxMIMoqhkoPv6Pp9aGkveWSvw
        0e54SE3i4fkA7ahj2qTbWv8BYESIlJlLfCEJ77meoCB5qbk1jeRcAgHA4yVCHkYZFNby9DOccYKcY
        e0mWQAdIGXs/swuICyM0P6Evmzw9DWp03l2egIIBtHNLdn/u6zDGwYGFu/H+xrEUB2c6fSmEqGBLA
        jFYODyEF0LUkU4q9go0ajaB2J1sOKueeJDbezffVfqoFZ2bsfuw1sulKY7Y5cSTFhyIyiIY1xe1We
        FK/UnWovDDsOmZoJ8hIyAAtyZepzEvn9q9b7bnCYz/1McoOTp6DOdiwMPwaUbu6PyivnrtEm5XQnj
        QH1v5iHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k94Ao-0003G8-1c; Fri, 21 Aug 2020 10:21:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B0ED33060F2;
        Fri, 21 Aug 2020 12:21:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 67BCF2C8FF36C; Fri, 21 Aug 2020 12:21:24 +0200 (CEST)
Message-ID: <20200821102053.160728884@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 11:39:19 +0200
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
Subject: [PATCH v2 7/8] x86/debug: Move cond_local_irq_enable() block into exc_debug_user()
References: <20200821093912.815135402@infradead.org>
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
 arch/x86/kernel/traps.c |   51 +++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -783,7 +783,8 @@ static __always_inline unsigned long deb
  *
  * May run on IST stack.
  */
-static bool handle_debug(struct pt_regs *regs, unsigned long *dr6)
+
+static bool notify_debug(struct pt_regs *regs, unsigned long *dr6)
 {
 	struct task_struct *tsk = current;
 
@@ -793,31 +794,9 @@ static bool handle_debug(struct pt_regs
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
 
-	/*
-	 * If dr6 has no reason to give us about the origin of this trap,
-	 * then it's very likely the result of an icebp/int01 trap.
-	 * User wants a sigtrap for that.
-	 */
-	if (*dr6 & (DR_STEP | DR_TRAP_BITS) || !*dr6)
-		send_sigtrap(regs, 0, get_si_code(*dr6));
-
-out:
-	cond_local_irq_disable(regs);
-
 	return false;
 }
 
@@ -861,7 +840,7 @@ static __always_inline void exc_debug_ke
 	if (!dr6)
 		goto out;
 
-	if (handle_debug(regs, &dr6))
+	if (notify_debug(regs, &dr6))
 		goto out;
 
 	if (WARN_ON_ONCE(dr6 & DR_STEP)) {
@@ -904,8 +883,28 @@ static __always_inline void exc_debug_us
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
-	handle_debug(regs, &dr6);
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
 
+	/*
+	 * If dr6 has no reason to give us about the origin of this trap,
+	 * then it's very likely the result of an icebp/int01 trap.
+	 * User wants a sigtrap for that.
+	 */
+	if (dr6 & (DR_STEP | DR_TRAP_BITS) || !dr6)
+		send_sigtrap(regs, 0, get_si_code(dr6));
+
+out_irq:
+	local_irq_disable();
+out:
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);
 }


