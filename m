Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D63C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3164A20771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wCTiXBd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgGOP7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgGOP66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:58:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDB3C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ExYAFJz0ZBBS/XgvHstTQZzss3nPH5mMu89RC/YVoN8=; b=wCTiXBd6+q4YP6aP6mI/GlWlPK
        C+hOQUbCsWTrv4X6QcK9PZKFXY/Spa6bpc+LqgeExYuEHt9Z+wkYfCupJgIUt5K89fSVgumWhxaNe
        9fbVJYiic6qSuqrhNBxvFQfpqdGhbgk5xWy0gySZpSFmjhSKt7iWT11Z44uPtItYINwDawFs2zmUq
        arohuRR5axkHHBmW9la7RsSJYFYce4x06P0T7C7JuvJe3A7TFJ4zGKuscSb1u1KwuliP1UxJko73N
        OgGDjsa3IEIJA0qw5qmECdYuUFI+f1Q2V+5fmJLE8O496PjE0kmf49h2E4rFrZUtQuBnASLJvv0Lg
        6lmxOlgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvjo6-0007t7-6Q; Wed, 15 Jul 2020 15:58:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39B83300446;
        Wed, 15 Jul 2020 17:58:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C83920D27ABC; Wed, 15 Jul 2020 17:58:50 +0200 (CEST)
Date:   Wed, 15 Jul 2020 17:58:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        John Ogness <jogness@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] time/sched_clock: Use raw_read_seqcount_latch()
Message-ID: <20200715155850.GL10769@hirez.programming.kicks-ass.net>
References: <20200715095220.GH10769@hirez.programming.kicks-ass.net>
 <20200715115901.515956-1-a.darwish@linutronix.de>
 <20200715152926.GA16686@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715152926.GA16686@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:29:26PM +0800, Leo Yan wrote:
> Hi Peter, Ahmed,
> 
> On Wed, Jul 15, 2020 at 01:59:01PM +0200, Ahmed S. Darwish wrote:
> > sched_clock uses seqcount_t latching to switch between two storage
> > places protected by the sequence counter. This allows it to have
> > interruptible, NMI-safe, seqcount_t write side critical sections.
> > 
> > Since 7fc26327b756 ("seqlock: Introduce raw_read_seqcount_latch()"),
> > raw_read_seqcount_latch() became the standardized way for seqcount_t
> > latch read paths. Due to the dependent load, it also has one read
> > memory barrier less than the currently used raw_read_seqcount() API.
> > 
> > Use raw_read_seqcount_latch() for the seqcount_t latch read path.
> > 
> > Link: https://lkml.kernel.org/r/20200625085745.GD117543@hirez.programming.kicks-ass.net
> > Link: https://lkml.kernel.org/r/20200715092345.GA231464@debian-buster-darwi.lab.linutronix.de
> > References: 1809bfa44e10 ("timers, sched/clock: Avoid deadlock during read from NMI")
> > Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> > ---
> >  kernel/time/sched_clock.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> > index fa3f800d7d76..ea007928d681 100644
> > --- a/kernel/time/sched_clock.c
> > +++ b/kernel/time/sched_clock.c
> > @@ -100,7 +100,7 @@ unsigned long long notrace sched_clock(void)
> >  	struct clock_read_data *rd;
> > 
> >  	do {
> > -		seq = raw_read_seqcount(&cd.seq);
> > +		seq = raw_read_seqcount_latch(&cd.seq);
> 
> Understand this is doing the same thing with __ktime_get_fast_ns() and
> I saw Peter acked to make change for this.
> 
> Just want to confirm, since this patch introduces conflict with the
> patch set "arm64: perf: Proper cap_user_time* support" [1], I should
> rebase the patch set on top of this patch, right?

Or rebase this patch on top of yours and include it, either way.
