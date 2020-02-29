Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26206C3F2D7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 06:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CD724691
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 06:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BiwbYIPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgB2GMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 01:12:35 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:21082 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgB2GMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 01:12:35 -0500
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 01T6CUaM007883;
        Sat, 29 Feb 2020 15:12:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 01T6CUaM007883
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582956751;
        bh=eUac00y4+KjD0ZFkpw13qSxG2E1VV85gjairgIZ++iU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BiwbYIPvVAtUArrnn9d47b0HltiNy5y8LXEUK8LZB1Kp4Yyog9aLThfOcmqwT7aFi
         NKeewG1nLH5CSU3rr9scD0zEIjKW1khdHKTyBRIDwri0r4bTUKLK7g7NUuBk9rscVE
         V6hFn9NEZTMn7o8fKQqCfWRE1VOMUp5Wu67h7S+NbgB7uqH+NhdbOi9CS3k0uDXs5A
         K7yAkkeL4ibsqZHwl/QoK3ctHqj6bID2THaT36Kvcz5onAWcJSUJPTtpGTormdXCoh
         vw4qQww4Rgv8wWhqEznT1jQjUO8ZICeJI+NRBdVQ5ds1ES9c7HCiUgqgZJ4Ed5DIfi
         wB5pYXpF4FY5g==
X-Nifty-SrcIP: [209.85.221.172]
Received: by mail-vk1-f172.google.com with SMTP id i78so1579832vke.0;
        Fri, 28 Feb 2020 22:12:31 -0800 (PST)
X-Gm-Message-State: ANhLgQ3kidTyFEzDTtv3TL+6r0BhRYG6QG9fwelQmTQrAXnLFmwpykwI
        QJ0JpcjPtMAJTT0mqFj2eYDm0JefRxSGN0NmGLA=
X-Google-Smtp-Source: ADFU+vuplMIRZuW5G8+FaAaCGMpR7KsnrGDyb+zzSiSHiyXAJwy+8RJztwATJpKRuKBVa3zHwzqoCxDMrmkWljbu8g4=
X-Received: by 2002:a1f:b401:: with SMTP id d1mr2587941vkf.26.1582956750237;
 Fri, 28 Feb 2020 22:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20200222064445.14903-1-yamada.masahiro@socionext.com> <20200222064445.14903-2-yamada.masahiro@socionext.com>
In-Reply-To: <20200222064445.14903-2-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 29 Feb 2020 15:11:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNARE4uo8+_+zHthy+nQQrVvT-DeNx8F_7i5jWF-33DMkMQ@mail.gmail.com>
Message-ID: <CAK7LNARE4uo8+_+zHthy+nQQrVvT-DeNx8F_7i5jWF-33DMkMQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: uniphier: change SD/eMMC node names to
 follow json-schema
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 3:45 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Follow the standard nodename pattern "^mmc(@.*)?$" defined in
> Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-uniphier.



>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 +-
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 4 ++--
>  arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> index 5b18bda9c5a6..7510db465f33 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> @@ -433,7 +433,7 @@
>                         };
>                 };
>
> -               emmc: sdhc@5a000000 {
> +               emmc: mmc@5a000000 {
>                         compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
>                         reg = <0x5a000000 0x400>;
>                         interrupts = <0 78 4>;
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> index f2dc5f695020..8d360c5cc32b 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> @@ -559,7 +559,7 @@
>                         };
>                 };
>
> -               emmc: sdhc@5a000000 {
> +               emmc: mmc@5a000000 {
>                         compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
>                         reg = <0x5a000000 0x400>;
>                         interrupts = <0 78 4>;
> @@ -578,7 +578,7 @@
>                         cdns,phy-dll-delay-sdclk-hsmmc = <21>;
>                 };
>
> -               sd: sdhc@5a400000 {
> +               sd: mmc@5a400000 {
>                         compatible = "socionext,uniphier-sd-v3.1.1";
>                         status = "disabled";
>                         reg = <0x5a400000 0x800>;
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> index 73e7e1203b09..d51b0735917c 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> @@ -353,7 +353,7 @@
>                         };
>                 };
>
> -               emmc: sdhc@5a000000 {
> +               emmc: mmc@5a000000 {
>                         compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
>                         reg = <0x5a000000 0x400>;
>                         interrupts = <0 78 4>;
> @@ -372,7 +372,7 @@
>                         cdns,phy-dll-delay-sdclk-hsmmc = <21>;
>                 };
>
> -               sd: sdhc@5a400000 {
> +               sd: mmc@5a400000 {
>                         compatible = "socionext,uniphier-sd-v3.1.1";
>                         status = "disabled";
>                         reg = <0x5a400000 0x800>;
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
