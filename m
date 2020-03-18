Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373DCC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1247F20757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584553692;
	bh=nIRM+WY3P5vmQLvcggYZkzjwW+uq3nchuZAFnsr2gLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uuusHe2sKpEN6IZ5l0oaD6XQs1bx6bO4jNqxnnGm1FPK8tHDQWU5UOFf7Z6MRtHaN
	 2uOSaJPU9ayp4JnGm0jliP/BxisiQ6AVjwXhAZlPao7q1aluTezN22pViNJkMya9+/
	 k+JpHISTb7wwMaRW5xag3KRC0tlbnYErRYAC80mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCRRsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRRsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:48:10 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB6B20752;
        Wed, 18 Mar 2020 17:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584553688;
        bh=nIRM+WY3P5vmQLvcggYZkzjwW+uq3nchuZAFnsr2gLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z2hysmjLTxToxZUAsYP5vyO0cdtXwbm0WB6Hl6cgzLv3k8l0WarkYNMKFynv6FLGk
         JUru6IgeSJOZhqP5ir8e9kZrVXlgz3wG07V/yYMI9KmgtYxAS+ECM9O2a8WdhAMCC/
         UKcnQM2rCMOf9pYvpZsAEEwZkxfPZ+vNxBtFaDOI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jEcnX-00Dhie-06; Wed, 18 Mar 2020 17:48:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Mar 2020 17:48:06 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     linux-oxnas@groups.io, Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] irqchip/versatile-fpga: Handle chained IRQs properly
In-Reply-To: <20200318170904.1461278-1-mans0n@gorani.run>
References: <20200318170904.1461278-1-mans0n@gorani.run>
Message-ID: <112cdab389aa9cc30189c7aec0baded2@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mans0n@gorani.run, linux-oxnas@groups.io, linus.walleij@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, narmstrong@baylibre.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sungbo,

On 2020-03-18 17:09, Sungbo Eo wrote:
> Enclose the chained handler with chained_irq_{enter,exit}(), so that 
> the
> muxed interrupts get properly acked.
> 
> This patch also fixes a reboot bug on OX820 SoC, where the jiffies 
> timer
> interrupt is never acked. The kernel waits a clock tick forever in
> calibrate_delay_converge(), which leads to a boot hang.

Nice catch.

> 
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/irqchip/irq-versatile-fpga.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-versatile-fpga.c
> b/drivers/irqchip/irq-versatile-fpga.c
> index 928858dada75..08faab2fec3e 100644
> --- a/drivers/irqchip/irq-versatile-fpga.c
> +++ b/drivers/irqchip/irq-versatile-fpga.c
> @@ -6,6 +6,7 @@
>  #include <linux/irq.h>
>  #include <linux/io.h>
>  #include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
>  #include <linux/irqchip/versatile-fpga.h>
>  #include <linux/irqdomain.h>
>  #include <linux/module.h>
> @@ -68,12 +69,15 @@ static void fpga_irq_unmask(struct irq_data *d)
> 
>  static void fpga_irq_handle(struct irq_desc *desc)
>  {
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	struct fpga_irq_data *f = irq_desc_get_handler_data(desc);
>  	u32 status = readl(f->base + IRQ_STATUS);
> 
> +	chained_irq_enter(chip, desc);
> +

It's probably not a big deal, but I'm not fond of starting talking to
the muxing irqchip before having done the chained_irq_enter() call.

Moving that read here would probably be safer.

>  	if (status == 0) {
>  		do_bad_IRQ(desc);
> -		return;
> +		goto out;
>  	}
> 
>  	do {
> @@ -82,6 +86,9 @@ static void fpga_irq_handle(struct irq_desc *desc)
>  		status &= ~(1 << irq);
>  		generic_handle_irq(irq_find_mapping(f->domain, irq));
>  	} while (status);
> +
> +out:
> +	chained_irq_exit(chip, desc);
>  }
> 
>  /*

Otherwise looks good. If you send it again with the above fixed
and a Fixes: tag, I'll queue it.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
