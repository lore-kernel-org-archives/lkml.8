Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE055C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABE120774
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585559663;
	bh=xQQ0SbWYahN2KSTCm8qNHH+4zd3tIw7YmSh5hEQ8xv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YbX5pUhO5qyrYW1a2RB6EAt+JyKvsxGAectjkLexVYuoPUeMRAiqp90cgtXO8IUgW
	 Jl3duDF58H4YJ2L+e0GmeV1O1pQYF+w+kfBhBuHOy31i4WkMa8M2KLQhx/xoodBonq
	 vE266IYBW7fq+yQlullIZh6644rGqyvKnpNCy3ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgC3JOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgC3JOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:14:22 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B8C620716;
        Mon, 30 Mar 2020 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585559661;
        bh=xQQ0SbWYahN2KSTCm8qNHH+4zd3tIw7YmSh5hEQ8xv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VtE7G6iPbBmP0BRX/c21YSsjY+jzxED6tamiRGlj3QdfyPlKgpAeqmXTaD8tTMK+y
         yuy4bz9napYHKx7O9+8LZG8dyC/J8t27w/KU6uP56ae1br9+sscrKaT8U5AwaiRTVF
         Rs9HZBoAEIgDUfuQ+eRZ7NGvmbmAb7CD9UJx7k6o=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jIqUt-00GpFM-Qp; Mon, 30 Mar 2020 10:14:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 30 Mar 2020 10:14:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        x86 <x86@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [tip: irq/core] irqchip/xilinx: Enable generic irq multi handler
In-Reply-To: <895eba40-2e77-db1b-ea82-035c05f0b77e@xilinx.com>
References: <20200317125600.15913-4-mubin.usman.sayyed@xilinx.com>
 <158551357076.28353.1716269552245308352.tip-bot2@tip-bot2>
 <083ad708-ea4d-ed53-598e-84d911ca4177@xilinx.com>
 <085188fea81d5ddc88b488124596a4a3@kernel.org>
 <895eba40-2e77-db1b-ea82-035c05f0b77e@xilinx.com>
