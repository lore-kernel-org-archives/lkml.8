Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6257FC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417C620801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgBRRIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:08:12 -0500
Received: from foss.arm.com ([217.140.110.172]:56152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgBRRIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:08:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFF7731B;
        Tue, 18 Feb 2020 09:08:10 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A9DF3F703;
        Tue, 18 Feb 2020 09:08:08 -0800 (PST)
Date:   Tue, 18 Feb 2020 17:08:03 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        suzuki.poulose@arm.com, james.clark@arm.com,
        zhangshaokun@hisilicon.com, robin.murphy@arm.com,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH RFC 0/7] perf pmu-events: Support event aliasing for
 system PMUs
Message-ID: <20200218170803.GA9968@lakrids.cambridge.arm.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <20200218125707.GB20212@willie-the-truck>
 <a40903fe-d52f-96c6-a06a-fe834d71d625@huawei.com>
 <20200218133943.GF20212@willie-the-truck>
 <627cbc50-4b36-7f7f-179d-3d27d9e0215a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <627cbc50-4b36-7f7f-179d-3d27d9e0215a@huawei.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:19:32PM +0000, John Garry wrote:
> > > 
> > > > Why don't we just expose SMMU_IIDR in the SMMUv3 PMU directory, so that
> > > > you can key off that?
> > > 
> > > That does not sound like a standard sysfs interface.
> > 
> > It's standard in the sense that PMUs already have their own directory under
> > sysfs where you can put things.
> 
> Sure, but then the perf tool will need to be able to interpret all these
> custom PMU files, which has scalability issues.
> 
> Maybe this would work and I did consider it, but another concern is that the
> PMU drivers will have problems making available some implementation-specific
> identifier at all.
> 
> For example, the "caps" directory is a
> > dumping ground for all sorts of PMU-specific information.
> > 
> > On the other hand, saying "please go figure out which SoC you're on"
> > certainly isn't standard and is likely to lead to unreliable, spaghetti
> > code.
> 
> I'm not sure how. The perf tool PMU event aliasing already takes a few
> certain steps to figure out which cpuid to use:
> 
> static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
> {
> 	char *cpuid;
> 	static bool printed;
> 
> 	cpuid = getenv("PERF_CPUID");
> 	if (cpuid)
> 		cpuid = strdup(cpuid);
> 	if (!cpuid)
> 		cpuid = get_cpuid_str(pmu);
> 	if (!cpuid)
> 		return NULL;
> 
> 	if (!printed) {
> 		pr_debug("Using CPUID %s\n", cpuid);
> 		printed = true;
> 	}
> 	return cpuid;
> }
> 
> And this would be something similar - just read some sysfs file.
> 
> > 
> > > Anyway, I don't think that works for every case, quoting from
> > > https://lkml.org/lkml/2019/10/16/465:
> > > 
> > > "> Note: I do acknowledge that an overall issue is that we assume all PMCG
> > > IMP DEF events are same for a given SMMU model.
> > > 
> > > That assumption does technically fail already - I know MMU-600 has
> > > different IMP-DEF events for its TCU and TBUs, however as long as we can
> > > get as far as "this is some part of an MMU-600" the driver should be
> > > able to figure out the rest ..."
> > 
> > Perhaps I'm misreading this, but it sounds like if you knew it was an
> > MMU-600 then you'd be ok. I also don't understand how a SoC ID makes things
> > any easier in this regard.
> 
> It's doesn't necessarily make things easier in this regard. But using a SoC
> ID is an alternative to checking the SMMU_ID or the kernel driver having to
> know that it was a MMU-600 at all.

Using SOC_ID means that going forward, userspace needs to learn about
the integration details of each SoC in order to identify a component. As
you said:

| As constantly checking what the SoC ID means throughout system components
| does not scale.

... and I think that equally applies to userspace in this case. Who knows how
many SoCs are going to have MMU-600?

I also know that SOC_ID is going to be optional, and I think it's near-certain
that someone will end up producing two SoCs exposing the same ID.

For system PMUs, I'd rather the system PMU driver exposed some sort of
implementation ID. e.g. the SMMU_ID for SMMU. We can give that a generic name,
and mandate that where a driver exposes it, the format/meaning is defined in
the documentation for the driver.

That can be namespace by driver, so e.g. keys would be smmu_sysfs_name/<id> and
ddrc_sysfs_name/<id>.

> > > So even if it is solvable here, the kernel driver(s) will need to be
> > > reworked. And that is just solving one case in many.
> > 
> > PMU drivers will need to expose more information to userspace so that they
> > can be identified more precisely, yes. I wouldn't say they would need to be
> > "reworked".
> 
> OK, so some combination of changes would still be required for the SMMU
> PMCG, IORT, and SMMUv3 drivers.

To expose the SMMU ID, surely that's just the driver? Or are there
implementations where the ID register is bogus and have to be overridden?

Thanks,
Mark.
