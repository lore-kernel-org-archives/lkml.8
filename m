Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A6AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 212582067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQddYGaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHXUID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXUIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:08:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6215EC061573;
        Mon, 24 Aug 2020 13:08:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c15so5166318lfi.3;
        Mon, 24 Aug 2020 13:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hEOJDy5VpY/6gwUau8NPAOLJV8wtmaTzguYs5BYd4s=;
        b=kQddYGaOjOGa9RJhgb6w3LT/vF+N7ObNoa4VwX8jngRhh/xFAWm3lyg92kYN1hpfZT
         bd2whc7oFU0tGl0t+fPiGTbxlMlzHVjwXlSaq13j2RdpPXar6z+lCFcEhYTmPNS2mCSM
         PIwpNub9tetSKh4iqu/r9GoBauRjnkU08yjuCasVcAvjeHEOcCoCuBMuzxRWFygqc+YB
         haLOVIueiFh0LRhtFh7YREN46exas9OebZvaUz+Lt8YYeVvAQUZVwZOsMqfyN77vXrOM
         won13lN5ZIbI/9qEuTrptYPDsWppwGErKsRYU2ahC3zTd2OO04iKoyy7MCMakyPBV6I3
         PJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hEOJDy5VpY/6gwUau8NPAOLJV8wtmaTzguYs5BYd4s=;
        b=FYOcmDv+Z6U+R4NtMywz1h5+LH5rTcnmI9pyOtHfjf/wwA+8y+sgEsfYJaPOd9M/WW
         RY0Cx55vTNhHegfe5mwBZgBXneIT43ckTnjHCFHemQlGqthjTT3ZZEC3Bvp7mISG4Cho
         Isvcy83i8m5Ez01egpev1fS8nbTArEPk3eiklBUTuky4PWbZdlSLz2rgbTNvJSJadQ3v
         rkkugo9xrGiSJ3DyuGk73pW8RlQgHyexNV6vQfoaRI5XFHUo0Ju5sBeDtNz6Hbf0kq9T
         /L9dmB60KbSANpQhofBR0DrlFh8Y4U8v4hSPw6E703WzlaH1uOA/yBtWPFBfaHxu0dTh
         FrwA==
X-Gm-Message-State: AOAM533jih6Ji15HUpp63BvjIXlD9GsujOGwmWooIZtPd8dAUIRu64MU
        2Zr6XDLpcPkGjDB0AeOOc3mpiJ9Sh9/+3VCwjFeKzqWNwZs=
X-Google-Smtp-Source: ABdhPJyDWK54OaNTznXHTHtxiBDJUsjV7st4S/DmUVjYLMEuSdDcBlmLrgy/zRKgFobf79N1zm3VopVh0dKl9vknAHM=
X-Received: by 2002:a19:4ace:: with SMTP id x197mr3295387lfa.70.1598299679565;
 Mon, 24 Aug 2020 13:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200824190701.8447-1-krzk@kernel.org> <20200824190701.8447-4-krzk@kernel.org>
In-Reply-To: <20200824190701.8447-4-krzk@kernel.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 24 Aug 2020 17:07:48 -0300
Message-ID: <CAOMZO5BgqJba+-Lqq_Js1Opkii8SZ3p66O7xOQibV1zgrXxS=Q@mail.gmail.com>
Subject: Re: [PATCH 04/16] arm64: dts: imx8mm-beacon-baseboard: Correct SPI CS polarity
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, Li Jun <jun.li@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Aug 24, 2020 at 4:07 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> index bf0859f1e1fa..5b5af8b381df 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> @@ -70,7 +70,7 @@
>  &ecspi2 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_espi2>;
> -       cs-gpios = <&gpio5 9 0>;
> +       cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;

I have already sent a patch fixing this:
https://www.spinics.net/lists/arm-kernel/msg830895.html
