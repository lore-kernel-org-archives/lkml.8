Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BCCC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6A820873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgBLQEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:04:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:33266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbgBLQEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:04:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ADFA7AE84;
        Wed, 12 Feb 2020 16:04:34 +0000 (UTC)
Date:   Wed, 12 Feb 2020 16:04:31 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [RFC 2/4] sched/numa: replace runnable_load_avg by load_avg
Message-ID: <20200212160431.GW3420@suse.de>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-3-vincent.guittot@linaro.org>
 <20200212133715.GU3420@suse.de>
 <CAKfTPtAJE_eDgR8dmScgVbOgS9sQSJg27Mw62Z1htMCmgN_Yew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtAJE_eDgR8dmScgVbOgS9sQSJg27Mw62Z1htMCmgN_Yew@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 04:03:28PM +0100, Vincent Guittot wrote:
> > Ok, so this is essentially group_is_overloaded.
> >
> >
> > > +     if ((ns->nr_running < ns->weight) ||
> > > +         ((ns->compute_capacity * 100) > (ns->util * imbalance_pct)))
> > > +             return node_has_spare;
> > > +
> >
> > And this is group_has_capacity. What I did was have a common helper
> > for both NUMA and normal load balancing and translated the fields from
> > sg_lb_stats and numa_stats into a common helper. This is to prevent them
> > getting out of sync. The conversion was incomplete in my case but in
> > principle, both NUMA and CPU load balancing should use common helpers or
> > they'll get out of sync.
> 
> I fact, I wanted to keep this patch simple and readable for the 1st
> version in order to not afraid people from reviewing it. That's the
> main reason I didn't merge it with load_balance but i agree that some
> common helper function might be possible.
> 

Makes sense.

> Also the struct sg_lb_stats has a lot more fields compared to struct numa_stats
> 

Yes, I considered reusing the same structure and decided against it. I
simply created a common helper. It's trivial enough to do on top after
the fact in the name of clarity. Fundamentally it's cosmetic.

> Then, I wonder if we could end up with different rules for numa like
> taking into account some NUMA specifics metrics to classify the node
> 

Well, we could but right now they should be the same. As it is, the NUMA
balancer and load balancer overrule each other. I think the scope for
changing that without causing regressions is limited.

-- 
Mel Gorman
SUSE Labs
