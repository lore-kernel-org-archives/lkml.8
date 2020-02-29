Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0DDC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 06:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA8624691
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 06:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XaaC3iYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgB2GMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 01:12:24 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:45017 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgB2GMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 01:12:23 -0500
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 01T6C9cp020131;
        Sat, 29 Feb 2020 15:12:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 01T6C9cp020131
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582956730;
        bh=S0njFHUxsIxjdz5yDTcE8c9CmwQQMKBJYk9q7UJP43s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XaaC3iYJbQAIenxVhP41okTS5fB0mpjVw7mgy+/WvZLWHg4kokqhbheDfQTyytYvm
         aJ/pqSqz31qLMVnRIS9OZy2dwJzu9rC4/R6//DG+RR5tfmP1+fSKtylUcTin8xnuUR
         4TVvYg6N368tKeXNtCxKv5P2oOEocfl4/xsAZd2QNX3nrkIhPxCz42jpLsCpXWEuH4
         mAN6dHJF6HCAnSnW7pDQfF23bFtFif29HBOeuNtn3JgawDyEdvLDya+GXPggfS9qAQ
         EFSeAB9Wo6byUC3RzLq/gLI/EKkBLFk8pJqw92J+A4PgDRKdDVgAVa7Auc+lUpC8Ha
         7qmjX7XglSUqg==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id 7so3373923vsr.10;
        Fri, 28 Feb 2020 22:12:09 -0800 (PST)
X-Gm-Message-State: ANhLgQ0w6Js8afRzv3PZ0XCexOGHBHerwYnwlb7f8SJEKKZJwwi4/obs
        RmOwW1GljhwTjNTmDLTNf6HuHW0I+v3qeqkxV+I=
X-Google-Smtp-Source: ADFU+vsr21moWJFN7V7QE8rx/N7pQ9ZhwoS/WYbo35jUF1cpQQ1ACOrc6b/XUt9sAeFWUZYy0BBG3rYpX/INBSWsitE=
X-Received: by 2002:a67:fa4b:: with SMTP id j11mr4503502vsq.155.1582956728783;
 Fri, 28 Feb 2020 22:12:08 -0800 (PST)
MIME-Version: 1.0
References: <20200222064445.14903-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200222064445.14903-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 29 Feb 2020 15:11:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNARa-t5f9d0NcyzQfGq3RaX8PnjUeuST8s0Wdfs1kP_vvg@mail.gmail.com>
Message-ID: <CAK7LNARa-t5f9d0NcyzQfGq3RaX8PnjUeuST8s0Wdfs1kP_vvg@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: uniphier: change SD/eMMC node names to
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


>  arch/arm/boot/dts/uniphier-ld4.dtsi  | 4 ++--
>  arch/arm/boot/dts/uniphier-pro4.dtsi | 6 +++---
>  arch/arm/boot/dts/uniphier-pro5.dtsi | 4 ++--
>  arch/arm/boot/dts/uniphier-pxs2.dtsi | 4 ++--
>  arch/arm/boot/dts/uniphier-sld8.dtsi | 4 ++--
>  5 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
> index 64ec46c72a4c..f3a20dc0b22b 100644
> --- a/arch/arm/boot/dts/uniphier-ld4.dtsi
> +++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
> @@ -245,7 +245,7 @@
>                         #dma-cells = <1>;
>                 };
>
> -               sd: sdhc@5a400000 {
> +               sd: mmc@5a400000 {
>                         compatible = "socionext,uniphier-sd-v2.91";
>                         status = "disabled";
>                         reg = <0x5a400000 0x200>;
> @@ -265,7 +265,7 @@
>                         sd-uhs-sdr50;
>                 };
>
> -               emmc: sdhc@5a500000 {
> +               emmc: mmc@5a500000 {
>                         compatible = "socionext,uniphier-sd-v2.91";
>                         status = "disabled";
>                         reg = <0x5a500000 0x200>;
> diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
> index 2ec04d7972ef..e96b5796f0f8 100644
> --- a/arch/arm/boot/dts/uniphier-pro4.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
> @@ -279,7 +279,7 @@
>                         #dma-cells = <1>;
>                 };
>
> -               sd: sdhc@5a400000 {
> +               sd: mmc@5a400000 {
>                         compatible = "socionext,uniphier-sd-v2.91";
>                         status = "disabled";
>                         reg = <0x5a400000 0x200>;
> @@ -299,7 +299,7 @@
>                         sd-uhs-sdr50;
>                 };
>
> -               emmc: sdhc@5a500000 {
> +               emmc: mmc@5a500000 {
>                         compatible = "socionext,uniphier-sd-v2.91";
>                         status = "disabled";
>                         reg = <0x5a500000 0x200>;
> @@ -317,7 +317,7 @@
>                         non-removable;
>                 };
>
> -               sd1: sdhc@5a600000 {
> +               sd1: mmc@5a600000 {
>                         compatible = "socionext,uniphier-sd-v2.91";
>                         status = "disabled";
>                         reg = <0x5a600000 0x200>;
> diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
> index ea3961f920a0..f794a0676760 100644
> --- a/arch/arm/boot/dts/uniphier-pro5.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
> @@ -469,7 +469,7 @@
>                         resets = <&sys_rst 2>, <&sys_rst 2>;
>                 };
>
> -               emmc: sdhc@68400000 {
> +               emmc: mmc@68400000 {
>                         compatible = "socionext,uniphier-sd-v3.1";
>                         status = "disabled";
>                         reg = <0x68400000 0x800>;
> @@ -485,7 +485,7 @@
>                         non-removable;
>                 };
>
> -               sd: sdhc@68800000 {
> +               sd: mmc@68800000 {
>                         compatible = "socionext,uniphier-sd-v3.1";
>                         status = "disabled";
>                         reg = <0x68800000 0x800>;
> diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> index 13b0d4a7741f..04d6bef3a00f 100644
> --- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> @@ -446,7 +446,7 @@
>                         };
>                 };
>
> -               emmc: sdhc@5a000000 {
> +               emmc: mmc@5a000000 {
>                         compatible = "socionext,uniphier-sd-v3.1.1";
>                         status = "disabled";
>                         reg = <0x5a000000 0x800>;
> @@ -462,7 +462,7 @@
>                         non-removable;
>                 };
>
> -               sd: sdhc@5a400000 {
> +               sd: mmc@5a400000 {
>                         compatible = "socionext,uniphier-sd-v3.1.1";
>                         status = "disabled";
>                         reg = <0x5a400000 0x800>;
> diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
> index 4fc6676f5486..beb1eac85436 100644
> --- a/arch/arm/boot/dts/uniphier-sld8.dtsi
> +++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
> @@ -249,7 +249,7 @@
>                         #dma-cells = <1>;
>                 };
>
> -               sd: sdhc@5a400000 {
> +               sd: mmc@5a400000 {
>                         compatible = "socionext,uniphier-sd-v2.91";
>                         status = "disabled";
>                         reg = <0x5a400000 0x200>;
> @@ -269,7 +269,7 @@
>                         sd-uhs-sdr50;
>                 };
>
> -               emmc: sdhc@5a500000 {
> +               emmc: mmc@5a500000 {
>                         compatible = "socionext,uniphier-sd-v2.91";
>                         status = "disabled";
>                         reg = <0x5a500000 0x200>;
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
