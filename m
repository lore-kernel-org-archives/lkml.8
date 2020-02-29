Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FAFC3F2D7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 06:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167A424691
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 06:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LbPDSFz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgB2GLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 01:11:38 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:17517 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgB2GLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 01:11:38 -0500
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 01T6BSRL028585;
        Sat, 29 Feb 2020 15:11:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 01T6BSRL028585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582956689;
        bh=S8ie6xcSgZjQKTwEkbDG56p/lOho2ipiDfPyiqZ7rvI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LbPDSFz5NguZ7qy+jJ2GTcVzpff7THwcImiuRRN+cm4HYVPvFHt2LbNcMT2OOPt7T
         Sn2PR3GodRycRePEbcksXISSHWOpfueUxiTquU41htdzf6pCV11J/JB6SGO4qa/5X7
         7zUzTdCe0JbQR2jMvJZo++gFNYBapYNgjMkUOvWoEOR1ZqJ8pRAmrN1zAqCjvVxEXZ
         BNjQz1zEblNaXSH1OrQwlN0TZSm8LbqO18IdjBpHg+lddEQvm0S9oANx8emS+HoJX+
         oaSSaT1UBck46ZNz6WVdVZxz+7qvnwKBjeq4925fWIJ1txrrda6LlUwhGj/MGqT/NF
         2oxkPxEKCsaCg==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id c7so1806095uaf.5;
        Fri, 28 Feb 2020 22:11:29 -0800 (PST)
X-Gm-Message-State: ANhLgQ1nIxIASV9AoFbHdqV4EM0mxxyjbayaFbHp3e1DfoPHIaOG0tsG
        SRW3ET+9/blgb9eTpd2kIYQV3NVHi7/hBKXuSuI=
X-Google-Smtp-Source: ADFU+vubh8kH92wzbPEOmByx/QnpSuJQV0HHcAkbw9vppZxNRv2USNuA4QfgAwjQSHZkZXIXBCMYVYnetsx1bYYikKk=
X-Received: by 2002:ab0:2881:: with SMTP id s1mr3837997uap.95.1582956688322;
 Fri, 28 Feb 2020 22:11:28 -0800 (PST)
MIME-Version: 1.0
References: <20200222064445.14903-1-yamada.masahiro@socionext.com> <20200222064445.14903-4-yamada.masahiro@socionext.com>
In-Reply-To: <20200222064445.14903-4-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 29 Feb 2020 15:10:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNASnmVJKvVA815oTwL-a37W9qhpV98RfGU+o5cMiM4Ek_w@mail.gmail.com>
Message-ID: <CAK7LNASnmVJKvVA815oTwL-a37W9qhpV98RfGU+o5cMiM4Ek_w@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: uniphier: rename aidet node names to
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
> Follow the standard nodename pattern "^interrupt-controller(@[0-9a-f,]+)*$"
> defined in schemas/interrupt-controller.yaml of dt-schema.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---



Applied to linux-uniphier.


>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 +-
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 +-
>  arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> index 7510db465f33..2e53daca9f5c 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> @@ -566,7 +566,7 @@
>                         };
>                 };
>
> -               aidet: aidet@5fc20000 {
> +               aidet: interrupt-controller@5fc20000 {
>                         compatible = "socionext,uniphier-ld11-aidet";
>                         reg = <0x5fc20000 0x200>;
>                         interrupt-controller;
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> index 8d360c5cc32b..be984200a70e 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> @@ -664,7 +664,7 @@
>                         };
>                 };
>
> -               aidet: aidet@5fc20000 {
> +               aidet: interrupt-controller@5fc20000 {
>                         compatible = "socionext,uniphier-ld20-aidet";
>                         reg = <0x5fc20000 0x200>;
>                         interrupt-controller;
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> index d51b0735917c..994fea7b12c1 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> @@ -462,7 +462,7 @@
>                         };
>                 };
>
> -               aidet: aidet@5fc20000 {
> +               aidet: interrupt-controller@5fc20000 {
>                         compatible = "socionext,uniphier-pxs3-aidet";
>                         reg = <0x5fc20000 0x200>;
>                         interrupt-controller;
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
