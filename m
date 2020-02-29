Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6F2C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 06:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7662468A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 06:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gCrDiaW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgB2GJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 01:09:17 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:63134 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgB2GJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 01:09:16 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 01T69Cqo027532;
        Sat, 29 Feb 2020 15:09:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 01T69Cqo027532
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582956553;
        bh=FDOn710v7y7+ihVj2jblA+fctMmPwnjIEd1Ea49dLC0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gCrDiaW46tABUNq60rflRlhsWX10fRekkRTzE8ubR0T4pbNKLlcSNKCg1okjYCVKE
         t2EY3wK5AtiTJKkonEmStcPPLl/dKmZIOgxHtRjO8Z4IPgvm2YWPrwPR/DuYM4N4VG
         8JZhY1ydVOuJKUjHCTpAVL8MZ4jFvgUYAGEqh++JULndT98gjk7cEg9TG8NCDz8lud
         iiDBmJpq9D/nIZBpkNKsXIyQ/2pqBdy+34HmCZLi+J9ekcixRjKaNB1GEQa4+YigX+
         t3vFKVxU//0qtaG1jQCko5qo59cHfX6g2t7wcCk6O/Gm8NMquzgUQH9+iafNZhgEjG
         NjDG3J2drHsFw==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id a33so1792338uad.11;
        Fri, 28 Feb 2020 22:09:13 -0800 (PST)
X-Gm-Message-State: ANhLgQ3V5/wBieBsQU/bXJJVyQP19PmE4djnbEfy4Y16S5VNYmWRe4l4
        5V/fWpnrXc1mB2heVHqsis/7glS7vtaMte5Fbt4=
X-Google-Smtp-Source: ADFU+vvd2S7Ste0Zn/eGxDN/NNdK6s5ZpfeCHP0r5Cao2Sh6KWRfQ2UxnVFAabBiDACbWhnKN3OXiVkeb8whOGEovwU=
X-Received: by 2002:ab0:2414:: with SMTP id f20mr3763217uan.121.1582956552146;
 Fri, 28 Feb 2020 22:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20200226035914.23582-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200226035914.23582-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 29 Feb 2020 15:08:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNATchD=T_V5Z489FqHB5VkLX4x=gMoq6azMQGk-Q2wQG_Q@mail.gmail.com>
Message-ID: <CAK7LNATchD=T_V5Z489FqHB5VkLX4x=gMoq6azMQGk-Q2wQG_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: uniphier: rename NAND node names to follow json-schema
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

On Wed, Feb 26, 2020 at 1:00 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Follow the standard nodename pattern "^nand-controller(@.*)?" defined
> in Documentation/devicetree/bindings/mtd/nand-controller.yaml
>
> Otherwise, after the dt-binding is converted to json-schema,
> 'make ARCH=arm dtbs_check' will show a warning like this:
>
>   nand@68000000: $nodename:0: 'nand@68000000' does not match '^nand-controller(@.*)?'
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-uniphier.



>  arch/arm/boot/dts/uniphier-ld4.dtsi  | 2 +-
>  arch/arm/boot/dts/uniphier-pro4.dtsi | 2 +-
>  arch/arm/boot/dts/uniphier-pro5.dtsi | 2 +-
>  arch/arm/boot/dts/uniphier-pxs2.dtsi | 2 +-
>  arch/arm/boot/dts/uniphier-sld8.dtsi | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
> index 23b8fd627c00..197bee7d8b7f 100644
> --- a/arch/arm/boot/dts/uniphier-ld4.dtsi
> +++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
> @@ -398,7 +398,7 @@
>                         };
>                 };
>
> -               nand: nand@68000000 {
> +               nand: nand-controller@68000000 {
>                         compatible = "socionext,uniphier-denali-nand-v5a";
>                         status = "disabled";
>                         reg-names = "nand_data", "denali_reg";
> diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
> index eb06c353970f..b02bc8a6346b 100644
> --- a/arch/arm/boot/dts/uniphier-pro4.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
> @@ -588,7 +588,7 @@
>                         };
>                 };
>
> -               nand: nand@68000000 {
> +               nand: nand-controller@68000000 {
>                         compatible = "socionext,uniphier-denali-nand-v5a";
>                         status = "disabled";
>                         reg-names = "nand_data", "denali_reg";
> diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
> index c95eb44c816d..f84a43a10f38 100644
> --- a/arch/arm/boot/dts/uniphier-pro5.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
> @@ -453,7 +453,7 @@
>                         };
>                 };
>
> -               nand: nand@68000000 {
> +               nand: nand-controller@68000000 {
>                         compatible = "socionext,uniphier-denali-nand-v5b";
>                         status = "disabled";
>                         reg-names = "nand_data", "denali_reg";
> diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> index c054d0175df9..989b2a241822 100644
> --- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> @@ -761,7 +761,7 @@
>                         };
>                 };
>
> -               nand: nand@68000000 {
> +               nand: nand-controller@68000000 {
>                         compatible = "socionext,uniphier-denali-nand-v5b";
>                         status = "disabled";
>                         reg-names = "nand_data", "denali_reg";
> diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
> index a05061038e78..fbfd25050a04 100644
> --- a/arch/arm/boot/dts/uniphier-sld8.dtsi
> +++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
> @@ -402,7 +402,7 @@
>                         };
>                 };
>
> -               nand: nand@68000000 {
> +               nand: nand-controller@68000000 {
>                         compatible = "socionext,uniphier-denali-nand-v5a";
>                         status = "disabled";
>                         reg-names = "nand_data", "denali_reg";
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
