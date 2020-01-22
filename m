Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490A1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC6721835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579706582;
	bh=I6Fm8pRywuvXE5eAUkUFAQZAHyzekaXyAPBr1svSKo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Y3/Ll8RZ+uzaR7SPGHrSLkuGWrecUGPiprJ6iY7TAMCUGs47wMQPx3Qu8ir5lY5v+
	 TvhqyXtUq/MB0mXEiIWuWLBSTviJdSv0KSfP2L6xUe6T+KTvozLXmuIafQgGm5ESeQ
	 PlcJlTwfX2/iwdXJHBDx18M/jqL7Db4OdzlEoEKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgAVPXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 10:23:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVPXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 10:23:00 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D22252071E;
        Wed, 22 Jan 2020 15:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579706580;
        bh=I6Fm8pRywuvXE5eAUkUFAQZAHyzekaXyAPBr1svSKo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JwTI5lg67kVcQZIQcX7ngbpqPVDrnWFO32tRtNk66TifmLRWur2b1K1wjX+ROG3X0
         XB30G7TCO7UebtCILqcyhNb14J2XasD7fQ/G27ccRi73U6HXREZSbiH9YsNPJiQ8dU
         m4lf4upiI6ZYcecFKp26B20XROJqHXZFQN7U8/6U=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1iuHqM-000m1N-1z; Wed, 22 Jan 2020 15:22:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 22 Jan 2020 15:22:58 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't confuse get_vlpi_map() by
 writing DB config
In-Reply-To: <06a484bd-4f46-6884-1bee-9b7b65fd0856@huawei.com>
References: <20200122085609.658-1-yuzenghui@huawei.com>
 <4aaaad3ae7367c5c932c430e18550d9e@kernel.org>
 <06a484bd-4f46-6884-1bee-9b7b65fd0856@huawei.com>
Message-ID: <b447c84c609e9799bbac6aada2ffb9ce@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-22 11:29, Zenghui Yu wrote:
> Hi Marc,
> 
> On 2020/1/22 18:44, Marc Zyngier wrote:
>> Hi Zenghui,
>> 
>> Thanks for this.
>> 
>> On 2020-01-22 08:56, Zenghui Yu wrote:
>>> When we're writing config for the doorbell interrupt, get_vlpi_map() 
>>> will
>>> get confused by doorbell's d->parent_data hack and find the wrong 
>>> its_dev
>>> as chip data and the wrong event.
>>> 
>>> Fix this issue by making sure no doorbells will be involved before 
>>> invoking
>>> get_vlpi_map(), which restore some of the logic in 
>>> lpi_write_config().
>>> 
>>> Fixes: c1d4d5cd203c ("irqchip/gic-v3-its: Add its_vlpi_map helpers")
>>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>>> ---
>>> 
>>> This is based on mainline and can't be directly applied to the 
>>> current
>>> irqchip-next.
>>> 
>>>  drivers/irqchip/irq-gic-v3-its.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>>> b/drivers/irqchip/irq-gic-v3-its.c
>>> index e05673bcd52b..cc8a4fcbd6d6 100644
>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>> @@ -1181,12 +1181,13 @@ static struct its_vlpi_map
>>> *get_vlpi_map(struct irq_data *d)
>>> 
>>>  static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
>>>  {
>>> -    struct its_vlpi_map *map = get_vlpi_map(d);
>>>      irq_hw_number_t hwirq;
>>>      void *va;
>>>      u8 *cfg;
>>> 
>>> -    if (map) {
>>> +    if (irqd_is_forwarded_to_vcpu(d)) {
>>> +        struct its_vlpi_map *map = get_vlpi_map(d);
>>> +
>>>          va = page_address(map->vm->vprop_page);
>>>          hwirq = map->vintid;
>> 
>> Shouldn't we fix get_vlpi_map() instead? Something like (untested):
>> 
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index e05673bcd52b..b704214390c0 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1170,13 +1170,14 @@ static void its_send_vclear(struct its_device 
>> *dev, u32 event_id)
>>    */
>>   static struct its_vlpi_map *get_vlpi_map(struct irq_data *d)
>>   {
>> -    struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>> -    u32 event = its_get_event_id(d);
>> +    if (irqd_is_forwarded_to_vcpu(d)) {
>> +        struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>> +        u32 event = its_get_event_id(d);
>> 
>> -    if (!irqd_is_forwarded_to_vcpu(d))
>> -        return NULL;
>> +        return dev_event_to_vlpi_map(its_dev, event);
>> +    }
>> 
>> -    return dev_event_to_vlpi_map(its_dev, event);
>> +    return NULL;
>>   }
>> 
>>   static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
>> 
>> 
>> Or am I missing the actual problem?
> 
> No. I also thought about fixing the issue by this way and I'm OK with
> both approaches.

OK, thanks. I've added this to irqchip-next[1], and rebased the v4.1
series on top of it. That way, the fix will trickle down to stable
without conflicts.

I've also given it a go on D05 with GICv4 enabled, and nothing caught 
fire.

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-next&id=093bf439fee0d40ade7e309c1288b409cdc3b38f
-- 
Jazz is not dead. It just smells funny...
