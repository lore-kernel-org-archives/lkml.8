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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49593C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8EC20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE8coocR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgFVMrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgFVMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:47:22 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31A8C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:47:22 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so19272203iow.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P90hcAlfcfEKul6aRarbOt34C+/UsEZJNQJCHc8YuWE=;
        b=WE8coocRKOgio+VovOZuaUR+4zHoIhpQfpMpQHZisILM+a+bnEHvpCk9l0zb8IaXAR
         a+iz4DYeJtXrb63m7xCE2FGZomSA8ysuo4US5t4fr0OWfEhc0JAdcgKZ3INOcmGTH2Xs
         qxrb8xA9PwjTtG0OmfwM7MlCz2p1ODmmJZI/8YRQXMoPa5k4Aki241wbnCdOmRUgdtZT
         nSk1ysdxUiNQGqw52b26E2vFE4C+iuZXO9pnVdobHS/84KiAYDVXAJjNaYpUnacsoZZS
         HkYDur/JNrEDVg5t+qUa/6pSVa434rdEY5kFyOgOqIJWZqMdld0rXnymWAu5GulKrRna
         hqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P90hcAlfcfEKul6aRarbOt34C+/UsEZJNQJCHc8YuWE=;
        b=fkjlwC13/weEq569c/+Ytla0R3GnaFTM1GQ9kFuhIBtN+TcHy283WUYIbFbED1/DR0
         Hom732NnIo8CSZYzlfxSRPvFrwM5oTRi1X3g2kR7gYWTkPzqA8pgTsLhFvIWrb/JZGV3
         eP20WHnxZmdwnAZeDqL6OsXb34jOF2giEXVtVgLNRoyTn4cQizE1iEN61LNd3PkHoJl2
         G2qS+brJt9SHbObAMLpg+u+BLxtmKdM5UuRhgB36CjQG0XOV1fmM7f2AQrKSSwfe0eyf
         NEYtQ3PvmAY9XEgc0lm9tLKU6vIcYvWj07pepyA5EAPG4wUGNbc5QwsAs1DDMQYC2VL6
         YaRQ==
X-Gm-Message-State: AOAM533qFZ2qZFixpNUBeNnZYMACSyiJepcNKfLuB7w7me2YEbzsYLn2
        sqC7eVAaKiw2v1dfvPz6LOVNZWqkXGVkjDVXSCEDFA==
X-Google-Smtp-Source: ABdhPJzO10/qEKx3q9bk3IlNVm+zpQ5pIfujVQ6xE/LGfo1zFGAEHK7272NUm9/8/aF9FwnXRixppLmxzHN4uzmrEM4=
X-Received: by 2002:a05:6638:d96:: with SMTP id l22mr18189029jaj.120.1592830042206;
 Mon, 22 Jun 2020 05:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200620163654.37207-1-martin.blumenstingl@googlemail.com> <20200620163654.37207-4-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200620163654.37207-4-martin.blumenstingl@googlemail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 22 Jun 2020 18:17:10 +0530
Message-ID: <CANAwSgQC_sf2Hvuf29aeSttF5JmJqBoXLOa=HybFys_hmBns3g@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: meson8b: odroidc1: enable the SDHC controller
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

On Sat, 20 Jun 2020 at 22:08, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Odroid-C1 has an eMMC connector where users can optionally install an
> eMMC module. The eMMC modules run off a 1.8V VQMMC supply which means
> that HS-200 mode can be used (this is the highest mode that the SDHC
> controller supports). Enable the SDHC controller so eMMC modules can be
> accessed.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Please add my
Reviewed-by: Anand Moon <linux.amoon@gmail.com>


-Anand
> ---
>  arch/arm/boot/dts/meson8b-odroidc1.dts | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index cb21ac9f517c..0c26467de4d0 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -15,6 +15,7 @@ / {
>         aliases {
>                 serial0 = &uart_AO;
>                 mmc0 = &sd_card_slot;
> +               mmc1 = &sdhc;
>         };
>
>         chosen {
> @@ -26,6 +27,11 @@ memory {
>                 reg = <0x40000000 0x40000000>;
>         };
>
> +       emmc_pwrseq: emmc-pwrseq {
> +               compatible = "mmc-pwrseq-emmc";
> +               reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
> +       };
> +
>         leds {
>                 compatible = "gpio-leds";
>                 blue {
> @@ -310,6 +316,26 @@ &saradc {
>         vref-supply = <&vcc_1v8>;
>  };
>
> +&sdhc {
> +       status = "okay";
> +
> +       pinctrl-0 = <&sdxc_c_pins>;
> +       pinctrl-names = "default";
> +
> +       bus-width = <8>;
> +       max-frequency = <100000000>;
> +
> +       disable-wp;
> +       cap-mmc-highspeed;
> +       mmc-hs200-1_8v;
> +       no-sdio;
> +
> +       mmc-pwrseq = <&emmc_pwrseq>;
> +
> +       vmmc-supply = <&vcc_3v3>;
> +       vqmmc-supply = <&vcc_1v8>;
> +};
> +
>  &sdio {
>         status = "okay";
>
> --
> 2.27.0
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
