Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD813C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2D9208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgBRSNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:13:39 -0500
Received: from foss.arm.com ([217.140.110.172]:58138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgBRSNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:13:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD76831B;
        Tue, 18 Feb 2020 10:13:35 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76EBD3F68F;
        Tue, 18 Feb 2020 10:13:33 -0800 (PST)
Date:   Tue, 18 Feb 2020 18:13:31 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     "ak@linux.intel.com" <ak@linux.intel.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC 0/7] perf pmu-events: Support event aliasing for
 system PMUs
Message-ID: <20200218181331.GB9968@lakrids.cambridge.arm.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <20200218125707.GB20212@willie-the-truck>
 <a40903fe-d52f-96c6-a06a-fe834d71d625@huawei.com>
 <20200218133943.GF20212@willie-the-truck>
 <627cbc50-4b36-7f7f-179d-3d27d9e0215a@huawei.com>
 <20200218170803.GA9968@lakrids.cambridge.arm.com>
 <cb004f43-b2a4-ae23-9fd3-0f70bd69701b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb004f43-b2a4-ae23-9fd3-0f70bd69701b@huawei.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:58:46PM +0000, John Garry wrote:
> On 18/02/2020 17:08, Mark Rutland wrote:
> > > > I also don't understand how a SoC ID makes things
> > > > any easier in this regard.
> > > It's doesn't necessarily make things easier in this regard. But using a SoC
> > > ID is an alternative to checking the SMMU_ID or the kernel driver having to
> > > know that it was a MMU-600 at all.
> > Using SOC_ID means that going forward, userspace needs to learn about
> > the integration details of each SoC in order to identify a component. As
> > you said:
> > 
> > | As constantly checking what the SoC ID means throughout system components
> > | does not scale.
> > 
> > ... and I think that equally applies to userspace in this case. Who knows how
> > many SoCs are going to have MMU-600?
> > 
> > I also know that SOC_ID is going to be optional, and I think it's near-certain
> > that someone will end up producing two SoCs exposing the same ID.
> 
> Wouldn't different SoCs having same SMC SOC_ID and revision be a (fixable)
> mistake in the SMC FW?
> 
> And if it's not implemented, then no PMU events aliasing in perf tool for
> those uncore PMUs - nothing gets broken though and no regression. But I do
> understand your concern here.
> 
> > For system PMUs, I'd rather the system PMU driver exposed some sort of
> > implementation ID. e.g. the SMMU_ID for SMMU. We can give that a generic name,
> > and mandate that where a driver exposes it, the format/meaning is defined in
> > the documentation for the driver.
> 
> Then doesn't that per-PMU ID qualify as brittle and non-standard also?

Not in my mind; any instances of the same IP can have the same ID,
regardless of which SoC they're in. Once userspace learns about
device-foo-4000, it knows about it on all SoCs. That also means you can
support heterogeneous instances in the same SoC.

If a device varies so much on a SoC-by-SoC basis and or the driver has
no idea what to expose, it could be legitimate for the PMU driver to
expose the SoC ID as its PMU-specific ID, but I don't think we should
make that the common/only case.

> At least the SMC SoC ID is according to some standard.
> 
> And typically most PMU HW would have no ID reg, so where to even get this
> identification info? Joakim Zhang seems to have this problem for the imx8
> DDRC PMU driver.

For imx8, the DT compat string or additional properties on the DDRC node
could be used to imply the id.

> > That can be namespace by driver, so e.g. keys would be smmu_sysfs_name/<id> and
> > ddrc_sysfs_name/<id>.
> > 
> > > > > So even if it is solvable here, the kernel driver(s) will need to be
> > > > > reworked. And that is just solving one case in many.
> > > > PMU drivers will need to expose more information to userspace so that they
> > > > can be identified more precisely, yes. I wouldn't say they would need to be
> > > > "reworked".
> > > OK, so some combination of changes would still be required for the SMMU
> > > PMCG, IORT, and SMMUv3 drivers.
> > To expose the SMMU ID, surely that's just the driver?
> 
> This case is complicated, like others I anticipate.
> 
> So the SMMU PMCG HW has no ID register itself, and this idea relies on using
> the associated SMMUv3 IIDR in lieu. For that, we need to involve the IORT,
> SMMUv3, and SMMU PMCG drivers to create this linkage, and even then I still
> have my doubts on whether this is even proper.

Ok, I hadn't appreciated that the PMCG did not have an ID register
itself.

I think that the relationship between the SMMU and PMCG is a stronger
argument against using the SOC_ID. If the PMCGs in a system are
heterogeneous, then you must know the type of the specific instance.

> Please see https://lore.kernel.org/linux-iommu/1569854031-237636-1-git-send-email-john.garry@huawei.com/
> for reference.
> 
> Or are there
> > implementations where the ID register is bogus and have to be overridden?
> > 
> 
> I will also note that perf tool PMU events framework relies today on
> generating a table of events aliases per CPU and matching based on that. If
> you want to totally disassociate a CPU or any SoC ID mapping, then this will
> require big perf tool rework.

I think that might be necessary, as otherwise we're going to back
ourselves into a corner by building what's simple now.

Thanks,
Mark.
