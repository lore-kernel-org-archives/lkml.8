Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE803C35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03C3206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgBXCXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:23:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11101 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727223AbgBXCW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:22:59 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4F1811C461BE87A593FA;
        Mon, 24 Feb 2020 10:22:54 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.228) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Feb 2020
 10:22:45 +0800
Subject: Re: [PATCH] irq/gic-its: gicv4: set VPENDING table as inner-shareable
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20191130073849.38378-1-guoheyi@huawei.com>
 <20191201180434.1dba3116@why>
From:   Heyi Guo <guoheyi@huawei.com>
Message-ID: <3de7a72f-1a15-c908-57e6-35eff00b1ca6@huawei.com>
Date:   Mon, 24 Feb 2020 10:22:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191201180434.1dba3116@why>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/12/2 2:04, Marc Zyngier wrote:
> On Sat, 30 Nov 2019 15:38:49 +0800
> Heyi Guo <guoheyi@huawei.com> wrote:
>
>> There is no special reason to set virtual LPI pending table as
>> non-shareable. If we choose to hard code the shareability without
>> probing, inner-shareable will be a better choice, for all the other
>> ITS/GICR tables prefer to be inner-shareable.
> One of the issues is that we have strictly no idea what the caches are
> Inner Shareable with (I've been asking for such clarification for years
> without getting anywhere). You can have as many disconnected inner
> shareable domains as you want!
>
> I suspect that in the grand scheme of things, the redistributors
> ought to be in the same inner shareable domain, and that with a bit of
> luck, the CPUs are there as well. Still, that's a massive guess.
>
>> What's more, on Hisilicon hip08 it will trigger some kind of bus
>> warning when mixing use of different shareabilities.
> Do you have more information about what the bus is complaining about?
> Is that because the CPUs have these pages mapped as inner shareable?
>
> I'll give it a go on D05 (HIP07) to find out what changes there.

How's your go on D05? Did you see any issues?

Thanks,

Heyi


>
> Thanks,
>
> 	M.
>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c   | 2 +-
>>   include/linux/irqchip/arm-gic-v3.h | 3 +++
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 787e8eec9a7f..d31e863bc9ef 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -2831,7 +2831,7 @@ static void its_vpe_schedule(struct its_vpe *vpe)
>>   	val  = virt_to_phys(page_address(vpe->vpt_page)) &
>>   		GENMASK_ULL(51, 16);
>>   	val |= GICR_VPENDBASER_RaWaWb;
>> -	val |= GICR_VPENDBASER_NonShareable;
>> +	val |= GICR_VPENDBASER_InnerShareable;
>>   	/*
>>   	 * There is no good way of finding out if the pending table is
>>   	 * empty as we can race against the doorbell interrupt very
>> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
>> index 5cc10cf7cb3e..a184f875e451 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -289,6 +289,9 @@
>>   #define GICR_VPENDBASER_NonShareable					\
>>   	GIC_BASER_SHAREABILITY(GICR_VPENDBASER, NonShareable)
>>   
>> +#define GICR_VPENDBASER_InnerShareable					\
>> +	GIC_BASER_SHAREABILITY(GICR_VPENDBASER, InnerShareable)
>> +
>>   #define GICR_VPENDBASER_nCnB	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, nCnB)
>>   #define GICR_VPENDBASER_nC 	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, nC)
>>   #define GICR_VPENDBASER_RaWt	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, RaWt)
>
>

