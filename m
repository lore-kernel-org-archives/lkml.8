Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6C8C47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA8D2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THlVjspY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgEDK7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727786AbgEDK7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:59:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E8FC061A0E;
        Mon,  4 May 2020 03:59:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u127so8507508wmg.1;
        Mon, 04 May 2020 03:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rg6MiL5KjJESJUJBphZH2wxAoWjr3LYiJXHLS1k8CEw=;
        b=THlVjspYEvW5ah85ef9CHZkOZaUmN9t2SMREKgz6CA8H74cLoka/cPPCHN6v0x7Pkq
         QjwD1MNR4jUeo7RqCCApALqBJYIoc5fUrLreYmEz6u/1PiYq3zSrewFBl6j38tA5Kjwl
         zEEbJ6gadFiuksqNVNbRFpG7sAe5XcJ+9TvwuR/jFajgaORpdLXTcph4YEcE8knOT4+f
         r/YK9tCELrlTpTwWmUiSn4yK/PAEAYoUgL8L0vepEXxHNlfEMnlnbGVJp4616qSXnJG/
         Yj0D7rtMAY0jfL7wmhBeoOmUZKqVv7gmlhSPPu85IX8LJUnc7OlVeVWb/kHuY63JO/mb
         XTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rg6MiL5KjJESJUJBphZH2wxAoWjr3LYiJXHLS1k8CEw=;
        b=DkVlDSLWz+P51SNKrdacdCVI2jsZZ/YNhqeB5XSiwGBaRbOa+6NPwfqORv/C0Ylw6P
         MlNQdSTh1Dj/Fpb5QGwhBGI+ESoSTd8mq+dMqhNIFiv7Ht4k5ltr1rUHzdlyHJ8d+zus
         k24nmMOeaZspPWJJyjWHi4rzdfcsWqcDAvp775y8y6kclyjyBG/R2yNu33UXsUF85HJe
         KjFvI5GrCfvcTaBCfjnrZNJ6F7woNxjVarBqaSoaiPk7j37d+u7jdBKmsh4xMO/L7QFs
         OysadhwUsIZebuuQryOGMLoR8VggF+2ciDPy9CkKOL+4KNrXy/kE9K6TOPDAG5c0Cjwq
         wxKw==
X-Gm-Message-State: AGi0PuZpzfDNXtyTlzFce2oE7NzfHLy2r6Lt7yi3kfZAp2kQtT1fL+Om
        SpPoLWTj0IBDoqgKkJueUNfSE11ZOV6BZSXARzs=
X-Google-Smtp-Source: APiQypIk1BJTmqCeYOqlKr/uqje+UW+4gTquQABz3PjQloTz+zW97EInEB1BpPX6W34cEIPdJcz7BIVlu5AJjXfp+hI=
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr13783192wmh.134.1588589968341;
 Mon, 04 May 2020 03:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com> <20200502114752.1048500-5-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200502114752.1048500-5-martin.blumenstingl@googlemail.com>
From:   hex dump <hexdump0815@gmail.com>
Date:   Mon, 4 May 2020 12:59:14 +0200
Message-ID: <CAKTihDWOZMHs5Bq++NeyE=VoyKBkAkfEXbr5QY29k=2XEr4K1g@mail.gmail.com>
Subject: Re: [PATCH 4/6] phy: amlogic: meson8b-usb2: Don't set
 REG_ADP_BC_ACA_ENABLE on Meson8
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 1:48 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Skip setting REG_ADP_BC_ACA_ENABLE on Meson8 SoCs and polling for the
> REG_ADP_BC_ACA_PIN_FLOAT bit. The vendor also skips this part on Meson8
> SoCs.
> This fixes initialization of the host-only USB PHY on Meson8 which would
> otherwise fail with "USB ID detect failed!".
>
> Fixes: 4a3449d1a0a10c ("phy: meson8b-usb2: add support for the USB PHY on Meson8 SoCs")
> Reported-by: hexdump <hexdump0815@googlemail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Tested-by: hexdump <hexdump0815@googlemail.com>

