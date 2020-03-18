Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F03C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBA520663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gorani.run header.i=@gorani.run header.b="h5ay3Dk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCSIOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:14:40 -0400
Received: from mout-u-204.mailbox.org ([91.198.250.253]:21838 "EHLO
        mout-u-204.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgCSIOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:14:39 -0400
Received: by mout-u-204.mailbox.org (Postfix, from userid 51)
        id 48jfcM4HJWzQlGP; Thu, 19 Mar 2020 08:05:14 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 48jJHZ6lt0zQlG0;
        Wed, 18 Mar 2020 19:20:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1584555625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O7m4lvrIqRs2bqX0fJ398lumr7Ad9ngJFhRhZgfuKUA=;
        b=h5ay3Dk8OATxLJQjj+ENRkkXBjclmZmucQCN6amcMPzC/kCrPcz++Ro4l6OKO+wETezw8E
        wm/LEL5Jq8uf24RZWv5i3rWLZyq4CIND+trc+fWbteI/jzEhhZhZW55HlhuiAmYIrunFUl
        2eVB4rraD9m2oK6edmXFCq4UrrUASgI9X84v68i+pwIfJADMJI8IpxLCVieUUzCTQU9Fdb
        wZJiNSdC9Dp4kUUWWcPRb0fmjgzaGpN1JdQ1C/Sz8xZGO3z5vTBZ76IqqwDN8vNq3Dbji6
        mBKvJC1lR8O1LI9YPjkV8Ut2kBtDEHjbhfC28j7rSwrQTYVI+sU3DGi/mmZIvQ==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id U7p6m9PGs4Mx; Wed, 18 Mar 2020 19:20:24 +0100 (CET)
Subject: Re: [PATCH] irqchip/versatile-fpga: Handle chained IRQs properly
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-oxnas@groups.io, Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
References: <20200318170904.1461278-1-mans0n@gorani.run>
 <112cdab389aa9cc30189c7aec0baded2@kernel.org>
From:   Sungbo Eo <mans0n@gorani.run>
Message-ID: <bdb90bd8-ede1-63d5-816c-57f6bf0417a4@gorani.run>
Date:   Thu, 19 Mar 2020 03:20:13 +0900
MIME-Version: 1.0
In-Reply-To: <112cdab389aa9cc30189c7aec0baded2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020-03-19 02:48, Marc Zyngier wrote:
> Hi Sungbo,
> 
> On 2020-03-18 17:09, Sungbo Eo wrote:
>> Enclose the chained handler with chained_irq_{enter,exit}(), so that the
>> muxed interrupts get properly acked.
>>
>> This patch also fixes a reboot bug on OX820 SoC, where the jiffies timer
>> interrupt is never acked. The kernel waits a clock tick forever in
>> calibrate_delay_converge(), which leads to a boot hang.
> 
> Nice catch.
> 
>>
>> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/irqchip/irq-versatile-fpga.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-versatile-fpga.c
>> b/drivers/irqchip/irq-versatile-fpga.c
>> index 928858dada75..08faab2fec3e 100644
>> --- a/drivers/irqchip/irq-versatile-fpga.c
>> +++ b/drivers/irqchip/irq-versatile-fpga.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/irq.h>
>>  #include <linux/io.h>
>>  #include <linux/irqchip.h>
>> +#include <linux/irqchip/chained_irq.h>
>>  #include <linux/irqchip/versatile-fpga.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/module.h>
>> @@ -68,12 +69,15 @@ static void fpga_irq_unmask(struct irq_data *d)
>>
>>  static void fpga_irq_handle(struct irq_desc *desc)
>>  {
>> +    struct irq_chip *chip = irq_desc_get_chip(desc);
>>      struct fpga_irq_data *f = irq_desc_get_handler_data(desc);
>>      u32 status = readl(f->base + IRQ_STATUS);
>>
>> +    chained_irq_enter(chip, desc);
>> +
> 
> It's probably not a big deal, but I'm not fond of starting talking to
> the muxing irqchip before having done the chained_irq_enter() call.
> 
> Moving that read here would probably be safer.

Oops, I missed it. Thanks for pointing it out.

> 
>>      if (status == 0) {
>>          do_bad_IRQ(desc);
>> -        return;
>> +        goto out;
>>      }
>>
>>      do {
>> @@ -82,6 +86,9 @@ static void fpga_irq_handle(struct irq_desc *desc)
>>          status &= ~(1 << irq);
>>          generic_handle_irq(irq_find_mapping(f->domain, irq));
>>      } while (status);
>> +
>> +out:
>> +    chained_irq_exit(chip, desc);
>>  }
>>
>>  /*
> 
> Otherwise looks good. If you send it again with the above fixed
> and a Fixes: tag, I'll queue it.

It seems the handler had been broken from the very beginning. Could you 
give me a hint on how the tag should be like?

Thanks.

> 
> Thanks,
> 
>          M.
