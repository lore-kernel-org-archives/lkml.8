Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4979FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1062078C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGPKiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:38:01 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726894AbgGPKiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:38:00 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E3D58E3A008D52B700C1;
        Thu, 16 Jul 2020 11:37:58 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.254) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 16 Jul
 2020 11:37:57 +0100
Subject: Re: [PATCH] drivers/perf: Fix kernel panic when rmmod PMU modules
 during perf sampling
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC:     Qi Liu <liuqi115@huawei.com>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>, <wang.wanghaifeng@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1594891165-8228-1-git-send-email-liuqi115@huawei.com>
 <20200716094144.GC6771@willie-the-truck>
 <a0f3d0c2-6a08-16a5-f7e9-42ac1d96ea11@arm.com>
 <20200716103058.GE7036@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <66a8eb37-b91a-d228-4ea4-8601e5518b31@huawei.com>
Date:   Thu, 16 Jul 2020 11:36:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200716103058.GE7036@willie-the-truck>
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

On 16/07/2020 11:30, Will Deacon wrote:
> On Thu, Jul 16, 2020 at 11:26:25AM +0100, Robin Murphy wrote:
>> On 2020-07-16 10:41, Will Deacon wrote:
>>> On Thu, Jul 16, 2020 at 05:19:25PM +0800, Qi Liu wrote:
>>>> Kernel panic will also happen when users try to unbind PMU drivers with
>>>> device. This unbind issue could be solved by another patch latter.
>>>>
>>>>    drivers/perf/arm_smmuv3_pmu.c                 | 1 +
>>>>    drivers/perf/fsl_imx8_ddr_perf.c              | 1 +
>>>>    drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 1 +
>>>>    drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 1 +
>>>>    drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 1 +
>>>>    5 files changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
>>>> index 48e28ef..90caba56 100644
>>>> --- a/drivers/perf/arm_smmuv3_pmu.c
>>>> +++ b/drivers/perf/arm_smmuv3_pmu.c
>>>> @@ -742,6 +742,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>>>>    	platform_set_drvdata(pdev, smmu_pmu);
>>>>
>>>>    	smmu_pmu->pmu = (struct pmu) {
>>>> +		.module		= THIS_MODULE,
>>> I thought platform_driver_register() did this automatically?
>> For the platform device itself, yes, but this is for the PMU device - perf
>> needs to take a reference to the module, otherwise the platform device can
>> still be pulled out from under its feet.
> Urgh, gross.
> 
>> I can't remember if we ever discussed making perf_pmu_register() do the same
>> trick as platform_device_register() and friends, but obviously it's a
>> possibility.
> Yeah, but I suppose this patch is the right thing to do for now. I'll queue
> it as a fix.
> 

Please also note what Qi Liu wrote about being able to unbind the driver 
and cause the same issue. I don't know if you can about that issue also.

