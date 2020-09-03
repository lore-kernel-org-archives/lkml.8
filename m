Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E491C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B14F20678
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgICBoc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 21:44:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbgICBoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 21:44:30 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id CCA8F8C6A025C2ED4545;
        Thu,  3 Sep 2020 09:44:27 +0800 (CST)
Received: from DGGEMM506-MBX.china.huawei.com ([169.254.3.104]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0487.000;
 Thu, 3 Sep 2020 09:44:24 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Morten Rasmussen" <morten.rasmussen@arm.com>
Subject: RE: [PATCH] arm64: topology: Stop using MPIDR for topology
 information
Thread-Topic: [PATCH] arm64: topology: Stop using MPIDR for topology
 information
Thread-Index: AQHWfgSJPmqF2SG48kSTbwY4HiAd4alUsrXQ///5YwCAAXpvEA==
Date:   Thu, 3 Sep 2020 01:44:24 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED482431A1@DGGEMM506-MBX.china.huawei.com>
References: <20200829130016.26106-1-valentin.schneider@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED482417F4@DGGEMM506-MBX.china.huawei.com>
 <jhja6y8o3hb.mognet@arm.com>
In-Reply-To: <jhja6y8o3hb.mognet@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
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
> Sent: Wednesday, September 02, 2020 6:52 PM
> To: Zengtao (B)
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Catalin Marinas; Will Deacon; Sudeep Holla; Robin Murphy; Jeremy Linton;
> Dietmar Eggemann; Morten Rasmussen
> Subject: Re: [PATCH] arm64: topology: Stop using MPIDR for topology
> information
> 
> 
> On 02/09/20 04:24, B wrote:
> > Hi Valentin:
> >
> >> -----Original Message-----
> >> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> >> Sent: Saturday, August 29, 2020 9:00 PM
> >> To: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> >> Cc: Catalin Marinas; Will Deacon; Sudeep Holla; Robin Murphy; Jeremy
> >> Linton; Dietmar Eggemann; Morten Rasmussen; Zengtao (B)
> >> Subject: [PATCH] arm64: topology: Stop using MPIDR for topology
> >> information
> >>
> >> In the absence of ACPI or DT topology data, we fallback to haphazardly
> >> decoding *something* out of MPIDR. Sadly, the contents of that
> register
> >> are
> >> mostly unusable due to the implementation leniancy and things like Aff0
> >> having to be capped to 15 (despite being encoded on 8 bits).
> >>
> >> Consider a simple system with a single package of 32 cores, all under
> the
> >> same LLC. We ought to be shoving them in the same core_sibling mask,
> >> but
> >> MPIDR is going to look like:
> >>
> >>   | CPU  | 0 | ... | 15 | 16 | ... | 31 |
> >>   |------+---+-----+----+----+-----+----+
> >>   | Aff0 | 0 | ... | 15 |  0 | ... | 15 |
> >>   | Aff1 | 0 | ... |  0 |  1 | ... |  1 |
> >>   | Aff2 | 0 | ... |  0 |  0 | ... |  0 |
> >>
> >> Which will eventually yield
> >>
> >>   core_sibling(0-15)  == 0-15
> >>   core_sibling(16-31) == 16-31
> >>
> >> NUMA woes
> >> =========
> >>
> >> If we try to play games with this and set up NUMA boundaries within
> those
> >> groups of 16 cores via e.g. QEMU:
> >>
> >>   # Node0: 0-9; Node1: 10-19
> >>   $ qemu-system-aarch64 <blah> \
> >>     -smp 20 -numa node,cpus=0-9,nodeid=0 -numa
> >> node,cpus=10-19,nodeid=1
> >>
> >> The scheduler's MC domain (all CPUs with same LLC) is going to be built
> via
> >>
> >>   arch_topology.c::cpu_coregroup_mask()
> >>
> >> In there we try to figure out a sensible mask out of the topology
> >> information we have. In short, here we'll pick the smallest of NUMA or
> >> core sibling mask.
> >>
> >>   node_mask(CPU9)    == 0-9
> >>   core_sibling(CPU9) == 0-15
> >>
> >> MC mask for CPU9 will thus be 0-9, not a problem.
> >>
> >>   node_mask(CPU10)    == 10-19
> >>   core_sibling(CPU10) == 0-15
> >>
> >> MC mask for CPU10 will thus be 10-19, not a problem.
> >>
> >>   node_mask(CPU16)    == 10-19
> >>   core_sibling(CPU16) == 16-19
> >>
> >> MC mask for CPU16 will thus be 16-19... Uh oh. CPUs 16-19 are in two
> >> different unique MC spans, and the scheduler has no idea what to make
> of
> >> that. That triggers the WARN_ON() added by commit
> >>
> >>   ccf74128d66c ("sched/topology: Assert non-NUMA topology masks
> >> don't (partially) overlap")
> >>
> >> Fixing MPIDR-derived topology
> >> =============================
> >>
> >> We could try to come up with some cleverer scheme to figure out which
> of
> >> the available masks to pick, but really if one of those masks resulted
> from
> >> MPIDR then it should be discarded because it's bound to be bogus.
> >>
> >> I was hoping to give MPIDR a chance for SMT, to figure out which
> threads
> >> are
> >> in the same core using Aff1-3 as core ID, but Sudeep and Robin pointed
> out
> >> to me that there are systems out there where *all* cores have
> non-zero
> >> values in their higher affinity fields (e.g. RK3288 has "5" in all of its
> >> cores' MPIDR.Aff1), which would expose a bogus core ID to userspace.
> >>
> >> Stop using MPIDR for topology information. When no other source of
> >> topology
> >> information is available, mark each CPU as its own core and its NUMA
> >> node
> >> as its LLC domain.
> >
> > I agree with your idea to remove the topology functionality of MPIDR ,
> > but I think we need also consider ARM32 and GIC.
> >
> 
> Could you please elaborate? This change doesn't impact arch_topology, so
> only arm64 is affected.

Yes, this change only affects arm64, my question is that do we need to
 leverage it to arm32 since arm32 got the same issue.

And for GIC we are also using MPIDR for the topology info, but I am sure
It's got the same issue or not, just a suggestion to have a look.


