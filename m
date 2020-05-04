Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A9AC47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FC3206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMqEVASM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgEDLA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726797AbgEDLA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:00:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF44C061A0E;
        Mon,  4 May 2020 04:00:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x4so7929448wmj.1;
        Mon, 04 May 2020 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j78pwgAoPIBXpzCPQa9obI1dS/AtoekTWfi/Z9wgTpE=;
        b=FMqEVASMwd4jsKWMbAfOMx/EXRykuKYV/52Xl+u4cPeVIB+mJWcN7ENXhsbR7M4YJc
         INi2krmc920kV+fanUnf0LILJH2Vmh/gmmgk4A7BXBQAfzTu+Zm58kFeDWvGGfM5dAHJ
         7R9XZXqsajrXS7/zCRbwZQGQrHHzAvouV68ESanU82QXWL2QQyIVUeA7sdBOosriWGXE
         SRtWN7QSzU6D579adzQtB5mdv/NeBhdlq+ZidnENn7rHNGyscMVcKK0DoRAVJBDpCrq+
         XeKGgCNTrGfGaVKG9C1tN6Isl3gKQkdvJTBKgL6n9rwYTdKQ7ijEgpd+WTIW3CmHcxI0
         y8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j78pwgAoPIBXpzCPQa9obI1dS/AtoekTWfi/Z9wgTpE=;
        b=F0tVNgwmMKkgeK20DeZNOdAFkQzzQAmgXm48HJzqjGVNSrnOiADofDpUNCLmsGejGd
         sxr1o/xzTO4f6I1n2JTF6AZM3ufZioKrmKk3BeUaGzQAc+e1cg0FAChCR79svzxIQ3k4
         BcDhAsZsXKNgdstpusyBDULzXSYNzxS2LFoyFHMjyVQbeDRzjGVgiTKZqFLnxhqQEOjH
         y95sPc+++wX+RKkhLV3/atrdihce6SdFyhpo4OScho8Fzx+jWJbrKg3WqOBV+kEb5pwL
         u1wQe9/XloSGOdygzrWb/aP/ebqJWoF0FmSa5bbeSWOE56bEkbl0XTzkigxXfodhmbf8
         O1Ow==
X-Gm-Message-State: AGi0Pub1b3iNNBqsjfaTe3afORtCW/j1S+SAMcwNjxwcpzBo+ZkuzWAj
        zpeMmfjbAEBKWBXqfJ/B2V8/I5ceeibZeyAK03M=
X-Google-Smtp-Source: APiQypLU0iLwcBk2HNdVaMBVWBe/1k0yjxd5T16MVENu1G8k0t+p0w9Rby7rjQjjzKlds5iHe4qWJXWBe1wvpqtxMAg=
X-Received: by 2002:a05:600c:c9:: with SMTP id u9mr13753067wmm.15.1588590025222;
 Mon, 04 May 2020 04:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com> <20200502114752.1048500-6-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200502114752.1048500-6-martin.blumenstingl@googlemail.com>
From:   hex dump <hexdump0815@gmail.com>
Date:   Mon, 4 May 2020 13:00:10 +0200
Message-ID: <CAKTihDXSmqzBxndCRncpBRdqKCtrujpzWUJ_-3k7JvXpNKSQKQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] phy: amlogic: meson8b-usb2: unset the IDDQ bit during
 PHY power-on
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
> The vendor driver unsets the set_iddig bit during power-on as well and
> sets it when suspending the PHY. I did not notice this in the vendor
> driver first, because it's part of the dwc_otg driver there (instead of
> their PHY code). While here, also add all other REG_DBG_UART register
> bit definitions.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Tested-by: hexdump <hexdump0815@googlemail.com>

> ---
>  drivers/phy/amlogic/phy-meson8b-usb2.c | 44 +++++++++++++++++++-------
>  1 file changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
> index 7236b8885f07..436dfa1a8a04 100644
> --- a/drivers/phy/amlogic/phy-meson8b-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
> @@ -78,6 +78,17 @@
>         #define REG_ADP_BC_ACA_PIN_FLOAT                BIT(26)
>
>  #define REG_DBG_UART                                   0x10
> +       #define REG_DBG_UART_BYPASS_SEL                 BIT(0)
> +       #define REG_DBG_UART_BYPASS_DM_EN               BIT(1)
> +       #define REG_DBG_UART_BYPASS_DP_EN               BIT(2)
> +       #define REG_DBG_UART_BYPASS_DM_DATA             BIT(3)
> +       #define REG_DBG_UART_BYPASS_DP_DATA             BIT(4)
> +       #define REG_DBG_UART_FSV_MINUS                  BIT(5)
> +       #define REG_DBG_UART_FSV_PLUS                   BIT(6)
> +       #define REG_DBG_UART_FSV_BURN_IN_TEST           BIT(7)
> +       #define REG_DBG_UART_LOOPBACK_EN_B              BIT(8)
> +       #define REG_DBG_UART_SET_IDDQ                   BIT(9)
> +       #define REG_DBG_UART_ATE_RESET                  BIT(10)
>
>  #define REG_TEST                                       0x14
>         #define REG_TEST_DATA_IN_MASK                   GENMASK(3, 0)
> @@ -172,20 +183,24 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
>         regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_SOF_TOGGLE_OUT,
>                            REG_CTRL_SOF_TOGGLE_OUT);
>
> -       if (priv->dr_mode == USB_DR_MODE_HOST &&
> -           priv->match->host_enable_aca) {
> -               regmap_update_bits(priv->regmap, REG_ADP_BC,
> -                                  REG_ADP_BC_ACA_ENABLE,
> -                                  REG_ADP_BC_ACA_ENABLE);
> +       if (priv->dr_mode == USB_DR_MODE_HOST) {
> +               regmap_update_bits(priv->regmap, REG_DBG_UART,
> +                                  REG_DBG_UART_SET_IDDQ, 0);
>
> -               udelay(ACA_ENABLE_COMPLETE_TIME);
> +               if (priv->match->host_enable_aca) {
> +                       regmap_update_bits(priv->regmap, REG_ADP_BC,
> +                                          REG_ADP_BC_ACA_ENABLE,
> +                                          REG_ADP_BC_ACA_ENABLE);
>
> -               regmap_read(priv->regmap, REG_ADP_BC, &reg);
> -               if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
> -                       dev_warn(&phy->dev, "USB ID detect failed!\n");
> -                       clk_disable_unprepare(priv->clk_usb);
> -                       clk_disable_unprepare(priv->clk_usb_general);
> -                       return -EINVAL;
> +                       udelay(ACA_ENABLE_COMPLETE_TIME);
> +
> +                       regmap_read(priv->regmap, REG_ADP_BC, &reg);
> +                       if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
> +                               dev_warn(&phy->dev, "USB ID detect failed!\n");
> +                               clk_disable_unprepare(priv->clk_usb);
> +                               clk_disable_unprepare(priv->clk_usb_general);
> +                               return -EINVAL;
> +                       }
>                 }
>         }
>
> @@ -196,6 +211,11 @@ static int phy_meson8b_usb2_power_off(struct phy *phy)
>  {
>         struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
>
> +       if (priv->dr_mode == USB_DR_MODE_HOST)
> +               regmap_update_bits(priv->regmap, REG_DBG_UART,
> +                                  REG_DBG_UART_SET_IDDQ,
> +                                  REG_DBG_UART_SET_IDDQ);
> +
>         clk_disable_unprepare(priv->clk_usb);
>         clk_disable_unprepare(priv->clk_usb_general);
>
> --
> 2.26.2
>
