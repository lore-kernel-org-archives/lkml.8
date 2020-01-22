Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6E8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1A824680
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgAVLaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 06:30:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbgAVLaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:30:02 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DCEDA8B92F11E2311C26;
        Wed, 22 Jan 2020 19:29:59 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 Jan 2020
 19:29:49 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't confuse get_vlpi_map() by
 writing DB config
To:     Marc Zyngier <maz@kernel.org>
CC:     <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <wanghaibin.wang@huawei.com>
References: <20200122085609.658-1-yuzenghui@huawei.com>
 <4aaaad3ae7367c5c932c430e18550d9e@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <06a484bd-4f46-6884-1bee-9b7b65fd0856@huawei.com>
Date:   Wed, 22 Jan 2020 19:29:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <4aaaad3ae7367c5c932c430e18550d9e@kernel.org>
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

On 2020/1/22 18:44, Marc Zyngier wrote:
> Hi Zenghui,
> 
> Thanks for this.
> 
> On 2020-01-22 08:56, Zenghui Yu wrote:
>> When we're writing config for the doorbell interrupt, get_vlpi_map() will
>> get confused by doorbell's d->parent_data hack and find the wrong its_dev
>> as chip data and the wrong event.
>>
>> Fix this issue by making sure no doorbells will be involved before 
>> invoking
>> get_vlpi_map(), which restore some of the logic in lpi_write_config().
>>
>> Fixes: c1d4d5cd203c ("irqchip/gic-v3-its: Add its_vlpi_map helpers")
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>
>> This is based on mainline and can't be directly applied to the current
>> irqchip-next.
>>
>>  drivers/irqchip/irq-gic-v3-its.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index e05673bcd52b..cc8a4fcbd6d6 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1181,12 +1181,13 @@ static struct its_vlpi_map
>> *get_vlpi_map(struct irq_data *d)
>>
>>  static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
>>  {
>> -    struct its_vlpi_map *map = get_vlpi_map(d);
>>      irq_hw_number_t hwirq;
>>      void *va;
>>      u8 *cfg;
>>
>> -    if (map) {
>> +    if (irqd_is_forwarded_to_vcpu(d)) {
>> +        struct its_vlpi_map *map = get_vlpi_map(d);
>> +
>>          va = page_address(map->vm->vprop_page);
>>          hwirq = map->vintid;
> 
> Shouldn't we fix get_vlpi_map() instead? Something like (untested):
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index e05673bcd52b..b704214390c0 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1170,13 +1170,14 @@ static void its_send_vclear(struct its_device 
> *dev, u32 event_id)
>    */
>   static struct its_vlpi_map *get_vlpi_map(struct irq_data *d)
>   {
> -    struct its_device *its_dev = irq_data_get_irq_chip_data(d);
> -    u32 event = its_get_event_id(d);
> +    if (irqd_is_forwarded_to_vcpu(d)) {
> +        struct its_device *its_dev = irq_data_get_irq_chip_data(d);
> +        u32 event = its_get_event_id(d);
> 
> -    if (!irqd_is_forwarded_to_vcpu(d))
> -        return NULL;
> +        return dev_event_to_vlpi_map(its_dev, event);
> +    }
> 
> -    return dev_event_to_vlpi_map(its_dev, event);
> +    return NULL;
>   }
> 
>   static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
> 
> 
> Or am I missing the actual problem?

No. I also thought about fixing the issue by this way and I'm OK with
both approaches.

> 
> Overall, I'm starting to hate that ->parent hack as it's been the source
> of a number of bugs.

(thankfully it's rarely used and we've so far handled them carefully,
except the lpi_write_config issue in this patch...)

> 
> The main issue is that the VPE hierarchy is missing one level (it has
> no ITS domain, and goes directly from the VPE domain to the low-level
> GIC domain). It means we end-up special-casing things, and that's never
> good...

Yeah, this may comes from the fact that the per-vPE doorbell is not
served by ITS and can be asserted by redistributor directly. And the
special doorbell is programmed together with those normal LPI
(translated from MSI by ITS).


Thanks,
Zenghui