Message-ID: <409514e35f5ed32de8a31977f6857077@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: michal.simek@xilinx.com, linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, tglx@linutronix.de, stefan.asserhall@xilinx.com, x86@kernel.org, sfr@canb.auug.org.au
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-30 10:03, Michal Simek wrote:
> On 30. 03. 20 10:45, Marc Zyngier wrote:
>> On 2020-03-30 09:32, Michal Simek wrote:
>>> Hi Thomas and Marc,
>>> 
>>> On 29. 03. 20 22:26, tip-bot2 for Michal Simek wrote:
>>>> The following commit has been merged into the irq/core branch of 
>>>> tip:
>>>> 
>>>> Commit-ID:     a0789993bf8266e62fea6b4613945ba081c71e7d
>>>> Gitweb:       
>>>> https://git.kernel.org/tip/a0789993bf8266e62fea6b4613945ba081c71e7d
>>>> Author:        Michal Simek <michal.simek@xilinx.com>
>>>> AuthorDate:    Tue, 17 Mar 2020 18:25:59 +05:30
>>>> Committer:     Marc Zyngier <maz@kernel.org>
>>>> CommitterDate: Sun, 22 Mar 2020 11:52:53
>>>> 
>>>> irqchip/xilinx: Enable generic irq multi handler
>>>> 
>>>> Register default arch handler via driver instead of directly 
>>>> pointing to
>>>> xilinx intc controller. This patch makes architecture code more 
>>>> generic.
>>>> 
>>>> Driver calls generic domain specific irq handler which does the most 
>>>> of
>>>> things self. Also get rid of concurrent_irq counting which hasn't 
>>>> been
>>>> exported anywhere.
>>>> Based on this loop was also optimized by using do/while loop instead 
>>>> of
>>>> goto loop.
>>>> 
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
>>>> Link:
>>>> https://lore.kernel.org/r/20200317125600.15913-4-mubin.usman.sayyed@xilinx.com
>>>> 
>>>> ---
>>>>  arch/microblaze/Kconfig           |  2 ++-
>>>>  arch/microblaze/include/asm/irq.h |  3 +---
>>>>  arch/microblaze/kernel/irq.c      | 21 +-------------------
>>>>  drivers/irqchip/irq-xilinx-intc.c | 34 
>>>> +++++++++++++++++-------------
>>>>  4 files changed, 23 insertions(+), 37 deletions(-)
>>>> 
>>>> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
>>>> index 6a331bd..242f58e 100644
>>>> --- a/arch/microblaze/Kconfig
>>>> +++ b/arch/microblaze/Kconfig
>>>> @@ -47,6 +47,8 @@ config MICROBLAZE
>>>>      select CPU_NO_EFFICIENT_FFS
>>>>      select MMU_GATHER_NO_RANGE if MMU
>>>>      select SPARSE_IRQ
>>>> +    select GENERIC_IRQ_MULTI_HANDLER
>>>> +    select HANDLE_DOMAIN_IRQ
>>>> 
>>>>  # Endianness selection
>>>>  choice
>>>> diff --git a/arch/microblaze/include/asm/irq.h
>>>> b/arch/microblaze/include/asm/irq.h
>>>> index eac2fb4..5166f08 100644
>>>> --- a/arch/microblaze/include/asm/irq.h
>>>> +++ b/arch/microblaze/include/asm/irq.h
>>>> @@ -14,7 +14,4 @@
>>>>  struct pt_regs;
>>>>  extern void do_IRQ(struct pt_regs *regs);
>>>> 
>>>> -/* should be defined in each interrupt controller driver */
>>>> -extern unsigned int xintc_get_irq(void);
>>>> -
>>>>  #endif /* _ASM_MICROBLAZE_IRQ_H */
>>>> diff --git a/arch/microblaze/kernel/irq.c 
>>>> b/arch/microblaze/kernel/irq.c
>>>> index 903dad8..0b37dde 100644
>>>> --- a/arch/microblaze/kernel/irq.c
>>>> +++ b/arch/microblaze/kernel/irq.c
>>>> @@ -20,29 +20,10 @@
>>>>  #include <linux/irqchip.h>
>>>>  #include <linux/of_irq.h>
>>>> 
>>>> -static u32 concurrent_irq;
>>>> -
>>>>  void __irq_entry do_IRQ(struct pt_regs *regs)
>>>>  {
>>>> -    unsigned int irq;
>>>> -    struct pt_regs *old_regs = set_irq_regs(regs);
>>>>      trace_hardirqs_off();
>>>> -
>>>> -    irq_enter();
>>>> -    irq = xintc_get_irq();
>>>> -next_irq:
>>>> -    BUG_ON(!irq);
>>>> -    generic_handle_irq(irq);
>>>> -
>>>> -    irq = xintc_get_irq();
>>>> -    if (irq != -1U) {
>>>> -        pr_debug("next irq: %d\n", irq);
>>>> -        ++concurrent_irq;
>>>> -        goto next_irq;
>>>> -    }
>>>> -
>>>> -    irq_exit();
>>>> -    set_irq_regs(old_regs);
>>>> +    handle_arch_irq(regs);
>>>>      trace_hardirqs_on();
>>>>  }
>>>> 
>>>> diff --git a/drivers/irqchip/irq-xilinx-intc.c
>>>> b/drivers/irqchip/irq-xilinx-intc.c
>>>> index 1d3d273..ea74181 100644
>>>> --- a/drivers/irqchip/irq-xilinx-intc.c
>>>> +++ b/drivers/irqchip/irq-xilinx-intc.c
>>>> @@ -124,20 +124,6 @@ static unsigned int xintc_get_irq_local(struct
>>>> xintc_irq_chip *irqc)
>>>>      return irq;
>>>>  }
>>>> 
>>>> -unsigned int xintc_get_irq(void)
>>>> -{
>>>> -    unsigned int irq = -1;
>>>> -    u32 hwirq;
>>>> -
>>>> -    hwirq = xintc_read(primary_intc, IVR);
>>>> -    if (hwirq != -1U)
>>>> -        irq = irq_find_mapping(primary_intc->root_domain, hwirq);
>>>> -
>>>> -    pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
>>>> -
>>>> -    return irq;
>>>> -}
>>>> -
>>>>  static int xintc_map(struct irq_domain *d, unsigned int irq,
>>>> irq_hw_number_t hw)
>>>>  {
>>>>      struct xintc_irq_chip *irqc = d->host_data;
>>>> @@ -177,6 +163,25 @@ static void xil_intc_irq_handler(struct 
>>>> irq_desc
>>>> *desc)
>>>>      chained_irq_exit(chip, desc);
>>>>  }
>>>> 
>>>> +static void xil_intc_handle_irq(struct pt_regs *regs)
>>>> +{
>>>> +    u32 hwirq;
>>>> +    struct xintc_irq_chip *irqc = primary_intc;
>>>> +
>>>> +    do {
>>>> +        hwirq = xintc_read(irqc, IVR);
>>>> +        if (likely(hwirq != -1U)) {
>>>> +            int ret;
>>>> +
>>>> +            ret = handle_domain_irq(irqc->root_domain, hwirq, 
>>>> regs);
>>>> +            WARN_ONCE(ret, "Unhandled HWIRQ %d\n", hwirq);
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        break;
>>>> +    } while (1);
>>>> +}
>>>> +
>>>>  static int __init xilinx_intc_of_init(struct device_node *intc,
>>>>                           struct device_node *parent)
>>>>  {
>>>> @@ -246,6 +251,7 @@ static int __init xilinx_intc_of_init(struct
>>>> device_node *intc,
>>>>      } else {
>>>>          primary_intc = irqc;
>>>>          irq_set_default_host(primary_intc->root_domain);
>>>> +        set_handle_irq(xil_intc_handle_irq);
>>>>      }
>>>> 
>>>>      return 0;
>>>> 
>>> 
>>> Stephen reported compilation issue when this patch is applied because 
>>> of
>>> removal of xintc_get_irq() which is also used by ancient 
>>> ppc405/ppc440
>>> xilinx platforms. I have reported this twice to Marc already last 
>>> week.
>> 
>> Did you? I can't possibly find these emails.
> 
> Stephen was using your arm.com email.
> 
> https://lore.kernel.org/linux-next/48d3232d-0f1d-42ea-3109-f44bbabfa2e8@xilinx.com/

Yeah, no chance I could read that, unfortunately. I've sent a separate
email to Stephen to update my email address.

>> 
>>> On Friday I have also send v1 of removal of that platforms (need to
>>> send v2)
>>> https://lore.kernel.org/alsa-devel/cover.1585311091.git.michal.simek@xilinx.com/
>>> 
>> 
>> You want to remove exising platforms two days before the start of the
>> merge window?
>> I don't think this is acceptable with such short notice.
> 
> I also don't think that will go through.
> 
>> 
>>> That's why please really consider next steps and let us know.
>> 
>> I think the only option is to revert (at least partially) the Xilinx
>> series.
> 
> Unfortunately.

Can you please check that we're OK reverting just the last two patches?
Or what is the minimal revert that can be done for everything to keep 
working?

         M.
-- 
Jazz is not dead. It just smells funny...
