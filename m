Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CF8C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B8820679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgBRR6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:58:50 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2440 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbgBRR6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:58:49 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id ECFB53CC3478A73BE448;
        Tue, 18 Feb 2020 17:58:47 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Feb 2020 17:58:47 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Tue, 18 Feb
 2020 17:58:47 +0000
Subject: Re: [PATCH RFC 0/7] perf pmu-events: Support event aliasing for
 system PMUs
To:     Mark Rutland <mark.rutland@arm.com>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
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
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <20200218125707.GB20212@willie-the-truck>
 <a40903fe-d52f-96c6-a06a-fe834d71d625@huawei.com>
 <20200218133943.GF20212@willie-the-truck>
 <627cbc50-4b36-7f7f-179d-3d27d9e0215a@huawei.com>
 <20200218170803.GA9968@lakrids.cambridge.arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <cb004f43-b2a4-ae23-9fd3-0f70bd69701b@huawei.com>
Date:   Tue, 18 Feb 2020 17:58:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200218170803.GA9968@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2020 17:08, Mark Rutland wrote:
>>> I also don't understand how a SoC ID makes things
>>> any easier in this regard.
>> It's doesn't necessarily make things easier in this regard. But using a SoC
>> ID is an alternative to checking the SMMU_ID or the kernel driver having to
>> know that it was a MMU-600 at all.
> Using SOC_ID means that going forward, userspace needs to learn about
> the integration details of each SoC in order to identify a component. As
> you said:
> 
> | As constantly checking what the SoC ID means throughout system components
> | does not scale.
> 
> ... and I think that equally applies to userspace in this case. Who knows how
> many SoCs are going to have MMU-600?
> 
> I also know that SOC_ID is going to be optional, and I think it's near-certain
> that someone will end up producing two SoCs exposing the same ID.

Wouldn't different SoCs having same SMC SOC_ID and revision be a 
(fixable) mistake in the SMC FW?

And if it's not implemented, then no PMU events aliasing in perf tool 
for those uncore PMUs - nothing gets broken though and no regression. 
But I do understand your concern here.

> 
> For system PMUs, I'd rather the system PMU driver exposed some sort of
> implementation ID. e.g. the SMMU_ID for SMMU. We can give that a generic name,
> and mandate that where a driver exposes it, the format/meaning is defined in
> the documentation for the driver.

Then doesn't that per-PMU ID qualify as brittle and non-standard also?

At least the SMC SoC ID is according to some standard.

And typically most PMU HW would have no ID reg, so where to even get 
this identification info? Joakim Zhang seems to have this problem for 
the imx8 DDRC PMU driver.

> 
> That can be namespace by driver, so e.g. keys would be smmu_sysfs_name/<id> and
> ddrc_sysfs_name/<id>.
> 
>>>> So even if it is solvable here, the kernel driver(s) will need to be
>>>> reworked. And that is just solving one case in many.
>>> PMU drivers will need to expose more information to userspace so that they
>>> can be identified more precisely, yes. I wouldn't say they would need to be
>>> "reworked".
>> OK, so some combination of changes would still be required for the SMMU
>> PMCG, IORT, and SMMUv3 drivers.
> To expose the SMMU ID, surely that's just the driver? 

This case is complicated, like others I anticipate.

So the SMMU PMCG HW has no ID register itself, and this idea relies on 
using the associated SMMUv3 IIDR in lieu. For that, we need to involve 
the IORT, SMMUv3, and SMMU PMCG drivers to create this linkage, and even 
then I still have my doubts on whether this is even proper.

Please see 
https://lore.kernel.org/linux-iommu/1569854031-237636-1-git-send-email-john.garry@huawei.com/ 
for reference.

Or are there
> implementations where the ID register is bogus and have to be overridden?
> 

I will also note that perf tool PMU events framework relies today on 
generating a table of events aliases per CPU and matching based on that. 
If you want to totally disassociate a CPU or any SoC ID mapping, then 
this will require big perf tool rework.

Thanks,
John
