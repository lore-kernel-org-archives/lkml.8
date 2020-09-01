Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55287C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373E3206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgIAJkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:40:52 -0400
Received: from foss.arm.com ([217.140.110.172]:39468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgIAJkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:40:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B51D730E;
        Tue,  1 Sep 2020 02:40:50 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99F163F71F;
        Tue,  1 Sep 2020 02:40:49 -0700 (PDT)
References: <6a5f06ff4ecb4f34bd7e9890dc07fb99@hisilicon.com> <422fb2cfe1d24fca8efa74ba23d8754b@hisilicon.com> <jhjpn79ocml.mognet@arm.com> <f9c1012800844c5dbaa049e05006c131@hisilicon.com>
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
In-reply-to: <f9c1012800844c5dbaa049e05006c131@hisilicon.com>
Date:   Tue, 01 Sep 2020 10:40:47 +0100
Message-ID: <jhjmu29omw0.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/08/20 11:45, Barry Song wrote:
>> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
>>
>> Ignoring corner cases where task affinity gets in the way, load balance
>> will always pull tasks to the local CPU (i.e. the CPU who's sched_domain we
>> are working on).
>>
>> If we're balancing load for CPU0-domain1, we would be looking at which CPUs
>> in [0-2] (i.e. the domain's span) we could (if we should) pull tasks from
>> to migrate them over to CPU0.
>>
>> We'll first try to figure out which sched_group has the more load (see
>> find_busiest_group() & friends), and that's where we may hit issues.
>>
>> Consider a scenario where CPU3 is noticeably busier than the other
>> CPUs. We'll end up marking CPU0-domain1-group2 (1-3) as the busiest group,
>> and compute an imbalance (i.e. amount of load to pull) mostly based on the
>> status of CPU3.
>>
>> We'll then go to find_busiest_queue(); the mask of CPUs we iterate over is
>> restricted by the sched_domain_span (i.e. doesn't include CPU3 here), so
>> we'll pull things from either CPU1 or CPU2 based on stats we built looking
>> at CPU3, which is bound to be pretty bogus.
>>
>> To summarise: we won't pull from the "outsider" node(s) (i.e., nodes
>> included in the sched_groups but not covered by the sched_domain), but they
>> will influence the stats and heuristics of the load balance.
>
> Hi Valentin,
> Thanks for your clarification. For many scenarios, to achieve good performance, people would
> pin processes in numa node. So the priority to pin would be local node first, then domain0 with one hop. Domain1
> with two hops is actually too far. Domain2 with three hops would be a disaster. If cpu0 pulls task from cpu2,
> but memory is still one CPU2's node, 3 hops would be a big problem for memory access and page migration.
>

Did you mean CPU3 here?

> However, for automatic numa balance, I would agree we need to fix the groups layout to make groups
> stay in the span of sched_domain. Otherwise, it seems the scheduler is running incorrectly to find the right
> cpu to pull task.
>
> In case we have
> 0 task on cpu0
> 1 task on cpu1
> 1 task on cpu2
> 4 task on cpu3
>
> In sched_domain1, cpu1+cpu3 is busy, so cpu0 would try to pull task from cpu2 of the group(1-3) because cpu3 is busy,
> meanwhile, it is an outsider.
>

Right, we'd pull from either CPU1 or CPU2 (in this case via a tentative
active load balance) because they are in the same group as CPU3 which
inflates the sched_group load stats, but we can't pull from it at this
domain because it's not included in the domain span.

> Thanks
> Barry
