Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AB1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8E2204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597844575;
	bh=nRHlZ1MnhuRCWEVlVgqtKUWgqsrlzs+w4Nj+dZAbawc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pFGta+4opxGkCrqA1imetzUcadUtYoH1OhEirSC/+npYlJpzYbfo4X65momUFehsS
	 SFIfC0raBmUaYnGTTSCNK7Jx2AyvlmW2qmB5C/jwzZAJLh1YEZ65ewV7nr5rWbdNEg
	 pUYMRlaQRkI96IqxOdk9gNwdgud8YVjmJR/j4lkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgHSNmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbgHSNmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:42:50 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3F5E204FD;
        Wed, 19 Aug 2020 13:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597844569;
        bh=nRHlZ1MnhuRCWEVlVgqtKUWgqsrlzs+w4Nj+dZAbawc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X2p4tG/lI4UDoGQ0sW7iBjo5mfR7OsNSzk2uNq3Xhim97qLQo2BUAax5CH6LxWxQ3
         SyLd/JY3Anlf1Vkm7UkfpDCr9hyV2G5dviys/6P/0z35NeRRb/G3vtxR+wiuYLfK9Q
         CM9M4FOLugd4F74QfZ7XQFOx/6L3XtyEgHhh141s=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k8OMa-004DzN-87; Wed, 19 Aug 2020 14:42:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Aug 2020 14:42:48 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     alix.wu@mediatek.com, daniel@0x0f.com, devicetree@vger.kernel.org,
        jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org, tglx@linutronix.de,
        yj.chiang@mediatek.com
Subject: Re: [PATCH 1/2] irqchip: irq-mst: Add MStar interrupt controller
 support
In-Reply-To: <a8ee65eb4d86963bd2b56e86eec0ab3e@kernel.org> (raw)
References: <a8ee65eb4d86963bd2b56e86eec0ab3e@kernel.org>
 <a8ee65eb4d86963bd2b56e86eec0ab3e@kernel.org> (raw)
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <f593f5e395c8558657a3f265b7038ec3@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark-pk.tsai@mediatek.com, alix.wu@mediatek.com, daniel@0x0f.com, devicetree@vger.kernel.org, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, yj.chiang@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-19 14:31, Mark-PK Tsai wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
>> > +
>> > +static int mst_intc_domain_alloc(struct irq_domain *domain, unsigned
>> > int virq,
>> > +				 unsigned int nr_irqs, void *data)
>> > +{
>> > +	int i;
>> > +	irq_hw_number_t hwirq;
>> > +	struct irq_fwspec parent_fwspec, *fwspec = data;
>> > +	struct mst_intc_chip_data *cd = (struct mst_intc_chip_data
>> > *)domain->host_data;
>> 
>> No cast necessary here.
>> 
>> > +
>> > +	/* Not GIC compliant */
>> > +	if (fwspec->param_count != 3)
>> > +		return -EINVAL;
>> > +
>> > +	/* No PPI should point to this domain */
>> > +	if (fwspec->param[0])
>> > +		return -EINVAL;
>> > +
>> > +	if (fwspec->param[1] >= cd->nr_irqs)
>> 
>> This condition is bogus, as it doesn't take into account the nr_irqs
>> parameter.
>> 
> 
> 
> The hwirq number need to be in the irq map range. (property:
> mstar,irqs-map-range)
> If it's not, it must be incorrect configuration.

I agree. And since you are checking whether the configuration is 
correct,
it'd better be completely correct.

> So how about use the condition as following?
> 
> if (hwirq >= cd->nr_irqs)
> 	return -EINVAL;

Again, this says nothing of the validity of (hwirq + nr_irqs - 1)...

> 
>> > +		return -EINVAL;
>> > +
>> > +	hwirq = fwspec->param[1];
>> > +	for (i = 0; i < nr_irqs; i++)
>> > +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
>> > +					      &mst_intc_chip,
>> > +					      domain->host_data);

... which you are using here.

         M.
-- 
Jazz is not dead. It just smells funny...
