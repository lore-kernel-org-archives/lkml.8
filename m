Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88514C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CBCA2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592239544;
	bh=0RD0yWcCVbH5iZJy8aa9w6yRypo5gCdy3LYCxlufcX8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=PhDcQT5ZYTkr6YzOUkHdFEtK2bLZoicNCV+Ar1Qt8nQbcUhoROzLi5O6Y6d/Qik5x
	 8qtLKdOI7Vjvj8xbQVT1MboIXgvQJfqBKONcFH8EOhJxBe2PQtXC77F3zBTijI5ncK
	 WiW9uViPLXIRsVYz94Ib55i+dFoARosDy0x2wbIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgFOQpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:45:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgFOQpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:45:42 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED312067B;
        Mon, 15 Jun 2020 16:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592239541;
        bh=0RD0yWcCVbH5iZJy8aa9w6yRypo5gCdy3LYCxlufcX8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cq05/dIg1PxK0lWi/pgKn6Q8nMKgs+F+gGUfGcDV64G7pVI4E6eiLA8QJ62KT6QqT
         2s8CDoxzpNLgoMauYF8u+lo0cxJb9B4T+MPqykOvNLpq12i0SAZouC/0WQ7+3Kut4D
         G59E3fvZVvdzRxgcipMQXy1L4yrvBY2fWby24ISc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3D0923522EFD; Mon, 15 Jun 2020 09:45:41 -0700 (PDT)
Date:   Mon, 15 Jun 2020 09:45:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org
Subject: Re: [PATCH 1/6] sched: Fix ttwu_queue_cond()
Message-ID: <20200615164541.GH2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200615125654.678940605@infradead.org>
 <20200615131143.130326165@infradead.org>
 <20200615133409.GS2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615133409.GS2531@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 03:34:09PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 15, 2020 at 02:56:55PM +0200, Peter Zijlstra wrote:
> > Where the condition:
> > 
> >   !cpus_share_cache(smp_processor_id(), cpu)
> > 
> > already implies 'cpu != smp_processor_id()', because a CPU always
> > shares cache with itself, the secondary condition added in commit:
> > 
> >   2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")
> > 
> > voids that implication, resulting in attempting to do local wake-ups
> > through the queue mechanism.
> > 
> > Fixes: 2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")
> > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/sched/core.c |   13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2356,11 +2356,22 @@ bool cpus_share_cache(int this_cpu, int
> >  
> >  static inline bool ttwu_queue_cond(int cpu, int wake_flags)
> >  {
> > +	int this_cpu = smp_processor_id();
> > +
> > +	/*
> > +	 * Only ever queue for remote wakeups. The on_cpu case can only ever
> > +	 * happen remotely, and for the normal case it makes no sense to
> 
> The 'funny' thing here is, that this must be false for this patch to
> make any difference.. I just cannot see how.
> 
> Also, if this is false, and p->on_cpu == 1 and p->cpu == this_cpu, then
> p _should_ be current, in which case we should never get here either,
> due to the 'p == current' special case in try_to_wake_up().
> 
> The only other option is that 'p == next', but then we'd be doing
> wakeups from the middle of __schedule() and seems 'unlikely' too, esp.
> so since none of the actual stack-traces we have shows that.
> 
> So colour me terribly confused.

I am rerunning with your patch 2 on the last bisection point that
resulted in scheduler NULL dereferences despite having your patch.
Hopefully some illumination will result...

						Thanx, Paul

> > +	 * involve IPIs here, and would be broken, as many architectures cannot
> > +	 * trivially IPI self in any case.
> > +	 */
> > +	if (cpu == this_cpu)
> > +		return false;
