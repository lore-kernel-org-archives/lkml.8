Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B283C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA45820674
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCLVrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:47:41 -0400
Received: from outbound-smtp06.blacknight.com ([81.17.249.39]:35894 "EHLO
        outbound-smtp06.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbgCLVrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:47:41 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp06.blacknight.com (Postfix) with ESMTPS id 6CEA9C2B25
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 21:47:39 +0000 (GMT)
Received: (qmail 3454 invoked from network); 12 Mar 2020 21:47:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Mar 2020 21:47:39 -0000
Date:   Thu, 12 Mar 2020 21:47:36 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200312214736.GA3818@techsingularity.net>
References: <20200224095223.13361-1-mgorman@techsingularity.net>
 <20200309191233.GG10065@pauld.bos.csb>
 <20200309203625.GU3818@techsingularity.net>
 <20200312095432.GW3818@techsingularity.net>
 <CAE4VaGA4q4_qfC5qe3zaLRfiJhvMaSb2WADgOcQeTwmPvNat+A@mail.gmail.com>
 <20200312155640.GX3818@techsingularity.net>
 <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 05:54:29PM +0100, Jirka Hladky wrote:
> >
> > find it unlikely that is common because who acquires such a large machine
> > and then uses a tiny percentage of it.
> 
> 
> I generally agree, but I also want to make a point that AMD made these
> large systems much more affordable with their EPYC CPUs. The 8 NUMA node
> server we are using costs under $8k.
> 
> 
> 
> > This is somewhat of a dilemma. Without the series, the load balancer and
> > NUMA balancer use very different criteria on what should happen and
> > results are not stable.
> 
> 
> Unfortunately, I see instabilities also for the series. This is again for
> the sp_C test with 8 threads executed on dual-socket AMD 7351 (EPYC Naples)
> server with 8 NUMA nodes. With the series applied, the runtime varies from
> 86 to 165 seconds! Could we do something about it? The runtime of 86
> seconds would be acceptable. If we could stabilize this case and get
> consistent runtime around 80 seconds, the problem would be gone.
> 
> Do you experience the similar instability of results on your HW for sp_C
> with low thread counts?
> 

I saw something similar but observed that it depended on whether the
worker tasks got spread wide or not which partially came down to luck.
The question is if it's possible to pick a point where we spread wide
and can recover quickly enough when tasks need to remain close without
knowledge of the future. Putting a balancing limit on tasks that
recently woke would be one option but that could also cause persistent
improper balancing for tasks that wake frequently.

> Runtime with this series applied:
>  $ grep "Time in seconds" *log
> sp.C.x.defaultRun.008threads.loop01.log: Time in seconds =
>   125.73
> sp.C.x.defaultRun.008threads.loop02.log: Time in seconds =
>    87.54
> sp.C.x.defaultRun.008threads.loop03.log: Time in seconds =
>    86.93
> sp.C.x.defaultRun.008threads.loop04.log: Time in seconds =
>   165.98
> sp.C.x.defaultRun.008threads.loop05.log: Time in seconds =
>   114.78
> 
> For comparison, here are vanilla kernel results:
> $ grep "Time in seconds" *log
> sp.C.x.defaultRun.008threads.loop01.log: Time in seconds =
>    59.83
> sp.C.x.defaultRun.008threads.loop02.log: Time in seconds =
>    67.72
> sp.C.x.defaultRun.008threads.loop03.log: Time in seconds =
>    63.62
> sp.C.x.defaultRun.008threads.loop04.log: Time in seconds =
>    55.01
> sp.C.x.defaultRun.008threads.loop05.log: Time in seconds =
>    65.20
> 
> 
> 
> > In *general*, I found that the series won a lot more than it lost across
> > a spread of workloads and machines but unfortunately it's also an area
> > where counter-examples can be found.
> 
> 
> OK, fair enough. I understand that there will always be trade-offs when
> making changes to scheduler like this. And I agree that cases with higher
> system load (where is series is helpful) outweigh the performance drops for
> low threads counts. I was hoping that it would be possible to improve the
> small threads results while keeping the gains for other scenarios:-)  But
> let's be realistic - I would be happy to fix the extreme case mentioned
> above. The other issues where performance drop is about 20% are OK with me
> and are outweighed by the gains for different scenarios.
> 

I'll continue thinking about it but whatever chance there is of
improving it while keeping CPU balancing, NUMA balancing and wake affine
consistent with each other, I think there is no chance with the
inconsistent logic used in the vanilla code :(

-- 
Mel Gorman
SUSE Labs
