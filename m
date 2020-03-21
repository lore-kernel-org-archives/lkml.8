Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39366C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0715020757
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584799580;
	bh=2LYqxlJLALkKFlpvVEGc+tjKLuBtfj/ozo9eACQKvaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gUijOosLvbpzpFMS+WUXIemPqm8+1E+RK8rrY3E7Xumi89A8iqNgIscUb8mXZ+B8u
	 SGUHP5k41ReUz/MmD4gdnpOuicb+6U7cd4WuRTxuNUGvCbUHvztFTP4hOyG/XSMgPG
	 sH7AxHR5nLSorYu6NmaOCw7WYeJCkZXEkGsU98kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgCUOFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 10:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbgCUOFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 10:05:04 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 916B320757;
        Sat, 21 Mar 2020 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584799503;
        bh=2LYqxlJLALkKFlpvVEGc+tjKLuBtfj/ozo9eACQKvaw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Viee7yhYqu5DhM3KRxgC7BOYKsHKq2eVJ3mZWlwBmROgY//CXPk6aiRd+kdVMPlfl
         bQWwtGOskyltOReYv3sK1c/ZZ+aZUm6WpLLUcOluQJk0uRVtwhvRmNZh9V71h0QrpB
         8bzoBozpXhJ/VbzRA7/M2wjTBafP9GpHyylNWXUw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jFekH-00EVV7-Sn; Sat, 21 Mar 2020 14:05:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 21 Mar 2020 14:05:01 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     linux-oxnas@groups.io, Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] irqchip/versatile-fpga: Apply clear-mask earlier
In-Reply-To: <20200321133842.2408823-1-mans0n@gorani.run>
References: <20200321133842.2408823-1-mans0n@gorani.run>
Message-ID: <4c8b67a7912b2863db99ff4e765fdb8b@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mans0n@gorani.run, linux-oxnas@groups.io, linus.walleij@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, narmstrong@baylibre.com, daniel@makrotopia.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-21 13:38, Sungbo Eo wrote:
> Clear its own IRQs before the parent IRQ get enabled, so that the
> remaining IRQs do not accidentally interrupt the parent IRQ controller.
> 
> This patch also fixes a reboot bug on OX820 SoC, where the remaining
> rps-timer IRQ raises a GIC interrupt that is left pending. After that,
> the rps-timer IRQ is cleared during driver initialization, and there's
> no IRQ left in rps-irq when local_irq_enable() is called, which evokes
> an error message "unexpected IRQ trap".
> 
> Fixes: bdd272cbb97a ("irqchip: versatile FPGA: support cascaded
> interrupts from DT")
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/irqchip/irq-versatile-fpga.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-versatile-fpga.c
> b/drivers/irqchip/irq-versatile-fpga.c
> index 70e2cfff8175..f1386733d3bc 100644
> --- a/drivers/irqchip/irq-versatile-fpga.c
> +++ b/drivers/irqchip/irq-versatile-fpga.c
> @@ -212,6 +212,9 @@ int __init fpga_irq_of_init(struct device_node 
> *node,
>  	if (of_property_read_u32(node, "valid-mask", &valid_mask))
>  		valid_mask = 0;
> 
> +	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
> +	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
> +
>  	/* Some chips are cascaded from a parent IRQ */
>  	parent_irq = irq_of_parse_and_map(node, 0);
>  	if (!parent_irq) {
> @@ -221,9 +224,6 @@ int __init fpga_irq_of_init(struct device_node 
> *node,
> 
>  	fpga_irq_init(base, node->name, 0, parent_irq, valid_mask, node);
> 
> -	writel(clear_mask, base + IRQ_ENABLE_CLEAR);
> -	writel(clear_mask, base + FIQ_ENABLE_CLEAR);
> -
>  	/*
>  	 * On Versatile AB/PB, some secondary interrupts have a direct
>  	 * pass-thru to the primary controller for IRQs 20 and 22-31 which 
> need

You're on a roll! ;-) Queued for 5.7.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
