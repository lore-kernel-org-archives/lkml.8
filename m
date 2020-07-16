Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994F2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678FB204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgGPKXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:23:17 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2486 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbgGPKXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:23:16 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 863847D64898BC86D4B5;
        Thu, 16 Jul 2020 11:23:14 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.254) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 16 Jul
 2020 11:23:13 +0100
Subject: Re: [PATCH] drivers/perf: Fix kernel panic when rmmod PMU modules
 during perf sampling
To:     Will Deacon <will@kernel.org>, Qi Liu <liuqi115@huawei.com>
CC:     <zhangshaokun@hisilicon.com>, <mark.rutland@arm.com>,
        <wang.wanghaifeng@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <1594891165-8228-1-git-send-email-liuqi115@huawei.com>
 <20200716094144.GC6771@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <07cd8e16-6967-410a-4006-6c82b0263397@huawei.com>
Date:   Thu, 16 Jul 2020 11:21:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200716094144.GC6771@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.254]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2020 10:41, Will Deacon wrote:
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
> 

Isn't that something different? The perf framework knows nothing of the 
platform_device/driver really, and just knows the event_source device 
which it creates. And so we also need to tell the perf framework about 
the module backing this pmu.

I think some relevant code is perf_try_init_event() -> 
try_module_get(pmu->module).

Thanks,
John

