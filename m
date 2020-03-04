Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE109C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926862166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aN61YDAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgCDJdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:33:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbgCDJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gX2uMel8bqojLwNLrW/nBkgoOloh9SjGrsYWMzHuEsw=; b=aN61YDADxoRGokV7pRaxA5Jw8t
        PNTXa6oprGIxP47+jS/vX10PY31xtAOd+yneGCjw02qlwgqy3WBg2KPXsVaq0+hRC71YgwZlI8XHt
        RYl89LPwSDQ/97/9g/42kYCsaX+D4DmLlcNYFl0FQ1eELJp8XmG4QXl71XvYKI457+XuyLgA1VKdx
        lHdsRtP4st2DBrZEVeGu3xnojyofs+zsgha71myWK+pj9ECD3H7/B5uLptuvyINaOsX0JfhqB5c52
        HffcJHhit69Ll8qT/efDPjtTRajMR4m4JADoiN1F2Uz6FRpYl2koeQDRSMKLR3hMqAOO9g1BWCdJj
        fRHOqqpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9QPS-0004ws-1v; Wed, 04 Mar 2020 09:33:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FAA63024EA;
        Wed,  4 Mar 2020 10:31:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1ECCC2011CA98; Wed,  4 Mar 2020 10:33:44 +0100 (CET)
Date:   Wed, 4 Mar 2020 10:33:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH] perf/core: Fix endless multiplex timer
Message-ID: <20200304093344.GJ2596@hirez.programming.kicks-ass.net>
References: <20200303202819.3942-1-kan.liang@linux.intel.com>
 <20200303210812.GA4745@worktop.programming.kicks-ass.net>
 <b71515e4-484e-d80a-37db-2e51abe69928@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b71515e4-484e-d80a-37db-2e51abe69928@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 08:40:10PM -0500, Liang, Kan wrote:
> > I'm thinking this is wrong.
> > 
> > That is, yes, this fixes the observed problem, but it also misses at
> > least one other site. Which seems to suggest we ought to take a
> > different approach.
> > 
> > But even with that; I wonder if the actual condition isn't wrong.
> > Suppose the event was exclusive, and other events weren't scheduled
> > because of that. Then you disable the one exclusive event _and_ kill
> > rotation, so then nothing else will ever get on.
> > 
> > So what I think was supposed to happen is rotation killing itself;
> > rotation will schedule out the context -- which will clear the flag, and
> > then schedule the thing back in -- which will set the flag again when
> > needed.
> > 
> > Now, that isn't happening, and I think I see why, because when we drop
> > to !nr_active, we terminate ctx_sched_out() before we get to clearing
> > the flag, oops!
> > 
> > So how about something like this?
> > 
> > ---
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index e453589da97c..7947bd3271a9 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2182,6 +2182,7 @@ __perf_remove_from_context(struct perf_event *event,
> >   	if (!ctx->nr_events && ctx->is_active) {
> >   		ctx->is_active = 0;
> > +		ctx->rotate_necessary = 0;
> >   		if (ctx->task) {
> >   			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
> >   			cpuctx->task_ctx = NULL;
> 
> 
> The patch can fix the observed problem with uncore PMU.
> But it cannot fix all the cases with core PMU, especially when NMI watchdog
> is enabled.
> Because the ctx->nr_events never be 0 with NMI watchdog enabled.

But, I'm confused.. why do we care about nr_events==0 ? The below: vvvv

> > @@ -3074,15 +3075,15 @@ static void ctx_sched_out(struct perf_event_context *ctx,
> >   	is_active ^= ctx->is_active; /* changed bits */
> > -	if (!ctx->nr_active || !(is_active & EVENT_ALL))
> > -		return;
> > -
> >   	/*
> >   	 * If we had been multiplexing, no rotations are necessary, now no events
> >   	 * are active.
> >   	 */
> >   	ctx->rotate_necessary = 0;
> > +	if (!ctx->nr_active || !(is_active & EVENT_ALL))
> > +		return;
> > +
> >   	perf_pmu_disable(ctx->pmu);
> >   	if (is_active & EVENT_PINNED) {
> >   		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)

Makes sure we clear the flag when we ctx_sched_out(), and as long as
ctx->rotate_necessary is set, perf_rotate_context() will do exactly
that.

Then ctx_sched_in() will re-set the flag if it failed to schedule a
counter.

So where is that going wrong?
