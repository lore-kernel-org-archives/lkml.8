Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A4CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F9D206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e8HNVypb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCFWuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:50:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38542 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFWuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:50:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so3892613ljh.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 14:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=+KdFgHd0Khi4D1I+q98xetrP7WjqAjfW7zo+CRETAms=;
        b=e8HNVypbS1BSjAYaVJJGJ+lKqiyoZLEYraBW0NcV4WgM3WRpmeJseFIlMHSsduthi8
         bfvxHTjVtPlItpMk7F/T9BgaTmF4A0GeTIML+V+gg1wHMUr1twtjejyU971EbA3I7srS
         P67lwS73bevLsMsn6lSRm+pieEbC3gt76dyLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=+KdFgHd0Khi4D1I+q98xetrP7WjqAjfW7zo+CRETAms=;
        b=K+xdjgtKr0E8f0Zxd0ewUT9ZYDYBpj5uBX6DrR6PXntuFk+jiXnIr9jOqYeAZ7GCeY
         l+XVFTs8/tme0IuUpbCU/yeyQNzWQ96PKdDGtApQYKukWNUVq5z0tYv2I9HMU9yxyGYr
         UpcHTnzzCMnmwsIPpDn7wkh58UjzTZGCkkCOHaIlJBCuT6nzixqAnSCUW95xjB1aNhbk
         zlxoQ9f15GlGlViASQoh8e8YEtMhtwCIA214+nXfBS3F5fUH0IU43Ug12sK/7nmtkyro
         kMW9RrcnbZAvcDcvxMe5lBSKV75abB/zHG8KyHN+LINmah+TrVCz3bCgwPtBeYkWYPm8
         3ksg==
X-Gm-Message-State: ANhLgQ1UJ9stMIEguwvHl33LgVCMREpzPVDUP0OhiDWpETXnIiqThMwL
        O54owu6CNHh7DGBYP4sllKq/w9fJAQo2VTLG0pxqrA==
X-Google-Smtp-Source: ADFU+vvb+PrrT95TpfxieL14D0NqyXJi/a9FHEMKFcoukv944eoKgmEzoL0AOVCOoUwoDUqsoNYVB8prKmFXlelzJYQ=
X-Received: by 2002:a2e:80c3:: with SMTP id r3mr3329042ljg.105.1583535048747;
 Fri, 06 Mar 2020 14:50:48 -0800 (PST)
From:   Kevin Li <kevin-ke.li@broadcom.com>
References: <20200306222705.13309-1-kevin-ke.li@broadcom.com> <8d4fc59e-f892-7228-4369-f40ced5dc2d3@gmail.com>
In-Reply-To: <8d4fc59e-f892-7228-4369-f40ced5dc2d3@gmail.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQK6AtPk+W1UvlC/8YJn5FlJAEq5hQIs4nExpmKljtA=
Date:   Fri, 6 Mar 2020 14:50:46 -0800
Message-ID: <31b665e609f3cfee935f4489a073af21@mail.gmail.com>
Subject: RE: [PATCH] ASoC: brcm: Add DSL/PON SoC audio driver
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Scott Branden <sbranden@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        bcm-kernel-feedback-list@broadcom.com,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

It is called from bcm63xx-i2s-whistler.c.
Maybe the name "_probe" function confused. It was 2 platform drivers, I
combined them together now.

Let me know if this answers your question, and what to do to address your
question.

Regards!
Kevin

-----Original Message-----
From: Florian Fainelli [mailto:f.fainelli@gmail.com]
Sent: Friday, March 06, 2020 2:34 PM
To: Kevin Li <kevin-ke.li@broadcom.com>; Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; Kuninori
Morimoto <kuninori.morimoto.gx@renesas.com>; Scott Branden
<sbranden@broadcom.com>; Liam Girdwood <lgirdwood@gmail.com>; Ray Jui
<rjui@broadcom.com>; Takashi Iwai <tiwai@suse.com>; Jaroslav Kysela
<perex@perex.cz>; bcm-kernel-feedback-list@broadcom.com; Stephen Boyd
<swboyd@chromium.org>; linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ASoC: brcm: Add DSL/PON SoC audio driver

On 3/6/20 2:27 PM, Kevin Li wrote:
> This patch adds Broadcom DSL/PON SoC audio driver with Whistler I2S
> block. The SoC supported by this patch are BCM63158B0,BCM63178 and
> BCM47622/6755.
>
> Signed-off-by: Kevin Li <kevin-ke.li@broadcom.com>
> ---

[snip]

> +int bcm63xx_soc_platform_probe(struct platform_device *pdev,
> +			       struct bcm_i2s_priv *i2s_priv) {
> +	int ret;
> +
> +	i2s_priv->r_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!i2s_priv->r_irq) {
> +		dev_err(&pdev->dev, "Unable to get register irq resource.\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, i2s_priv->r_irq->start, i2s_dma_isr,
> +			i2s_priv->r_irq->flags, "i2s_dma", (void *)i2s_priv);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"i2s_init: failed to request interrupt.ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	return devm_snd_soc_register_component(&pdev->dev,
> +					&bcm63xx_soc_platform, NULL, 0); }
> +
> +int bcm63xx_soc_platform_remove(struct platform_device *pdev) {
> +	return 0;
> +}

How does one probe this module if the bcm63xx_soc_platform_probe() functions
are not called from anywhere and/or hooked up to the module entry/exit
points?

Are you not missing a platform_driver entry which matches the compatible
string you defined?
--
Florian
