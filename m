Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED5EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB872080C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597313338;
	bh=nsoK2lVbOKDQ4GSO14CBSj3EPe+//8yAv/WHujwP4Jk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TIaH9L1zyYSxKsstnVgvioUbKQFf/0NoCJu4+DJbQiUTfYx63FV/0WY9U93Ac/cLW
	 3OvRp+5BnNtyaWVq4CuIrciBGetgSmiiJX9BnWMKwCj17IzKypI2pxqvW5QzNnsrwP
	 ve3LJBHn2ux6AKxWD0/8vzrU7Ojy200HPHk35Ylk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHMKI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgHMKI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:08:56 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE2CC20781;
        Thu, 13 Aug 2020 10:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597313336;
        bh=nsoK2lVbOKDQ4GSO14CBSj3EPe+//8yAv/WHujwP4Jk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OJ+zI1X3X0dfUgs29Jm/QGJTVyzT4CufV1NIRx15ih+0h3wzlVKKRQf9ZZBZcaRH0
         UI9UPmVyj2SbGvZUX+Yw9S5rGvROaBqeuzGlKyuVIN6H3781Us0hGUE5sEb4RuchfK
         lFWI2RgPgBwVzeLKfEnppRfA34/emwBv7Xts62Js=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k6AAI-001ko4-CX; Thu, 13 Aug 2020 11:08:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 13 Aug 2020 11:08:54 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jason Liu <jason.hui.liu@nxp.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask if it
 already masked
In-Reply-To: <VI1PR0402MB3824B4D3BF37335FE48A12F1AE430@VI1PR0402MB3824.eurprd04.prod.outlook.com>
References: <20200804085657.10776-1-jason.hui.liu@nxp.com>
 <b4444c737f9d6fd8fd99dbb809d35a0f@kernel.org> <20200804113850.GB15199@bogus>
 <VI1PR0402MB38243230C51FDB1C3F490853AE4B0@VI1PR0402MB3824.eurprd04.prod.outlook.com>
 <3c63ae0cc3a7b5bad5d4638a9870340e@kernel.org>
 <VI1PR0402MB38249815EA37338953E8AAC1AE480@VI1PR0402MB3824.eurprd04.prod.outlook.com>
 <1e4496c263e486be3438f2797630164a@kernel.org>
 <VI1PR0402MB3824B4D3BF37335FE48A12F1AE430@VI1PR0402MB3824.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <01b7091e69d2b4e51f280b05f6218a65@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: jason.hui.liu@nxp.com, sudeep.holla@arm.com, catalin.marinas@arm.com, will@kernel.org, sashal@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-13 07:03, Jason Liu wrote:
>> -----Original Message-----
>> From: Marc Zyngier <maz@kernel.org>
>> Sent: Thursday, August 6, 2020 8:26 PM
>> To: Jason Liu <jason.hui.liu@nxp.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>; catalin.marinas@arm.com;
>> will@kernel.org; sashal@kernel.org; linux-kernel@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH 1/1] arm64: kexec: no need to do 
>> irq_chip->irq_mask if it
>> already masked
>> 
>> On 2020-08-06 11:05, Jason Liu wrote:
>> >> -----Original Message-----
>> >> From: Marc Zyngier <maz@kernel.org>
>> 
>> [...]
>> 
>> >> > No, this patch is not papering over a much deeper issue in the driver.
>> >> > This is just to make things better for the ARM64 kexec.
>> >>
>> >> Yes, I'm sure it is... However:
>> >>
>> >> request_irq()
>> >> <goes into suspend, panic somewhere after having turned the irqchip
>> >> clock off> if (chip->irq_mask && !irqd_irq_masked(&desc->irq_data))
>> >>      <explodes, as the interrupt isn't masked>
>> >>
>> >> This is because the PM in the irqsteer driver is completely busted:
>> >> request_irq() should get a reference on the driver to prevent it from
>> >> being suspended. Since you don't implement it correctly, this doesn't
>> >> happen and your "improvement" doesn't help at all.
>> >
>> > The request_irq will get a reference to prevent the irqchip from being
>> > suspended due to it call irq_chip_pm_get(). I am pretty sure we have
>> > implemented correctly and that is also the common Linux code.
>> 
>> Then it seems you cannot read your own driver. At no point do you set 
>> the
>> parent_device that would give you a fighting chance to get the device 
>> clocked
>> and powered on. How does it work? Magic?
>> 
>> > In order to save power and let the irqchip enter into runtime SUSPEND
>> > mode, the driver will call free_irq() When it was not used(idle). Then
>> > free_irq() will decrease the reference and let the irqchip enter
>> > suspend state.
>> 
>> The reference count on *what*? There is nothing to take a reference 
>> on. So yes,
>> you understand how the core kernel works. But you don't seem to notice 
>> that
>> there is no link between the irq and the device that implements the 
>> controller.
> 
> See the code, it will call irq_chip_pm_put(&desc->irq_data)
> 
> /*
>  * Internal function to unregister an irqaction - used to free
>  * regular and special interrupts that are part of the architecture.
>  */
> static struct irqaction *__free_irq(struct irq_desc *desc, void 
> *dev_id)
> {
> ..
>         irq_chip_pm_put(&desc->irq_data);
>         module_put(desc->owner);
>         kfree(action->secondary);
>         return action;
> }

This is getting tiresome. You want to play the code-quote game?

int irq_chip_pm_put(struct irq_data *data)
{
	int retval = 0;

	if (IS_ENABLED(CONFIG_PM) && data->chip->parent_device)
		retval = pm_runtime_put(data->chip->parent_device);

	return (retval < 0) ? retval : 0;
}

What is parent_device set to in your driver? Oh wait... Nothing.
So what does the code you quoted do? Not much.

>> > So, when the irqchip entered suspend, which means there is no user for
>> > the irqchip and all the irqs were DISABLED + MASKED.
>> > Due to the runtimePM support for the irqchip, when kexec runs, it will
>> > sometimes meet the situation that the irqchip is suspend due to no
>> > users for it. So from either the performance(time cost) or coding
>> > logic, the machine_kexec_mask_interrupts() should not do double mask
>> > for the irqs which already masked.
>> 
>> I strongly suggest you start by fixing the damn driver first.
> 
> Our driver does not have issue at all. What to fix?

[I've censored myself here...]

> 
>> 
>> In the meantime, NAK to this patch.
> 
> Anyway, it seems don't really understand this issue and you just
> simply reject one reasonable fix. Sounds not good at all.

I reject it because your approach is flawed, and that you are
papering over a glaring bug in your driver that you are refusing
to fix.

Maybe the right thing to do is to remove this driver from the code
base altogether. I will prepare a patch to that effect.

         M.
-- 
Jazz is not dead. It just smells funny...
