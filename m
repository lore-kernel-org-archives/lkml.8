Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD60FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832F92064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgGPK03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:26:29 -0400
Received: from foss.arm.com ([217.140.110.172]:52830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgGPK02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:26:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 315A91FB;
        Thu, 16 Jul 2020 03:26:28 -0700 (PDT)
Received: from [10.57.35.46] (unknown [10.57.35.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDA633F68F;
        Thu, 16 Jul 2020 03:26:26 -0700 (PDT)
Subject: Re: [PATCH] drivers/perf: Fix kernel panic when rmmod PMU modules
 during perf sampling
To:     Will Deacon <will@kernel.org>, Qi Liu <liuqi115@huawei.com>
Cc:     mark.rutland@arm.com, john.garry@huawei.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhangshaokun@hisilicon.com, wang.wanghaifeng@huawei.com,
        linux-arm-kernel@lists.infradead.org
References: <1594891165-8228-1-git-send-email-liuqi115@huawei.com>
 <20200716094144.GC6771@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a0f3d0c2-6a08-16a5-f7e9-42ac1d96ea11@arm.com>
Date:   Thu, 16 Jul 2020 11:26:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716094144.GC6771@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-16 10:41, Will Deacon wrote:
> On Thu, Jul 16, 2020 at 05:19:25PM +0800, Qi Liu wrote:
>> Kernel panic will also happen when users try to unbind PMU drivers with
>> device. This unbind issue could be solved by another patch latter.
>>
>>   drivers/perf/arm_smmuv3_pmu.c                 | 1 +
>>   drivers/perf/fsl_imx8_ddr_perf.c              | 1 +
>>   drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 1 +
>>   drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 1 +
>>   drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 1 +
>>   5 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
>> index 48e28ef..90caba56 100644
>> --- a/drivers/perf/arm_smmuv3_pmu.c
>> +++ b/drivers/perf/arm_smmuv3_pmu.c
>> @@ -742,6 +742,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>>   	platform_set_drvdata(pdev, smmu_pmu);
>>
>>   	smmu_pmu->pmu = (struct pmu) {
>> +		.module		= THIS_MODULE,
> 
> I thought platform_driver_register() did this automatically?

For the platform device itself, yes, but this is for the PMU device - 
perf needs to take a reference to the module, otherwise the platform 
device can still be pulled out from under its feet.

I can't remember if we ever discussed making perf_pmu_register() do the 
same trick as platform_device_register() and friends, but obviously it's 
a possibility.

Robin.
