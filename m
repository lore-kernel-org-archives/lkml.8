Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78460C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B46020693
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHaKpo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:45:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3147 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726248AbgHaKpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:45:42 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 52E172045769F2B465DF;
        Mon, 31 Aug 2020 18:45:39 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 31 Aug 2020 18:45:30 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 31 Aug 2020 18:45:30 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Mon, 31 Aug 2020 18:45:30 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC] sched/topology: NUMA topology limitations
Thread-Topic: [RFC] sched/topology: NUMA topology limitations
Thread-Index: AdZ9wnXtzQTRsfy/TeONv+XCq4dqYgAACfmw///10gD//H0PoA==
Date:   Mon, 31 Aug 2020 10:45:30 +0000
Message-ID: <f9c1012800844c5dbaa049e05006c131@hisilicon.com>
References: <6a5f06ff4ecb4f34bd7e9890dc07fb99@hisilicon.com>
 <422fb2cfe1d24fca8efa74ba23d8754b@hisilicon.com> <jhjpn79ocml.mognet@arm.com>
In-Reply-To: <jhjpn79ocml.mognet@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> Sent: Sunday, August 30, 2020 12:33 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: linux-kernel@vger.kernel.org; Ingo Molnar <mingo@kernel.org>; Peter
> Zijlstra <peterz@infradead.org>; vincent.guittot@linaro.org;
> dietmar.eggemann@arm.com; morten.rasmussen@arm.com; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [RFC] sched/topology: NUMA topology limitations
> 
> 
> Hi Barry,
> 
> Thanks for having a look!
> 
> On 29/08/20 06:32, Barry Song wrote:
> >> If you boot the above with CONFIG_SCHED_DEBUG, you'll get:
> >>
> >> [    0.245896] CPU0 attaching sched-domain(s):
> >> [    0.246133]  domain-0: span=0-1 level=NUMA
> >> [    0.246592]   groups: 0:{ span=0 cap=1011 }, 1:{ span=1 cap=1008 }
> >> [    0.246998]   domain-1: span=0-2 level=NUMA
> >> [    0.247145]    groups: 0:{ span=0-1 mask=0 cap=2019 }, 2:{ span=1-3
> >> mask=2 cap=3025 }
> >> [    0.247454] ERROR: groups don't span domain->span
> >
> > Hi Valtentin,
> > Thanks for your email. It seems it is quite clear. May I ask what is the real
> harm
> > when group 2 is actually out of the span of diameter 2 here? What will
> happen when group2
> > doesn't span cpu0_domain1->span?
> > In domain-1, will scheduler fail to do load balance between group0 and
> group2?
> >
> >> [    0.247654]    domain-2: span=0-3 level=NUMA
> >> [    0.247892]     groups: 0:{ span=0-2 mask=0 cap=3021 },
> 3:{ span=1-3
> >> mask=3 cap=3047 }
> >
> > Here domain-2 includes all span from 0 to 3, so that means we should still be
> able to do
> > load balance in domain-2 between cpu0 and cpu3 even we fail in domain-1?
> >
> 
> [...]
> 
> >> Implications of fixing this
> >> ---------------------------
> >>
> >> Clearly the current sched_group setup for such topologies is not what we
> >> want: this disturbs load balancing on the 'corrupted' domains.
> >>
> >> If we *do* want to support systems like this, then we have other problems
> to
> >> solve. Currently, on the aforementioned QEMU setup, we have:
> >>
> >>   CPU0-domain1
> >>     group0: span=0-2, mask=0
> >>     group2: span=1-3, mask=2
> >
> > Your kernel log is:
> > [    0.246998]   domain-1: span=0-2 level=NUMA
> > [    0.247145]    groups: 0:{ span=0-1 mask=0 cap=2019 }, 2:{ span=1-3
> > mask=2 cap=3025 }
> >
> > it seems group0 should be:
> > group0: span=0-1, mask=0
> >
> > but not
> > group0: span=0-2, mask=0 ?
> >
> > is it a typo here?
> >
> 
> It is indeed, well spotted.
> 
> [...]
> 
> >
> > What is the real harm you have seen in load balance? Have you even tried
> > to make cpu0,cpu1,cpu2 busy and wake-up more tasks in cpu0? Will cpu3
> > join to share the loading in your qemu topology?
> >
> 
> (pasting the comment from your other email here)
> 
> > After second thought, would the harm be that scheduler should do load
> balance
> > among cpu0, cpu1 and cpu2 in domain1, but it is actually doing load balance
> > among all of cpu0, cpu1, cpu2 and cpu3 since cpu3 is incorrectly put in
> group2?
> > So it is possible that scheduler will make wrong decision to put tasks in cpu3
> while
> > it actually should only begin to do that in domain2?
> 
> Ignoring corner cases where task affinity gets in the way, load balance
> will always pull tasks to the local CPU (i.e. the CPU who's sched_domain we
> are working on).
> 
> If we're balancing load for CPU0-domain1, we would be looking at which CPUs
> in [0-2] (i.e. the domain's span) we could (if we should) pull tasks from
> to migrate them over to CPU0.
> 
> We'll first try to figure out which sched_group has the more load (see
> find_busiest_group() & friends), and that's where we may hit issues.
> 
> Consider a scenario where CPU3 is noticeably busier than the other
> CPUs. We'll end up marking CPU0-domain1-group2 (1-3) as the busiest group,
> and compute an imbalance (i.e. amount of load to pull) mostly based on the
> status of CPU3.
> 
> We'll then go to find_busiest_queue(); the mask of CPUs we iterate over is
> restricted by the sched_domain_span (i.e. doesn't include CPU3 here), so
> we'll pull things from either CPU1 or CPU2 based on stats we built looking
> at CPU3, which is bound to be pretty bogus.
> 
> To summarise: we won't pull from the "outsider" node(s) (i.e., nodes
> included in the sched_groups but not covered by the sched_domain), but they
> will influence the stats and heuristics of the load balance.

Hi Valentin,
Thanks for your clarification. For many scenarios, to achieve good performance, people would
pin processes in numa node. So the priority to pin would be local node first, then domain0 with one hop. Domain1
with two hops is actually too far. Domain2 with three hops would be a disaster. If cpu0 pulls task from cpu2,
but memory is still one CPU2's node, 3 hops would be a big problem for memory access and page migration.

However, for automatic numa balance, I would agree we need to fix the groups layout to make groups
stay in the span of sched_domain. Otherwise, it seems the scheduler is running incorrectly to find the right
cpu to pull task.

In case we have 
0 task on cpu0
1 task on cpu1
1 task on cpu2
4 task on cpu3

In sched_domain1, cpu1+cpu3 is busy, so cpu0 would try to pull task from cpu2 of the group(1-3) because cpu3 is busy,
meanwhile, it is an outsider.

Thanks
Barry
