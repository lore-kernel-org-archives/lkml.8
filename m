Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD732C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CEC9207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgH2Mde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 08:33:34 -0400
Received: from foss.arm.com ([217.140.110.172]:41476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgH2Md3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 08:33:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12420101E;
        Sat, 29 Aug 2020 05:33:28 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E818C3F71F;
        Sat, 29 Aug 2020 05:33:26 -0700 (PDT)
References: <6a5f06ff4ecb4f34bd7e9890dc07fb99@hisilicon.com> <422fb2cfe1d24fca8efa74ba23d8754b@hisilicon.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "vincent.guittot\@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann\@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen\@arm.com" <morten.rasmussen@arm.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC] sched/topology: NUMA topology limitations
In-reply-to: <422fb2cfe1d24fca8efa74ba23d8754b@hisilicon.com>
Date:   Sat, 29 Aug 2020 13:33:22 +0100
Message-ID: <jhjpn79ocml.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Barry,

Thanks for having a look!

On 29/08/20 06:32, Barry Song wrote:
>> If you boot the above with CONFIG_SCHED_DEBUG, you'll get:
>>
>> [    0.245896] CPU0 attaching sched-domain(s):
>> [    0.246133]  domain-0: span=0-1 level=NUMA
>> [    0.246592]   groups: 0:{ span=0 cap=1011 }, 1:{ span=1 cap=1008 }
>> [    0.246998]   domain-1: span=0-2 level=NUMA
>> [    0.247145]    groups: 0:{ span=0-1 mask=0 cap=2019 }, 2:{ span=1-3
>> mask=2 cap=3025 }
>> [    0.247454] ERROR: groups don't span domain->span
>
> Hi Valtentin,
> Thanks for your email. It seems it is quite clear. May I ask what is the real harm
> when group 2 is actually out of the span of diameter 2 here? What will happen when group2
> doesn't span cpu0_domain1->span?
> In domain-1, will scheduler fail to do load balance between group0 and group2?
>
>> [    0.247654]    domain-2: span=0-3 level=NUMA
>> [    0.247892]     groups: 0:{ span=0-2 mask=0 cap=3021 }, 3:{ span=1-3
>> mask=3 cap=3047 }
>
> Here domain-2 includes all span from 0 to 3, so that means we should still be able to do
> load balance in domain-2 between cpu0 and cpu3 even we fail in domain-1?
>

[...]

>> Implications of fixing this
>> ---------------------------
>>
>> Clearly the current sched_group setup for such topologies is not what we
>> want: this disturbs load balancing on the 'corrupted' domains.
>>
>> If we *do* want to support systems like this, then we have other problems to
>> solve. Currently, on the aforementioned QEMU setup, we have:
>>
>>   CPU0-domain1
>>     group0: span=0-2, mask=0
>>     group2: span=1-3, mask=2
>
> Your kernel log is:
> [    0.246998]   domain-1: span=0-2 level=NUMA
> [    0.247145]    groups: 0:{ span=0-1 mask=0 cap=2019 }, 2:{ span=1-3
> mask=2 cap=3025 }
>
> it seems group0 should be:
> group0: span=0-1, mask=0
>
> but not
> group0: span=0-2, mask=0 ?
>
> is it a typo here?
>

It is indeed, well spotted.

[...]

>
> What is the real harm you have seen in load balance? Have you even tried
> to make cpu0,cpu1,cpu2 busy and wake-up more tasks in cpu0? Will cpu3
> join to share the loading in your qemu topology?
>

(pasting the comment from your other email here)

> After second thought, would the harm be that scheduler should do load balance
> among cpu0, cpu1 and cpu2 in domain1, but it is actually doing load balance
> among all of cpu0, cpu1, cpu2 and cpu3 since cpu3 is incorrectly put in group2?
> So it is possible that scheduler will make wrong decision to put tasks in cpu3 while
> it actually should only begin to do that in domain2?

Ignoring corner cases where task affinity gets in the way, load balance
will always pull tasks to the local CPU (i.e. the CPU who's sched_domain we
are working on).

If we're balancing load for CPU0-domain1, we would be looking at which CPUs
in [0-2] (i.e. the domain's span) we could (if we should) pull tasks from
to migrate them over to CPU0.

We'll first try to figure out which sched_group has the more load (see
find_busiest_group() & friends), and that's where we may hit issues.

Consider a scenario where CPU3 is noticeably busier than the other
CPUs. We'll end up marking CPU0-domain1-group2 (1-3) as the busiest group,
and compute an imbalance (i.e. amount of load to pull) mostly based on the
status of CPU3.

We'll then go to find_busiest_queue(); the mask of CPUs we iterate over is
restricted by the sched_domain_span (i.e. doesn't include CPU3 here), so
we'll pull things from either CPU1 or CPU2 based on stats we built looking
at CPU3, which is bound to be pretty bogus.

To summarise: we won't pull from the "outsider" node(s) (i.e., nodes
included in the sched_groups but not covered by the sched_domain), but they
will influence the stats and heuristics of the load balance.

HTH
