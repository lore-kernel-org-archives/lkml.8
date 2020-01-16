Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358B1C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C3F2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cG+G6v5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgAPOk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:40:28 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40985 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgAPOk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:40:27 -0500
Received: by mail-vk1-f193.google.com with SMTP id p191so5726302vkf.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 06:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NpLGxQLI1+y6uTLo6qG0jPbqV9mq8oEXss/UvO2Z700=;
        b=cG+G6v5T4hfjbtdqUTbPM1+6tb5EA3x5QYuBV2O5VLPt2vUv403KNW8eS/zfvRGuEp
         whraMXFHluXO3YHILR5f20IbEtyEv5qG1VdFSWe8jhMxiII18sOLN1O02cplp47S2zLZ
         ZsKjVLuYJDHGUD9EaWiMwm+q653+je2mz5BJkkh2avssS7SfaHrith/cbbKbYSUMaWWu
         VhehXskrjyGlUX+O7NS+MrVbAg6OerKZ4fUn/S3E7jyw+++HusMZiMGF14hvx6hE3D0i
         mkrqfg8+aiQmSi9QF+9J+locg4e3lQjpgsBEA+I1+grBeGA4hGHTWJhit2Pzun0Z6Dqm
         OcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NpLGxQLI1+y6uTLo6qG0jPbqV9mq8oEXss/UvO2Z700=;
        b=kyqe1z2+tnCb1uRqTnrBdPVRMqK34DWwAirS0MPmfJ6sG0vvu5rpmx2ghFZF24Lfzj
         urBPaAqtRrHmbEOEwpHDBgrJiYbbuS+Ii4zh/8C3Qybuob4YkW1afmTX9y5I/ZC9dLkK
         QTfVJNefhu30gxK1R81TcTgiE48mOCZiNBaoYmcqclu4OIg2uMtcR90RiuuW3kkf2oN0
         NoVrWHmdbFpM9YpXbbVe+HkpFfhmThONsBcymOs4pkARKyGry07zZ9wpz4WmpFsKfJwI
         vZft7H7TCoWOtXSsnbb47Mias0hKk8/7QHpzH1dg0ledw+1EDHwO+2yltm9DD22yQeYX
         MJ6w==
X-Gm-Message-State: APjAAAWbq5YNUur5akUt5yK53tRA4UnGa320TA1vtCaIBRCxk0AUtKbx
        RB7H+w78NmoBZlafDW3JpcA75M5sygEp19hm6B4Ybw==
X-Google-Smtp-Source: APXvYqz4hUhZEk4bx4J5CXNlGulkNxAsAS+pnqFVPO/QlgvVVbZEFAEOBOW63sbJ700Hbl+Ouq9yjwPBQiz34wro8ck=
X-Received: by 2002:ac5:c844:: with SMTP id g4mr17798634vkm.25.1579185626649;
 Thu, 16 Jan 2020 06:40:26 -0800 (PST)
MIME-Version: 1.0
References: <b2a44d5be2e06ff075f32477e466598bb0f07b36.1577961679.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <b2a44d5be2e06ff075f32477e466598bb0f07b36.1577961679.git.mirq-linux@rere.qmqm.pl>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 15:39:50 +0100
Message-ID: <CAPDyKFoJzcRDEx9HD3XngbbaMJcj1LEJ2OeLKdvNKG_rxuWFkg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix memleak on clk_get failure
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020 at 11:42, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmq=
m.pl> wrote:
>
> sdhci_alloc_host() does its work not using managed infrastructure, so
> needs explicit free on error path. Add it where needed.
>
> Cc: <stable@vger.kernel.org>
> Fixes: bb5f8ea4d514 ("mmc: sdhci-of-at91: introduce driver for the Atmel =
SDMMC")
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Applied for next, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/sdhci-of-at91.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of=
-at91.c
> index b2a8c45c9c23..ab2bd314a390 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -345,20 +345,23 @@ static int sdhci_at91_probe(struct platform_device =
*pdev)
>                         priv->mainck =3D NULL;
>                 } else {
>                         dev_err(&pdev->dev, "failed to get baseclk\n");
> -                       return PTR_ERR(priv->mainck);
> +                       ret =3D PTR_ERR(priv->mainck);
> +                       goto sdhci_pltfm_free;
>                 }
>         }
>
>         priv->hclock =3D devm_clk_get(&pdev->dev, "hclock");
>         if (IS_ERR(priv->hclock)) {
>                 dev_err(&pdev->dev, "failed to get hclock\n");
> -               return PTR_ERR(priv->hclock);
> +               ret =3D PTR_ERR(priv->hclock);
> +               goto sdhci_pltfm_free;
>         }
>
>         priv->gck =3D devm_clk_get(&pdev->dev, "multclk");
>         if (IS_ERR(priv->gck)) {
>                 dev_err(&pdev->dev, "failed to get multclk\n");
> -               return PTR_ERR(priv->gck);
> +               ret =3D PTR_ERR(priv->gck);
> +               goto sdhci_pltfm_free;
>         }
>
>         ret =3D sdhci_at91_set_clks_presets(&pdev->dev);
> --
> 2.20.1
>
