Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D45C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F91420835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591955672;
	bh=29xLLgXrlFOND3xwt1R9OGzjgUccP8AdjRanBn+2N0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=k918l9zSROJIIvKqeQBSIQ4kdrv/2gUs14ulx+yuGQTfv7GMtqYpF1LgpCTr9pwSH
	 Lnu6Tqy+mtNDKVUrf/c3LX7nNuitZBk1koqB22KJQNd3ZFe6PLxL/sSuIMW+duNVB/
	 DO8hHEqGgZsCsqHnPVUXR8w+SI6VbbvMxNLUsfS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgFLJya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgFLJya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:54:30 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963142081A;
        Fri, 12 Jun 2020 09:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591955669;
        bh=29xLLgXrlFOND3xwt1R9OGzjgUccP8AdjRanBn+2N0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BHgrfA+l8ekz4sPjfRG2DD+BcuA/k8P3NIYzebAqeoIAJPNuhvZ9Ld3x8v5L8fPCQ
         QNBWIIbWWHUmDokn73uZ3jitchC4DhKao5Kl4pIKLIMRdwlUdNWpODH9tlUC4AMTn5
         N03OrIgLygDs8uAkpA0EbaENpb5DoxQu1CKRiZIo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jjgOJ-002M7n-UK; Fri, 12 Jun 2020 10:54:28 +0100
Date:   Fri, 12 Jun 2020 10:54:26 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 01/11] genirq: Add fasteoi IPI flow
Message-ID: <20200612105426.39ff61bb@why>
In-Reply-To: <b691a46e-7461-89c8-c760-a1ef9769091f@gmail.com>
References: <20200519161755.209565-1-maz@kernel.org>
        <20200519161755.209565-2-maz@kernel.org>
        <b691a46e-7461-89c8-c760-a1ef9769091f@gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: f.fainelli@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sumit.garg@linaro.org, kernel-team@android.com, linux@arm.linux.org.uk, jason@lakedaemon.net, catalin.marinas@arm.com, tglx@linutronix.de, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 12:47:24 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 5/19/2020 9:17 AM, Marc Zyngier wrote:
> > For irqchips using the fasteoi flow, IPIs are a bit special.
> > 
> > They need to be EOId early (before calling the handler), as
> > funny things may happen in the handler (they do not necessarily
> > behave like a normal interrupt), and that the arch code is
> > already handling the stats.
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  include/linux/irq.h |  1 +
> >  kernel/irq/chip.c   | 26 ++++++++++++++++++++++++++
> >  2 files changed, 27 insertions(+)
> > 
> > diff --git a/include/linux/irq.h b/include/linux/irq.h
> > index 8d5bc2c237d7..726f94d8b8cc 100644
> > --- a/include/linux/irq.h
> > +++ b/include/linux/irq.h
> > @@ -621,6 +621,7 @@ static inline int irq_set_parent(int irq, int parent_irq)
> >   */
> >  extern void handle_level_irq(struct irq_desc *desc);
> >  extern void handle_fasteoi_irq(struct irq_desc *desc);
> > +extern void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc);
> >  extern void handle_edge_irq(struct irq_desc *desc);
> >  extern void handle_edge_eoi_irq(struct irq_desc *desc);
> >  extern void handle_simple_irq(struct irq_desc *desc);
> > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > index 41e7e37a0928..7b0b789cfed4 100644
> > --- a/kernel/irq/chip.c
> > +++ b/kernel/irq/chip.c
> > @@ -955,6 +955,32 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
> >  		chip->irq_eoi(&desc->irq_data);
> >  }
> >  
> > +/**
> > + * handle_percpu_devid_fasteoi_ipi - Per CPU local IPI handler with per cpu
> > + *				     dev ids
> > + * @desc:	the interrupt description structure for this irq
> > + *
> > + * The biggest differences with the IRQ version are that:
> > + * - the interrupt is EOIed early, as the IPI could result in a context
> > + *   switch, and we need to make sure the IPI can fire again
> > + * - Stats are usually handled at the architecture level, so we ignore them
> > + *   here
> > + */
> > +void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc)
> > +{
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +	struct irqaction *action = desc->action;
> > +	unsigned int irq = irq_desc_get_irq(desc);
> > +	irqreturn_t res;  
> 
> Should not this have a:
> 
> 	if (!irq_settings_is_no_accounting(desc))
> 		__kstat_incr_irqs_this_cpu(desc);
> 
> here in case you are using that handler with a SGI interrupt which is
> not used as an IPI?

I see you coming... ;-)

Yes, could do. TBH, I plan on killing the "no accounting" altogether
and move to the core IRQ one, so this would only be temporary. All I
need is to update the rest of the arm32 interrupt controllers...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
