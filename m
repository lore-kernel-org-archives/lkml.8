Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11422C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06842077A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584558669;
	bh=i8/4x4L6BzJAkJGRo/v8prKLCHA1ASdllNL4i+xuPoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XU8mIZrvBrEAtbihqyUUMpBms+mYoPEkB4g6lnuMQ9LmQelU8SCcjdtrlXmG+1cqs
	 ulsrVlG6vKH/L0fXsCR8XjMDnIiBXwivtrcI5/S2ntEBo5Q6T7FPgtJxm7Noc8+2lD
	 ehTCjORaLa8anW3wwwURYys41JRlWvIRC+Ub9qf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCRTLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgCRTLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:11:08 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6795320768;
        Wed, 18 Mar 2020 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584558667;
        bh=i8/4x4L6BzJAkJGRo/v8prKLCHA1ASdllNL4i+xuPoM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dt0nHeg7Qcu0KW7uQbQ2qwUrNujsVAuLeAiJrrKBfvfGCVCeKWWsB3VlZn9e3qlsd
         QyqJnS9r2Z3UhO8B52td/QEWvjPisF6g94G9C+MWp7pHHwNHTABvj0mCKpZDUQqGSq
         HNXZA2KunSE7Uzunjz/1sR2GT5XB7FE8uNPWTvbY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jEe5p-00Diha-NV; Wed, 18 Mar 2020 19:11:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 18 Mar 2020 19:11:05 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     linux-oxnas@groups.io, Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] irqchip/versatile-fpga: Handle chained IRQs properly
In-Reply-To: <bdb90bd8-ede1-63d5-816c-57f6bf0417a4@gorani.run>
References: <20200318170904.1461278-1-mans0n@gorani.run>
 <112cdab389aa9cc30189c7aec0baded2@kernel.org>
 <bdb90bd8-ede1-63d5-816c-57f6bf0417a4@gorani.run>
Message-ID: <002b72cab9896fa5ac76a52e0cb503ff@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mans0n@gorani.run, linux-oxnas@groups.io, linus.walleij@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, narmstrong@baylibre.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-18 18:20, Sungbo Eo wrote:
> Hi Marc,
> 
> On 2020-03-19 02:48, Marc Zyngier wrote:
>> Hi Sungbo,
>> 
>> On 2020-03-18 17:09, Sungbo Eo wrote:
>>> Enclose the chained handler with chained_irq_{enter,exit}(), so that 
>>> the
>>> muxed interrupts get properly acked.
>>> 
>>> This patch also fixes a reboot bug on OX820 SoC, where the jiffies 
>>> timer
>>> interrupt is never acked. The kernel waits a clock tick forever in
>>> calibrate_delay_converge(), which leads to a boot hang.
>> 
>> Nice catch.
>> 
>>> 
>>> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
>>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  drivers/irqchip/irq-versatile-fpga.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/irqchip/irq-versatile-fpga.c
>>> b/drivers/irqchip/irq-versatile-fpga.c
>>> index 928858dada75..08faab2fec3e 100644
>>> --- a/drivers/irqchip/irq-versatile-fpga.c
>>> +++ b/drivers/irqchip/irq-versatile-fpga.c
>>> @@ -6,6 +6,7 @@
>>>  #include <linux/irq.h>
>>>  #include <linux/io.h>
>>>  #include <linux/irqchip.h>
>>> +#include <linux/irqchip/chained_irq.h>
>>>  #include <linux/irqchip/versatile-fpga.h>
>>>  #include <linux/irqdomain.h>
>>>  #include <linux/module.h>
>>> @@ -68,12 +69,15 @@ static void fpga_irq_unmask(struct irq_data *d)
>>> 
>>>  static void fpga_irq_handle(struct irq_desc *desc)
>>>  {
>>> +    struct irq_chip *chip = irq_desc_get_chip(desc);
>>>      struct fpga_irq_data *f = irq_desc_get_handler_data(desc);
>>>      u32 status = readl(f->base + IRQ_STATUS);
>>> 
>>> +    chained_irq_enter(chip, desc);
>>> +
>> 
>> It's probably not a big deal, but I'm not fond of starting talking to
>> the muxing irqchip before having done the chained_irq_enter() call.
>> 
>> Moving that read here would probably be safer.
> 
> Oops, I missed it. Thanks for pointing it out.
> 
>> 
>>>      if (status == 0) {
>>>          do_bad_IRQ(desc);
>>> -        return;
>>> +        goto out;
>>>      }
>>> 
>>>      do {
>>> @@ -82,6 +86,9 @@ static void fpga_irq_handle(struct irq_desc *desc)
>>>          status &= ~(1 << irq);
>>>          generic_handle_irq(irq_find_mapping(f->domain, irq));
>>>      } while (status);
>>> +
>>> +out:
>>> +    chained_irq_exit(chip, desc);
>>>  }
>>> 
>>>  /*
>> 
>> Otherwise looks good. If you send it again with the above fixed
>> and a Fixes: tag, I'll queue it.
> 
> It seems the handler had been broken from the very beginning. Could
> you give me a hint on how the tag should be like?

Indeed, it has been broken forever. I'm tempted to say:

Fixes: c41b16f8c9d9d ("ARM: integrator/versatile: consolidate FPGA IRQ 
handling code")

even if it probably predates the introduction of the chained_irq_enter() 
helpers.
This will ensure this gets backported to older kernels...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
