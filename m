Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D62C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C04F20658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WLLCZFZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgHTM7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgHTM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:59:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B318C061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 05:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lQg8TlP6dR9sIvxfDK+IReywdAXhOR7V/bB3+sWI/Kw=; b=WLLCZFZMcyvYc2/o+1q1KH6fP5
        JnSLaImmX1fpKkjBWrLVnzTFpuzdbCzdCGaiLp6qmRzjwXEzKqwDjFP98dsyjmfWugCxRH8Z5C/TV
        RMlTeceJ+nTws1ofbq2fAapEyyv0jsR61TjDqTUtOqPRKISE4XBerdlif2gkvsG4U7lDJbq4ylWuu
        DhBBy6t7TZWJDXJia12/lrBoyitTOsaBBEdI+0Fbrmiyxt3oT0yC1Nggi4ppDOcv/buzuSbwlJWKf
        HTeEkAxkcksD8W6dzUTQxb65O7pZRMeDYcgDKykrfD3SGltOqXjFE5yWIL9DfHPMPswBmuYs8IKZh
        dT5i7/UA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8k9G-0000BD-Cs; Thu, 20 Aug 2020 12:58:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58629305B23;
        Thu, 20 Aug 2020 14:58:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1CD592BC7FC9E; Thu, 20 Aug 2020 14:58:29 +0200 (CEST)
Date:   Thu, 20 Aug 2020 14:58:29 +0200
From:   peterz@infradead.org
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Jiang Biao <benbjiang@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Subject: Re: [PATCH] sched/fair: avoid vruntime compensation for SCHED_IDLE
 task
Message-ID: <20200820125829.GT2674@hirez.programming.kicks-ass.net>
References: <20200820120025.74460-1-benbjiang@tencent.com>
 <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 02:51:06PM +0200, Vincent Guittot wrote:
> On Thu, 20 Aug 2020 at 14:00, Jiang Biao <benbjiang@gmail.com> wrote:
> >
> > From: Jiang Biao <benbjiang@tencent.com>
> >
> > Vruntime compensation has been down in place_entity() to
> > boot the waking procedure for fair tasks. There is no need to
> 
> s/boot/boost/ ?
> 
> > do that for SCHED_IDLE task actually.
> >
> > Not compensating vruntime for SCHED_IDLE task could make
> > SCHED_IDLE task more harmless for normal tasks.

This is rather week. It would be much better if there's some actual data
to support this claim.

> > Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1a68a0536add..adff77676a0a 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4115,7 +4115,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> >                 vruntime += sched_vslice(cfs_rq, se);
> >
> >         /* sleeps up to a single latency don't count. */
> > -       if (!initial) {
> > +       if (!initial && likely(!task_has_idle_policy(task_of(se)))) {
> 
> What if se is not a task ?

Then we very much need it, because it might have fair tasks inside. I
suppose you could do something complicated with idle_h_nr_running, but
is all that really worth the effort?

> >                 unsigned long thresh = sysctl_sched_latency;
> >
> >                 /*
> > --
> > 2.21.0
> >
