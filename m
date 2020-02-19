Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1D8C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1110222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgBSIuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:50:19 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2443 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726582AbgBSIuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:50:18 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 94A329A75D14FEA2E52C;
        Wed, 19 Feb 2020 08:50:16 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 19 Feb 2020 08:50:15 +0000
Received: from [127.0.0.1] (10.210.170.116) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 19 Feb
 2020 08:50:14 +0000
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
 <cb004f43-b2a4-ae23-9fd3-0f70bd69701b@huawei.com>
 <20200218181331.GB9968@lakrids.cambridge.arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <822114f9-8ff4-c769-66a0-7e637ce49cd5@huawei.com>
Date:   Wed, 19 Feb 2020 08:50:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200218181331.GB9968@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.116]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>>> For system PMUs, I'd rather the system PMU driver exposed some sort of
>>> implementation ID. e.g. the SMMU_ID for SMMU. We can give that a generic name,
>>> and mandate that where a driver exposes it, the format/meaning is defined in
>>> the documentation for the driver.
>>
>> Then doesn't that per-PMU ID qualify as brittle and non-standard also?
> 
> Not in my mind; any instances of the same IP can have the same ID,
> regardless of which SoC they're in. Once userspace learns about
> device-foo-4000, it knows about it on all SoCs. That also means you can
> support heterogeneous instances in the same SoC.

Sure, but this device-foo-4000 naming is a concern for standardization, 
stable ABI, and perf tool support.

> 
> If a device varies so much on a SoC-by-SoC basis and or the driver has
> no idea what to expose, it could be legitimate for the PMU driver to
> expose the SoC ID as its PMU-specific ID, but I don't think we should
> make that the common/only case.

But where does the PMU driver get the SoC ID? Does it have to check DT 
machine ID, ACPI OEM ID, or SMCCC SOC ID?

I can't imagine that you really want this stuff in the kernel PMU 
drivers, but that's your call.

> 
>> At least the SMC SoC ID is according to some standard.
>>
>> And typically most PMU HW would have no ID reg, so where to even get this
>> identification info? Joakim Zhang seems to have this problem for the imx8
>> DDRC PMU driver.
> 
> For imx8, the DT compat string or additional properties on the DDRC node
> could be used to imply the id.

Fine, but it's the ACPI case which is what I am concerned about.

> 
>>> That can be namespace by driver, so e.g. keys would be smmu_sysfs_name/<id> and
>>> ddrc_sysfs_name/<id>.
>>>
>>>>>> So even if it is solvable here, the kernel driver(s) will need to be
>>>>>> reworked. And that is just solving one case in many.
>>>>> PMU drivers will need to expose more information to userspace so that they
>>>>> can be identified more precisely, yes. I wouldn't say they would need to be
>>>>> "reworked".
>>>> OK, so some combination of changes would still be required for the SMMU
>>>> PMCG, IORT, and SMMUv3 drivers.
>>> To expose the SMMU ID, surely that's just the driver?
>>
>> This case is complicated, like others I anticipate.
>>
>> So the SMMU PMCG HW has no ID register itself, and this idea relies on using
>> the associated SMMUv3 IIDR in lieu. For that, we need to involve the IORT,
>> SMMUv3, and SMMU PMCG drivers to create this linkage, and even then I still
>> have my doubts on whether this is even proper.
> 
> Ok, I hadn't appreciated that the PMCG did not have an ID register
> itself.
> 
> I think that the relationship between the SMMU and PMCG is a stronger
> argument against using the SOC_ID. If the PMCGs in a system are
> heterogeneous, then you must know the type of the specific instance.

Perf tool PMU events can handle that. Each PMCG PMU instance has a 
different name - the name encoding includes the HW base address, so 
always unique per system - and then so the JSON can know this and have 
events specific per instance.

> 
>> Please see https://lore.kernel.org/linux-iommu/1569854031-237636-1-git-send-email-john.garry@huawei.com/
>> for reference.
>>
>> Or are there
>>> implementations where the ID register is bogus and have to be overridden?
>>>
>>
>> I will also note that perf tool PMU events framework relies today on
>> generating a table of events aliases per CPU and matching based on that. If
>> you want to totally disassociate a CPU or any SoC ID mapping, then this will
>> require big perf tool rework.
> 
> I think that might be necessary, as otherwise we're going to back
> ourselves into a corner by building what's simple now.

I appreciate what you're saying. I'll check this idea further.

Cheers,
John
