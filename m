Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2999C2BB86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A304E20B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i/wAPC2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDILLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:11:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56888 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDILLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:11:36 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 039BBJcq106985;
        Thu, 9 Apr 2020 06:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586430679;
        bh=E8tVnmNNO/6VeJ/pnizdaaUgKBPhHIA/HRlOTtiF0JQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=i/wAPC2YVcfdMrzt+LiAwyLGuDfxSYteoAx6ZWWevHYH2uXsA9oetr7TQF+Dm8wpI
         +n+92Em4VqNYwUC+jt67NhODhNELjbcatkrJocY+uTc6EbWYu/c81PKKzC4JR6OptM
         ECF8buK0rLt2enK/ZiDr5CvgM69VOwKHw1ABzNN4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 039BBJPI045541;
        Thu, 9 Apr 2020 06:11:19 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 9 Apr
 2020 06:11:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 9 Apr 2020 06:11:18 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 039BBDME125366;
        Thu, 9 Apr 2020 06:11:13 -0500
Subject: Re: [PATCH] irqchip/ti-sci-inta: fix processing of masked irqs
To:     Marc Zyngier <maz@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20200408191532.31252-1-grygorii.strashko@ti.com>
 <20200409103144.3b2169bf@why>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <851d5063-475e-ea7b-6609-684b08283550@ti.com>
Date:   Thu, 9 Apr 2020 14:11:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200409103144.3b2169bf@why>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/2020 12:31, Marc Zyngier wrote:
> On Wed, 8 Apr 2020 22:15:32 +0300
> Grygorii Strashko <grygorii.strashko@ti.com> wrote:
> 
>> The ti_sci_inta_irq_handler() does not take into account INTA IRQs state
>> (masked/unmasked) as it uses INTA_STATUS_CLEAR_j register to get INTA IRQs
>> status, which provides raw status value.
>> This causes hard IRQ handlers to be called or threaded handlers to be
>> scheduled many times even if corresponding INTA IRQ is masked.
>> Above, first of all, affects the LEVEL interrupts processing and causes
>> unexpected behavior up the system stack or crash.
>>
>> Fix it by using the Interrupt Masked Status INTA_STATUSM_j register which
>> provides masked INTA IRQs status.
>>
>> Fixes: 9f1463b86c13 ("irqchip/ti-sci-inta: Add support for Interrupt Aggregator driver")
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Given the failure mode, doesn't this deserve a Cc stable?

Sorry, was not sure how it works here.
"Fixes" tag now is usually enough to get included in stable.
Any way, I'll track it and if not included will re-send for stable.

> 
>> ---
>>   drivers/irqchip/irq-ti-sci-inta.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
>> index 8f6e6b08eadf..7e3ebf6ed2cd 100644
>> --- a/drivers/irqchip/irq-ti-sci-inta.c
>> +++ b/drivers/irqchip/irq-ti-sci-inta.c
>> @@ -37,6 +37,7 @@
>>   #define VINT_ENABLE_SET_OFFSET	0x0
>>   #define VINT_ENABLE_CLR_OFFSET	0x8
>>   #define VINT_STATUS_OFFSET	0x18
>> +#define VINT_STATUS_MASKED_OFFSET	0x20
>>   
>>   /**
>>    * struct ti_sci_inta_event_desc - Description of an event coming to
>> @@ -116,7 +117,7 @@ static void ti_sci_inta_irq_handler(struct irq_desc *desc)
>>   	chained_irq_enter(irq_desc_get_chip(desc), desc);
>>   
>>   	val = readq_relaxed(inta->base + vint_desc->vint_id * 0x1000 +
>> -			    VINT_STATUS_OFFSET);
>> +			    VINT_STATUS_MASKED_OFFSET);
>>   
>>   	for_each_set_bit(bit, &val, MAX_EVENTS_PER_VINT) {
>>   		virq = irq_find_mapping(domain, vint_desc->events[bit].hwirq);
> 
> 
> Otherwise queued for post -rc1.

Thanks.

-- 
Best regards,
grygorii
