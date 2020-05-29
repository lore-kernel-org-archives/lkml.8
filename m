Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D02C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C8920810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hhUfMFOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgE2VfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgE2Ve5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:34:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E65C08C5D1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jkfi8De0rOCnIZq+jSVpuHzRxY6NvNqU+eyz6LHLrYQ=; b=hhUfMFOJhzIFo8hVId0+9nc22u
        CsBbl4d5CuKKRws0AoyFXg1k5zbiZAph9zWm+qukDiQNJCuH8RIFJCiLkIvSZ4nzEt7VCg/Dd1PXc
        Jm+CBu3luBoOMHfPL/YbwO1Ql5ZUH+u/Ko9TqzxJ97/jeM8N2C4dmGKvsApbhy+4Zn8pKsYSKr/bw
        LGbTuvD9qcsGsDbwcpXPdGM8OeSIe4btWAqJmMicEW1ORN5CrxNtcrfetcGYO64ApxSpZzPBSYt5i
        p9hZlxAchgJLakt/0LHUMd2IRhzAQ3iO5YdytpK2koO6L9As76F5+XP+R8IZmp9v899ExEwoS5/pQ
        yK14ruQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemeJ-0000Kk-Jg; Fri, 29 May 2020 21:34:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF8F4306A9D;
        Fri, 29 May 2020 23:34:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2CAC120FF0A0D; Fri, 29 May 2020 23:34:41 +0200 (CEST)
Message-ID: <20200529213321.069223695@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:27:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
Subject: [PATCH 06/14] x86/entry, nmi: Disable #DB
References: <20200529212728.795169701@infradead.org>
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
@@ -474,40 +474,7 @@ enum nmi_states {
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
@@ -522,18 +489,7 @@ DEFINE_IDTENTRY_NMI(exc_nmi)
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
+	this_cpu_write(nmi_dr7, local_db_save());
 
 	nmi_enter();
 
@@ -544,12 +500,7 @@ DEFINE_IDTENTRY_NMI(exc_nmi)
 
 	nmi_exit();
 
-#ifdef CONFIG_X86_64
-	if (unlikely(this_cpu_read(update_debug_stack))) {
-		debug_stack_reset();
-		this_cpu_write(update_debug_stack, 0);
-	}
-#endif
+	local_db_restore(this_cpu_read(nmi_dr7));
 
 	if (unlikely(this_cpu_read(nmi_cr2) != read_cr2()))
 		write_cr2(this_cpu_read(nmi_cr2));


