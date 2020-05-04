Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B14C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 101E2206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzvieQvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgEDK6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDK6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:58:06 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA38C061A0E;
        Mon,  4 May 2020 03:58:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z6so8513135wml.2;
        Mon, 04 May 2020 03:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0VLwOT6bJqN3K7ts+w2SYMjYr93mptYzOJqRAqbrzsY=;
        b=HzvieQvpoS8MOsvOHkWRFAqYFMxa5kiZ+2Cca+rP7jHhs3UvjiTtmb8ZSfAUMIxUd2
         WKbQ1JA6DjZg7sVjddKL5WhNFiqYHmuWSg7zSJZqyvStKoYRrZ8q37qX1AUYNnOA8LmP
         rbFEzhyylwrl7ftFEqdrNt8YzHPWiTg4lM0JmzeM5v4GwWNlbQQND2cNGGAYY+om/zrM
         BJ28Vm7FE5UDtaYfZYoAFn1zHn8AQ+Wa89gyE0DDB7WGD6EsM2Ydn59/w36iNf/6p/hH
         zmt6/1wajPh0TcFGgA11IBL2NxKUXzk5P9azCkEptTQGrjVRAKJgmzWMJA24y1gOUgGT
         Vszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VLwOT6bJqN3K7ts+w2SYMjYr93mptYzOJqRAqbrzsY=;
        b=f8Pwa9ZETWkSoZmqrl6pHG+tza5JiqBqIejDgKIHvVjno1d/I1ObxVf7o1WAqURc+J
         r6vjGxh1vNSXbya2mte1+buO/7qxuVHHzn0Uzpyiwn/eAOQKDnyv9y8uLq4RqHB+VWSp
         FTeJtXPeO6TS3WA/5HwwvTU3i9i51KuEzma7tuUiyG1X9sQ0RhBy92HunMuN3DfLxKU3
         yM+iUd+eXlu2yiNdVCoxdIzZrcZDQzGSihdFZ+3cqByc+Nwfth/WOPGGun1vghBsymna
         xa+Sb5kfHJfFkoxqp1jUw9A06rrUcUwlPPLf2z3EmBFPHkX+x9450yq1HBL8rhYSWxaR
         /ByA==
X-Gm-Message-State: AGi0PubJLJwI5e3UkPuYKR5kVHyph6x14PSO7h1IwXduHN83iEBOdZ96
        kIt0+WhDv0gaq/T4CY0xg9Mz10LXw0+eNKqP6Eg=
X-Google-Smtp-Source: APiQypIyFdGV0t4KhW/32RO57/X+1YIjrApNcxzi2Lmx8drWPz/6xswQx7UZRCu8zdIJb7JNUsYHxLqNiDDqpxOvkTQ=
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr15112247wme.177.1588589885341;
 Mon, 04 May 2020 03:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com> <20200502114752.1048500-4-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200502114752.1048500-4-martin.blumenstingl@googlemail.com>
From:   hex dump <hexdump0815@gmail.com>
Date:   Mon, 4 May 2020 12:57:51 +0200
Message-ID: <CAKTihDUY5VRMtydLWkH3pg+EYdUbss5-mKzrfPOapLP1J0cEXg@mail.gmail.com>
Subject: Re: [PATCH 3/6] phy: amlogic: meson8b-usb2: Use a MMIO regmap
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
> Using a MMIO regmap and switch to regmap_update_bits() to simplify the
> code in the driver. Also switch to devm_platform_ioremap_resource()
> instead of open-coding it. No functional changes intended.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Tested-by: hexdump <hexdump0815@googlemail.com>

