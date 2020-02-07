Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB608C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD3920720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tWIyT3JC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBGNIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:08:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBGNIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ifUoH7dK4vhbVULGfnT7B07fxu23LKdoHciUnJ/81OM=; b=tWIyT3JCCa9A/h8MkBFEaYMrO0
        jeiqV5T2zOf87Xjy4kfoHHjmynYmyoCQBYHHDovtHspoD+VX0dA2HCkm1yq+CH0AClp1GXSHuHNO+
        UdwIldwY+bo9bC9NTUwIIRGy+0MT34Sn9xOP4FItWna91w5/QURoOQwNmaJPriXmG5lkz0Zg9BmV2
        Evb8nMvqlIrHmsjOC7YkgETvbSrd8HT7Ul2qQM6JONNddQ44iosjxHLRjRQ70lYfpEKCMau8dPqL8
        r4TVbDdjuLIh/dDbOX6xNI7WeObxJDuxj263rgQtBbKA9+V5w3cYEXeDR7UWcvgr93kCd7lsq35WG
        BBToEz4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j03N2-000353-JL; Fri, 07 Feb 2020 13:08:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 223F5305EEC;
        Fri,  7 Feb 2020 14:06:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C950A2032662D; Fri,  7 Feb 2020 14:08:29 +0100 (CET)
Date:   Fri, 7 Feb 2020 14:08:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: Lower than expected CPU pressure in PSI
Message-ID: <20200207130829.GG14897@hirez.programming.kicks-ass.net>
References: <CABWYdi25Y=zrfdnitT3sSgC3UqcFHfz6-N2YP7h2TJai=JH_zg@mail.gmail.com>
 <20200109161632.GB8547@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109161632.GB8547@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 11:16:32AM -0500, Johannes Weiner wrote:
> On Wed, Jan 08, 2020 at 11:47:10AM -0800, Ivan Babrou wrote:
> > We added reporting for PSI in cgroups and results are somewhat surprising.
> > 
> > My test setup consists of 3 services:
> > 
> > * stress-cpu1-no-contention.service : taskset -c 1 stress --cpu 1
> > * stress-cpu2-first-half.service    : taskset -c 2 stress --cpu 1
> > * stress-cpu2-second-half.service   : taskset -c 2 stress --cpu 1
> > 
> > First service runs unconstrained, the other two compete for CPU.
> > 
> > As expected, I can see 500ms/s sched delay for the latter two and
> > aggregated 1000ms/s delay for /system.slice, no surprises here.
> > 
> > However, CPU pressure reported by PSI says that none of my services
> > have any pressure on them. I can see around 434ms/s pressure on
> > /unified/system.slice and 425ms/s pressure on /unified cgroup, which
> > is surprising for three reasons:
> > 
> > * Pressure is absent for my services (I expect it to match scheed delay)
> > * Pressure on /unified/system.slice is lower than both 500ms/s and 1000ms/s
> > * Pressure on root cgroup is lower than on system.slice
> 
> CPU pressure is currently implemented based only on the number of
> *runnable* tasks, not on who gets to actively use the CPU. This works
> for contention within cgroups or at the global scope, but it doesn't
> correctly reflect competition between cgroups. It also doesn't show
> the effects of e.g. cpu cycle limiting through cpu.max where there
> might *be* only one runnable task, but it's not getting the CPU.
> 
> I've been working on fixing this, but hadn't gotten around to sending
> the patch upstream. Attaching it below. Would you mind testing it?
> 
> Peter, what would you think of the below?

I'm not loving it; but I see what it does and I can't quickly see an
alternative.

My main gripe is doing even more of those cgroup traversals.

One thing pick_next_task_fair() does is try and limit the cgroup
traversal to the sub-tree that contains both prev and next. Not sure
that is immediately applicable here, but it might be worth looking into.
