Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DDEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CA1207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CLqf0aif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgESSqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:46:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45868 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgESSqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JyzkKr1JhOCfKm02c+21XonEXostNDxmZnTbn9PYvN8=; b=CLqf0aifIj0VH4QIoZuacBPBRH
        XB9v62HUkRhzdcxBtbtle/Qa6NG4mUhtE050hOmZBlTodi4nsxHG3Poh2MLG5g4V5v3lViVUy6DRF
        cftEo7KzDlLTdAgvvCmHFfqm1Z9XrbHM5JC7qT5enwpzS/fKFe3v15WDiJkBKqpfkc0FWM5rD3qY1
        TwifgQmOvMW2vxvSO6Y8wShS6rX6rYPKazo21kpk+1KbKGZ+kmzLG3lU+szhKliPDhqA6GMKnQgF0
        q3re+w2qF6ZzmNWZNqxrr7tEzFBeIQXyTgIT/WWSzG8W4geQdsuB47Jdu7y4APnCa4lrOyqa7JPf7
        YWANoo3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb7Bz-0008TD-6L; Tue, 19 May 2020 18:42:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3402D301A80;
        Tue, 19 May 2020 20:42:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 238A125D60953; Tue, 19 May 2020 20:42:10 +0200 (CEST)
Date:   Tue, 19 May 2020 20:42:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH v2] sched/cputime: make scale_stime() more precise
Message-ID: <20200519184210.GD317569@hirez.programming.kicks-ass.net>
References: <20190718131834.GA22211@redhat.com>
 <20200127122817.GA10957@redhat.com>
 <20200519172506.GA317395@hirez.programming.kicks-ass.net>
 <CAHk-=wjjxDY6XzKKPEE1S+AUXycmo8XNpX2C-jO4fS+qU8ObpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjjxDY6XzKKPEE1S+AUXycmo8XNpX2C-jO4fS+qU8ObpA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:33:34AM -0700, Linus Torvalds wrote:
> On Tue, May 19, 2020 at 10:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > --- a/include/linux/math64.h
> > +++ b/include/linux/math64.h
> > @@ -263,6 +263,47 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
> >  }
> >  #endif /* mul_u64_u32_div */
> >
> > +#ifndef mul_u64_u64_div_u64
> > +static inline u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
> 
> Do we really want to inline this? Particularly if we expect this to be
> the "architecture doesn't have a better version" case?
> 
> It's not like we'd expect people to call it with constant values that
> could be optimized by inlining, do we? If any of the values are
> actually constants and it's performance-critical, the code is likely
> better off using some special helper rather than this anyway.
> 
> So I'd much rather see it as a weak function defined in
> lib/math/div64.c, and then architectures don't even need to override
> it at all. Just let them define their own (inline or not) function,
> and we have this as a weak fallback.

I completely forgot we had a .c file to go with all this. Yes, I'll put
it in there.
