Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2519C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB99206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4BtqCav8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DOKFv728"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgG2NCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgG2NCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:02:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C315EC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 06:02:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596027741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ISg0/WArn12noaQmrr46IGgWshWP/iaAXMHUeAAHF4U=;
        b=4BtqCav83IxKHOF5OuHBXDNPxXmA1MKiNVJZFKGS73HUdSYrUsax3Jm8GPZ6nuA7PnH/w9
        G7GFrNWL48jeSLOfIqeZhKPMwNsJTUvabXeCQwMWTFHRpXzSxpUnw/iFF1j+gAycS6vnki
        xGhW+xOK2CrzZqEjgGLgV9B53LGg4Hk7GPN8DPUSssg44bbvXidTNzDmCLoRbtGmh/nvEL
        iPl3HEtwo5oF2mw8umxFlA6q8I0R1LP7qHz80aZV1NnGf2F6HPDTHHubq93JOcWCLp2kXb
        nrlcUUy4uJ1k4vK2SiEbsChPmryUXmhZI3vhvXZb2pfKAAdxLBFVIVF6pCmsWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596027741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ISg0/WArn12noaQmrr46IGgWshWP/iaAXMHUeAAHF4U=;
        b=DOKFv728My1t2n9oT14oCmpA1rDI1NsmD92tbTt0Mhfw6esQlSSTu64E0pDmCqVbe+bT57
        brxZA12YUaUnRzDQ==
To:     Freddy Hsin <freddy.hsin@mediatek.com>,
        linux-mediatek@lists.infradead.or,
        linux-arm-kernel@lists.infradead.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks \(Codethink\)" <ben.dooks@codethink.co.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, chang-an.chen@mediatek.com,
        Baolin Wang <baolin.wang7@gmail.com>,
        wsd_upstream@mediatek.com, kuohong.wang@mediatek.com,
        stanley.chu@mediatek.com, Freddy Hsin <freddy.hsin@mediatek.com>
Subject: Re: [PATCH v1 2/2] timer: mt6873: porting Mediatek timer driver to loadable module
In-Reply-To: <1595931377-21627-3-git-send-email-freddy.hsin@mediatek.com>
References: <1595931377-21627-1-git-send-email-freddy.hsin@mediatek.com> <1595931377-21627-3-git-send-email-freddy.hsin@mediatek.com>
Date:   Wed, 29 Jul 2020 15:02:20 +0200
Message-ID: <87mu3ia2zn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freddy,

Freddy Hsin <freddy.hsin@mediatek.com> writes:

again, please be more careful with subject lines. git log $FILE will
give you a hint. 

> porting Mediatek timer driver to loadable module

Repeating the sentence in the subject line is not giving any
information. Also changelogs want to tell the WHY and not the WHAT. This
also lacks any information why this is actually safe when booting such a
system w/o this particular driver built in. What is early boot - up to
module load - using as clocksource and timer?

> diff --git a/drivers/clocksource/mmio.c b/drivers/clocksource/mmio.c
> index 9de7515..5504569 100644
> --- a/drivers/clocksource/mmio.c
> +++ b/drivers/clocksource/mmio.c
> @@ -21,6 +21,7 @@ u64 clocksource_mmio_readl_up(struct clocksource *c)
>  {
>  	return (u64)readl_relaxed(to_mmio_clksrc(c)->reg);
>  }
> +EXPORT_SYMBOL(clocksource_mmio_readl_up);

Again EXPORT_SYMBOL_GPL() and this wants to be a seperate patch. It has
absolutely no business with the mediatek timer changes. 
  
>  u64 clocksource_mmio_readl_down(struct clocksource *c)
>  {
> @@ -46,7 +47,7 @@ u64 clocksource_mmio_readw_down(struct clocksource *c)
>   * @bits:	Number of valid bits
>   * @read:	One of clocksource_mmio_read*() above
>   */
> -int __init clocksource_mmio_init(void __iomem *base, const char *name,
> +int clocksource_mmio_init(void __iomem *base, const char *name,
>
>  	unsigned long hz, int rating, unsigned bits,
>  	u64 (*read)(struct clocksource *))
>  {
> @@ -68,3 +69,4 @@ int __init clocksource_mmio_init(void __iomem *base, const char *name,
>  
>  	return clocksource_register_hz(&cs->clksrc, hz);
>  }
> +EXPORT_SYMBOL(clocksource_mmio_init);

See above.

> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> index 9318edc..5c89b6b 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -13,6 +13,9 @@
>  #include <linux/clocksource.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqreturn.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/sched_clock.h>
>  #include <linux/slab.h>
>  #include "timer-of.h"
> @@ -309,5 +312,41 @@ static int __init mtk_gpt_init(struct device_node *node)
>  
>  	return 0;
>  }
> +
> +#ifdef MODULE
> +static int mtk_timer_probe(struct platform_device *pdev)
> +{
> +	int (*timer_init)(struct device_node *node);
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	timer_init = of_device_get_match_data(&pdev->dev);
> +	return timer_init(np);
> +}
> +
> +static const struct of_device_id mtk_timer_match_table[] = {
> +	{
> +		.compatible = "mediatek,mt6577-timer",
> +		.data = mtk_gpt_init,
> +	},
> +	{
> +		.compatible = "mediatek,mt6765-timer",
> +		.data = mtk_syst_init,
> +	},
> +	{}
> +};
> +
> +static struct platform_driver mtk_timer_driver = {
> +	.probe = mtk_timer_probe,
> +	.driver = {
> +		.name = "mtk-timer",
> +		.of_match_table = mtk_timer_match_table,
> +	},
> +};
> +MODULE_DESCRIPTION("MEDIATEK Module timer driver");
> +MODULE_LICENSE("GPL v2");
> +
> +module_platform_driver(mtk_timer_driver);
> +#else
>  TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
>  TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
> +#endif

Sorry no. This is not going to happen.

The above probe, match table and platform driver structs plus the module*
thingies are going to be repeated in every single driver which is going
to support module build. Tons of boilerplate copied over and over
again.

We had exactly the same before TIMER_OF_DECLARE() came around, so pretty
please this want's to be some smart macro which handles all of this
automatically.

Thanks,

        tglx


