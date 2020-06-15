Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90127C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E02C2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H52QNX2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgFOPVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730313AbgFOPVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:21:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A272C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Udue+LwwMS7xIun8pCno4Qdzcnv4kfX0ri/1a/g6c/k=; b=H52QNX2jaSfrKP3H7353XNxUQl
        JbEKHp5vhJk+xhPAnq6tsFUNwk1pSZFn/F6enslamIL/ygi3NZkbTzOt4YZinaVC2u+KsYXuLMq/4
        jZNur1SlSu9sIbEctHrRVHooj+3eGOpEVqRRopw9dELDrHW6dAO3LIKRFWW2nRZTkTeJ/1aNQEnZa
        UdmNHi0iBKHH2CknmTdxoKKvj+AXJbxRiBtGlhrKSdwTqXqsGqHLkjgonIU6g8Lr8Q7yV2FcwnY1d
        oPYuGu5ulSJouIixOcDbpFbmcEzrVcdbN5UYN0dQP1dtJ4MUfYd7sy5UDai1Bv020RLCekRVe1mo6
        rhQpYvQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkquv-00053R-UE; Mon, 15 Jun 2020 15:20:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EC123003E1;
        Mon, 15 Jun 2020 17:20:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3535C203C3762; Mon, 15 Jun 2020 17:20:56 +0200 (CEST)
Date:   Mon, 15 Jun 2020 17:20:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions
 noinstr-compatible
Message-ID: <20200615152056.GF2554@hirez.programming.kicks-ass.net>
References: <CACT4Y+Z+FFHFGSgEJGkd+zCBgUOck_odOf9_=5YQLNJQVMGNdw@mail.gmail.com>
 <20200608110108.GB2497@hirez.programming.kicks-ass.net>
 <20200611215538.GE4496@worktop.programming.kicks-ass.net>
 <CACT4Y+aKVKEp1yoBYSH0ebJxeqKj8TPR9MVtHC1Mh=jgX0ZvLw@mail.gmail.com>
 <20200612114900.GA187027@google.com>
 <CACT4Y+bBtCbEk2tg60gn5bgfBjARQFBgtqkQg8VnLLg5JwyL5g@mail.gmail.com>
 <CANpmjNM+Tcn40MsfFKvKxNTtev-TXDsosN+z9ATL8hVJdK1yug@mail.gmail.com>
 <20200615142949.GT2531@hirez.programming.kicks-ass.net>
 <20200615145336.GA220132@google.com>
 <20200615150327.GW2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615150327.GW2531@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 05:03:27PM +0200, Peter Zijlstra wrote:

> Yes, I think so. x86_64 needs lib/memcpy_64.S in .noinstr.text then. For
> i386 it's an __always_inline inline-asm thing.

Bah, I tried writing it without memcpy, but clang inserts memcpy anyway
:/

---
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index af75109485c26..d74fd6313a4ed 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -686,17 +686,17 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 	 * just below the IRET frame) and we want to pretend that the
 	 * exception came from the IRET target.
 	 */
-	struct bad_iret_stack tmp, *new_stack =
+	struct bad_iret_stack tmp = *s, *new_stack =
 		(struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
+	unsigned long *p = (unsigned long *)s->regs.sp;
 
-	/* Copy the IRET target to the temporary storage. */
-	memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
+	tmp.regs.ip	= p[0];
+	tmp.regs.cs	= p[1];
+	tmp.regs.flags	= p[2];
+	tmp.regs.sp	= p[3];
+	tmp.regs.ss	= p[4];
 
-	/* Copy the remainder of the stack from the current stack. */
-	memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
-
-	/* Update the entry stack */
-	memcpy(new_stack, &tmp, sizeof(tmp));
+	*new_stack = tmp;
 
 	BUG_ON(!user_mode(&new_stack->regs));
 	return new_stack;
