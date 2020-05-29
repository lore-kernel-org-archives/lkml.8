Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B81C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72892075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590741157;
	bh=c6Aa5ByuhdG16T+5Vu74GnNb0ZM+kd3oe7ecqFSIjgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kO2U1n72SzlF9YgHrC9xc8nTyDEVTQKFfUVG9ui1pPDILgZM7pA31OWs31rfdU60t
	 EaaC82zuJXhn4qTh+s0PhdqJglY3V+2kmYK81IK1B/lc7NtP/xQLnhLdeYmx68cPAU
	 TlP+mACVM2gnOsleoET0dJpu02kspHMxcLdMnsH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgE2Ich (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2Icg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:32:36 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95CD2207F5;
        Fri, 29 May 2020 08:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590741155;
        bh=c6Aa5ByuhdG16T+5Vu74GnNb0ZM+kd3oe7ecqFSIjgY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=joysJ+Nph1O6ii0Q3g0E5dyYkW2jwQEFd1pZ0jexWpDcDdZDw/XCRQlYlZ20PpBoV
         0f5TU88TMJzW4ub8J2EfxgBtv1ynUdMN48EFzdgrohcbJLLvER467XxLdtOH0hPIUD
         IquyZ2Wcsof87ce7gBTifswM/74D6c7vWMUhM2Lk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jeaRN-00GDax-PL; Fri, 29 May 2020 09:32:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 May 2020 09:32:33 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        benh@amazon.com, dwmw@amazon.com, zeev@amazon.com, zorik@amazon.com
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
In-Reply-To: <20200529015501.15771-1-alisaidi@amazon.com>
References: <20200529015501.15771-1-alisaidi@amazon.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <8c3be990888ecfb7cca9503853dc4aac@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: alisaidi@amazon.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, benh@amazon.com, dwmw@amazon.com, zeev@amazon.com, zorik@amazon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ali,

On 2020-05-29 02:55, Ali Saidi wrote:
> If an interrupt is disabled the ITS driver has sent a discard removing
> the DeviceID and EventID from the ITT. After this occurs it can't be
> moved to another collection with a MOVI and a command error occurs if
> attempted. Before issuing the MOVI command make sure that the IRQ isn't
> disabled and change the activate code to try and use the previous
> affinity.
> 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index 124251b0ccba..1235dd9a2fb2 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1540,7 +1540,11 @@ static int its_set_affinity(struct irq_data *d,
> const struct cpumask *mask_val,
>  	/* don't set the affinity when the target cpu is same as current one 
> */
>  	if (cpu != its_dev->event_map.col_map[id]) {
>  		target_col = &its_dev->its->collections[cpu];
> -		its_send_movi(its_dev, target_col, id);
> +
> +		/* If the IRQ is disabled a discard was sent so don't move */
> +		if (!irqd_irq_disabled(d))
> +			its_send_movi(its_dev, target_col, id);
> +

This looks wrong. What you are testing here is whether the interrupt
is masked, not that there isn't a valid translation.

In the commit message, you're saying that we've issued a discard. This
hints at doing a set_affinity on an interrupt that has been deactivated
(mapping removed). Is that actually the case? If so, why was it 
deactivated
the first place?

>  		its_dev->event_map.col_map[id] = cpu;
>  		irq_data_update_effective_affinity(d, cpumask_of(cpu));
>  	}
> @@ -3439,8 +3443,16 @@ static int its_irq_domain_activate(struct
> irq_domain *domain,
>  	if (its_dev->its->numa_node >= 0)
>  		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
> 
> -	/* Bind the LPI to the first possible CPU */
> -	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
> +	/* If the cpu set to a different CPU that is still online use it */
> +	cpu = its_dev->event_map.col_map[event];
> +
> +	cpumask_and(cpu_mask, cpu_mask, cpu_online_mask);
> +
> +	if (!cpumask_test_cpu(cpu, cpu_mask)) {
> +		/* Bind the LPI to the first possible CPU */
> +		cpu = cpumask_first(cpu_mask);
> +	}
> +
>  	if (cpu >= nr_cpu_ids) {
>  		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
>  			return -EINVAL;

So you deactivate an interrupt, do a set_affinity that doesn't issue
a MOVI but preserves the affinity, then reactivate it and hope that
the new mapping will target the "right" CPU.

That seems a bit mad, but I presume this isn't the whole story...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
