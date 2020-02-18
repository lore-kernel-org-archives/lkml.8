Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC54C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804A624677
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgBRRlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:41:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:34252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgBRRlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:41:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AC980ADAA;
        Tue, 18 Feb 2020 17:41:22 +0000 (UTC)
Date:   Tue, 18 Feb 2020 17:41:19 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, hdanton@sina.com
Subject: Re: [PATCH v2 2/5] sched/numa: Replace runnable_load_avg by load_avg
Message-ID: <20200218174119.GG3420@suse.de>
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-3-vincent.guittot@linaro.org>
 <b67ae78b-17ba-8f3f-9052-fecefb848e3d@arm.com>
 <20200218153801.GF3420@suse.de>
 <e28bb567-dade-877b-f338-ce87e28cc02d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e28bb567-dade-877b-f338-ce87e28cc02d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:50:48PM +0000, Valentin Schneider wrote:
> On 18/02/2020 15:38, Mel Gorman wrote:
> >>
> >> Could we reuse group_type instead? The definitions are the same modulo
> >> s/group/node/.
> >>
> > 
> > I kept the naming because there is the remote possibility that NUMA
> > balancing will deviate in some fashion. Right now, it's harmless.
> > 
> 
> Since it's just a subset ATM I'd go for the reuse and change that later if
> shown a split is required, but fair enough.
> 

I would feel that I was churning code for the sake of it.

> > I didn't merge that part of the first version of my series. I was
> > waiting to see how the implementation for allowing a small degree of
> > imbalance looks like. If it's entirely confined in adjust_numa_balance
>                                                      ^^^^^^^^^^^^^^^^^^^
> Apologies if that's a newbie question, but I'm not familiar with that one.
> Would that be added in your reconciliation series? I've only had a brief
> look at it yet (it's next on the chopping block).
> 

I should have wrote adjust_numa_imbalance but yes, it's part of the
reconciled series so that NUMA balancing and the load balancer use the
same helper.

> > Yikes, no I'd rather not do that. Basically all I did before was create
> > a common helper like __lb_has_capacity that only took basic types as
> > parameters. group_has_capacity and numa_has_capacity were simple wrappers
> > that read the correct fields from their respective stats structures.
> > 
> 
> That's more sensible indeed. It'd definitely be nice to actually reconcile
> the two balancers with these common helpers, though I guess it doesn't
> *have* to happen with this very patch.

Yep, it can happen at a later time.

As it stands, I think the reconciled series stands on its own even
though there are further improvements that could be built on top.

-- 
Mel Gorman
SUSE Labs
