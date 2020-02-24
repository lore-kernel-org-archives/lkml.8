Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676BBC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3858720842
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hvufIr9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgBXJyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:54:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgBXJyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ox3XWd1h0UFdpJWgXqkeLH4EDTvT30rmX9E287Fs9Mc=; b=hvufIr9pooCrFsZ9kEGSb3f9zq
        4Q9DVNZ15CcdRQCq97rhL4JOELdYuB6qgEtuCrUXJHS5a0aNDfaTGG2YzSnEUhQBrUkW2ezu5tHoq
        JnPB18Zj+IhYdDz8luHXPvbKtHYB7nHZPOpNRQnGUD09DeR/ZMph9x3QOiTH2A4oTGvBsVYYMlMrT
        Yvjqsqkd+Hagu08xedXb36TL04iGKAQingnpTBCRpMNfjHSJ0HCaVYpJVjIoZ2hd4ZfoSnRP5ConU
        Zu55UjbeVcGBan5KNcYVpVgT46OwtMa/4w0uIXpGDXRWaP7xfUbEY+480pUtO8Z+FEGs9IG+mqDLc
        HWexdmVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6ARA-00007B-RU; Mon, 24 Feb 2020 09:54:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD7B730783F;
        Mon, 24 Feb 2020 10:52:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 636002B4DAAD2; Mon, 24 Feb 2020 10:54:02 +0100 (CET)
Date:   Mon, 24 Feb 2020 10:54:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 1/2] x86: fix bitops.h warning with a moved cast
Message-ID: <20200224095402.GD14897@hirez.programming.kicks-ass.net>
References: <20200222000214.2169531-1-jesse.brandeburg@intel.com>
 <CAHp75Vc=9aSt1DH-LzDHnX1+fnPpkJWHkkh0-ApTL0zm+ZA2oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc=9aSt1DH-LzDHnX1+fnPpkJWHkkh0-ApTL0zm+ZA2oQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 11:39:57AM +0200, Andy Shevchenko wrote:
> On Sat, Feb 22, 2020 at 2:04 AM Jesse Brandeburg

> > -#define CONST_MASK(nr)                 (1 << ((nr) & 7))
> > +#define CONST_MASK(nr)                 ((u8)1 << ((nr) & 7))
> >
> >  static __always_inline void
> >  arch_set_bit(long nr, volatile unsigned long *addr)
> > @@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
> >         if (__builtin_constant_p(nr)) {
> >                 asm volatile(LOCK_PREFIX "orb %1,%0"
> >                         : CONST_MASK_ADDR(nr, addr)
> > -                       : "iq" ((u8)CONST_MASK(nr))
> > +                       : "iq" (CONST_MASK(nr))

Note how this is not equivalent, the old code actually handed in a u8
while the new code hands int. By moving the (u8) cast into the parens,
you casl 1 to u8, which then instantly gets promoted to 'int' due to the
'<<' operator.

> >                         : "memory");
> >         } else {
> >                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> > @@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
> >         if (__builtin_constant_p(nr)) {
> >                 asm volatile(LOCK_PREFIX "andb %1,%0"
> >                         : CONST_MASK_ADDR(nr, addr)
> > -                       : "iq" ((u8)~CONST_MASK(nr)));
> > +                       : "iq" (CONST_MASK(nr) ^ 0xff));
> 
> I'm wondering if the original, by Peter Z, order allows us to drop
> (u8) casting in the CONST_MASK completely.

I'm thinking it's all nonsense anyway :-), the result of either << or ^
is always promoted to int anyway.

The sparse complaint was that ~CONST_MASK(nr) had high bits set which
were lost, which is true, but a copmletely stupid warning IMO.

By using 0xff ^ CONST_MASK(nr), those bits will not be set and will not
be lost.

None of that has anything to do with where we place a pointless cast
more or less.
