Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73BFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EC9207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ya28CAy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407265AbgE1U1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:27:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36698 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407245AbgE1U0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=DU7YFvUq5M82ZXp8BeldN/FNS/pnt66urUkgmqrZJ90=; b=Ya28CAy3JUig9byF+i9TmLoTqw
        ssDcO1N3QXAoZJOzajd9lSLOi+PGchFfMOGdF1AgrgmESF++p648lufcRfKnVxHGmMtLNkkR+53iF
        dRkniO50XkIP40OA6FtCKZwzrOmH9cxRUJ0wQqjEXeQSnrUFfZA6HzDb5B5lZknQ02P7GzyeVkaHK
        3BgQPmJ4dm9EXobj6gUl5w7n0lZDiLLFrU9RULB2/0v950xJX0p5Ewk5AF65Y1pH3OWGgpaj0Ht3J
        bOpK/PGZItPila9UqnKGdiwOgvUKEbIX7UMAv5A7Choun0M6ERb6HMlGdeZXEKZVctfZwOoPZecZq
        gC/rMAgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeP4m-0003gY-TB; Thu, 28 May 2020 20:24:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E71BC303DA0;
        Thu, 28 May 2020 22:24:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D03B02BA01B16; Thu, 28 May 2020 22:24:22 +0200 (CEST)
Message-ID: <20200528202328.475098073@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 28 May 2020 22:19:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org
Subject: [PATCH 2/6] x86/entry, nmi: Disable #DB
References: <20200528201937.038455891@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of playing stupid games with IST stacks, fully disallow #DB
during NMIs. There is absolutely no reason to allow them, and killing
this saves a heap of trouble.

We already disallow #DB on noinstr and CEA, so we can't get #DB before
this, and this ensures we can't get it after this either.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/nmi.c |   55 ++------------------------------------------------
 1 file changed, 3 insertions(+), 52 deletions(-)

--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -478,40 +478,7 @@ enum nmi_states {
 };
 static DEFINE_PER_CPU(enum nmi_states, nmi_state);
 static DEFINE_PER_CPU(unsigned long, nmi_cr2);
-
-#ifdef CONFIG_X86_64
-/*
- * In x86_64, we need to handle breakpoint -> NMI -> breakpoint.  Without
- * some care, the inner breakpoint will clobber the outer breakpoint's
- * stack.
- *
- * If a breakpoint is being processed, and the debug stack is being
- * used, if an NMI comes in and also hits a breakpoint, the stack
- * pointer will be set to the same fixed address as the breakpoint that
- * was interrupted, causing that stack to be corrupted. To handle this
- * case, check if the stack that was interrupted is the debug stack, and
- * if so, change the IDT so that new breakpoints will use the current
- * stack and not switch to the fixed address. On return of the NMI,
- * switch back to the original IDT.
- */
-static DEFINE_PER_CPU(int, update_debug_stack);
-
-static noinstr bool is_debug_stack(unsigned long addr)
-{
-	struct cea_exception_stacks *cs = __this_cpu_read(cea_exception_stacks);
-	unsigned long top = CEA_ESTACK_TOP(cs, DB);
-	unsigned long bot = CEA_ESTACK_BOT(cs, DB1);
-
-	if (__this_cpu_read(debug_stack_usage))
-		return true;
-	/*
-	 * Note, this covers the guard page between DB and DB1 as well to
-	 * avoid two checks. But by all means @addr can never point into
-	 * the guard page.
-	 */
-	return addr >= bot && addr < top;
-}
-#endif
+static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
 DEFINE_IDTENTRY_NMI(exc_nmi)
 {
@@ -526,18 +493,7 @@ DEFINE_IDTENTRY_NMI(exc_nmi)
 	this_cpu_write(nmi_cr2, read_cr2());
 nmi_restart:
 
-#ifdef CONFIG_X86_64
-	/*
-	 * If we interrupted a breakpoint, it is possible that
-	 * the nmi handler will have breakpoints too. We need to
-	 * change the IDT such that breakpoints that happen here
-	 * continue to use the NMI stack.
-	 */
-	if (unlikely(is_debug_stack(regs->sp))) {
-		debug_stack_set_zero();
-		this_cpu_write(update_debug_stack, 1);
-	}
-#endif
+	local_db_save(this_cpu_ptr(&nmi_dr7));
 
 	nmi_enter();
 
@@ -548,12 +504,7 @@ DEFINE_IDTENTRY_NMI(exc_nmi)
 
 	nmi_exit();
 
-#ifdef CONFIG_X86_64
-	if (unlikely(this_cpu_read(update_debug_stack))) {
-		debug_stack_reset();
-		this_cpu_write(update_debug_stack, 0);
-	}
-#endif
+	local_db_restore(*this_cpu_ptr(&nmi_dr7));
 
 	if (unlikely(this_cpu_read(nmi_cr2) != read_cr2()))
 		write_cr2(this_cpu_read(nmi_cr2));


