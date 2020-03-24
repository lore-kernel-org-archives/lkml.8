Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94181C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6999120786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCXLXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:23:47 -0400
Received: from outbound-smtp39.blacknight.com ([46.22.139.222]:58603 "EHLO
        outbound-smtp39.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727124AbgCXLXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:23:47 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id F2A84173A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 11:23:44 +0000 (GMT)
Received: (qmail 25315 invoked from network); 24 Mar 2020 11:23:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Mar 2020 11:23:44 -0000
Date:   Tue, 24 Mar 2020 11:23:42 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Track possibly overloaded domains and
 abort a scan if necessary
Message-ID: <20200324112342.GH3818@techsingularity.net>
References: <20200320151245.21152-1-mgorman@techsingularity.net>
 <20200320151245.21152-5-mgorman@techsingularity.net>
 <CAKfTPtAUuO1Jp6P73gAiP+g5iLTx16UeBgBjm_5zjFxwiBD9=Q@mail.gmail.com>
 <20200320164432.GE3818@techsingularity.net>
 <CAKfTPtBixZKDES_i3Lnsj1eAa_kVi-zHv-0uE8uTsKOBcjmkYg@mail.gmail.com>
 <20200320174304.GF3818@techsingularity.net>
 <CAKfTPtBQ5Y5CAtbJ2YSVxFtQWUVsdxTLjz+NxTHcLj-UnAQWqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBQ5Y5CAtbJ2YSVxFtQWUVsdxTLjz+NxTHcLj-UnAQWqg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:35:08AM +0100, Vincent Guittot wrote:
> > > > It's connected to nohz balancing and I didn't see how I could use that
> > > > for detecting overload. Also, I don't think it ever can be larger than
> > > > the sd weight and overload is based on the number of running tasks being
> > > > greater than the number of available CPUs. Did I miss something obvious?
> > >
> > > IIUC you try to estimate if there is a chance to find an idle cpu
> > > before starting the loop and scanning the domain and abort early if
> > > the possibility is low.
> > >
> > > if nr_busy_cpus equals to sd->span_weight it means that there is no
> > > free cpu so there is no need to scan
> > >
> >
> > Ok, I see what you are getting at but I worry there are multiple
> > problems there. First, the nr_busy_cpus is decremented only when a CPU
> > is entering idle with the tick stopped. If nohz is disabled then this
> > breaks, no? Secondly, a CPU can be idle but the tick not stopped if
> 
> But this can be changed if that make the statistic useful
> 

Hmm, for all cases to track number of running tasks, I think that would
end up being too costly because of the shared cache line.

> > __tick_nohz_idle_stop_tick knows there is an event in the near future
> > so using busy_cpus, we potentially miss a sibling that was adequate
> > for running a task. Finally, the threshold for cutting off the search
> > entirely seems low. The patch marks a domain as overloaded if there are
> > twice as many running tasks as runqueues scanned. In that scenario, even
> > if tasks are rapidly switching between busy/idle, it's still unlikely
> > the task will go idle. When cutting off at just the fully-busy mark, we
> > could miss a CPU that is going idle, almost idle or is running SCHED_IDLE
> > tasks where are acceptable target candidates for select_idle_sibling. I
> > think there are too many cases where nr_busy_cpus are problematic to
> > make it a good alternative.
> 
> I don't really like this patch because it adds yet another metrics and
> yet another feature which is set true by default. Also the current
> proposal seems a bit fragile because it uses an arbitrary ratio of 2
> on an arbitrary number of CPUs. This threshold probably works in your
> case and your system but probably not for others and the threshold
> really looks like a heuristic that works for you but without any real
> meaning.
> 

I have to admit that is a possibility. The really interesting case for
other people is the transition from almost-fully-busy -> fully-busy ->
overloaded because the optimal amount to search changes at those points.
It's a minefield of hitting a regression somewhere whether you search
too much or too little.

It also can be somewhat problematic when there are multiple small llc
caches per numa node. In that case a "full" search is still a small number
of CPUs and premature cutoff can be hurtful. It eventually showed up when
enough tests ran for long enough.

> Then, the update is done at each and every task wake up and by all
> CPUs in the LLC.

I avoided that by only doing the write when there is a state transition.
set_sd_overloaded() does not write if it's already marked overloaded.

> It means that the same variable is updated
> simultaneously by all CPUs: one CPU can set it and the next one might
> clear it immediately because they haven't scanned the same CPUs.

That is possible.

> At
> the end, 2 threads waking up simultaneously on different CPUS, might
> end up using 2 different policy without any other reason than a random
> ordering.
> 

True, but I did not feel the race was extremely damaging because it
happens once per transition for up to sd_weight-1 unlucky tasks. The same
is true for the test for idle cores where multiple tasks can search for
an idle core unnecessarily. Now the search for an idle core can actually
cache one idle candidate it finds. It's a straight-forward patch but it
hurts the fast path when the domain has spare capacity and similar to
the overloaded state, we cannot detect spare capacity in advance.

> I agree that the concept of detecting that a LLC domain is overloaded
> can be useful to decide to skip searching for an idle cpu but this
> proposal seems to be not really generic
> 

Ok, I can dump the patch and think of something else.

Thanks for the review!

-- 
Mel Gorman
SUSE Labs
