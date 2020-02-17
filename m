Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1DCC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E36206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgBQJu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:50:29 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38993 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbgBQJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:50:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id m13so19931981edb.6;
        Mon, 17 Feb 2020 01:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XrEF/NtEu+Nj+IQK0nqsFK8onNp/rg/dsNwpBu7rDS8=;
        b=MnR2HkJQDugQQ/0hjJFE3/r6A1QpHYEsTGhSsehPOrNYgw+yi18k+ihf5BfCT39l8q
         gyd5KBqS8LYVNWv0SjXYXZ2UtyNMwSnQqMLNMFXeQWlB8z577SUMrpkeDsuEyToqXAWG
         hkdJtF8Nt55AIexh4fIQmw4/4lBLTZYv3OUJm77gIAxj7SWvY2W7xtqtbSZoGOsPscNu
         R4MVISZf1sFjLSWDCXR/WeUCos66zTo5X10FsIHzeTHfHXYvEnGkQVfLDmD0Zr+IxkYx
         fZY7CCbdhMU1eCB+MpR2WXG7VECIt3eXRCKTQEYaYW8bkqWAwjkPyDaNsphhYo3uGCx7
         ZvMA==
X-Gm-Message-State: APjAAAUuGAEab9SzEE4XQ+StDIiDS7jOCq3SFWgL68LffvQ7KB9oKdxV
        jKtn5yrH+Nz5Jm+++SMewHLTcm+g7aQ=
X-Google-Smtp-Source: APXvYqyUKRAUDHAZDyg19iG/rK++YSsZqmEKhpdNsiW0BoPRh6LPV5sjASAOm6HbH03K7eOnTcQcog==
X-Received: by 2002:a05:6402:1352:: with SMTP id y18mr13254104edw.35.1581933026732;
        Mon, 17 Feb 2020 01:50:26 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id qt20sm852240ejb.65.2020.02.17.01.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 01:50:26 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id a5so16424313wmb.0;
        Mon, 17 Feb 2020 01:50:25 -0800 (PST)
X-Received: by 2002:a05:600c:34d:: with SMTP id u13mr21962294wmd.77.1581933025751;
 Mon, 17 Feb 2020 01:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org> <20200217064250.15516-3-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-3-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 17:50:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v66b=JyB+7WYJ9Yv_C4TS3BSofjaahXc6VP3Kbzo91YffA@mail.gmail.com>
Message-ID: <CAGb2v66b=JyB+7WYJ9Yv_C4TS3BSofjaahXc6VP3Kbzo91YffA@mail.gmail.com>
Subject: Re: [RFC PATCH 02/34] ASoC: sun8i-codec: LRCK is not inverted on A64
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 2:42 PM Samuel Holland <samuel@sholland.org> wrote:
>
> On the A64 (tested with the Pinephone), the current code causes the
> left/right channels to be swapped during I2S playback from the CPU on
> AIF1, and breaks DSP_A communication with the modem on AIF2.
>
> Trusting that the comment in the code is correct, the existing behavior
> is kept for the A33.
>
> Cc: stable@kernel.org
> Fixes: ec4a95409d5c ("arm64: dts: allwinner: a64: add nodes necessary for analog sound support")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  sound/soc/sunxi/sun8i-codec.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> index 55798bc8eae2..14cf31f5c535 100644
> --- a/sound/soc/sunxi/sun8i-codec.c
> +++ b/sound/soc/sunxi/sun8i-codec.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/log2.h>
> @@ -89,6 +90,7 @@ struct sun8i_codec {
>         struct regmap   *regmap;
>         struct clk      *clk_module;
>         struct clk      *clk_bus;
> +       bool            inverted_lrck;
>  };
>
>  static int sun8i_codec_runtime_resume(struct device *dev)
> @@ -209,18 +211,19 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>                            value << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV);
>
>         /*
> -        * It appears that the DAI and the codec don't share the same
> -        * polarity for the LRCK signal when they mean 'normal' and
> -        * 'inverted' in the datasheet.
> +        * It appears that the DAI and the codec in the A33 SoC don't
> +        * share the same polarity for the LRCK signal when they mean
> +        * 'normal' and 'inverted' in the datasheet.
>          *
>          * Since the DAI here is our regular i2s driver that have been
>          * tested with way more codecs than just this one, it means
>          * that the codec probably gets it backward, and we have to
>          * invert the value here.
>          */
> +       value ^= scodec->inverted_lrck;
>         regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
>                            BIT(SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV),
> -                          !value << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV);
> +                          value << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV);
>
>         /* DAI format */
>         switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> @@ -568,6 +571,8 @@ static int sun8i_codec_probe(struct platform_device *pdev)
>                 return PTR_ERR(scodec->regmap);
>         }
>
> +       scodec->inverted_lrck = (uintptr_t)of_device_get_match_data(&pdev->dev);
> +
>         platform_set_drvdata(pdev, scodec);
>
>         pm_runtime_enable(&pdev->dev);
> @@ -606,7 +611,14 @@ static int sun8i_codec_remove(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id sun8i_codec_of_match[] = {
> -       { .compatible = "allwinner,sun8i-a33-codec" },
> +       {
> +               .compatible = "allwinner,sun8i-a33-codec",
> +               .data = (void *)1,

So depending on the answer to the previous patch, this might be enough,
though somewhat an eyesore. Otherwise I suggest using a proper quirks
structure.

ChenYu


> +       },
> +       {
> +               .compatible = "allwinner,sun50i-a64-codec",
> +               .data = (void *)0,
> +       },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, sun8i_codec_of_match);
> --
> 2.24.1
>
