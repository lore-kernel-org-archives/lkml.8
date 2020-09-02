Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B2DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CBED2078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U33kUoYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgIBOAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgIBNqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:46:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8736EC061262
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Sc6YEqpGmtc0p9Dtq1vzjzDfqz/+cVcUufBA0gw7gww=; b=U33kUoYAVwbyXUnj91k6CX2CrX
        XoBUXmzAhdF2ScFu/c/c6szaezRsj8G2jAX+Vb9FVJjUvotBiNjen9IZLMjGBAvdFTVrJp4JiSJfD
        ZWHr71cEYDBUeyG7iH+g4oBDu2C/yAKY2SIp0IRYdueHu3Zt3Ukvy+Bp4Vx7SQn+1wykKBh2Ev9tG
        cock85za7BR0BQrxcIM5RttpARsp30y9z9DzGWOL2pao3k9JDQcCB337B5myIJoRWjpnLlmvlRIZv
        6sQ1M9j0BimR6iepZ9pHIteb6/4woG5ukU4Ik7dfP99wxInQ0RO5j6zW7D8y0IixsSJd1H0KndUWC
        4SzKyVGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDSxq-0003ZV-5a; Wed, 02 Sep 2020 13:38:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D73F306E56;
        Wed,  2 Sep 2020 15:38:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C772329A82C23; Wed,  2 Sep 2020 15:38:11 +0200 (CEST)
Message-ID: <20200902133200.967434217@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Sep 2020 15:25:55 +0200
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
Subject: [PATCH 06/13] x86/debug: Simplify #DB signal code
References: <20200902132549.496605622@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no point in calculating si_code if we're not going to use it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -786,15 +786,14 @@ static __always_inline unsigned long deb
 static void handle_debug(struct pt_regs *regs, unsigned long dr6)
 {
 	struct task_struct *tsk = current;
-	bool user_icebp;
-	int si_code;
+	bool icebp;
 
 	/*
 	 * If dr6 has no reason to give us about the origin of this trap,
 	 * then it's very likely the result of an icebp/int01 trap.
 	 * User wants a sigtrap for that.
 	 */
-	user_icebp = !dr6;
+	icebp = !dr6;
 
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = dr6;
@@ -813,6 +812,11 @@ static void handle_debug(struct pt_regs
 		goto out;
 	}
 
+	/*
+	 * Reload dr6, the notifier might have changed it.
+	 */
+	dr6 = tsk->thread.debugreg6;
+
 	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
 		/*
 		 * Historical junk that used to handle SYSENTER single-stepping.
@@ -825,9 +829,8 @@ static void handle_debug(struct pt_regs
 		regs->flags &= ~X86_EFLAGS_TF;
 	}
 
-	si_code = get_si_code(tsk->thread.debugreg6);
-	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
-		send_sigtrap(regs, 0, si_code);
+	if (dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
+		send_sigtrap(regs, 0, get_si_code(dr6));
 
 out:
 	cond_local_irq_disable(regs);


