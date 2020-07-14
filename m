Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1018EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE2F2193E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFadGpuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGNDhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgGNDhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:37:43 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621F7C061755;
        Mon, 13 Jul 2020 20:37:43 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t4so13113061iln.1;
        Mon, 13 Jul 2020 20:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x5kA50WCYmAo+Q8432Sy1VWAEloJEHU1E0inGU7UJt4=;
        b=NFadGpuFjJ3tv7FOJrDxOb09SxgAqSP6xTut0HFSaivRjSIvWM4zedl+yOsvzbHyGp
         GZ6V8je0HHQQ/gAH4Ajffl0VN8ZchHbXb8mj+jkCQvVV9ymE5qlRxXvdFzVA6CJu1qCL
         3Q2HvrpVvjDeviw41DVzRWAyMqRI+/Hu33o7yypqALpNrQz3i2GSaO0Vju0oGbucTSDm
         C4YO1Sb2E1/qkZ+MoLUFnSRdc6Tg8n3SbvkV+yKtNIixJvvtJc2yPGP2P30xWvBB/dKc
         0hxWjARpQYsrxL8c6dYfo7Wea3UrF6zqRUhXAbflAcf+HaGEGFC0VdFpPZnVv09CEtP7
         7BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x5kA50WCYmAo+Q8432Sy1VWAEloJEHU1E0inGU7UJt4=;
        b=MVWK2ypUrAEARPY/oAMPjxIhsyK3aBAaAf/1QTY6B2AmS8SCknJQ89l5Xts2SVWx0a
         P/eFPK2RScorPnoFrPKcxAQvQq0yS7mSmLEFT3S4aBHyK5O1vzqEGxa5VUCu1FW5/YM5
         vDmV/OSEWPKks0oesZnpBQlrnS8dXhJYZD+Fi2NBfCY8oA6xZLF2U4JsUCt27f/Ehjxe
         Di5JidEKpaaO99hsZeUjfQyfkCv//TpqC5dmVLlQkQ2n/cQJHZFTae6A47ZhgtJwjYjV
         WpQl1R0UjlObgbf5x6mwU/QQZxOkjB8Dvo6qJbvExlXbX87utKCMyp6NWjbaBRWK9/6F
         SebA==
X-Gm-Message-State: AOAM530C9SMd6XH3yIGXApUmChY30uJ1/+oFPw15rxK8ic6DuufZM/++
        NH3Nl8EjKo3JTw9bH04sjhJ+T76KYTMTjHkB3yMhLTWzYo00/A==
X-Google-Smtp-Source: ABdhPJwt2i4uMXnI/aDf/IMCkp+fkfiR8T1ZV0Xq5jPXfVkLqk1/z6xJceU91wFxGtS0OwHxE8OGOEvpPZuhVEc/yDo=
X-Received: by 2002:a92:d6d2:: with SMTP id z18mr2855668ilp.272.1594697862742;
 Mon, 13 Jul 2020 20:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200702172714.158786-1-pop.adrian61@gmail.com> <20200702172714.158786-2-pop.adrian61@gmail.com>
In-Reply-To: <20200702172714.158786-2-pop.adrian61@gmail.com>
From:   Hua Dillon <dillonhua@gmail.com>
Date:   Tue, 14 Jul 2020 11:37:30 +0800
Message-ID: <CAPTRvHm0gX=myLBeztq-7q8hMGZ+a0pH_ZB8hH+RZtSSsqVGDw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: stm32: Enable MIPI DSI display support.
To:     Adrian Pop <pop.adrian61@gmail.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian,

Just one suggestion for you.

