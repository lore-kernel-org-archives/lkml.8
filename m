Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE53CC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF372065C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOs1HrhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgHQNrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgHQNrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:47:21 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF70CC061389;
        Mon, 17 Aug 2020 06:47:20 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b11so8390305lfe.10;
        Mon, 17 Aug 2020 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kp2OAD0ICogQKk52QDNikt0ThpNhJxZYmPf9EL7yEaM=;
        b=TOs1HrhMt19tbzY2EpvLz0ZtqqfJBYuaiUcH1BoiflXvgVQXzRskCMS5CRRklvjC6t
         eGBk6qUdm0k2f+5hb2i9wIgxxxFkqiFEgGIAagH4vDpuaDc77YGkVmb311PB9CZD8CWJ
         Ft5IktDWFGEnAg2wd6cNmMftbBUTKLoCA8/OTi92XxV/N9aeksT2NYMvYAtcK9BM4puK
         5C1fpmjshcdns4dH5k77cNgcuTzOKGiYvHcItBYHR8Lxz1yMNoBAJNcrdav9DGC99obX
         MROU8H7nS1Rvc4qO72R7wy7J+hZ6lAO2ayQ7a1UYRixcSCgdv/j+lydISSxyUtMZOQLd
         eFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kp2OAD0ICogQKk52QDNikt0ThpNhJxZYmPf9EL7yEaM=;
        b=SfqJhxq9ILGsQLduW4O4lZolebG7eByky7mY6T+TNhfLJ+O1jg55Hc15YSwUlh2/53
         TvbGSFdnqUB4KbYY0u/miE3U1f2SAHRiUr0xWix3Ttfljva8IlrXRl+tSpIqButiBe+i
         Gpybxbjs7telE611H8VFtZ2lbZXjutp39IO/eUEyppWpnzEdYhaUvBeiokSGfmA6aqkg
         KTPEqW319qfb/IsZfI9umXOzaukmns5KR1U8BaBCbyzs8ELlCZqIz4QXHWdVpjAhQUf4
         0UssbwYJ/P583EmDu4O6GTt4q5xw4O7UfapYvyIcX6lcc8o8V2+3zyZBVkaExdNO5AIP
         rVMA==
X-Gm-Message-State: AOAM533RnuxcskePDvSiEEL0k7mN0B+/had3/YXrrSb8++JQA2jo3QBG
        gGjUXFB7aZMsmtrjrsCGKxKg+Dapi7h7dGhBBYA=
X-Google-Smtp-Source: ABdhPJyfeEonIvGC2m3t5jnrWcaI+aOxpZTWZT8u8NDEyeRVe4igLqnzXcGjizWkbSVMZm2wPBtA/32o9PnS1z7Skxw=
X-Received: by 2002:a19:8957:: with SMTP id l84mr7184858lfd.66.1597672039259;
 Mon, 17 Aug 2020 06:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <1596714629-16425-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1596714629-16425-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 17 Aug 2020 10:47:08 -0300
Message-ID: <CAOMZO5C34LyMEx0S+_W-OuHz=SjbzRGb8gf5+tj6MvsMGD0x_Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sll-evk: Add audio sound card node
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Thu, Aug 6, 2020 at 8:55 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> Add audio sound card node, which depends on codec node,
> SSI node, audmux node.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sll-evk.dts | 74 +++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
> index 5ace9e6acf85..45bf5e61e960 100644
> --- a/arch/arm/boot/dts/imx6sll-evk.dts
> +++ b/arch/arm/boot/dts/imx6sll-evk.dts
> @@ -132,6 +132,29 @@ panel_in: endpoint {
>                         };
>                 };
>         };
> +
> +       sound {
> +               compatible = "fsl,imx6sl-evk-wm8962", "fsl,imx-audio-wm8962";
> +               model = "wm8962-audio";
> +               audio-cpu = <&ssi2>;
> +               audio-codec = <&codec>;
> +               audio-routing =
> +                       "Headphone Jack", "HPOUTL",
> +                       "Headphone Jack", "HPOUTR",
> +                       "Ext Spk", "SPKOUTL",
> +                       "Ext Spk", "SPKOUTR",
> +                       "AMIC", "MICBIAS",
> +                       "IN3R", "AMIC";
> +               mux-int-port = <2>;
> +               mux-ext-port = <3>;
> +               hp-det-gpio = <&gpio4 24 GPIO_ACTIVE_LOW>;
> +       };
> +};
> +
> +&audmux {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_audmux3>;
> +       status = "okay";
>  };
>
>  &cpu0 {
> @@ -247,6 +270,27 @@ vgen6_reg: vgen6 {
>         };
>  };
>
> +&i2c3 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c3>;
> +       status = "okay";
> +
> +       codec: wm8962@1a {

Node names should be generic:

wm8962: audio-codec@1a

> +               compatible = "wlf,wm8962";
> +               reg = <0x1a>;
> +               clocks = <&clks IMX6SLL_CLK_EXTERN_AUDIO>;
> +               DCVDD-supply = <&vgen3_reg>;
> +               DBVDD-supply = <&reg_aud3v>;
> +               AVDD-supply = <&vgen3_reg>;
> +               CPVDD-supply = <&vgen3_reg>;
> +               MICVDD-supply = <&reg_aud3v>;
> +               PLLVDD-supply = <&vgen3_reg>;
> +               SPKVDD1-supply = <&reg_aud4v>;
> +               SPKVDD2-supply = <&reg_aud4v>;
> +       };
> +};
> +
>  &lcdif {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_lcd>;
> @@ -273,6 +317,10 @@ &snvs_pwrkey {
>         status = "okay";
>  };
>
> +&ssi2 {
> +       status = "okay";
> +};
> +
>  &uart1 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_uart1>;
> @@ -329,6 +377,25 @@ &wdog1 {
>  };
>
>  &iomuxc {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_hog>;
> +
> +       pinctrl_audmux3: audmux3grp {
> +               fsl,pins = <
> +                       MX6SLL_PAD_AUD_TXC__AUD3_TXC            0x4130b0
> +                       MX6SLL_PAD_AUD_TXFS__AUD3_TXFS          0x4130b0
> +                       MX6SLL_PAD_AUD_TXD__AUD3_TXD            0x4110b0
> +                       MX6SLL_PAD_AUD_RXD__AUD3_RXD            0x4130b0
> +                       MX6SLL_PAD_AUD_MCLK__AUDIO_CLK_OUT      0x4130b0
> +               >;
> +       };
> +
> +       pinctrl_hog: hoggrp {
> +               fsl,pins = <
> +                       MX6SLL_PAD_GPIO4_IO24__GPIO4_IO24 0x17059 /* HP DETECT */

Please place it under audmux3 group for consistency.
