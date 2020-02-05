Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178CBC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36452072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rbYxnd3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBEMS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:18:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52822 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgBEMS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:18:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so2252791wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 04:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=voMdPtqTu9Je6ipNUTsS1dof90qK0VWTr6b+FpuYAkw=;
        b=rbYxnd3Uix7LvN8ZvaV0sEul0n8FVzPXwHi7sHxmLtOpmfZGdBtWi+TVgWzW5dKARR
         6A5yOT4I3hYP7jhJmEzkNzdZoIo9QUZ5eKrl/CrxN+bpQkrNx+7UHuSCkWjanxeK8/zF
         PlKx3mHY3WdKj7TmWrM3JCpP/+DtEWP/2pUfTvEusUpDPaSrEzobnG9zQrOACe3LywVB
         Xh7JJYtulg4YpAs7zkDo8D/uYt+pEawWL9RDV4qaRaG3hVDd1uNSuFZ5a6ueXc0C0ojS
         LDgmedeSLNDaJUrtpI7t3t72nkeETwNSQQCbkuAjPJ0rqKV34c+/wi9U9HQ7vjNcV6EC
         /fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=voMdPtqTu9Je6ipNUTsS1dof90qK0VWTr6b+FpuYAkw=;
        b=h/IyZ7ovjrIxo9J5AwEbyQsLqztItHTjniWLZOIL6AC+CVUCpLbGTg9DRVmObXNToe
         uRh6bHFqPineY4K8OltfbxG0MPg7X18X/+e1sCYOakL2l0Qq4I/6cewRTZ5+EGtjrByX
         3wHx9Ufp3Gvc6yWpTpse16JapJe7RTULfkYlzTL862PRE9gCFogD/SNpb26NFsoDVAcU
         MmfCLU1Y95yRhptjx2tXeyzJFBrqoCIRowg9sZbrGOvPYmywueku0LEejE/ppc2/rwFr
         3r/mxGMZm9tfMdszbP7QvXt4PVtPdRBHtbvqgdkHAewnQVHB9RNTDGycaOSu/vpPak49
         OJuQ==
X-Gm-Message-State: APjAAAWI9UiyeHWnFEoTHaoFLhvT0f/zDoH1Kl38e6wCQOXnTvyK5J4x
        ZE67jda3CjXZ5EX1ZElhQRfY7w==
X-Google-Smtp-Source: APXvYqyDoDPihMTOysPRfqs269bKMj5DhpyROGO1P5iqEr8w+Aqy9iE+RcMqTgaKG2uVbVB/PT73+Q==
X-Received: by 2002:a1c:4d08:: with SMTP id o8mr5620521wmh.86.1580905104558;
        Wed, 05 Feb 2020 04:18:24 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y20sm7513220wmi.25.2020.02.05.04.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 04:18:23 -0800 (PST)
References: <CAJZgTGF2ihuu_bSzQ93iBTf1YQ4_NM29S4iBFM8Fhd_RUaw2vQ@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Nicolas Belin <nbelin@baylibre.com>, linus.walleij@linaro.org
Cc:     Kevin Hilman <khilman@baylibre.com>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: meson-gxl: fix GPIOX sdio pins
In-reply-to: <CAJZgTGF2ihuu_bSzQ93iBTf1YQ4_NM29S4iBFM8Fhd_RUaw2vQ@mail.gmail.com>
Date:   Wed, 05 Feb 2020 13:18:22 +0100
Message-ID: <1ja75x6xdd.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 05 Feb 2020 at 12:22, Nicolas Belin <nbelin@baylibre.com> wrote:

> In the gxl driver, the sdio cmd and clk pins are inverted. It has not caused
> any issue so far because devices using these pins always take both pins
> so the resulting configuration is OK.
>
> Fixes: 0f15f500ff2c ("pinctrl: meson: Add GXL pinctrl definitions")
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  drivers/pinctrl/meson/pinctrl-meson-gxl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> index 72c5373c8dc1..e8d1f3050487 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> @@ -147,8 +147,8 @@ static const unsigned int sdio_d0_pins[]    = { GPIOX_0 };
>  static const unsigned int sdio_d1_pins[]       = { GPIOX_1 };
>  static const unsigned int sdio_d2_pins[]       = { GPIOX_2 };
>  static const unsigned int sdio_d3_pins[]       = { GPIOX_3 };
> -static const unsigned int sdio_cmd_pins[]      = { GPIOX_4 };
> -static const unsigned int sdio_clk_pins[]      = { GPIOX_5 };
> +static const unsigned int sdio_clk_pins[]      = { GPIOX_4 };
> +static const unsigned int sdio_cmd_pins[]      = { GPIOX_5 };
>  static const unsigned int sdio_irq_pins[]      = { GPIOX_7 };
>
>  static const unsigned int nand_ce0_pins[]      = { BOOT_8 };

