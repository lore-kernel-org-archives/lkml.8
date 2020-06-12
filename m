Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD09C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5B2207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591958348;
	bh=Ic5qw5oifdLSTHOeMZf7Yti20T61ZRmCTHxVz++OVmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PB9OdLu8VlYYjbywf0ZqGGKe1cDRfC5hy7GhwNf6wH1XQTAX760s2YlQHHvvKjFvD
	 YE8GP54NG8luS1yEo/eNbWitZ864Xcr7Ekedmw7U7jCjPVYn+FL0Pr8XVKsZRCxuFd
	 KkfXUMeFexCLiZTH8vXm2srsL8rx+THMcnrP1Gm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgFLKjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgFLKjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:39:05 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F5B420792;
        Fri, 12 Jun 2020 10:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591958344;
        bh=Ic5qw5oifdLSTHOeMZf7Yti20T61ZRmCTHxVz++OVmY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iqQTcCa0+IVkdpWesoiLrhyjZMFk6VVnbhjwKh1SfzhXm9EGnMkRZpYqvsJQCG1V0
         pMz6sgPbHiFBHpmxIks72Ct6ZjFzb6U8kB40mc5e917uIJjeH4VmS6z+Ya0yXAhbGP
         9mD1RhvKVUF4iyR+SiFAiKDvHYi1MSx+5ED0ikew=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jjh5S-002MhN-Bj; Fri, 12 Jun 2020 11:39:02 +0100
Date:   Fri, 12 Jun 2020 11:39:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: Re: [PATCH 06/11] irqchip/gic-v3: Configure SGIs as standard
 interrupts
Message-ID: <20200612113900.09d53bd0@why>
In-Reply-To: <jhjimgpxu2h.mognet@arm.com>
References: <20200519161755.209565-1-maz@kernel.org>
        <20200519161755.209565-7-maz@kernel.org>
        <jhjimgpxu2h.mognet@arm.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: valentin.schneider@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Thu, 21 May 2020 15:04:54 +0100
Valentin Schneider <valentin.schneider@arm.com> wrote:

> On 19/05/20 17:17, Marc Zyngier wrote:
> > Change the way we deal with GICv3 SGIs by turning them into proper
> > IRQs, and calling into the arch code to register the interrupt range
> > instead of a callback.
> >
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 91 +++++++++++++++++++++---------------
> >  1 file changed, 53 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 23d7c87da407..d57289057b75 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -1163,10 +1142,36 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
> >
> >  static void gic_smp_init(void)
> >  {
> > -	set_smp_cross_call(gic_raise_softirq);
> > +	struct irq_fwspec sgi_fwspec = {
> > +		.fwnode		= gic_data.fwnode,
> > +	};
> > +	int base_sgi;
> > +
> >       cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
> >                                 "irqchip/arm/gicv3:starting",
> >                                 gic_starting_cpu, NULL);
> > +
> > +	if (is_of_node(gic_data.fwnode)) {
> > +		/* DT */
> > +		sgi_fwspec.param_count = 3;
> > +		sgi_fwspec.param[0] = GIC_IRQ_TYPE_SGI;
> > +		sgi_fwspec.param[1] = 0;
> > +		sgi_fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
> > +	} else {
> > +		/* ACPI */
> > +		sgi_fwspec.param_count = 2;
> > +		sgi_fwspec.param[0] = 0;
> > +		sgi_fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
> > +	}
> > +
> > +	/* Register all 8 non-secure SGIs */
> > +	base_sgi = __irq_domain_alloc_irqs(gic_data.domain, -1, 8,
> > +					   NUMA_NO_NODE, &sgi_fwspec,
> > +					   false, NULL);  
> 
> So IIUC using irq_reserve_ipi() would require us to have a separate IPI
> domain, so instead here we can use a fwspec + the 'regular' GIC domain.

Indeed. Using an IPI domain wouldn't bring much. But the major point
against the current state of the IPI domain is that it sucks a bit for
our use case. We want interrupts to be contiguous in the Linux IRQ
space, and the IPI allocator prevents this.

But maybe I should just bite the bullet and hack that as well.

> One thing I see is that by not going through irq_reserve_ipi(), we don't set
> data->common->ipi_offset. I think this is all kzalloc'd, and we want an
> offset of 0 so it all works out, but this feels somewhat fragile.

So far, nothing is using this field on the limited piece of code we
use. But I agree, not the nicest behaviour.

> > +	if (WARN_ON(base_sgi <= 0))
> > +		return;
> > +
> > +	set_smp_ipi_range(base_sgi, 8);
> >  }
> >
> >  static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
> > @@ -1289,6 +1296,13 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
> >
> >       switch (__get_intid_range(hw)) {
> >       case SGI_RANGE:
> > +		irq_set_percpu_devid(irq);
> > +		irq_domain_set_info(d, irq, hw, chip, d->host_data,
> > +				    handle_percpu_devid_fasteoi_ipi,
> > +				    NULL, NULL);
> > +		irq_set_status_flags(irq, IRQ_NOAUTOEN);  
> 
> FWIW IRQ_NOAUTOEN is already set by irq_set_percpu_devid_flags(), so that's
> not required. I know we do that for (E)PPIs, I think I already have a small
> patch stashed somewhere regarding that.

Already merged! ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