> ---
>  drivers/phy/amlogic/Kconfig            |  1 +
>  drivers/phy/amlogic/phy-meson8b-usb2.c | 73 ++++++++++++--------------
>  2 files changed, 35 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index 71801e30d601..3495b23af797 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -9,6 +9,7 @@ config PHY_MESON8B_USB2
>         depends on USB_SUPPORT
>         select USB_COMMON
>         select GENERIC_PHY
> +       select REGMAP_MMIO
>         help
>           Enable this to support the Meson USB2 PHYs found in Meson8,
>           Meson8b and GXBB SoCs.
> diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
> index bd66bd723e4a..86824cc21f11 100644
> --- a/drivers/phy/amlogic/phy-meson8b-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
> @@ -10,6 +10,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/regmap.h>
>  #include <linux/reset.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> @@ -105,34 +106,24 @@
>  #define ACA_ENABLE_COMPLETE_TIME                       50
>
>  struct phy_meson8b_usb2_priv {
> -       void __iomem            *regs;
> +       struct regmap           *regmap;
>         enum usb_dr_mode        dr_mode;
>         struct clk              *clk_usb_general;
>         struct clk              *clk_usb;
>         struct reset_control    *reset;
>  };
>
> -static u32 phy_meson8b_usb2_read(struct phy_meson8b_usb2_priv *phy_priv,
> -                                u32 reg)
> -{
> -       return readl(phy_priv->regs + reg);
> -}
> -
> -static void phy_meson8b_usb2_mask_bits(struct phy_meson8b_usb2_priv *phy_priv,
> -                                      u32 reg, u32 mask, u32 value)
> -{
> -       u32 data;
> -
> -       data = phy_meson8b_usb2_read(phy_priv, reg);
> -       data &= ~mask;
> -       data |= (value & mask);
> -
> -       writel(data, phy_priv->regs + reg);
> -}
> +static const struct regmap_config phy_meson8b_usb2_regmap_conf = {
> +       .reg_bits = 8,
> +       .val_bits = 32,
> +       .reg_stride = 4,
> +       .max_register = REG_TUNE,
> +};
>
>  static int phy_meson8b_usb2_power_on(struct phy *phy)
>  {
>         struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
> +       u32 reg;
>         int ret;
>
>         if (!IS_ERR_OR_NULL(priv->reset)) {
> @@ -156,34 +147,34 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
>                 return ret;
>         }
>
> -       phy_meson8b_usb2_mask_bits(priv, REG_CONFIG, REG_CONFIG_CLK_32k_ALTSEL,
> -                                  REG_CONFIG_CLK_32k_ALTSEL);
> +       regmap_update_bits(priv->regmap, REG_CONFIG, REG_CONFIG_CLK_32k_ALTSEL,
> +                          REG_CONFIG_CLK_32k_ALTSEL);
>
> -       phy_meson8b_usb2_mask_bits(priv, REG_CTRL, REG_CTRL_REF_CLK_SEL_MASK,
> -                                  0x2 << REG_CTRL_REF_CLK_SEL_SHIFT);
> +       regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_REF_CLK_SEL_MASK,
> +                          0x2 << REG_CTRL_REF_CLK_SEL_SHIFT);
>
> -       phy_meson8b_usb2_mask_bits(priv, REG_CTRL, REG_CTRL_FSEL_MASK,
> -                                  0x5 << REG_CTRL_FSEL_SHIFT);
> +       regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_FSEL_MASK,
> +                          0x5 << REG_CTRL_FSEL_SHIFT);
>
>         /* reset the PHY */
> -       phy_meson8b_usb2_mask_bits(priv, REG_CTRL, REG_CTRL_POWER_ON_RESET,
> -                                  REG_CTRL_POWER_ON_RESET);
> +       regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_POWER_ON_RESET,
> +                          REG_CTRL_POWER_ON_RESET);
>         udelay(RESET_COMPLETE_TIME);
> -       phy_meson8b_usb2_mask_bits(priv, REG_CTRL, REG_CTRL_POWER_ON_RESET, 0);
> +       regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_POWER_ON_RESET, 0);
>         udelay(RESET_COMPLETE_TIME);
>
> -       phy_meson8b_usb2_mask_bits(priv, REG_CTRL, REG_CTRL_SOF_TOGGLE_OUT,
> -                                  REG_CTRL_SOF_TOGGLE_OUT);
> +       regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_SOF_TOGGLE_OUT,
> +                          REG_CTRL_SOF_TOGGLE_OUT);
>
>         if (priv->dr_mode == USB_DR_MODE_HOST) {
> -               phy_meson8b_usb2_mask_bits(priv, REG_ADP_BC,
> -                                          REG_ADP_BC_ACA_ENABLE,
> -                                          REG_ADP_BC_ACA_ENABLE);
> +               regmap_update_bits(priv->regmap, REG_ADP_BC,
> +                                  REG_ADP_BC_ACA_ENABLE,
> +                                  REG_ADP_BC_ACA_ENABLE);
>
>                 udelay(ACA_ENABLE_COMPLETE_TIME);
>
> -               if (phy_meson8b_usb2_read(priv, REG_ADP_BC) &
> -                       REG_ADP_BC_ACA_PIN_FLOAT) {
> +               regmap_read(priv->regmap, REG_ADP_BC, &reg);
> +               if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
>                         dev_warn(&phy->dev, "USB ID detect failed!\n");
>                         clk_disable_unprepare(priv->clk_usb);
>                         clk_disable_unprepare(priv->clk_usb_general);
> @@ -213,18 +204,22 @@ static const struct phy_ops phy_meson8b_usb2_ops = {
>  static int phy_meson8b_usb2_probe(struct platform_device *pdev)
>  {
>         struct phy_meson8b_usb2_priv *priv;
> -       struct resource *res;
>         struct phy *phy;
>         struct phy_provider *phy_provider;
> +       void __iomem *base;
>
>         priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       priv->regs = devm_ioremap_resource(&pdev->dev, res);
> -       if (IS_ERR(priv->regs))
> -               return PTR_ERR(priv->regs);
> +       base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
> +                                            &phy_meson8b_usb2_regmap_conf);
> +       if (IS_ERR(priv->regmap))
> +               return PTR_ERR(priv->regmap);
>
>         priv->clk_usb_general = devm_clk_get(&pdev->dev, "usb_general");
>         if (IS_ERR(priv->clk_usb_general))
> --
> 2.26.2
>
