Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A654FC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A9D21D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgBRIr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:47:56 -0500
Received: from outbound-smtp06.blacknight.com ([81.17.249.39]:36934 "EHLO
        outbound-smtp06.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbgBRIrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:47:55 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp06.blacknight.com (Postfix) with ESMTPS id 0DEB498B43
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 08:47:53 +0000 (GMT)
Received: (qmail 31332 invoked from network); 18 Feb 2020 08:47:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Feb 2020 08:47:52 -0000
Date:   Tue, 18 Feb 2020 08:47:50 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/13] sched/numa: Use similar logic to the load balancer
 for moving between domains with spare capacity
Message-ID: <20200218084750.GM3466@techsingularity.net>
References: <20200217104402.11643-1-mgorman@techsingularity.net>
 <20200217132019.6684-1-hdanton@sina.com>
 <20200218033244.6860-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200218033244.6860-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 11:32:44AM +0800, Hillf Danton wrote:
> 
> On Mon, 17 Feb 2020 15:06:15 +0000 Mel Gorman wrote:
> > On Mon, Feb 17, 2020 at 09:20:19PM +0800, Hillf Danton wrote:
> > > >  	/*
> > > > -	 * If the improvement from just moving env->p direction is better
> > > > -	 * than swapping tasks around, check if a move is possible.
> > > > +	 * If dst node has spare capacity, then check if there is an
> > > > +	 * imbalance that would be overruled by the load balancer.
> > > >  	 */
> > > > -	maymove = !load_too_imbalanced(src_load, dst_load, env);
> > > > +	if (env->dst_stats.node_type == node_has_spare) {
> > > 
> > > so maymove should be true here.
> > > 
> > 
> > Performance suffers on numerous workloads that way.
> > 
> Suspect you are meaning something like
> 
> 		maymove = adjust_numa_imbalance(true,
> 						env->src_stats.nr_running);
> 
> given dst node's spare capacity.
> 

Given that adjust_numa_imbalance takes the imbalance as the first
parameter, not a boolean and it's not unconditionally true, I don't
get what you mean. Can you propose a patch on top of the entire series
explaining what you suggest please?

> > > > +		unsigned int imbalance;
> > > > +		int src_running, dst_running;
> > > > +
> > > > +		/* Would movement cause an imbalance? */
> > > > +		src_running = env->src_stats.nr_running - 1;
> > > > +		dst_running = env->dst_stats.nr_running + 1;
> > > > +		imbalance = max(0, dst_running - src_running);
> > > > +		imbalance = adjust_numa_imbalance(imbalance, src_running);
> > > > +
> > > The imbalance could be ignored if src domain is idle enough, and no move
> > > could be expected.
> > > 
> > 
> > Again, it hits corner cases. While there is scope for allowing some
> > degree of imbalance, it needs to be a separate patch on top of this.
> > It's something I intend to examine but only once this series is out of
> > the way because the NUMA and load balancer do need to be using similar
> > logic first or it gets a bit fragile.
> > 
> Add this to log or comment.
> 

It's somewhat codified by the general comment "Would movement cause an
imbalance?". The hint is that any change in the NUMA balancer should check
whether it is in conflict with the load balancer. Being specific runs the
risk that the comment gets stale which may be dangerously misleading if
it's later wrong and a developer trusts the comment instead of checking the
code. Generally I do try to explain fully what is happening in comments but
this is a case where I really want developers to check the load balancer
code if they are updating the NUMA balancer.

> > With this patch, and the series in general, it does mean that some tasks
> > fail to migrate to a CPU local to the memory being accessed even though
> > there are CPUs available but having the NUMA balancer and load balancer
> > override each other is not free either.
> >
>
> Ditto
> 

I can update the changelog if there is a v4 release, right now there are
no substantial changes suggested by review. That may change depending on
other review feedback and what you think the call to adjust_numa_imbalance
should look like. Also bear in mind that the changelog wil become stale
if/when adjust_numa_imbalance is altered to allow a small imbalance between
NUMA nodes. While I plan to do that, this series should be finalised first.

-- 
Mel Gorman
SUSE Labs
