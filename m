Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C013FC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9865920752
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UiBCw6Ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgEFNvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbgEFNvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:51:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D09C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jEJBzua8/RGymwAaDc/kEJMuCfcFhoV0OLdBTpJd4BA=; b=UiBCw6Ml0qUVWxWls6z4uBM/y2
        Jo3c6n0xCmCTvccwTBKon2QbEueJBGSyH6aTt95pa33PLHn7AloYDDj3nGr3a3WAnR3i/ozzJS+EX
        CKoMCgYUwtPjY8krnxCXKk8n9du/WtWty19/z4JwuX3NrSyZsxN8+Hm05IAyhZr9/fSikdAJ8d46n
        m//ACNSJlT8Fwr9rdmxZTqZmyhMhagWdlZTb8L05A+kvDMcQ9axsndyQneV60quxwmIR/Ag0ec9OF
        YGnbottKBP3BdnaCUh9b/eR5g0lq2u1NdB8Cz5Hld8wB7rAZsToYPYxOzNA0ARUR6sY/YwU/iYiYR
        jT4USONw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWKSS-0000MN-8W; Wed, 06 May 2020 13:51:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D3B9301DFC;
        Wed,  6 May 2020 15:51:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FE952B74FC98; Wed,  6 May 2020 15:51:28 +0200 (CEST)
Date:   Wed, 6 May 2020 15:51:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bristot@redhat.com,
        Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
Message-ID: <20200506135128.GR3762@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.593400184@infradead.org>
 <1238787e-d97d-f09b-d76d-2df2dc273f4b@rasmusvillemoes.dk>
 <20200503125813.GL3762@hirez.programming.kicks-ass.net>
 <a53369f3-665a-af0e-efad-09ae456af847@rasmusvillemoes.dk>
 <20200504201445.GQ3762@hirez.programming.kicks-ass.net>
 <20200505093625.GE5298@hirez.programming.kicks-ass.net>
 <CAKwvOd=cP8UCX0+5pZ3AqzvOM8LKzLJJ_heDhrghqJdOnHoGMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=cP8UCX0+5pZ3AqzvOM8LKzLJJ_heDhrghqJdOnHoGMg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 11:13:53AM -0700, Nick Desaulniers wrote:
> On Tue, May 5, 2020 at 2:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >
> > HJ, Nick,
> >
> > Any chance any of you can see a way to make your respective compilers
> > not emit utter junk for this?
> >
> > On Mon, May 04, 2020 at 10:14:45PM +0200, Peter Zijlstra wrote:
> >
> > > https://godbolt.org/z/SDRG2q
> 
> Woah, a godbolt link! Now we're speaking the same language.  What were
> you expecting?

Given the output for x86-64 clang (trunk)

	bar:                                    # @bar
		movl    %edi, .L_x$local(%rip)
		retq
	ponies:                                 # @ponies
		movq    .Lfoo$local(%rip), %rax
		testq   %rax, %rax
		movl    $__static_call_nop, %ecx
		cmovneq %rax, %rcx
		jmpq    *%rcx                   # TAILCALL
	__static_call_nop:                      # @__static_call_nop
		retq
	_x:
	.L_x$local:
		.long   0                       # 0x0

	foo:
	.Lfoo$local:
		.zero   8


I was hoping for:

	bar:                                    # @bar
		movl    %edi, .L_x$local(%rip)
		retq
	ponies:                                 # @ponies
		movq    .Lfoo$local(%rip), %rax
		testq   %rax, %rax
		jz	1f
		jmpq    *%rcx                   # TAILCALL
	1:
		retq

That avoids the indirect call (possible retpoline) and does an immediate
return.

So it does 2 things different:

 - it realizes the NULL case is a constant and uses an
   immediate call and avoids the indirect call/jmp.

 - it realizes __static_call_nop() is a no-op and avoids the call
   entirely and does an immediate return.

> Us to remove the conditional check that a volatile read
> wasn't NULL?

No, obviously the load is required, and the READ_ONCE() is so that the
compiler will not emit 2 different loads (just for giggles).

That is:

	tmp1 = name.func;
	if (!tmp) {
		tmp2 = name.func;
		tmp2(args);
	}

is a valid translation of:

	if (!name.func)
		name.func(args)

and allows for a NULL dereference (as noted by Rasmus).

What I did do want, per the above, is to avoid the indirect (tail) call.
Because indirect jmp/call are evil and expensive.

> I am simultaneously impressed
> and disgusted by this btw, cool stuff.

Yes, it's nasty, esp the casting of a function pointer like that is
gruesome.
