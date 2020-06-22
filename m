Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C75DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2135020739
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5EMOy8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgFVMrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgFVMrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:47:14 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908F2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:47:14 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l9so920487ilq.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjgW6NPfbhJuM7YbaUjuEo6Wv6GzrZDFYsvWAkW0utw=;
        b=s5EMOy8arPFCi52uwK9d9HUd4ElpDc7h6kiwSTFf6EGIr8tyFut99ujvqpd/sFb9tM
         zJuZAlBYmWVH1aQYYyn8Yf3ss89eylA1pwIJXjPsmgECWi1CAzHNF4tyBIZe1LAS6xh0
         PyqSLvtkasRrZi0gu1OsuYd0oF7l2NYpf8NKdr0JZs3TFCD63k+IbxI02HbewNp8Q6DX
         wBuyDh+4SymxAk0BgtMMf7LJZZgoWflEZdDts9ll5yCpZf/htxdSGdovp+HmaXvMP7yt
         M8hTeFxj8ev8cJeLHlaX/qq97Z3bN8j2CZ6owmVo/pI5Jcd7GK7D/x+a0j0L7ktDruCh
         l5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjgW6NPfbhJuM7YbaUjuEo6Wv6GzrZDFYsvWAkW0utw=;
        b=pcMuZwuCElNuNf3w6aIJrd09x+dJTf/8Sn57uzWA0MCJKDOqXGd6LwtJ8BITnhBfMS
         +2y0bkYIpnQAqc5EhQ/utBAja2H4LSo+9xn0F3A8NTocA684JF1z0uvzgH5pge2aIVBf
         W1dFy5ZFbuajqMj0j4ZHS2zGpHkvdIYR9eae7V5wX1QqMwbz8Fzl/dneFcd/PNtJXmJt
         /KcsD4dGBoGKbcTbgm/Qz/nAsPYTwns6chHta2ButfYrrmJfIzY0CvZG/tlXQSCqdlWy
         pzV1CwatJtVNH6RMLl6QUdkzqChfARxtyvQ19DyLkPMFgAYBgs2sd7L1B4Rxe9h+Nmbs
         fmWw==
X-Gm-Message-State: AOAM531DtY5QwAsXTQgojnYzeKpoMKJJvsGeDyIk8PUCCM7uDzE27JaJ
        fDgRpMr9TwIWoLPhWGf1KgSpBD41TzEP97LtEOA=
X-Google-Smtp-Source: ABdhPJzJ3/1jNgStbXeRrALepz8feAarPc9QMrvjApN0qi6F4sELJQ1rP9U84lMbmBjLKEJi0lkLIT8Row3F0r+V7J0=
X-Received: by 2002:a92:9989:: with SMTP id t9mr1326252ilk.221.1592830033974;
 Mon, 22 Jun 2020 05:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200620163654.37207-1-martin.blumenstingl@googlemail.com> <20200620163654.37207-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200620163654.37207-2-martin.blumenstingl@googlemail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 22 Jun 2020 18:17:02 +0530
Message-ID: <CANAwSgRi1ZtvLhgiE3dGxsJWbXv2DZkEp7t9EQDt9bt_+vGw_A@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: meson: add the SDHC MMC controller
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,


On Sat, 20 Jun 2020 at 22:07, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Meson6, Meson8, Meson8b and Meson8m2 are using a similar SDHC controller
> IP which typically connects to an eMMC chip (because unlike the SDIO
> controller the SDHC controller has an 8-bit bus interface).
>
> On Meson8, Meson8b and Meson8m2 the clock inputs are all the same.
> However, Meson8m2 seems to have an improved version of the SHDC
> controller IP which doesn't require the driver to wait manually for a
> flush of a DMA transfer. Thus every SoC has it's own compatible string
> so if more difference are discovered they can be implemented.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Please add my
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

