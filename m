Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2B2C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE3E20678
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIBKuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 06:50:52 -0400
Received: from foss.arm.com ([217.140.110.172]:35502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBKuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 06:50:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C185D6E;
        Wed,  2 Sep 2020 03:50:49 -0700 (PDT)
Received: from bogus (unknown [10.57.4.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6E713F66F;
        Wed,  2 Sep 2020 03:50:47 -0700 (PDT)
Date:   Wed, 2 Sep 2020 11:50:45 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] arm64: topology: Stop using MPIDR for topology
 information
Message-ID: <20200902105045.GB25462@bogus>
References: <20200829130016.26106-1-valentin.schneider@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED482417F4@DGGEMM506-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED482417F4@DGGEMM506-MBX.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:24:17AM +0000, Zengtao (B) wrote:
> Hi Valentin:
>
> > -----Original Message-----
> > From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> > Sent: Saturday, August 29, 2020 9:00 PM
> > To: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Cc: Catalin Marinas; Will Deacon; Sudeep Holla; Robin Murphy; Jeremy
> > Linton; Dietmar Eggemann; Morten Rasmussen; Zengtao (B)
> > Subject: [PATCH] arm64: topology: Stop using MPIDR for topology
> > information
> >
> > In the absence of ACPI or DT topology data, we fallback to haphazardly
> > decoding *something* out of MPIDR. Sadly, the contents of that register
> > are
> > mostly unusable due to the implementation leniancy and things like Aff0
> > having to be capped to 15 (despite being encoded on 8 bits).
> >
> > Consider a simple system with a single package of 32 cores, all under the
> > same LLC. We ought to be shoving them in the same core_sibling mask,
> > but
> > MPIDR is going to look like:
> >
> >   | CPU  | 0 | ... | 15 | 16 | ... | 31 |
> >   |------+---+-----+----+----+-----+----+
> >   | Aff0 | 0 | ... | 15 |  0 | ... | 15 |
> >   | Aff1 | 0 | ... |  0 |  1 | ... |  1 |
> >   | Aff2 | 0 | ... |  0 |  0 | ... |  0 |
> >
> > Which will eventually yield
> >
> >   core_sibling(0-15)  == 0-15
> >   core_sibling(16-31) == 16-31
> >
> > NUMA woes
> > =========
> >
> > If we try to play games with this and set up NUMA boundaries within those
> > groups of 16 cores via e.g. QEMU:
> >
> >   # Node0: 0-9; Node1: 10-19
> >   $ qemu-system-aarch64 <blah> \
> >     -smp 20 -numa node,cpus=0-9,nodeid=0 -numa
> > node,cpus=10-19,nodeid=1
> >
> > The scheduler's MC domain (all CPUs with same LLC) is going to be built via
> >
> >   arch_topology.c::cpu_coregroup_mask()
> >
> > In there we try to figure out a sensible mask out of the topology
> > information we have. In short, here we'll pick the smallest of NUMA or
> > core sibling mask.
> >
> >   node_mask(CPU9)    == 0-9
> >   core_sibling(CPU9) == 0-15
> >
> > MC mask for CPU9 will thus be 0-9, not a problem.
> >
> >   node_mask(CPU10)    == 10-19
> >   core_sibling(CPU10) == 0-15
> >
> > MC mask for CPU10 will thus be 10-19, not a problem.
> >
> >   node_mask(CPU16)    == 10-19
> >   core_sibling(CPU16) == 16-19
> >
> > MC mask for CPU16 will thus be 16-19... Uh oh. CPUs 16-19 are in two
> > different unique MC spans, and the scheduler has no idea what to make of
> > that. That triggers the WARN_ON() added by commit
> >
> >   ccf74128d66c ("sched/topology: Assert non-NUMA topology masks
> > don't (partially) overlap")
> >
> > Fixing MPIDR-derived topology
> > =============================
> >
> > We could try to come up with some cleverer scheme to figure out which of
> > the available masks to pick, but really if one of those masks resulted from
> > MPIDR then it should be discarded because it's bound to be bogus.
> >
> > I was hoping to give MPIDR a chance for SMT, to figure out which threads
> > are
> > in the same core using Aff1-3 as core ID, but Sudeep and Robin pointed out
> > to me that there are systems out there where *all* cores have non-zero
> > values in their higher affinity fields (e.g. RK3288 has "5" in all of its
> > cores' MPIDR.Aff1), which would expose a bogus core ID to userspace.
> >
> > Stop using MPIDR for topology information. When no other source of
> > topology
> > information is available, mark each CPU as its own core and its NUMA
> > node
> > as its LLC domain.
>
> I agree with your idea to remove the topology functionality of MPIDR ,
> but I think we need also consider ARM32 and GIC.
>

This is changing only arm64 for now. For fun, looked at some arm32 DTS:
arch/arm/boot/dts/aspeed-g6.dtsi
arch/arm/boot/dts/bcm2836.dtsi
arch/arm/boot/dts/exynos4210.dtsi
arch/arm/boot/dts/exynos4412.dtsi
arch/arm/boot/dts/highbank.dts
arch/arm/boot/dts/imx7ulp.dtsi
arch/arm/boot/dts/ls1021a.dtsi
arch/arm/boot/dts/meson6.dtsi
arch/arm/boot/dts/meson8.dtsi
arch/arm/boot/dts/meson8b.dtsi
arch/arm/boot/dts/milbeaut-m10v.dtsi
arch/arm/boot/dts/rk3036.dtsi
arch/arm/boot/dts/rk322x.dtsi
arch/arm/boot/dts/rk3288.dtsi
arch/arm/boot/dts/rtd1195.dtsi
arch/arm/boot/dts/rv1108.dtsi
arch/arm/boot/dts/ste-dbx5x0.dtsi

These have random non-zero values in Aff1 or Aff2. I may have generated
some false positives with simple search.

--
Regards,
Sudeep
