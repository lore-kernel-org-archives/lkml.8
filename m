Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F22C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C84C2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585559978;
	bh=BEMJImsgD27QGlIhCOTQO98o8mVJJpJscxhbONLw4IY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZOmyvoeZiTpS/Gc78cRchTTuPsvEshKhMdyWOrSxbxEbdg1HGHK8pGD+M8mSWvwBy
	 hBsr24VcS5PWvJMHbZ8oaumI2P17hAAUN+Pg2qVVGRBqqNqFJpf+IwXfCRUsR+zPqE
	 MImY4dy3omPIPhzW2ZjgaxlxLWlyuhgKBEudsjXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgC3JTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgC3JTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:19:36 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 648DF20716;
        Mon, 30 Mar 2020 09:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585559975;
        bh=BEMJImsgD27QGlIhCOTQO98o8mVJJpJscxhbONLw4IY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z4V818BzjGCIael0YuGIjvRDWWHR3zNSyOg8ogQyugr3RcDGczPFj5gIca7hGHFOz
         nue3dZaWO5+/orQl7iaRlOcCsznPCuUAzSRDiCYr0vvsWo2G6tF3Y/a/ktBdZHJHgN
         znWqlS6frMSY9/OJ9A8V4O1uDQDnR9hLabQE1/8c=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jIqZx-00GpIg-Mr; Mon, 30 Mar 2020 10:19:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 30 Mar 2020 10:19:33 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        x86 <x86@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [tip: irq/core] irqchip/xilinx: Enable generic irq multi handler
In-Reply-To: <ca0f62da-1e89-4fe8-5cb4-b7a86f97c5a3@xilinx.com>
References: <20200317125600.15913-4-mubin.usman.sayyed@xilinx.com>
 <158551357076.28353.1716269552245308352.tip-bot2@tip-bot2>
 <083ad708-ea4d-ed53-598e-84d911ca4177@xilinx.com>
 <085188fea81d5ddc88b488124596a4a3@kernel.org>
 <895eba40-2e77-db1b-ea82-035c05f0b77e@xilinx.com>
 <ca0f62da-1e89-4fe8-5cb4-b7a86f97c5a3@xilinx.com>
Message-ID: <21f1157d885071dcfdb1de0847c19e24@kernel.org>
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

