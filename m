Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA56C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C4220890
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l5S4jMfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgFQOuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:50:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9399CC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8tV90J3ommZlSIBCa9GxO7kk+JI83XJ4xYdDZnD4Ijc=; b=l5S4jMfSGIQUg/N8n1oegTOpBr
        asq6get5vZnR0xcL5ok+/GxmscseDXThs3pWAf8MS4xt0KRUZHySA+8l776NFslmhaoeJuwoTHHQP
        QdLvZhOIH5t4fEtuo5cOMH8GIEl3blBERoOyji8T9SEP8t+4Yj/mUGnoqPpZcitkgYDCckft19ZMl
        jc/8T3XRi7Pp+UGFWyPKBo5/ubnvbkHQ0SwBz43y6/zQYIMw0wWfgcnzmkk5T8+B3MWtip12iR29m
        ce3AuRL0CF/esGImMZ6A2H+dj7bEsnWJ+gF6uBCecUPBvqyq7PVVkYKTOLT4myp3+1S7iZkzxgN3w
        PK1zCIrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlZNv-0005BJ-Ds; Wed, 17 Jun 2020 14:49:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91214301DFC;
        Wed, 17 Jun 2020 16:49:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D29A203CE7F6; Wed, 17 Jun 2020 16:49:49 +0200 (CEST)
Date:   Wed, 17 Jun 2020 16:49:49 +0200
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
        Josh Poimboeuf <jpoimboe@redhat.com>, ndesaulniers@google.com
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions
 noinstr-compatible
Message-ID: <20200617144949.GA576905@hirez.programming.kicks-ass.net>
References: <20200611215538.GE4496@worktop.programming.kicks-ass.net>
 <CACT4Y+aKVKEp1yoBYSH0ebJxeqKj8TPR9MVtHC1Mh=jgX0ZvLw@mail.gmail.com>
 <20200612114900.GA187027@google.com>
 <CACT4Y+bBtCbEk2tg60gn5bgfBjARQFBgtqkQg8VnLLg5JwyL5g@mail.gmail.com>
 <CANpmjNM+Tcn40MsfFKvKxNTtev-TXDsosN+z9ATL8hVJdK1yug@mail.gmail.com>
 <20200615142949.GT2531@hirez.programming.kicks-ass.net>
 <20200615145336.GA220132@google.com>
 <20200615150327.GW2531@hirez.programming.kicks-ass.net>
 <20200615152056.GF2554@hirez.programming.kicks-ass.net>
 <20200617143208.GA56208@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617143208.GA56208@elver.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 04:32:08PM +0200, Marco Elver wrote:
> On Mon, Jun 15, 2020 at 05:20PM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 15, 2020 at 05:03:27PM +0200, Peter Zijlstra wrote:
> > 
> > > Yes, I think so. x86_64 needs lib/memcpy_64.S in .noinstr.text then. For
> > > i386 it's an __always_inline inline-asm thing.
> > 
> > Bah, I tried writing it without memcpy, but clang inserts memcpy anyway
> > :/
> 
> Hmm, __builtin_memcpy() won't help either.
> 
> Turns out, Clang 11 got __builtin_memcpy_inline(): https://reviews.llvm.org/D73543
> 
> The below works, no more crash on either KASAN or KCSAN with Clang. We
> can test if we have it with __has_feature(__builtin_memcpy_inline)
> (although that's currently not working as expected, trying to fix :-/).
> 
> Would a memcpy_inline() be generally useful? It's not just Clang but
> also GCC that isn't entirely upfront about which memcpy is inlined and
> which isn't. If the compiler has __builtin_memcpy_inline(), we can use
> it, otherwise the arch likely has to provide the implementation.
> 
> Thoughts?

I had the below, except of course that yields another objtool
complaint, and I was still looking at that.

Does GCC (8, as per the new KASAN thing) have that
__builtin_memcpy_inline() ?

---
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index af75109485c26..a7d1570905727 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -690,13 +690,13 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 		(struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
 
 	/* Copy the IRET target to the temporary storage. */
-	memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
+	__memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
 
 	/* Copy the remainder of the stack from the current stack. */
-	memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
+	__memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
 
 	/* Update the entry stack */
-	memcpy(new_stack, &tmp, sizeof(tmp));
+	__memcpy(new_stack, &tmp, sizeof(tmp));
 
 	BUG_ON(!user_mode(&new_stack->regs));
 	return new_stack;
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 56b243b14c3a2..bbcc05bcefadb 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -8,6 +8,8 @@
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
 
+.pushsection .noinstr.text, "ax"
+
 /*
  * We build a jump to memcpy_orig by default which gets NOPped out on
  * the majority of x86 CPUs which set REP_GOOD. In addition, CPUs which
@@ -184,6 +186,8 @@ SYM_FUNC_START_LOCAL(memcpy_orig)
 	retq
 SYM_FUNC_END(memcpy_orig)
 
+.popsection
+
 #ifndef CONFIG_UML
 
 MCSAFE_TEST_CTL
