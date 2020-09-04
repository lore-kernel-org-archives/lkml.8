Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E35C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8203520829
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgIDT2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:28:49 -0400
Received: from foss.arm.com ([217.140.110.172]:54912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgIDT2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:28:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F6591045;
        Fri,  4 Sep 2020 12:28:47 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68F433F68F;
        Fri,  4 Sep 2020 12:28:46 -0700 (PDT)
References: <20200903183206.104838-1-maz@kernel.org> <20200903183206.104838-2-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Subject: Re: [PATCH v2 1/4] genirq: Walk the irq_data hierarchy when resending an interrupt
In-reply-to: <20200903183206.104838-2-maz@kernel.org>
Date:   Fri, 04 Sep 2020 20:28:38 +0100
Message-ID: <jhj4kodxrx5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

On 03/09/20 19:32, Marc Zyngier wrote:
> On resending an interrupt, we only check the topmost irqchip for
> a irq_retrigger callback. However, this callback could be implemented
> at a lower level. Use irq_chip_retrigger_hierarchy() in this case.
>

Rookie wording question here; re-reading this I'm questioning which way is
up.

From an irq_data hierarchy PoV, the topmost chip (i.e. last ->parent)
should be the root irqchip. However, the irq_desc we get from irq_to_desc()
ought to hold the irq_data for the lowermost irqchip in that irq_data
hierarchy.

Is it that here by "topmost" you instead mean topmost of the irqchip stack
on top of the root (IOW furthest away from the root)?

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  kernel/irq/resend.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
> index c48ce19a257f..8ccd32a0cc80 100644
> --- a/kernel/irq/resend.c
> +++ b/kernel/irq/resend.c
> @@ -86,6 +86,18 @@ static int irq_sw_resend(struct irq_desc *desc)
>  }
>  #endif
>
> +static int try_retrigger(struct irq_desc *desc)
> +{
> +	if (desc->irq_data.chip->irq_retrigger)
> +		return desc->irq_data.chip->irq_retrigger(&desc->irq_data);
> +
> +#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
> +	return irq_chip_retrigger_hierarchy(&desc->irq_data);
> +#else
> +	return 0;
> +#endif
> +}
> +
>  /*
>   * IRQ resend
>   *
> @@ -113,8 +125,7 @@ int check_irq_resend(struct irq_desc *desc, bool inject)
>
>       desc->istate &= ~IRQS_PENDING;
>
> -	if (!desc->irq_data.chip->irq_retrigger ||
> -	    !desc->irq_data.chip->irq_retrigger(&desc->irq_data))
> +	if (!try_retrigger(desc))
>               err = irq_sw_resend(desc);
>
>       /* If the retrigger was successfull, mark it with the REPLAY bit */
