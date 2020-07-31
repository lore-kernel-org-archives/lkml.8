Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9F2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 00:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E6152082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 00:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbgGaAI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:08:58 -0400
Received: from foss.arm.com ([217.140.110.172]:46560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730874AbgGaAIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 20:08:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8544731B;
        Thu, 30 Jul 2020 17:08:53 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EF0F3F66E;
        Thu, 30 Jul 2020 17:08:52 -0700 (PDT)
References: <20200730170321.31228-1-valentin.schneider@arm.com> <20200730170321.31228-3-valentin.schneider@arm.com> <ba26464de5e82eace97924121d7bcd1d@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [PATCH v2 2/2] irqchip/gic-v2, v3: Prevent SW resends entirely
In-reply-to: <ba26464de5e82eace97924121d7bcd1d@kernel.org>
Date:   Fri, 31 Jul 2020 01:08:47 +0100
Message-ID: <jhjmu3gim0g.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

On 30/07/20 19:10, Marc Zyngier wrote:
[...]
>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>> index e2b4cae88bce..a91ce1e73bd2 100644
>> --- a/drivers/irqchip/irq-gic.c
>> +++ b/drivers/irqchip/irq-gic.c
>> @@ -983,6 +983,7 @@ static int gic_irq_domain_map(struct irq_domain
>> *d, unsigned int irq,
>>                              irq_hw_number_t hw)
>>  {
>>      struct gic_chip_data *gic = d->host_data;
>> +	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
>>
>>      if (hw < 32) {
>>              irq_set_percpu_devid(irq);
>> @@ -992,8 +993,11 @@ static int gic_irq_domain_map(struct irq_domain
>> *d, unsigned int irq,
>>              irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
>>                                  handle_fasteoi_irq, NULL, NULL);
>>              irq_set_probe(irq);
>> -		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
>> +		irqd_set_single_target(irqd);
>>      }
>> +
>> +	/* Prevents SW retriggers which mess up the ACK/EOI ordering */
>> +	irqd_set_handle_enforce_irqctx(irqd);
>>      return 0;
>>  }
>
> I'm OK with this in principle, but this requires additional changes
> in the rest of the GIC universe. The ITS driver needs to provide its own
> retrigger function for LPIs (queuing an INT command), and any of the
> SPI generating widgets that can be stacked on top of a GIC (GICv3-MBI,
> GICv2m, and all the other Annapurna/Marvell/NVDIA wonders need to gain
> directly or indirectly a call to irq_chip_retrigger_hierarchy().
>

Eep, yes indeed... I didn't see that can was full of worms, though even if
it only really matters for eoimode=0 I think it might still be worth it
(if only to respect the spec).

> We can probably avoid changing the MSI widgets by teaching the MSI
> code about the HW retrigger, but a number of other non-MSI drivers
> will need some help...
>
> I'll have a look tomorrow.
>

For LPIs AFAICT we could directly reuse its_irq_set_irqchip_state() - I see
the VPE side of things already has a HW retrigger callback.

For gicv2m, I *think* we'd want irq_chip_retrigger_hierarchy() on both MSI
domains (which IIUC you suggest might be doable by adding the retrigger as
a default MSI chip op).

I'm not very familiar with the rest of the fauna, so I'll have to do some
reading tomorrow as well; it's probably high time for me to actually read
up on LPIs & ITS while I'm at it...

> Thanks,
>
>          M.
