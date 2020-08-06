Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD51C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA540206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735162;
	bh=V1PSRo4eX8swYDgWsq71j+ws4CVRQUFXtfzrKm6Cs7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wPwj/XKPwTH4TjOC1b/8i3sUo2/qMqqNf+hdNE4eTAHqjk2ELrZKho/wE3CUGhYJB
	 gQAnvtDQiTexN67cG794UgDvHoe1IT0alFXLM0hnECeqnS8pxhxwDy9wS+LQpT/10O
	 0I4XHr8lta1BGMWFxYeuipFJktOaP91SW+BnvMzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbgHFRcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730000AbgHFRcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:32:05 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAE6A22DA9;
        Thu,  6 Aug 2020 12:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596717375;
        bh=V1PSRo4eX8swYDgWsq71j+ws4CVRQUFXtfzrKm6Cs7g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YdOifq+YBdCEaRBYC/2UMY89UncYsccDHOtl9ip82PBoV1QXbyBcyhdkRqstYBDmg
         92q4c79+Ym+cezlho5R9ZueuW9+3ku53CLnyxnaK6Hmfo/4TjYbuwT7zj4nE4Jg1Eh
         2QRQZeKN1Hs73+lNjjbMFygLq9kJDYH7ZujeajtM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k3f82-000H6F-3e; Thu, 06 Aug 2020 13:36:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 06 Aug 2020 13:36:14 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        tglx@linutronix.de, jason@lakedaemon.net,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Willy Tarreau <w@1wt.eu>,
        mark-pk.tsai@mediatek.com
Subject: Re: [PATCH 2/3] irqchip: mstar: msc313-intc interrupt controller
 driver
In-Reply-To: <CAFr9PXmzZmHWv+DWppaXOih9p5pJK=3JYCCC+-XrnQ+S7sV+fw@mail.gmail.com>
References: <20200805110052.2655487-1-daniel@0x0f.com>
 <20200805110052.2655487-3-daniel@0x0f.com>
 <a2ac8875d67ce7afe1b28f01683e0c9d@kernel.org>
 <CAFr9PXmzZmHWv+DWppaXOih9p5pJK=3JYCCC+-XrnQ+S7sV+fw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <3e177112a804b54589464853ff8ac8ad@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: daniel@0x0f.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, arnd@arndb.de, w@1wt.eu, mark-pk.tsai@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-06 11:03, Daniel Palmer wrote:
> Hi Marc,
> 
> On Thu, 6 Aug 2020 at 01:26, Marc Zyngier <maz@kernel.org> wrote:
>> > +struct msc313_intc {
>> > +     struct irq_domain *domain;
>> > +     void __iomem *base;
>> > +     struct irq_chip irqchip;
>> 
>> Why do you need to embed the irq_chip on a per-controller basis?
> 
> Current chips have 1 instance of each type of controller but some of 
> the
> newer ones seem to have an extra copy of the non-FIQ version with 
> different
> offset to the GIC.

It is much better to have an irqchip structure per irqchip type,
rather than one per instance, as you can then make the irqchip const.
It also saves memory when you have more than a single instance.

The only case where it doesn't work is when PM gets involved, as the
parent_device pointer is stupidly stored in the irqchip device.

> 
>> > +};
>> > +
>> > +static void msc313_intc_maskunmask(struct msc313_intc *intc, int
>> > hwirq, bool mask)
>> > +{
>> > +     int regoff = REGOFF(hwirq);
>> > +     void __iomem *addr = intc->base + REGOFF_MASK + regoff;
>> > +     u16 bit = IRQBIT(hwirq);
>> > +     u16 reg = readw_relaxed(addr);
>> > +
>> > +     if (mask)
>> > +             reg |= bit;
>> > +     else
>> > +             reg &= ~bit;
>> > +
>> > +     writew_relaxed(reg, addr);
>> 
>> RMW on a shared MMIO register. Not going to end well. This is valid
>> for all the callbacks, I believe.
> 
> Do you have any suggestions on how to resolve that? It seems usually
> an interrupt controller has set and clear registers to get around this.
> Would defining a spinlock at the top of the driver and using that 
> around
> the read and modify sequences be good enough?

Yes, a spinlock is the conventional way to solve it. Make sure
you use the irqsave/irqrestore versions, as mask/unmask can
also occur whilst in interrupt context.

> 
>> > +
>> > +     if (flow_type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_LEVEL_HIGH))
>> > +             reg &= ~bit;
>> > +     else
>> > +             reg |= bit;
>> 
>> I don't follow grasp the logic here. What happens on EDGE_BOTH, for
>> example?
> 
> To be honest I don't quite remember. I'll check and rewrite this.
> 
>> This driver has a massive feeling of déja-vu. It is almost
>> a copy of the one posted at [1], which I reviewed early
>> this week. The issues are the exact same, and I'm 98%
>> sure this is the same IP block used by two SoC vendors.
> 
> This would make a lot of sense considering MediaTek bought MStar
> for their TV SoCs. The weirdness with only using 16 bits in a register
> suggests they've inherited the shared ARM/8051 bus that the MStar
> chips have. Thanks for the tip off.

It is indeed the 16bit accesses that reminded me of the MTK
code, as that's very unusual.

Hopefully you can work with the MTK guys to resolve this quickly.

         M.
-- 
Jazz is not dead. It just smells funny...
