Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0A8C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3972168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgBMPMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:12:03 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726937AbgBMPMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:12:02 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 87457483DF8DF9ECD8F4;
        Thu, 13 Feb 2020 23:11:59 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 23:11:52 +0800
Subject: Re: [PATCH v2 3/6] irqchip/gic-v4.1: Ensure L2 vPE table is allocated
 at RD level
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>
References: <20200206075711.1275-1-yuzenghui@huawei.com>
 <20200206075711.1275-4-yuzenghui@huawei.com>
 <2f6a27ac57aef9b948952c210c9a5882@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <b1cdce3f-0c0e-8b78-0fe0-f4114190caa3@huawei.com>
Date:   Thu, 13 Feb 2020 23:11:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <2f6a27ac57aef9b948952c210c9a5882@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/2/13 22:22, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On 2020-02-06 07:57, Zenghui Yu wrote:
>> In GICv4, we will ensure that level2 vPE table memory is allocated
>> for the specified vpe_id on all v4 ITS, in its_alloc_vpe_table().
>> This still works well for the typical GICv4.1 implementation, where
>> the new vPE table is shared between the ITSs and the RDs.
>>
>> To make it explicit, let us introduce allocate_vpe_l2_table() to
>> make sure that the L2 tables are allocated on all v4.1 RDs. We're
>> likely not need to allocate memory in it because the vPE table is
>> shared and (L2 table is) already allocated at ITS level, except
>> for the case where the ITS doesn't share anything (say SVPET == 0,
>> practically unlikely but architecturally allowed).
>>
>> The implementation of allocate_vpe_l2_table() is mostly copied from
>> its_alloc_table_entry().
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 80 ++++++++++++++++++++++++++++++++
>>  1 file changed, 80 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 0f1fe56ce0af..ae4e7b355b46 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -2443,6 +2443,72 @@ static u64 
>> inherit_vpe_l1_table_from_rd(cpumask_t **mask)
>>      return 0;
>>  }
>>
>> +static bool allocate_vpe_l2_table(int cpu, u32 id)
>> +{
>> +    void __iomem *base = gic_data_rdist_cpu(cpu)->rd_base;
>> +    u64 val, gpsz, npg;
>> +    unsigned int psz, esz, idx;
>> +    struct page *page;
>> +    __le64 *table;
>> +
>> +    if (!gic_rdists->has_rvpeid)
>> +        return true;
>> +
>> +    val  = gits_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
> 
> Having rebased the rest of the GICv4.1 series on top of -rc1, I've hit a 
> small
> issue right here. I run a FVP model that only spawns 4 CPUs, while the 
> DT has
> 8 of them. This means that online_cpus = 4, and possible_cpus = 8.
> 
> So in my case, half of the RDs have base == NULL, and things stop quickly.

Ah, so this may also be why we check '!base' for each possible CPU in
inherit_vpe_l1_table_from_rd(). I didn't think about it at that time.

> 
> I plan to queue the following:
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index d85dc8dcb0ad..7656b353a95f 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2526,6 +2526,10 @@ static bool allocate_vpe_l2_table(int cpu, u32 id)
>       if (!gic_rdists->has_rvpeid)
>           return true;
> 
> +    /* Skip non-present CPUs */
> +    if (!base)
> +        return true;
> +
>       val  = gicr_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
> 
>       esz  = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val) + 1;

Thanks for fixing the second bug for this patch :-)


Zenghui

