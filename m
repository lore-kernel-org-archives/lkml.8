Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBC3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7B7208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596194871;
	bh=hvoBtB4p+m34vRWlhfI0+65sCvBD61ZM/ZgBJ1fZ/Ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oIMDj5Mt5tvkluBd4+mqpjKArBwmLFZXj/iLRi8qEBtFQLuvPZnOrPUHx0l41qf5r
	 4T7WHD6kReskK7bPPkPVdFDemnQKhz82VjV9ThNgVDsmt74RHMlcwTZaE2JE9sMJcM
	 G7JLdJzuPazZo+Yc6+EnF0Z1LiwtUuxv/I2xE7Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732681AbgGaL1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732437AbgGaL1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:27:40 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E435208E4;
        Fri, 31 Jul 2020 11:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596194857;
        bh=hvoBtB4p+m34vRWlhfI0+65sCvBD61ZM/ZgBJ1fZ/Ew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qiwftiurYb205xG5MlpUGmVuFQZlpki5R8+ofaLnfIfHGqocSabbHrctnRzRmkWBt
         lB7R+UX0NtAnvQxPSzQ3Q/6G1D/Ae7KOUX4H8QAF6bIoulHm+BZ/x0RdYTUfQFPKNI
         u2tJTXFCR5sVvO2REULOHfzKOnXh/02qDQmpwCPk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k1TCJ-00GVz8-NI; Fri, 31 Jul 2020 12:27:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 31 Jul 2020 12:27:35 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [PATCH v2 2/2] irqchip/gic-v2, v3: Prevent SW resends entirely
In-Reply-To: <10da73b8a8937b08b0993513d6c20e98@kernel.org>
References: <20200730170321.31228-1-valentin.schneider@arm.com>
 <20200730170321.31228-3-valentin.schneider@arm.com>
 <ba26464de5e82eace97924121d7bcd1d@kernel.org> <jhjmu3gim0g.mognet@arm.com>
 <10da73b8a8937b08b0993513d6c20e98@kernel.org>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <8dfeb7782d7ffaa1f107a8e4aca10840@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: valentin.schneider@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, Lorenzo.Pieralisi@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-31 09:08, Marc Zyngier wrote:
> Hi Valentin,
> 
> On 2020-07-31 01:08, Valentin Schneider wrote:
>> Hi Marc,
>> 
>> On 30/07/20 19:10, Marc Zyngier wrote:
>> [...]
>>>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>>>> index e2b4cae88bce..a91ce1e73bd2 100644
>>>> --- a/drivers/irqchip/irq-gic.c
>>>> +++ b/drivers/irqchip/irq-gic.c
>>>> @@ -983,6 +983,7 @@ static int gic_irq_domain_map(struct irq_domain
>>>> *d, unsigned int irq,
>>>>                              irq_hw_number_t hw)
>>>>  {
>>>>      struct gic_chip_data *gic = d->host_data;
>>>> +	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
>>>> 
>>>>      if (hw < 32) {
>>>>              irq_set_percpu_devid(irq);
>>>> @@ -992,8 +993,11 @@ static int gic_irq_domain_map(struct irq_domain
>>>> *d, unsigned int irq,
>>>>              irq_domain_set_info(d, irq, hw, &gic->chip, 
>>>> d->host_data,
>>>>                                  handle_fasteoi_irq, NULL, NULL);
>>>>              irq_set_probe(irq);
>>>> -		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
>>>> +		irqd_set_single_target(irqd);
>>>>      }
>>>> +
>>>> +	/* Prevents SW retriggers which mess up the ACK/EOI ordering */
>>>> +	irqd_set_handle_enforce_irqctx(irqd);
>>>>      return 0;
>>>>  }
>>> 
>>> I'm OK with this in principle, but this requires additional changes
>>> in the rest of the GIC universe. The ITS driver needs to provide its 
>>> own
>>> retrigger function for LPIs (queuing an INT command), and any of the
>>> SPI generating widgets that can be stacked on top of a GIC 
>>> (GICv3-MBI,
>>> GICv2m, and all the other Annapurna/Marvell/NVDIA wonders need to 
>>> gain
>>> directly or indirectly a call to irq_chip_retrigger_hierarchy().
>>> 
>> 
>> Eep, yes indeed... I didn't see that can was full of worms, though 
>> even if
>> it only really matters for eoimode=0 I think it might still be worth 
>> it
>> (if only to respect the spec).
> 
> Well, given that we are using EOImode=0 for all guests at the moment,
> there is some value it getting it right! ;-)
> 
>> 
>>> We can probably avoid changing the MSI widgets by teaching the MSI
>>> code about the HW retrigger, but a number of other non-MSI drivers
>>> will need some help...
>>> 
>>> I'll have a look tomorrow.
>>> 
>> 
>> For LPIs AFAICT we could directly reuse its_irq_set_irqchip_state() - 
>> I see
>> the VPE side of things already has a HW retrigger callback.
> 
> Yes, that's the idea (in general, if you implement the PENDING side of
> irq_set_irqchip_state(), retrigger comes for free).
> 
>> For gicv2m, I *think* we'd want irq_chip_retrigger_hierarchy() on both 
>> MSI
>> domains (which IIUC you suggest might be doable by adding the 
>> retrigger as
>> a default MSI chip op).
> 
> Yes, that was my idea.
> 
>> I'm not very familiar with the rest of the fauna, so I'll have to do 
>> some
>> reading tomorrow as well; it's probably high time for me to actually 
>> read
>> up on LPIs & ITS while I'm at it...
> 
> Look for anything that performs an interrupt allocation by calling
> into the parent with a 3 cell (DT case) fwspec. There is a bunch
> of them.

For what it is worth, I have just pushed out a branch[1] containing some
of this rework as well as your patches.

The only tricky part is the GICv4.1 doorbell retriggering, which just
can't be re-injected. It shouldn't matter though. Same for vSGIs, they
never fire on the host.

Thanks,

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gic-retrigger
-- 
Jazz is not dead. It just smells funny...
