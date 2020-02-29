Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08F2C3F2D8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 06:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39A0246AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 06:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YJq/gTCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgB2GI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 01:08:27 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:25808 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgB2GI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 01:08:26 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 01T684d8012423;
        Sat, 29 Feb 2020 15:08:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 01T684d8012423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582956485;
        bh=MPlTFlGFOYGEN3wAxlaLHIRWtngnYQ4XIJlxJ/a/yLc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YJq/gTCYvlxhgM30Kqw/i0LSYVLlYHTx3+2gcBhwmK1rWoD85wZHVjhB473I1cA9z
         e7CTlet+8Fs6AjAsmGIiStEfEDtO9j8qfXmjhXJE4xgXNgGI7IbNGZ7hDmrdlQcaa0
         TMJSSK9lYMwL2Zj4m8LcnWg9+0aFyCzRXWXAOiRKUyHwlJevvBP5Yd9sfJ8+H2EpmT
         9MzRKCiAj9aiH705htDG/4uy+to9jcKn+zCmmaFYn8rGKCI678QjdhS2nn7yswgzu1
         duZCT8mohG1TZh932ubd1ZRUGaovwTs+ZMlo+n0B0zts/mdEa8i+VaAOeRPQ/165ud
         sIOIiTo64y8NQ==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id a33so1791853uad.11;
        Fri, 28 Feb 2020 22:08:04 -0800 (PST)
X-Gm-Message-State: ANhLgQ3ZLHg23Bo2TAPgbUqhJiffAt1XrjksNROxXbIMyxGuzoBbhkHB
        AfYfNc2hH7fUL2peJuFxGH2Pd97npahfKLPfz54=
X-Google-Smtp-Source: ADFU+vvD+Jes1r5LCq19pCWnEzIalPq/2VR6XM24yQcSfzbLuAgf5XLPlQKQLx7SVBw4EIpuLJtnBOfj6+Tppj9etdg=
X-Received: by 2002:ab0:14ea:: with SMTP id f39mr3906665uae.40.1582956483318;
 Fri, 28 Feb 2020 22:08:03 -0800 (PST)
MIME-Version: 1.0
References: <20200227123726.12910-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200227123726.12910-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 29 Feb 2020 15:07:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNARGNmg8VtwZgxets5NYLnNrzp1eryEOEFGyCxDvKiVisQ@mail.gmail.com>
Message-ID: <CAK7LNARGNmg8VtwZgxets5NYLnNrzp1eryEOEFGyCxDvKiVisQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: uniphier: rename cache controller nodes to
 follow json-schema
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 9:38 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Follow the standard nodename pattern
> "^(cache-controller|cpu)(@[0-9a-f,]+)*$" defined in
> schemas/cache-controller.yaml of dt-schema.
>
> Otherwise, after the dt-binding is converted to json-schema,
> 'make ARCH=arm dtbs_check' will show a warning like this:
>
>   l2-cache@500c0000: $nodename:0: 'l2-cache@500c0000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-uniphier.

>
>  arch/arm/boot/dts/uniphier-ld4.dtsi  | 2 +-
>  arch/arm/boot/dts/uniphier-pro4.dtsi | 2 +-
>  arch/arm/boot/dts/uniphier-pro5.dtsi | 4 ++--
>  arch/arm/boot/dts/uniphier-pxs2.dtsi | 2 +-
>  arch/arm/boot/dts/uniphier-sld8.dtsi | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
> index 197bee7d8b7f..06e7400d2940 100644
> --- a/arch/arm/boot/dts/uniphier-ld4.dtsi
> +++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
> @@ -51,7 +51,7 @@
>                 ranges;
>                 interrupt-parent = <&intc>;
>
> -               l2: l2-cache@500c0000 {
> +               l2: cache-controller@500c0000 {
>                         compatible = "socionext,uniphier-system-cache";
>                         reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
>                               <0x506c0000 0x400>;
> diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
> index b02bc8a6346b..1c866f0306fc 100644
> --- a/arch/arm/boot/dts/uniphier-pro4.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
> @@ -59,7 +59,7 @@
>                 ranges;
>                 interrupt-parent = <&intc>;
>
> -               l2: l2-cache@500c0000 {
> +               l2: cache-controller@500c0000 {
>                         compatible = "socionext,uniphier-system-cache";
>                         reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
>                               <0x506c0000 0x400>;
> diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
> index f84a43a10f38..da772429b55a 100644
> --- a/arch/arm/boot/dts/uniphier-pro5.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
> @@ -131,7 +131,7 @@
>                 ranges;
>                 interrupt-parent = <&intc>;
>
> -               l2: l2-cache@500c0000 {
> +               l2: cache-controller@500c0000 {
>                         compatible = "socionext,uniphier-system-cache";
>                         reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
>                               <0x506c0000 0x400>;
> @@ -144,7 +144,7 @@
>                         next-level-cache = <&l3>;
>                 };
>
> -               l3: l3-cache@500c8000 {
> +               l3: cache-controller@500c8000 {
>                         compatible = "socionext,uniphier-system-cache";
>                         reg = <0x500c8000 0x2000>, <0x503c8100 0x8>,
>                               <0x506c8000 0x400>;
> diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> index 989b2a241822..7044f8700cb2 100644
> --- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> @@ -157,7 +157,7 @@
>                 ranges;
>                 interrupt-parent = <&intc>;
>
> -               l2: l2-cache@500c0000 {
> +               l2: cache-controller@500c0000 {
>                         compatible = "socionext,uniphier-system-cache";
>                         reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
>                               <0x506c0000 0x400>;
> diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
> index fbfd25050a04..09992163e1f4 100644
> --- a/arch/arm/boot/dts/uniphier-sld8.dtsi
> +++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
> @@ -51,7 +51,7 @@
>                 ranges;
>                 interrupt-parent = <&intc>;
>
> -               l2: l2-cache@500c0000 {
> +               l2: cache-controller@500c0000 {
>                         compatible = "socionext,uniphier-system-cache";
>                         reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
>                               <0x506c0000 0x400>;
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best Regards
Masahiro Yamada
