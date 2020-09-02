Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7933AC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547232065E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgIBDYX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 23:24:23 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:57620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726193AbgIBDYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 23:24:22 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 9AA4328DDD7190997FC9;
        Wed,  2 Sep 2020 11:24:20 +0800 (CST)
Received: from DGGEMM506-MBX.china.huawei.com ([169.254.3.104]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0487.000;
 Wed, 2 Sep 2020 11:24:17 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: RE: [PATCH] arm64: topology: Stop using MPIDR for topology
 information
Thread-Topic: [PATCH] arm64: topology: Stop using MPIDR for topology
 information
Thread-Index: AQHWfgSJPmqF2SG48kSTbwY4HiAd4alUsrXQ
Date:   Wed, 2 Sep 2020 03:24:17 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED482417F4@DGGEMM506-MBX.china.huawei.com>
References: <20200829130016.26106-1-valentin.schneider@arm.com>
In-Reply-To: <20200829130016.26106-1-valentin.schneider@arm.com>
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

Hi Valentin:

> -----Original Message-----
> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> Sent: Saturday, August 29, 2020 9:00 PM
> To: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Catalin Marinas; Will Deacon; Sudeep Holla; Robin Murphy; Jeremy
> Linton; Dietmar Eggemann; Morten Rasmussen; Zengtao (B)
> Subject: [PATCH] arm64: topology: Stop using MPIDR for topology
> information
> 
> In the absence of ACPI or DT topology data, we fallback to haphazardly
> decoding *something* out of MPIDR. Sadly, the contents of that register
> are
> mostly unusable due to the implementation leniancy and things like Aff0
> having to be capped to 15 (despite being encoded on 8 bits).
> 
> Consider a simple system with a single package of 32 cores, all under the
> same LLC. We ought to be shoving them in the same core_sibling mask,
> but
> MPIDR is going to look like:
> 
>   | CPU  | 0 | ... | 15 | 16 | ... | 31 |
>   |------+---+-----+----+----+-----+----+
>   | Aff0 | 0 | ... | 15 |  0 | ... | 15 |
>   | Aff1 | 0 | ... |  0 |  1 | ... |  1 |
>   | Aff2 | 0 | ... |  0 |  0 | ... |  0 |
> 
> Which will eventually yield
> 
>   core_sibling(0-15)  == 0-15
>   core_sibling(16-31) == 16-31
> 
> NUMA woes
> =========
> 
> If we try to play games with this and set up NUMA boundaries within those
> groups of 16 cores via e.g. QEMU:
> 
>   # Node0: 0-9; Node1: 10-19
>   $ qemu-system-aarch64 <blah> \
>     -smp 20 -numa node,cpus=0-9,nodeid=0 -numa
> node,cpus=10-19,nodeid=1
> 
> The scheduler's MC domain (all CPUs with same LLC) is going to be built via
> 
>   arch_topology.c::cpu_coregroup_mask()
> 
> In there we try to figure out a sensible mask out of the topology
> information we have. In short, here we'll pick the smallest of NUMA or
> core sibling mask.
> 
>   node_mask(CPU9)    == 0-9
>   core_sibling(CPU9) == 0-15
> 
> MC mask for CPU9 will thus be 0-9, not a problem.
> 
>   node_mask(CPU10)    == 10-19
>   core_sibling(CPU10) == 0-15
> 
> MC mask for CPU10 will thus be 10-19, not a problem.
> 
>   node_mask(CPU16)    == 10-19
>   core_sibling(CPU16) == 16-19
> 
> MC mask for CPU16 will thus be 16-19... Uh oh. CPUs 16-19 are in two
> different unique MC spans, and the scheduler has no idea what to make of
> that. That triggers the WARN_ON() added by commit
> 
>   ccf74128d66c ("sched/topology: Assert non-NUMA topology masks
> don't (partially) overlap")
> 
> Fixing MPIDR-derived topology
> =============================
> 
> We could try to come up with some cleverer scheme to figure out which of
> the available masks to pick, but really if one of those masks resulted from
> MPIDR then it should be discarded because it's bound to be bogus.
> 
> I was hoping to give MPIDR a chance for SMT, to figure out which threads
> are
> in the same core using Aff1-3 as core ID, but Sudeep and Robin pointed out
> to me that there are systems out there where *all* cores have non-zero
> values in their higher affinity fields (e.g. RK3288 has "5" in all of its
> cores' MPIDR.Aff1), which would expose a bogus core ID to userspace.
> 
> Stop using MPIDR for topology information. When no other source of
> topology
> information is available, mark each CPU as its own core and its NUMA
> node
> as its LLC domain.

I agree with your idea to remove the topology functionality of MPIDR ,
but I think we need also consider ARM32 and GIC. 

> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  arch/arm64/kernel/topology.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 0801a0f3c156..ff1dd1dbfe64 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -36,21 +36,23 @@ void store_cpu_topology(unsigned int cpuid)
>  	if (mpidr & MPIDR_UP_BITMASK)
>  		return;
> 
> -	/* Create cpu topology mapping based on MPIDR. */
> -	if (mpidr & MPIDR_MT_BITMASK) {
> -		/* Multiprocessor system : Multi-threads per core */
> -		cpuid_topo->thread_id  = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> -		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> -		cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 2) |
> -					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 8;
> -	} else {
> -		/* Multiprocessor system : Single-thread per core */
> -		cpuid_topo->thread_id  = -1;
> -		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> -		cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 1) |
> -					 MPIDR_AFFINITY_LEVEL(mpidr, 2) << 8 |
> -					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 16;
> -	}
> +	/*
> +	 * This would be the place to create cpu topology based on MPIDR.
> +	 *
> +	 * However, it cannot be trusted to depict the actual topology; some
> +	 * pieces of the architecture enforce an artificial cap on Aff0 values
> +	 * (e.g. GICv3's ICC_SGI1R_EL1 limits it to 15), leading to an
> +	 * artificial cycling of Aff1, Aff2 and Aff3 values. IOW, these end up
> +	 * having absolutely no relationship to the actual underlying system
> +	 * topology, and cannot be reasonably used as core / package ID.
> +	 *
> +	 * If the MT bit is set, Aff0 *could* be used to define a thread ID, but
> +	 * we still wouldn't be able to obtain a sane core ID. This means we
> +	 * need to entirely ignore MPIDR for any topology deduction.
> +	 */
> +	cpuid_topo->thread_id  = -1;
> +	cpuid_topo->core_id    = cpuid;
> +	cpuid_topo->package_id = cpu_to_node(cpuid);
> 
>  	pr_debug("CPU%u: cluster %d core %d thread %d mpidr %#016llx\n",
>  		 cpuid, cpuid_topo->package_id, cpuid_topo->core_id,
> --
> 2.27.0