On 2020-03-30 10:12, Michal Simek wrote:
> On 30. 03. 20 11:03, Michal Simek wrote:
>> On 30. 03. 20 10:45, Marc Zyngier wrote:
>>> On 2020-03-30 09:32, Michal Simek wrote:
>>>> Hi Thomas and Marc,
>>>> 
>>>> On 29. 03. 20 22:26, tip-bot2 for Michal Simek wrote:
>>>>> The following commit has been merged into the irq/core branch of 
>>>>> tip:
>>>>> 
>>>>> Commit-ID:     a0789993bf8266e62fea6b4613945ba081c71e7d
>>>>> Gitweb:       
>>>>> https://git.kernel.org/tip/a0789993bf8266e62fea6b4613945ba081c71e7d
>>>>> Author:        Michal Simek <michal.simek@xilinx.com>
>>>>> AuthorDate:    Tue, 17 Mar 2020 18:25:59 +05:30
>>>>> Committer:     Marc Zyngier <maz@kernel.org>
>>>>> CommitterDate: Sun, 22 Mar 2020 11:52:53
>>>>> 
>>>>> irqchip/xilinx: Enable generic irq multi handler
>>>>> 
>>>>> Register default arch handler via driver instead of directly 
>>>>> pointing to
>>>>> xilinx intc controller. This patch makes architecture code more 
>>>>> generic.
>>>>> 
>>>>> Driver calls generic domain specific irq handler which does the 
>>>>> most of
>>>>> things self. Also get rid of concurrent_irq counting which hasn't 
>>>>> been
>>>>> exported anywhere.
>>>>> Based on this loop was also optimized by using do/while loop 
>>>>> instead of
>>>>> goto loop.
>>>>> 
>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>>>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
>>>>> Link:
>>>>> https://lore.kernel.org/r/20200317125600.15913-4-mubin.usman.sayyed@xilinx.com
>>>>> 
>>>>> ---
>>>>>  arch/microblaze/Kconfig           |  2 ++-
>>>>>  arch/microblaze/include/asm/irq.h |  3 +---
>>>>>  arch/microblaze/kernel/irq.c      | 21 +-------------------
>>>>>  drivers/irqchip/irq-xilinx-intc.c | 34 
>>>>> +++++++++++++++++-------------
>>>>>  4 files changed, 23 insertions(+), 37 deletions(-)
>>>>> 
>>>>> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
>>>>> index 6a331bd..242f58e 100644
>>>>> --- a/arch/microblaze/Kconfig
>>>>> +++ b/arch/microblaze/Kconfig
>>>>> @@ -47,6 +47,8 @@ config MICROBLAZE
>>>>>      select CPU_NO_EFFICIENT_FFS
>>>>>      select MMU_GATHER_NO_RANGE if MMU
>>>>>      select SPARSE_IRQ
>>>>> +    select GENERIC_IRQ_MULTI_HANDLER
>>>>> +    select HANDLE_DOMAIN_IRQ
>>>>> 
>>>>>  # Endianness selection
>>>>>  choice
>>>>> diff --git a/arch/microblaze/include/asm/irq.h
>>>>> b/arch/microblaze/include/asm/irq.h
>>>>> index eac2fb4..5166f08 100644
>>>>> --- a/arch/microblaze/include/asm/irq.h
>>>>> +++ b/arch/microblaze/include/asm/irq.h
>>>>> @@ -14,7 +14,4 @@
>>>>>  struct pt_regs;
>>>>>  extern void do_IRQ(struct pt_regs *regs);
>>>>> 
>>>>> -/* should be defined in each interrupt controller driver */
>>>>> -extern unsigned int xintc_get_irq(void);
>>>>> -
>>>>>  #endif /* _ASM_MICROBLAZE_IRQ_H */
>>>>> diff --git a/arch/microblaze/kernel/irq.c 
>>>>> b/arch/microblaze/kernel/irq.c
>>>>> index 903dad8..0b37dde 100644
>>>>> --- a/arch/microblaze/kernel/irq.c
>>>>> +++ b/arch/microblaze/kernel/irq.c
>>>>> @@ -20,29 +20,10 @@
>>>>>  #include <linux/irqchip.h>
>>>>>  #include <linux/of_irq.h>
>>>>> 
>>>>> -static u32 concurrent_irq;
>>>>> -
>>>>>  void __irq_entry do_IRQ(struct pt_regs *regs)
>>>>>  {
>>>>> -    unsigned int irq;
>>>>> -    struct pt_regs *old_regs = set_irq_regs(regs);
>>>>>      trace_hardirqs_off();
>>>>> -
>>>>> -    irq_enter();
>>>>> -    irq = xintc_get_irq();
>>>>> -next_irq:
>>>>> -    BUG_ON(!irq);
>>>>> -    generic_handle_irq(irq);
>>>>> -
>>>>> -    irq = xintc_get_irq();
>>>>> -    if (irq != -1U) {
>>>>> -        pr_debug("next irq: %d\n", irq);
>>>>> -        ++concurrent_irq;
>>>>> -        goto next_irq;
>>>>> -    }
>>>>> -
>>>>> -    irq_exit();
>>>>> -    set_irq_regs(old_regs);
>>>>> +    handle_arch_irq(regs);
>>>>>      trace_hardirqs_on();
>>>>>  }
>>>>> 
>>>>> diff --git a/drivers/irqchip/irq-xilinx-intc.c
>>>>> b/drivers/irqchip/irq-xilinx-intc.c
>>>>> index 1d3d273..ea74181 100644
>>>>> --- a/drivers/irqchip/irq-xilinx-intc.c
>>>>> +++ b/drivers/irqchip/irq-xilinx-intc.c
>>>>> @@ -124,20 +124,6 @@ static unsigned int xintc_get_irq_local(struct
>>>>> xintc_irq_chip *irqc)
>>>>>      return irq;
>>>>>  }
>>>>> 
>>>>> -unsigned int xintc_get_irq(void)
>>>>> -{
>>>>> -    unsigned int irq = -1;
>>>>> -    u32 hwirq;
>>>>> -
>>>>> -    hwirq = xintc_read(primary_intc, IVR);
>>>>> -    if (hwirq != -1U)
>>>>> -        irq = irq_find_mapping(primary_intc->root_domain, hwirq);
>>>>> -
>>>>> -    pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
>>>>> -
>>>>> -    return irq;
>>>>> -}
>>>>> -
> 
> One more thing. We could also get this function back and it will be 
> fine
> too. But up2you.

If you leave it up to me, I'll revert the whole series right now.

What I'd expect from you is to tell me exactly what is the minimal
change that keeps it working on both ARM, microblaze and PPC.
If it is a revert, tell me which patches to revert. if it is a patch
on top, send me the fix so that I can queue it now.

         M.
-- 
Jazz is not dead. It just smells funny...
