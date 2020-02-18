Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E144CC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E5122527
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgBRQTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:19:37 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2439 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726399AbgBRQTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:19:37 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id DD10D8678BA5F207C4CC;
        Tue, 18 Feb 2020 16:19:34 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Feb 2020 16:19:34 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Tue, 18 Feb
 2020 16:19:34 +0000
Subject: Re: [PATCH RFC 0/7] perf pmu-events: Support event aliasing for
 system PMUs
To:     Will Deacon <will@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <james.clark@arm.com>, <zhangshaokun@hisilicon.com>,
        <robin.murphy@arm.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <20200218125707.GB20212@willie-the-truck>
 <a40903fe-d52f-96c6-a06a-fe834d71d625@huawei.com>
 <20200218133943.GF20212@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <627cbc50-4b36-7f7f-179d-3d27d9e0215a@huawei.com>
Date:   Tue, 18 Feb 2020 16:19:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200218133943.GF20212@willie-the-truck>
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

>>
>>> Why don't we just expose SMMU_IIDR in the SMMUv3 PMU directory, so that
>>> you can key off that?
>>
>> That does not sound like a standard sysfs interface.
> 
> It's standard in the sense that PMUs already have their own directory under
> sysfs where you can put things. 

Sure, but then the perf tool will need to be able to interpret all these 
custom PMU files, which has scalability issues.

Maybe this would work and I did consider it, but another concern is that 
the PMU drivers will have problems making available some 
implementation-specific identifier at all.

For example, the "caps" directory is a
> dumping ground for all sorts of PMU-specific information.
> 
> On the other hand, saying "please go figure out which SoC you're on"
> certainly isn't standard and is likely to lead to unreliable, spaghetti
> code.

I'm not sure how. The perf tool PMU event aliasing already takes a few 
certain steps to figure out which cpuid to use:

static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
{
	char *cpuid;
	static bool printed;

	cpuid = getenv("PERF_CPUID");
	if (cpuid)
		cpuid = strdup(cpuid);
	if (!cpuid)
		cpuid = get_cpuid_str(pmu);
	if (!cpuid)
		return NULL;

	if (!printed) {
		pr_debug("Using CPUID %s\n", cpuid);
		printed = true;
	}
	return cpuid;
}

And this would be something similar - just read some sysfs file.

> 
>> Anyway, I don't think that works for every case, quoting from
>> https://lkml.org/lkml/2019/10/16/465:
>>
>> "> Note: I do acknowledge that an overall issue is that we assume all PMCG
>> IMP DEF events are same for a given SMMU model.
>>
>> That assumption does technically fail already - I know MMU-600 has
>> different IMP-DEF events for its TCU and TBUs, however as long as we can
>> get as far as "this is some part of an MMU-600" the driver should be
>> able to figure out the rest ..."
> 
> Perhaps I'm misreading this, but it sounds like if you knew it was an
> MMU-600 then you'd be ok. I also don't understand how a SoC ID makes things
> any easier in this regard.

It's doesn't necessarily make things easier in this regard. But using a 
SoC ID is an alternative to checking the SMMU_ID or the kernel driver 
having to know that it was a MMU-600 at all.

> 
>> So even if it is solvable here, the kernel driver(s) will need to be
>> reworked. And that is just solving one case in many.
> 
> PMU drivers will need to expose more information to userspace so that they
> can be identified more precisely, yes. I wouldn't say they would need to be
> "reworked".

OK, so some combination of changes would still be required for the SMMU 
PMCG, IORT, and SMMUv3 drivers.

These changes were included in my RFC.

> 
>> I'm nervous about coming up with a global "SYSID"
>>> when we don't have the ability to standardise anything in that space.
>>
>> I understand totally, especially if any sysid is based on DT bindings.
> 
> Well if this is going to be ACPI-only then it's a non-starter.

No, in fact I would rather not rely on ACPI or DT at all.

> 
>> But this is some sort of standardization:
>> https://developer.arm.com/docs/den0028/c, see SMCCC_ARCH_SOC_ID
> 
> Yay, firmware :/
>  > Even if this was widely implemented (it's not),

The spec is in beta stage now.

And if it's not implemented, then simply the perf tool cannot make PMU 
aliases for those DDRC or similar PMUs (and we would find that the DDRC 
or similar JSON files for those platforms would not be added until it 
does support it).

>I still think that it's
> the wrong level of abstraction. 

As I said above, we could try to expand the PMU sysfs entries for this, 
but I have concerns on how we make some imp specific identifier or what 
this would look like.

Why not do away with ACPI/DT entirely
> and predicate everything off the SoC ID?

As constantly checking what the SoC ID means throughout system 
components does not scale.

John
