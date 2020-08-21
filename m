Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B153C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0FF20732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PFfBR0q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgHUKWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbgHUKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:21:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F081C061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=AdGrrqMQ6rl4GO9VH7qBKAFNd8P/sp+D3lGhXAJHb0E=; b=PFfBR0q97nsq2AgRr88rFkr1/t
        /GP2kJ/mUBeuxLKe/1G22OTPvFjA3QcLxpxXs+Cme8g+6C7NDmTHqUlM/NOy8g0JsnIcjj99oW17r
        fVtHhHv64ESSP7XjbsF9kAxPlEH4vW8NUO71B7wK95SPqI+dCn5mEzaJWJ4NP8BPOQKMjo0Xij7qE
        I6fsAswDQxBrBsLchvx51k3q4sFzRVqtuliFGCnPqXwSr9kHbVrwkhHzlsgEC0dA9HWSIW1HHzt9N
        0EcSNzQKLMfS4tljL1GcCszIlbShXPwolKN6Zm+DWB7UjPcuNfKQPhQCPuidGUm1X+EjMjR2IXlMu
        64dJCEZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k94An-0003G1-1I; Fri, 21 Aug 2020 10:21:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 719673059C6;
        Fri, 21 Aug 2020 12:21:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5CD572C8FF369; Fri, 21 Aug 2020 12:21:24 +0200 (CEST)
Message-ID: <20200821102052.969925934@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 11:39:16 +0200
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
Subject: [PATCH v2 4/8] x86/debug: Remove handle_debug(.user) argument
References: <20200821093912.815135402@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handle_debug(.user) argument is used to terminate the #DB handler
early for the INT1-from-kernel case, since the kernel doesn't use
INT1.

Remove the argument and handle this explicitly in #DB-from-kernel.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -783,25 +783,18 @@ static __always_inline unsigned long deb
  *
  * May run on IST stack.
  */
-static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
+static void handle_debug(struct pt_regs *regs, unsigned long dr6)
 {
 	struct task_struct *tsk = current;
 	bool user_icebp;
 	int si_code;
 
 	/*
-	 * If DR6 is zero, no point in trying to handle it. The kernel is
-	 * not using INT1.
-	 */
-	if (!user && !dr6)
-		return;
-
-	/*
 	 * If dr6 has no reason to give us about the origin of this trap,
 	 * then it's very likely the result of an icebp/int01 trap.
 	 * User wants a sigtrap for that.
 	 */
-	user_icebp = user && !dr6;
+	user_icebp = !dr6;
 
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = dr6;
@@ -874,7 +867,13 @@ static __always_inline void exc_debug_ke
 	if (kprobe_debug_handler(regs))
 		goto out;
 
-	handle_debug(regs, dr6, false);
+	/*
+	 * The kernel doesn't use INT1
+	 */
+	if (!dr6)
+		goto out;
+
+	handle_debug(regs, dr6);
 
 out:
 	instrumentation_end();
@@ -904,7 +903,7 @@ static __always_inline void exc_debug_us
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
-	handle_debug(regs, dr6, true);
+	handle_debug(regs, dr6);
 
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);


