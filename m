Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B95EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A0820897
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597850668;
	bh=hHa5rHHEdmaLPV8IAAgl2hoR1WMKnusCrOaK/4DnvIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zhyTaexzUdCfaKvPz100I3P65c5kgSKmj4uxBVbEAWRoqPd1dgpvzEtmnAa5yVxbz
	 og03MLn6JlRkLyCnogC/Cd4uPdIzkx5bf9kcN2J+9QFdR7JD9fdBxcf+apWWPz8uby
	 7rZuOEMvPtfgWxUD3CQlJiO16Ri4kTFfeTLRs/HY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgHSPY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgHSPYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:24:20 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E18B220897;
        Wed, 19 Aug 2020 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597850660;
        bh=hHa5rHHEdmaLPV8IAAgl2hoR1WMKnusCrOaK/4DnvIM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SzbRLU6uplI9w6fF5ALOG9qTdPUx4A/TcBFXF5MUcMy7oWkEp2G5W2+VgF7Jwd7fn
         Ktrm0XTFXwDXpE1EcWltK4ppy8NwfHG9YElNZ5Wyc7T1xGGOzPNAF9wK59JeqeOP8C
         tFbNuQD+Eq5tGugI17/6zzsdxmKZcc49JnubXs+Y=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k8Pwn-004Fc2-Tn; Wed, 19 Aug 2020 16:24:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Aug 2020 16:24:17 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     alix.wu@mediatek.com, daniel@0x0f.com, devicetree@vger.kernel.org,
        jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org, tglx@linutronix.de,
        yj.chiang@mediatek.com
Subject: Re: [PATCH 1/2] irqchip: irq-mst: Add MStar interrupt controller
 support
In-Reply-To: <20200819145525.26315-1-mark-pk.tsai@mediatek.com>
References: <f593f5e395c8558657a3f265b7038ec3@kernel.org>
 <20200819145525.26315-1-mark-pk.tsai@mediatek.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <85749ec80ad0b9c85e3984c808d02b9c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark-pk.tsai@mediatek.com, alix.wu@mediatek.com, daniel@0x0f.com, devicetree@vger.kernel.org, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, yj.chiang@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-19 15:55, Mark-PK Tsai wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
>> On 2020-08-19 14:31, Mark-PK Tsai wrote:
>>> From: Marc Zyngier <maz@kernel.org>
>>> 
>>>> > +
>>>> > +static int mst_intc_domain_alloc(struct irq_domain *domain, unsigned
>>>> > int virq,
>>>> > +				 unsigned int nr_irqs, void *data)
>>>> > +{
>>>> > +	int i;
>>>> > +	irq_hw_number_t hwirq;
>>>> > +	struct irq_fwspec parent_fwspec, *fwspec = data;
>>>> > +	struct mst_intc_chip_data *cd = (struct mst_intc_chip_data
>>>> > *)domain->host_data;
>>>> 
>>>> No cast necessary here.
>>>> 
>>>> > +
>>>> > +	/* Not GIC compliant */
>>>> > +	if (fwspec->param_count != 3)
>>>> > +		return -EINVAL;
>>>> > +
>>>> > +	/* No PPI should point to this domain */
>>>> > +	if (fwspec->param[0])
>>>> > +		return -EINVAL;
>>>> > +
>>>> > +	if (fwspec->param[1] >= cd->nr_irqs)
>>>> 
>>>> This condition is bogus, as it doesn't take into account the nr_irqs
>>>> parameter.
>>>> 
>>> 
>>> 
>>> The hwirq number need to be in the irq map range. (property:
>>> mstar,irqs-map-range)
>>> If it's not, it must be incorrect configuration.
>> 
>> I agree. And since you are checking whether the configuration is
>> correct,
>> it'd better be completely correct.
>> 
>>> So how about use the condition as following?
>>> 
>>> if (hwirq >= cd->nr_irqs)
>>> 	return -EINVAL;
>> 
>> Again, this says nothing of the validity of (hwirq + nr_irqs - 1)...
>> 
> 
> How about move this to mst_intc_domain_translate? Then all the 
> irq_fwspec
> point to domain mst_intc should be valid.
> 
> The mst_intc_domain_translate will be as following:
> 
> static int mst_intc_domain_translate(struct irq_domain *d,
> 				     struct irq_fwspec *fwspec,
> 				     unsigned long *hwirq,
> 				     unsigned int *type)
> {
> 	struct mst_intc_chip_data *cd = d->host_data;
> 
> 	if (is_of_node(fwspec->fwnode)) {
> 		if (fwspec->param_count != 3)
> 			return -EINVAL;
> 
> 		/* No PPI should point to this domain */
> 		if (fwspec->param[0] != 0)
> 			return -EINVAL;
> 
> 		if (fwspec->param[1] >= cd->nr_irqs)
> 			return -EINVAL;
> 
> 		*hwirq = fwspec->param[1];
> 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
> 		return 0;
> 	}
> 
> 	return -EINVAL;
> }

It would make more sense.

         M.
-- 
Jazz is not dead. It just smells funny...
