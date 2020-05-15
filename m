Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB02C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4280A206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yJJR0pMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgEONNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgEONNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:13:31 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A07C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 06:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yfKPxko55jufmY0xy3S8W87THENHzmg1dUd7YFjxF4E=; b=yJJR0pMtsCZqYTPsfQocCBO78z
        EhpRZyVKSf5IlEaU4swzxO4zwPkmOdXycBPpfOHsqsdTUWu2RywnuI4lDiZCOhJ1Sgk5qwKVYhjGJ
        sHkHMoUn1+J6X3/hQX8ARJfMhU45IzBJbldCMQ9wKxnfa01WvOagEsp0Ge1D5xV0D5UBN1aHH8Xs2
        R4/2FrVT/wYlU13jajtTK2pYHYEVywe2Z3ADy8KVcUHvkZAAVex8aZAWII5YUI1nTC5aWBs36b3Dw
        NM1JTH9gOiMWzeYRHG1tnxv4l4xiH4itsz8XKoe/i7EJZOHZnh9rhNU2ARJcanB7sAxsMQc/wwU+t
        cJnNgFBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZa8n-0000ad-1i; Fri, 15 May 2020 13:12:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39315302753;
        Fri, 15 May 2020 15:12:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C2A320267E67; Fri, 15 May 2020 15:12:39 +0200 (CEST)
Date:   Fri, 15 May 2020 15:12:39 +0200
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
Message-ID: <20200515131239.GX2957@hirez.programming.kicks-ass.net>
References: <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <20200514153122.GE2978@hirez.programming.kicks-ass.net>
 <20200515084740.GJ3758@techsingularity.net>
 <20200515111732.GS2957@hirez.programming.kicks-ass.net>
 <20200515130346.GM3758@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515130346.GM3758@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:03:46PM +0100, Mel Gorman wrote:
> On Fri, May 15, 2020 at 01:17:32PM +0200, Peter Zijlstra wrote:
> > On Fri, May 15, 2020 at 09:47:40AM +0100, Mel Gorman wrote:
> > +static bool ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
> > +{
> > +	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
> > +		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
> > +		__ttwu_queue_remote(p, cpu, wake_flags);
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}

> > +	if (READ_ONCE(p->on_cpu) && __ttwu_queue_remote(p, cpu, wake_flags))
> > +		goto unlock;

> I don't see a problem with moving the updating of p->state to the other
> side of the barrier but I'm relying on the comment that the barrier is
> only related to on_rq and on_cpu.

Yeah, I went with that too, like I said, didn't think too hard.

> However, I'm less sure about what exactly you intended to do.
> __ttwu_queue_remote is void so maybe you meant to use ttwu_queue_remote.

That!

> In that case, we potentially avoid spinning on on_rq for wakeups between
> tasks that do not share CPU but it's not clear why it would be specific to
> remote tasks.

The thinking was that we can avoid spinning on ->on_cpu, and let the CPU
get on with things. Rik had a workload where that spinning was
significant, and I thought to have understood you saw the same.

By sticking the task on the wake_list of the CPU that's in charge of
clearing ->on_cpu we ensure ->on_cpu is 0 by the time we get to doing
the actual enqueue.

