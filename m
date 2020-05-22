Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4688C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17E82073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hLHCGOoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgEVUuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730967AbgEVUuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:50:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A137C05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=POcE9Zsqk5Wj8pYWDoycnkQXPDgA8x0UIJc1wCvh6Cg=; b=hLHCGOoTHozoeyt1KML5u/pIX7
        5XNaQKLnOviptdOFxpOyf03mprgK6usaaLarhEWnDneQb4ay5whBH2Ddb5afEP3bWph2UGsPErRxC
        /o6WBbNvjitXSKJY26ktamCuQl8/PWtdZf7Fv3lzJzzY7jX82kzek3n3KtaL0fea+PGBNwrU1dYFP
        30/gn7mjVKh9sQ8DJpIDsH/N9bEDleBPmfYJNRu7gda/pKj+B8ZsrRsljGfHaVZeeKmhOPKze/vx5
        ei9CkZmMDYSxcAbSEUP40icKfQ30kM//LxvlQalR9D1JvJBY8898wYmfi6ecB8Ws93rxvUMWHXHQK
        uFGMvl8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcEcA-0000lO-PM; Fri, 22 May 2020 20:49:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF95B3060FC;
        Fri, 22 May 2020 22:49:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B05DC2B4213E7; Fri, 22 May 2020 22:49:56 +0200 (CEST)
Message-ID: <20200522204943.293321207@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 22 May 2020 22:47:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [RFC][PATCH 2/4] x86/entry, nmi: Disable #DB
References: <20200522204738.645043059@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of playing stupid games with IST stacks, fully disallow #DB
during NMIs. There is absolutely no reason to allow them, and killing
this saves a heap of trouble.

We already disallow #BD on noinstr and CEA, so we can't get #DB before
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


