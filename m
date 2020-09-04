Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C75C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D27302067C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgIDCCb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 22:02:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3085 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728288AbgIDCCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 22:02:30 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 620FFAA1C0EB0BCA423F;
        Fri,  4 Sep 2020 10:02:26 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 4 Sep 2020 10:02:25 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 4 Sep 2020 10:02:25 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Fri, 4 Sep 2020 10:02:26 +0800
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
Thread-Index: AdZ9wnXtzQTRsfy/TeONv+XCq4dqYgAACfmw///10gD//H0PoIAICbeA//tEExA=
Date:   Fri, 4 Sep 2020 02:02:25 +0000
Message-ID: <655f90166c2946bc94ec389645694aa7@hisilicon.com>
References: <6a5f06ff4ecb4f34bd7e9890dc07fb99@hisilicon.com>
 <422fb2cfe1d24fca8efa74ba23d8754b@hisilicon.com> <jhjpn79ocml.mognet@arm.com>
 <f9c1012800844c5dbaa049e05006c131@hisilicon.com> <jhjmu29omw0.mognet@arm.com>
In-Reply-To: <jhjmu29omw0.mognet@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.41]
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
> Sent: Tuesday, September 1, 2020 9:41 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: linux-kernel@vger.kernel.org; Ingo Molnar <mingo@kernel.org>; Peter
> Zijlstra <peterz@infradead.org>; vincent.guittot@linaro.org;
> dietmar.eggemann@arm.com; morten.rasmussen@arm.com; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [RFC] sched/topology: NUMA topology limitations
> 
> 
> On 31/08/20 11:45, Barry Song wrote:
> >> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> >>
> >> Ignoring corner cases where task affinity gets in the way, load balance
> >> will always pull tasks to the local CPU (i.e. the CPU who's sched_domain we
> >> are working on).
> >>
> >> If we're balancing load for CPU0-domain1, we would be looking at which
> CPUs
> >> in [0-2] (i.e. the domain's span) we could (if we should) pull tasks from
> >> to migrate them over to CPU0.
> >>
> >> We'll first try to figure out which sched_group has the more load (see
> >> find_busiest_group() & friends), and that's where we may hit issues.
> >>
> >> Consider a scenario where CPU3 is noticeably busier than the other
> >> CPUs. We'll end up marking CPU0-domain1-group2 (1-3) as the busiest
> group,
> >> and compute an imbalance (i.e. amount of load to pull) mostly based on the
> >> status of CPU3.
> >>
> >> We'll then go to find_busiest_queue(); the mask of CPUs we iterate over is
> >> restricted by the sched_domain_span (i.e. doesn't include CPU3 here), so
> >> we'll pull things from either CPU1 or CPU2 based on stats we built looking
> >> at CPU3, which is bound to be pretty bogus.
> >>
> >> To summarise: we won't pull from the "outsider" node(s) (i.e., nodes
> >> included in the sched_groups but not covered by the sched_domain), but
> they
> >> will influence the stats and heuristics of the load balance.
> >
> > Hi Valentin,
> > Thanks for your clarification. For many scenarios, to achieve good
> performance, people would
> > pin processes in numa node. So the priority to pin would be local node first,
> then domain0 with one hop. Domain1
> > with two hops is actually too far. Domain2 with three hops would be a
> disaster. If cpu0 pulls task from cpu2,
> > but memory is still one CPU2's node, 3 hops would be a big problem for
> memory access and page migration.
> >
> 
> Did you mean CPU3 here?

Yep. I meant cpu3 here.

> 
> > However, for automatic numa balance, I would agree we need to fix the
> groups layout to make groups
> > stay in the span of sched_domain. Otherwise, it seems the scheduler is
> running incorrectly to find the right
> > cpu to pull task.
> >
> > In case we have
> > 0 task on cpu0
> > 1 task on cpu1
> > 1 task on cpu2
> > 4 task on cpu3
> >
> > In sched_domain1, cpu1+cpu3 is busy, so cpu0 would try to pull task from
> cpu2 of the group(1-3) because cpu3 is busy,
> > meanwhile, it is an outsider.
> >
> 
> Right, we'd pull from either CPU1 or CPU2 (in this case via a tentative
> active load balance) because they are in the same group as CPU3 which
> inflates the sched_group load stats, but we can't pull from it at this
> domain because it's not included in the domain span.
> 
Thanks
Barry
