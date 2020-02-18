Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A60C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1036F2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgBRNYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:24:42 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbgBRNYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:24:42 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 7A16C82D34BC3905797B;
        Tue, 18 Feb 2020 13:24:40 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Feb 2020 13:24:40 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Tue, 18 Feb
 2020 13:24:39 +0000
Subject: Re: [PATCH RFC 0/7] perf pmu-events: Support event aliasing for
 system PMUs
To:     Will Deacon <will@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <james.clark@arm.com>, <zhangshaokun@hisilicon.com>,
        <robin.murphy@arm.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <20200218125707.GB20212@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a40903fe-d52f-96c6-a06a-fe834d71d625@huawei.com>
Date:   Tue, 18 Feb 2020 13:24:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200218125707.GB20212@willie-the-truck>
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

On 18/02/2020 12:57, Will Deacon wrote:
> On Fri, Jan 24, 2020 at 10:34:58PM +0800, John Garry wrote:
>> Currently event aliasing for only CPU and uncore PMUs is supported. In
>> fact, only uncore PMUs aliasing for when the uncore PMUs are fixed for a
>> CPU is supported, which may not always be the case for certain
>> architectures.
>>
>> This series adds support for PMU event aliasing for system and other
>> uncore PMUs which are not fixed to a specific CPU.
>>
>> For this, we introduce support for another per-arch mapfile, which maps a
>> particular system identifier to a set of system PMU events for that
>> system. This is much the same as what we do for CPU event aliasing.
>>
>> To support this, we need to change how we match a PMU to a mapfile,
>> whether it should use a CPU or system mapfile. For this we do the
>> following:
>>
>> - For CPU PMU, we always match for the event mapfile based on the CPUID.
>>    This has not changed.
>>
>> - For an uncore or system PMU, we match first based on the SYSID (if set).
>>    If this fails, then we match on the CPUID.
>>
>>    This works for x86, as x86 would not have any system mapfiles for uncore
>>    PMUs (and match on the CPUID).
>>
>> Initial reference support is also added for ARM SMMUv3 PMCG (Performance
>> Monitor Event Group) PMU for HiSilicon hip08 platform with only a single
>> event so far - see driver in drivers/perf/arm_smmuv3_pmu.c for that driver.
> 
> Why don't we just expose SMMU_IIDR in the SMMUv3 PMU directory, so that
> you can key off that? 

That does not sound like a standard sysfs interface.

Anyway, I don't think that works for every case, quoting from 
https://lkml.org/lkml/2019/10/16/465:

"> Note: I do acknowledge that an overall issue is that we assume all 
PMCG IMP DEF events are same for a given SMMU model.

That assumption does technically fail already - I know MMU-600 has
different IMP-DEF events for its TCU and TBUs, however as long as we can
get as far as "this is some part of an MMU-600" the driver should be
able to figure out the rest ..."

So even if it is solvable here, the kernel driver(s) will need to be 
reworked. And that is just solving one case in many.

I'm nervous about coming up with a global "SYSID"
> when we don't have the ability to standardise anything in that space.

I understand totally, especially if any sysid is based on DT bindings.

But this is some sort of standardization:
https://developer.arm.com/docs/den0028/c, see SMCCC_ARCH_SOC_ID

John
