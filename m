Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0C7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20307207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yBDfG6Nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgHSTlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSTlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:41:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32964C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YXJsdr3GQ8OB6AyXkOr2FEt7S5fD4HZ3P2BDC88D7pc=; b=yBDfG6Njq61Pud368Xho++vFO8
        0tuqqV4sLDDc5zFA8gjxAOemN+21/UUxIhdlACmClreyXhlVskU9GfLJPaJKqSguaiE2yllJFWYaq
        uIYDqmFdTeKQnjArliKoj+pPfYZtKueomwsgXOiMKoC7RR7JWsz0jhzigdNBhE/G57Kztbbt1Ke+6
        1u6jWqpRwyi/5o95yzbYtWmXVNO0baQeWIR7p/vcaCll31ySkuGYL9BYN9MM0iR9oQyNg4hSLS42e
        9xyKCvFNImHjpbYCH3zgcfJ8saoP21FoGGQhpBQZlWyjnoxigCFBYiaAMJ/HReOq+6/o4eH53UVfr
        vJ49FSTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Txa-0007o2-EA; Wed, 19 Aug 2020 19:41:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D3A53003E1;
        Wed, 19 Aug 2020 21:41:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFCEB2C0F7C8C; Wed, 19 Aug 2020 21:41:16 +0200 (CEST)
Date:   Wed, 19 Aug 2020 21:41:16 +0200
From:   peterz@infradead.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC][PATCH v2 08/10] smp,irq_work: Use the new irq_work API
Message-ID: <20200819194116.GJ2674@hirez.programming.kicks-ass.net>
References: <20200818105102.926463950@infradead.org>
 <20200818112418.460474861@infradead.org>
 <20200818162542.GB27196@lst.de>
 <20200819072209.GU2674@hirez.programming.kicks-ass.net>
 <CAHk-=wgMATDQQxLSsgmxCoCqApVXVeRnGOf6iWjnYdTJY_R3aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMATDQQxLSsgmxCoCqApVXVeRnGOf6iWjnYdTJY_R3aw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:50:55AM -0700, Linus Torvalds wrote:
> On Wed, Aug 19, 2020 at 12:22 AM <peterz@infradead.org> wrote:
> >
> > That is, the external serialization comes from the non-atomic
> > test-and-set they both have. This works nicely when there is external
> > state that already serializes things, but totally comes apart (and
> > causes trivial list corruption) when you get it wrong.
> 
> Quite often, there just isn't any *need* for serialization, because
> there is only ever one op active.
> 
> That can be either because the csd is fundamentally a single thing ("I
> will transfer this object to another CPU"), or it can be because the
> CSD is already per-cpu (ie smp_call_function_single).

Note that smp_call_function_single() doesn't use _async(), and while it
does use per-cpu CSDs, the reqular .wait=false case then potentially
waits before (instead of after) in the unlikely case the local CSD was
already taken.

This makes that we cannot use it with IRQs disabled.

> You seem to make that common situation much worse.

Probably -- like I said, I'm not really happy with this either.

> Not only do you add that expensive atomic op, you add that expensive
> "use irq_work queues" for something that doesn't _need_ to use them.

I'm not sure I get the "expensive irq_work queues" argument, I fully
agree with you that adding the atomic op is fairly crap.

The remote irq_work is exactly same llist and IPI vector as remote
smp_call_function_single(). And the new irq_work_queue_remote_static()
is exactly as cheap as smp_call_function_single_async() for not having
an atomic op, queues to the same llist, sends the same IPI, but uses the
embedded data structure instead of pass a data pointer pattern.

Because most of the async users end up having another data structure to
pass arguments around anyway.

> I have to say, I'm not a fan. What are the real advantages? Your
> listed disadvantages are very very questionable.
> 
> IOW, what are the actual examples of "totally comes apart" that justifies this?
> 
> If the example is theoretical ("if you use csd's wrong") then I think
> they are worthless.

Well, I did use the CSD's wrong. I forgot the gotcha and made a mess of
things and stuff crashed, the wreckage is in the git history :/ I fixed
it, but I got burned.

I then went and looked at a bunch of other _async users and it wasn't
immediately obvious that they were doing it right (they were).

I wanted to improve things, but I'm willing to admit to just making it
worse in these last few patches.

Anyway, the pattern I wanted is more easily expressed with the new
irq_work_queue_remote(), even though I don't need it anymore. I can
throw away all the patches after that without loosing too much sleep.