-Anand
> ---
>  arch/arm/boot/dts/meson.dtsi    |  7 +++++++
>  arch/arm/boot/dts/meson8.dtsi   | 19 +++++++++++++++++++
>  arch/arm/boot/dts/meson8b.dtsi  | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/meson8m2.dtsi |  4 ++++
>  4 files changed, 50 insertions(+)
>
> diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
> index ae89deaa8c9c..464057989572 100644
> --- a/arch/arm/boot/dts/meson.dtsi
> +++ b/arch/arm/boot/dts/meson.dtsi
> @@ -140,6 +140,13 @@ spifc: spi@8c80 {
>                                 status = "disabled";
>                         };
>
> +                       sdhc: mmc@8e00 {
> +                               compatible = "amlogic,meson-mx-sdhc";
> +                               reg = <0x8e00 0x42>;
> +                               interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
> +                               status = "disabled";
> +                       };
> +
>                         gpio_intc: interrupt-controller@9880 {
>                                 compatible = "amlogic,meson-gpio-intc";
>                                 reg = <0x9880 0x10>;
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index 3d0ab2ac5332..04688e8abce2 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -384,6 +384,15 @@ mux {
>                         };
>                 };
>
> +               sdxc_b_pins: sdxc-b {
> +                       mux {
> +                               groups = "sdxc_d0_b", "sdxc_d13_b",
> +                                        "sdxc_clk_b", "sdxc_cmd_b";
> +                               function = "sdxc_b";
> +                               bias-pull-up;
> +                       };
> +               };
> +
>                 spi_nor_pins: nor {
>                         mux {
>                                 groups = "nor_d", "nor_q", "nor_c", "nor_cs";
> @@ -558,6 +567,16 @@ &saradc {
>         nvmem-cell-names = "temperature_calib";
>  };
>
> +&sdhc {
> +       compatible = "amlogic,meson8-sdhc", "amlogic,meson-mx-sdhc";
> +       clocks = <&xtal>,
> +                <&clkc CLKID_FCLK_DIV4>,
> +                <&clkc CLKID_FCLK_DIV3>,
> +                <&clkc CLKID_FCLK_DIV5>,
> +                <&clkc CLKID_SDHC>;
> +       clock-names = "clkin0", "clkin1", "clkin2", "clkin3", "pclk";
> +};
> +
>  &sdio {
>         compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
>         clocks = <&clkc CLKID_SDIO>, <&clkc CLKID_CLK81>;
> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> index 2069c57343e5..2401cdf5f751 100644
> --- a/arch/arm/boot/dts/meson8b.dtsi
> +++ b/arch/arm/boot/dts/meson8b.dtsi
> @@ -363,6 +363,16 @@ mux {
>                         };
>                 };
>
> +               sdxc_c_pins: sdxc-c {
> +                       mux {
> +                               groups = "sdxc_d0_c", "sdxc_d13_c",
> +                                        "sdxc_d47_c", "sdxc_clk_c",
> +                                        "sdxc_cmd_c";
> +                               function = "sdxc_c";
> +                               bias-pull-up;
> +                       };
> +               };
> +
>                 pwm_c1_pins: pwm-c1 {
>                         mux {
>                                 groups = "pwm_c1";
> @@ -554,6 +564,16 @@ &saradc {
>         nvmem-cell-names = "temperature_calib";
>  };
>
> +&sdhc {
> +       compatible = "amlogic,meson8-sdhc", "amlogic,meson-mx-sdhc";
> +       clocks = <&xtal>,
> +                <&clkc CLKID_FCLK_DIV4>,
> +                <&clkc CLKID_FCLK_DIV3>,
> +                <&clkc CLKID_FCLK_DIV5>,
> +                <&clkc CLKID_SDHC>;
> +       clock-names = "clkin0", "clkin1", "clkin2", "clkin3", "pclk";
> +};
> +
>  &sdio {
>         compatible = "amlogic,meson8b-sdio", "amlogic,meson-mx-sdio";
>         clocks = <&clkc CLKID_SDIO>, <&clkc CLKID_CLK81>;
> diff --git a/arch/arm/boot/dts/meson8m2.dtsi b/arch/arm/boot/dts/meson8m2.dtsi
> index c7ddbb210366..6725dd9fd825 100644
> --- a/arch/arm/boot/dts/meson8m2.dtsi
> +++ b/arch/arm/boot/dts/meson8m2.dtsi
> @@ -84,6 +84,10 @@ &saradc {
>         compatible = "amlogic,meson8m2-saradc", "amlogic,meson-saradc";
>  };
>
> +&sdhc {
> +       compatible = "amlogic,meson8m2-sdhc", "amlogic,meson-mx-sdhc";
> +};
> +
>  &usb0_phy {
>         compatible = "amlogic,meson8m2-usb2-phy", "amlogic,meson-mx-usb2-phy";
>  };
> --
> 2.27.0
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
