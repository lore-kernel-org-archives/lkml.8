Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DBAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6CFF20758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e+hvs8n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgEOMwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgEOMwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:52:12 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7329FC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z+Jyvc8F629bU/MQ39LYHqG/QpmGLVqISbuPj5aTL40=; b=e+hvs8n9Dg9ggBJp+KqoFUET0H
        TE7G3GkwOLilDJKeaCbMjHlSL/D5ETMzqn5faToSoSfVKXLEbhNwFxZ2GdvmS7bK57wwnv3k3YjTd
        xb3xecfKQu76MkGdigffM/5uD7RKKuu9OsrBHSooYg1zopCrW1AXz6BM1eCEMSYCiLgywFGsK4FRa
        ixsxT/5DUJzfnqiBRWHKLZY9GujDwK5J01IY5XxQjoD/q8lteWYIFvoEKhhufhKZYK5Jpl5xluVDY
        Klbqyt4n7yKOOSqvLgzfTShfW2LPWcRQM02qJaxEAfTedDlNEACPqsLE7v4uE7iec0Z4xaMezSp3z
        9kAbxyDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZZoK-0008NQ-0Q; Fri, 15 May 2020 12:51:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 86A4B300261;
        Fri, 15 May 2020 14:51:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 71825202E0F9C; Fri, 15 May 2020 14:51:28 +0200 (CEST)
Date:   Fri, 15 May 2020 14:51:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jirka Hladky <jhladky@redhat.com>, Phil Auld <pauld@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200515125128.GU2957@hirez.programming.kicks-ass.net>
References: <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <20200514153122.GE2978@hirez.programming.kicks-ass.net>
 <20200515084740.GJ3758@techsingularity.net>
 <20200515112815.GT2957@hirez.programming.kicks-ass.net>
 <20200515122231.GL3758@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515122231.GL3758@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 01:22:31PM +0100, Mel Gorman wrote:
> On Fri, May 15, 2020 at 01:28:15PM +0200, Peter Zijlstra wrote:

> > > +			if (val & _TIF_POLLING_NRFLAG)
> > > +				goto activate;
> > 
> > I'm completely confused... the result here is that if you're polling you
> > do _NOT_ queue on the wake_list, but instead immediately enqueue.
> > 
> > (which kinda makes sense, since if the remote CPU is idle, it doesn't
> > have these lines in its cache anyway)
> > 
> 
> Crap, I rushed this and severely confused myself about what is going

Hehe, and here I though I was confused :-)

> on. It is definitely the case that flipping this check does not give
> any benefit. The patch shows a benefit but I'm failing to understand
> exactly why. How I ended up here was perf indicating a lot of time spent
> on smp_cond_load_acquire() which made me look closely at ttwu_remote()
> and looking at function graphs to compare the different types of wakeups
> and their timings.

So the raisin we did this remote wakeup thing in the first place was
that Oracle was having very heavy rq->lock cache-line contention. By
farming off the enqueue to the CPU that was going to run the task
anyway, the rq->lock (and the other runqueue structure lines) could stay
in the CPU that was using them (hard). Less cacheline ping-pong, more
win.

The observation here is that if a CPU is idle, it's rq will not be
contended.