Adrian Pop <pop.adrian61@gmail.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:30=E5=86=99=E9=81=93=EF=BC=9A
>
> STM32f769-disco features a 4" MIPI DSI display: add support for it.
> On Cortex-M7 DMA can't use cached memory. For this reason I use a dedicat=
ed
> memory pool for DMA with no-cache attribute which is located at the end o=
f
>  RAM.
>
> Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
> ---
>  arch/arm/boot/dts/stm32f746.dtsi      | 34 +++++++++++++++++++
>  arch/arm/boot/dts/stm32f769-disco.dts | 49 +++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f7=
46.dtsi
> index 93c063796780..577a812ca01c 100644
> --- a/arch/arm/boot/dts/stm32f746.dtsi
> +++ b/arch/arm/boot/dts/stm32f746.dtsi
> @@ -48,6 +48,19 @@ / {
>         #address-cells =3D <1>;
>         #size-cells =3D <1>;
>
> +       reserved-memory {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               ranges;
> +
> +               linux,dma {
> +                       compatible =3D "shared-dma-pool";
> +                       linux,dma-default;
> +                       no-map;
> +                       reg =3D <0xc0f00000 0x100000>;
> +               };
> +       };
> +
Christoph Hellwig was submit a patch for !CONFIG_MMU platforms to support m=
map.
the patch is : 1fbf57d05302 dma-direct: re-enable mmap for !CONFIG_MMU
i thought there is no need to create a reserved-memory for it.

>         clocks {
>                 clk_hse: clk-hse {
>                         #clock-cells =3D <0>;
> @@ -75,6 +88,27 @@ clk_i2s_ckin: clk-i2s-ckin {
>         };
>
>         soc {
> +               ltdc: display-controller@40016800 {
> +                       compatible =3D "st,stm32-ltdc";
> +                       reg =3D <0x40016800 0x200>;
> +                       interrupts =3D <88>, <89>;
> +                       resets =3D <&rcc STM32F7_APB2_RESET(LTDC)>;
> +                       clocks =3D <&rcc 1 CLK_LCD>;
> +                       clock-names =3D "lcd";
> +                       status =3D "disabled";
> +               };
> +
> +               dsi: dsi@40016c00 {
> +                       compatible =3D "st,stm32-dsi";
> +                       reg =3D <0x40016c00 0x800>;
> +                       interrupts =3D <98>;
> +                       clocks =3D <&rcc 1 CLK_F769_DSI>, <&clk_hse>;
> +                       clock-names =3D "pclk", "ref";
> +                       resets =3D <&rcc STM32F7_APB2_RESET(DSI)>;
> +                       reset-names =3D "apb";
> +                       status =3D "disabled";
> +               };
> +
>                 timer2: timer@40000000 {
>                         compatible =3D "st,stm32-timer";
>                         reg =3D <0x40000000 0x400>;
> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/st=
m32f769-disco.dts
> index 1626e00bb2cb..a9e81b49809c 100644
> --- a/arch/arm/boot/dts/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> @@ -153,3 +153,52 @@ &usbotg_hs {
>         pinctrl-names =3D "default";
>         status =3D "okay";
>  };
> +
> +&dsi {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       status =3D "okay";
> +
> +       ports {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               port@0 {
> +                       reg =3D <0>;
> +                       dsi_in: endpoint {
> +                               remote-endpoint =3D <&ltdc_out_dsi>;
> +                       };
> +               };
> +
> +               port@1 {
> +                       reg =3D <1>;
> +                       dsi_out: endpoint {
> +                               remote-endpoint =3D <&dsi_in_panel>;
> +                       };
> +               };
> +
> +       };
> +
> +       panel: panel {
> +               compatible =3D "orisetech,otm8009a";
> +               reg =3D <0>;
> +               reset-gpios =3D <&gpioj 15 GPIO_ACTIVE_LOW>;
> +               status =3D "okay";
> +
> +               port {
> +                       dsi_in_panel: endpoint {
> +                               remote-endpoint =3D <&dsi_out>;
> +                       };
> +               };
> +       };
> +};
> +
> +&ltdc {
> +       status =3D "okay";
> +
> +       port {
> +               ltdc_out_dsi: endpoint {
> +                       remote-endpoint =3D <&dsi_in>;
> +               };
> +       };
> +};
> --
> 2.27.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
