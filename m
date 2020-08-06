Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4703C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C26206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735779;
	bh=jpYTCCwR4fZP8SyH14e+ACdHwa6e8RH80YNL1hLi6L8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HxrOV3ygaHglVqwygMEVMkG3l5TCKq/tKg9RJtlz+6rxRXxvidKCh3uUr/MDKv9rQ
	 IP/8d90rJ5cCeg+En4UFNg4Hz6CFWqf6+PKxMYark1SvgxhODiuFvwDuH74BVL6NhJ
	 OM8EQ+e7oRMejlj+EpLV/jzSoMHPre6j8b/cNkGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgHFRmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbgHFRbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:31:43 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF96B22CF6;
        Thu,  6 Aug 2020 12:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596716738;
        bh=jpYTCCwR4fZP8SyH14e+ACdHwa6e8RH80YNL1hLi6L8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IRZhR4rjAD9KvhCFxHEGYa6XFLYelDK0rOrJrpXDwilVmtTt1wRyxDSC4Wswclshs
         B9Q7GB075Ei7Z37D1jXxrm1iIYpDK/dls9Z2XQoCLXwexQHnOD9Fobkp8o7ddWlAJ0
         IUPhOkDgbXgI0PhArND5uIY0mRYirezqMMpSjl2A=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k3exk-000Gxu-7i; Thu, 06 Aug 2020 13:25:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Aug 2020 13:25:35 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jason Liu <jason.hui.liu@nxp.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask if it
 already masked
In-Reply-To: <VI1PR0402MB38249815EA37338953E8AAC1AE480@VI1PR0402MB3824.eurprd04.prod.outlook.com>
References: <20200804085657.10776-1-jason.hui.liu@nxp.com>
 <b4444c737f9d6fd8fd99dbb809d35a0f@kernel.org> <20200804113850.GB15199@bogus>
 <VI1PR0402MB38243230C51FDB1C3F490853AE4B0@VI1PR0402MB3824.eurprd04.prod.outlook.com>
 <3c63ae0cc3a7b5bad5d4638a9870340e@kernel.org>
 <VI1PR0402MB38249815EA37338953E8AAC1AE480@VI1PR0402MB3824.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <1e4496c263e486be3438f2797630164a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: jason.hui.liu@nxp.com, sudeep.holla@arm.com, catalin.marinas@arm.com, will@kernel.org, sashal@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-06 11:05, Jason Liu wrote:
>> -----Original Message-----
>> From: Marc Zyngier <maz@kernel.org>

[...]

>> > No, this patch is not papering over a much deeper issue in the driver.
>> > This is just to make things better for the ARM64 kexec.
>> 
>> Yes, I'm sure it is... However:
>> 
>> request_irq()
>> <goes into suspend, panic somewhere after having turned the irqchip 
>> clock off>
>> if (chip->irq_mask && !irqd_irq_masked(&desc->irq_data))
>>      <explodes, as the interrupt isn't masked>
>> 
>> This is because the PM in the irqsteer driver is completely busted:
>> request_irq() should get a reference on the driver to prevent it from 
>> being
>> suspended. Since you don't implement it correctly, this doesn't happen 
>> and
>> your "improvement" doesn't help at all.
> 
> The request_irq will get a reference to prevent the irqchip from being
> suspended due to it call
> irq_chip_pm_get(). I am pretty sure we have implemented correctly and
> that is also the common Linux code.

Then it seems you cannot read your own driver. At no point do you
set the parent_device that would give you a fighting chance to
get the device clocked and powered on. How does it work? Magic?

> In order to save power and let the irqchip enter into runtime SUSPEND
> mode, the driver will call free_irq()
> When it was not used(idle). Then free_irq() will decrease the
> reference and let the irqchip enter suspend state.

The reference count on *what*? There is nothing to take a reference
on. So yes, you understand how the core kernel works. But you don't
seem to notice that there is no link between the irq and the device
that implements the controller.

> So, when the irqchip entered suspend, which means there is no user for
> the irqchip and all the irqs were DISABLED + MASKED.
> Due to the runtimePM support for the irqchip, when kexec runs, it will
> sometimes meet the situation that the irqchip is suspend due to
> no users for it. So from either the performance(time cost) or coding
> logic, the machine_kexec_mask_interrupts() should not do
> double mask for the irqs which already masked.

I strongly suggest you start by fixing the damn driver first.

In the meantime, NAK to this patch.

         M.
-- 
Jazz is not dead. It just smells funny...