BEFORE: usb failed with:
[    3.451386] dwc2 c9040000.usb: c9040000.usb supply vusb_d not
found, using dummy regulator
[    3.454097] dwc2 c9040000.usb: c9040000.usb supply vusb_a not
found, using dummy regulator
[    3.463602] phy phy-c1108800.phy.0: USB ID detect failed!
[    3.467646] phy phy-c1108800.phy.0: phy poweron failed --> -22

AFTER: usb is detected and working fine on my mxiiii meson8 box

> ---
>  drivers/phy/amlogic/phy-meson8b-usb2.c | 48 ++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
> index 86824cc21f11..7236b8885f07 100644
> --- a/drivers/phy/amlogic/phy-meson8b-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
> @@ -10,6 +10,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  #include <linux/phy/phy.h>
> @@ -105,12 +106,17 @@
>  #define RESET_COMPLETE_TIME                            500
>  #define ACA_ENABLE_COMPLETE_TIME                       50
>
> +struct phy_meson8b_usb2_match_data {
> +       bool                    host_enable_aca;
> +};
> +
>  struct phy_meson8b_usb2_priv {
> -       struct regmap           *regmap;
> -       enum usb_dr_mode        dr_mode;
> -       struct clk              *clk_usb_general;
> -       struct clk              *clk_usb;
> -       struct reset_control    *reset;
> +       struct regmap                                   *regmap;
> +       enum usb_dr_mode                                dr_mode;
> +       struct clk                                      *clk_usb_general;
> +       struct clk                                      *clk_usb;
> +       struct reset_control                            *reset;
> +       const struct phy_meson8b_usb2_match_data        *match;
>  };
>
>  static const struct regmap_config phy_meson8b_usb2_regmap_conf = {
> @@ -166,7 +172,8 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
>         regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_SOF_TOGGLE_OUT,
>                            REG_CTRL_SOF_TOGGLE_OUT);
>
> -       if (priv->dr_mode == USB_DR_MODE_HOST) {
> +       if (priv->dr_mode == USB_DR_MODE_HOST &&
> +           priv->match->host_enable_aca) {
>                 regmap_update_bits(priv->regmap, REG_ADP_BC,
>                                    REG_ADP_BC_ACA_ENABLE,
>                                    REG_ADP_BC_ACA_ENABLE);
> @@ -216,6 +223,10 @@ static int phy_meson8b_usb2_probe(struct platform_device *pdev)
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>
> +       priv->match = device_get_match_data(&pdev->dev);
> +       if (!priv->match)
> +               return -ENODEV;
> +
>         priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
>                                              &phy_meson8b_usb2_regmap_conf);
>         if (IS_ERR(priv->regmap))
> @@ -254,11 +265,28 @@ static int phy_meson8b_usb2_probe(struct platform_device *pdev)
>         return PTR_ERR_OR_ZERO(phy_provider);
>  }
>
> +static const struct phy_meson8b_usb2_match_data phy_meson8_usb2_match_data = {
> +       .host_enable_aca = false,
> +};
> +
> +static const struct phy_meson8b_usb2_match_data phy_meson8b_usb2_match_data = {
> +       .host_enable_aca = true,
> +};
> +
>  static const struct of_device_id phy_meson8b_usb2_of_match[] = {
> -       { .compatible = "amlogic,meson8-usb2-phy", },
> -       { .compatible = "amlogic,meson8b-usb2-phy", },
> -       { .compatible = "amlogic,meson-gxbb-usb2-phy", },
> -       { },
> +       {
> +               .compatible = "amlogic,meson8-usb2-phy",
> +               .data = &phy_meson8_usb2_match_data
> +       },
> +       {
> +               .compatible = "amlogic,meson8b-usb2-phy",
> +               .data = &phy_meson8b_usb2_match_data
> +       },
> +       {
> +               .compatible = "amlogic,meson-gxbb-usb2-phy",
> +               .data = &phy_meson8b_usb2_match_data
> +       },
> +       { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, phy_meson8b_usb2_of_match);
>
> --
> 2.26.2
>
