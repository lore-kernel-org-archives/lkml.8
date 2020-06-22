Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAC6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2B420716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hB9jERzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgFVLrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgFVLrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:47:49 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98E2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hfvlznUygRqFdDOHpCKEfZ5wshmNz2jqwQWxzgI5F8M=; b=hB9jERzJlmZnJBe8CaL8pMG6AM
        1QB7D2d74rQagF7YirNJKOAqQuhulFZq9XYnkB8UcAOGbj/AcujtaY6iY73yeFAn2M48LDsPltcF4
        KHk36hmTf7vIu2C9yUKP0Gog1tGsl66tM3Oz0eReMYD4OkfTNLLZ0Esp5TJXr09JkGCvkgnpvkCKg
        6g7LwpCcI7270kho6avvrMpRN1OtCVqUqC0RyE6umWVwPcpm4uzspqgCbyPsCU4L9a5mi87TSll4Y
        662/U+e1b3Ca0Bqrhs8GgSKEVq0jwnIp/SUA+hP7DGuSysyuBtK0csKvAw0pHNTRtbA63I0QFTbR2
        s6wcVfrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnKv0-0003i5-PL; Mon, 22 Jun 2020 11:47:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F24E830018A;
        Mon, 22 Jun 2020 13:47:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D4392236D2014; Mon, 22 Jun 2020 13:47:13 +0200 (CEST)
Date:   Mon, 22 Jun 2020 13:47:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>, jthierry@redhat.com,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 1/7] x86/entry: Fix #UD vs WARN more
Message-ID: <20200622114713.GE577403@hirez.programming.kicks-ass.net>
References: <20200618190207.GO576905@hirez.programming.kicks-ass.net>
 <257B4193-08FB-4B3E-85E9-6C512B52C2C2@amacapital.net>
 <20200618211823.GP576905@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200618211823.GP576905@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 11:18:23PM +0200, Peter Zijlstra wrote:

> > So maybe also do an untraced cond_local_irq_enable()?  After all, if
> > we’re trying to report a bug from IRQs on, it should be okay to have
> > IRQs on while reporting it. It might even work better than having IRQs
> > off.
> 
> Yes, very good point. Now I want to go look at the old code... I'll frob
> something tomorrow, brain is pretty fried by now.

How's this then?

---
Subject: x86/entry: Fix #UD vs WARN more
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Jun 16 13:28:36 CEST 2020

vmlinux.o: warning: objtool: exc_invalid_op()+0x47: call to probe_kernel_read() leaves .noinstr.text section

Since we use UD2 as a short-cut for 'CALL __WARN', treat it as such.
Have the bare exception handler do the report_bug() thing.

Fixes: 15a416e8aaa7 ("x86/entry: Treat BUG/WARN as NMI-like entries")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   72 +++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -86,15 +86,14 @@ static inline void cond_local_irq_disabl
 
 int is_valid_bugaddr(unsigned long addr)
 {
-	unsigned short ud;
-
 	if (addr < TASK_SIZE_MAX)
 		return 0;
 
-	if (probe_kernel_address((unsigned short *)addr, ud))
-		return 0;
-
-	return ud == INSN_UD0 || ud == INSN_UD2;
+	/*
+	 * We got #UD, if the text isn't readable we'd have gotten
+	 * a different exception.
+	 */
+	return *(unsigned short)addr == INSN_UD2;
 }
 
 static nokprobe_inline int
@@ -216,40 +215,45 @@ static inline void handle_invalid_op(str
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
 
-DEFINE_IDTENTRY_RAW(exc_invalid_op)
+static noinstr bool handle_bug(struct pt_regs *regs)
 {
-	bool rcu_exit;
+	bool handled = false;
+
+	if (!is_valid_bugaddr(regs->ip))
+		return handled;
 
 	/*
-	 * Handle BUG/WARN like NMIs instead of like normal idtentries:
-	 * if we bugged/warned in a bad RCU context, for example, the last
-	 * thing we want is to BUG/WARN again in the idtentry code, ad
-	 * infinitum.
+	 * All lies, just get the WARN/BUG out.
+	 */
+	instrumentation_begin();
+	/*
+	 * Since we're emulating a CALL with exceptions, restore the interrupt
+	 * state to what it was at the exception site.
 	 */
-	if (!user_mode(regs) && is_valid_bugaddr(regs->ip)) {
-		enum bug_trap_type type;
+	if (regs->flags & X86_EFLAGS_IF)
+		raw_local_irq_enable();
+	if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
+		regs->ip += LEN_UD2;
+		handled = true;
+	}
+	if (regs->flags & X86_EFLAGS_IF)
+		raw_local_irq_disable();
+	instrumentation_end();
 
-		nmi_enter();
-		instrumentation_begin();
-		trace_hardirqs_off_finish();
-		type = report_bug(regs->ip, regs);
-		if (regs->flags & X86_EFLAGS_IF)
-			trace_hardirqs_on_prepare();
-		instrumentation_end();
-		nmi_exit();
-
-		if (type == BUG_TRAP_TYPE_WARN) {
-			/* Skip the ud2. */
-			regs->ip += LEN_UD2;
-			return;
-		}
+	return handled;
+}
 
-		/*
-		 * Else, if this was a BUG and report_bug returns or if this
-		 * was just a normal #UD, we want to continue onward and
-		 * crash.
-		 */
-	}
+DEFINE_IDTENTRY_RAW(exc_invalid_op)
+{
+	bool rcu_exit;
+
+	/*
+	 * We use UD2 as a short encoding for 'CALL __WARN', as such
+	 * handle it before exception entry to avoid recursive WARN
+	 * in case exception entry is the one triggering WARNs.
+	 */
+	if (!user_mode(regs) && handle_bug(regs))
+		return;
 
 	rcu_exit = idtentry_enter_cond_rcu(regs);
 	instrumentation_begin();
