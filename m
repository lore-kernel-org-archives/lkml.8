Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD369C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D7B2071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pq/NRTih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgICHnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgICHm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:42:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206B2C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 00:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z2zwM95IPgkBTO4Wu24eSib0PZAEqyn1hWAVi1nsOs4=; b=Pq/NRTihLN/0dCTzX1OI9MU8Qn
        c7PIiE+l3F9wOM/AQkH8r7vCZZDIn2pgJujY8OAsPkbl1cAYeNtnzn910H5Lauzz6gK4ERMWEdN07
        Z1Moel7PFytIenNbJXLvy/iWlmWdJdOvLgks4SThyuUvVQrWnyMZwh8jgp184HTwGeT0NTFw/rCxR
        kTsXLip0/2mcSutpCXqraZS2RTv3bHM+Cuupd3aTw8wqqsiZdZn6foENJTufF4RmUmeyFCngbflke
        /BtCV4Kn5ardkZlq1n3CPuas2YOegYcX94hZc+NNMtbWc7Tv3ElQfYGxqmhyLlvwmKCX2tRaIHqOf
        ifvAjQpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDjtB-0005Px-VY; Thu, 03 Sep 2020 07:42:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D6843012DF;
        Thu,  3 Sep 2020 09:42:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39B922BA41930; Thu,  3 Sep 2020 09:42:32 +0200 (CEST)
Date:   Thu, 3 Sep 2020 09:42:32 +0200
From:   peterz@infradead.org
To:     gengdongjiu <gengdongjiu@huawei.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "thara.gopinath@linaro.org" <thara.gopinath@linaro.org>,
        "pauld@redhat.com" <pauld@redhat.com>,
        "vincent.donnefort@arm.com" <vincent.donnefort@arm.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?UkXvvJpbUEFUQ0hdIHNjaGVk?= =?utf-8?Q?=3A?= Add trace
 for task wake up latency and leave running time
Message-ID: <20200903074232.GW1362448@hirez.programming.kicks-ass.net>
References: <6995260be2ca4fd18bc773fe9f50f420@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6995260be2ca4fd18bc773fe9f50f420@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 10:35:34PM +0000, gengdongjiu wrote:

> > NAK, that tracepoint is already broken, we don't want to proliferate the broken.
>   
> Sorry, What the meaning that tracepoint is already broken? 

Just that, the tracepoint is crap. But we can't fix it because ABI. Did
I tell you I utterly hate tracepoints?

> Maybe I need to explain the reason that why I add two trace point. 
> when using perf tool or Ftrace sysfs to capture the task wake-up latency and the task leaving running queue time, usually the trace data is too large and the CPU utilization rate is too high in the process due to a lot of disk write. Sometimes even the disk is full, the issue still does not reproduced that above two time exceed a certain threshold.  So I added two trace points, using filter we can only record the abnormal trace that includes wakeup latency and leaving running time larger than an threshold. 
> Or do you have better solution?

Learn to use a MUA and wrap your lines at 78 chars like normal people.

Yes, use ftrace synthetic events, or bpf or really anything other than
this.

> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c index
> > > 8471a0f7eb32..b5a1928dc948 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -2464,6 +2464,8 @@ static void ttwu_do_wakeup(struct rq *rq, struct
> > > task_struct *p, int wake_flags,  {
> > >  	check_preempt_curr(rq, p, wake_flags);
> > >  	p->state = TASK_RUNNING;
> > > +	p->ts_wakeup = local_clock();
> > > +	p->wakeup_state = true;
> > >  	trace_sched_wakeup(p);
> > >
> > >  #ifdef CONFIG_SMP
> > 
> > NAK, userless overhead.
> 
>  When sched switch, we do not know the next task previous state and
>  wakeup timestamp, so I record the task previous state if it is waken
>  from sleep.  And then it can calculate the wakeup latency when task
>  switch.

I don't care. You're making things slower.
