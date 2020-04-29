Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5611C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B065620731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pzZU8AEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgD2IbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2IbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:31:23 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7BAC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BvjmK3vN0uGbY28dcKoajhBRy2G9ruAzcetEN/XucG4=; b=pzZU8AEthYq2ZZUpDSbe49q0Ej
        AJPxtq2h6/F7ecJaUo+ZCCN5jt8ROc9fTWSoy0P2wSUpHPWkO1IAc/lLC6tyc0y+9FhoKIpSgJ1aw
        api8WWg5ekBhnOfyV7JxA/ah7QczCw5PXFwrmXHdYZnhLg+/6g75KcQXWCaDWlPGTacujWIcc8vm1
        iT+gM3rlfHoW/CDO0l2IXMX7dgj3WANmQFdM6fSVJwQFlnUvshqNNj9EqqH/zv+cd8DC6o+gc4jnl
        95V5tiy7D7YhS45V3DW8KJgq+USAn8DS43u8c8iAhzxAZsAVowO7L4incYUSJhDVidoIHuxskDpvZ
        UMPjahag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTi7M-0006zc-8m; Wed, 29 Apr 2020 08:30:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B4F3300130;
        Wed, 29 Apr 2020 10:30:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5706E20BD900F; Wed, 29 Apr 2020 10:30:53 +0200 (CEST)
Date:   Wed, 29 Apr 2020 10:30:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jthierry@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 03/14] x86,smap: Fix smap_{save,restore}() alternatives
Message-ID: <20200429083053.GE13592@hirez.programming.kicks-ass.net>
References: <20200428191101.886208539@infradead.org>
 <20200428191659.558899462@infradead.org>
 <CAMzpN2jp1mtnf61eXPaj2O5=-8Fp42v+t6Br3ce9Fioq8h=0YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2jp1mtnf61eXPaj2O5=-8Fp42v+t6Br3ce9Fioq8h=0YA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 08:54:05PM -0400, Brian Gerst wrote:
> On Tue, Apr 28, 2020 at 3:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > As reported by objtool:
> >
> >   lib/ubsan.o: warning: objtool: .altinstr_replacement+0x0: alternative modifies stack
> >   lib/ubsan.o: warning: objtool: .altinstr_replacement+0x7: alternative modifies stack
> >
> > the smap_{save,restore}() alternatives violate (the newly enforced)
> > rule on stack invariance. That is, due to there only being a single
> > ORC table it must be valid to any alternative. These alternatives
> > violate this with the direct result that unwinds will not be correct
> > in between these calls.
> >
> > [ In specific, since we force SMAP on for objtool, running on !SMAP
> > hardware will observe a different stack-layout and the ORC unwinder
> > will stumble. ]
> >
> > So rewrite the functions to unconditionally save/restore the flags,
> > which gives an invariant stack layout irrespective of the SMAP state.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/include/asm/smap.h |   11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > --- a/arch/x86/include/asm/smap.h
> > +++ b/arch/x86/include/asm/smap.h
> > @@ -57,16 +57,19 @@ static __always_inline unsigned long sma
> >  {
> >         unsigned long flags;
> >
> > -       asm volatile (ALTERNATIVE("", "pushf; pop %0; " __ASM_CLAC,
> > -                                 X86_FEATURE_SMAP)
> > -                     : "=rm" (flags) : : "memory", "cc");
> > +       asm volatile ("# smap_save\n\t"
> > +                     "pushf; pop %0"
> > +                     : "=rm" (flags) : : "memory");
> > +
> > +       clac();
> >
> >         return flags;
> >  }
> >
> >  static __always_inline void smap_restore(unsigned long flags)
> >  {
> > -       asm volatile (ALTERNATIVE("", "push %0; popf", X86_FEATURE_SMAP)
> > +       asm volatile ("# smap_restore\n\t"
> > +                     "push %0; popf"
> >                       : : "g" (flags) : "memory", "cc");
> >  }
> 
> POPF is an expensive instruction that should be avoided if possible.
> A better solution would be to have the alternative jump over the
> push/pop when SMAP is disabled.

Yeah. I think I had that, but then confused myself again. I don't think
it matters much if you look at where it's used though.

Still, let me try the jmp thing again..
