Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5613AC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 06:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249D02468A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 06:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="a6JQ1jn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgB2GJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 01:09:47 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:52994 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgB2GJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 01:09:46 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 01T69VoD008222;
        Sat, 29 Feb 2020 15:09:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 01T69VoD008222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582956572;
        bh=T4mYF9PdGCCx51/8tVnGLpffkqtEkPRbg0ZE1yEu3Y4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a6JQ1jn+SkINLjt7ka4hUO0gyE6mJjW8w8OnpOBaf7xBexOx5lszzunIF+RIHIiuA
         IbL0jzmT5xrFxvk+yW0OW/TxspNz5E94KtI7Q0yLXyge68JlD9NAMYSawd6uhApdQS
         z5j3gYbz7WjDj0kbELA/MCUSm9R1wFbfAQISzVdP91rGqHPQr6KSZgEQrnaoFSDJtP
         P7VEgy8GkrA5WAVkU3IfmR+4+jqUV8Qcj5kqPQ0YY9isnoZ23MkJletch+RUtHEjcp
         ZZ7oZ8fiq6EBdD2YQm/Au57QY8bGyzKn7IUPfrlcjuKGwcL663g5Y/9F8zsLW3/0JN
         5OnxJlEUVFS2g==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id a19so3216565vsp.6;
        Fri, 28 Feb 2020 22:09:32 -0800 (PST)
X-Gm-Message-State: ANhLgQ34XxJDxCgfuB4FYOLCRbzGl1CX0VqOOZq8D3HicT0maX67NAc6
        hhUkIpusX/y2L9ct3rQZrgzH2HBvt7eE+dimVYA=
X-Google-Smtp-Source: ADFU+vsR9iQ5EQp9E08EzMVqnnAyJbA3o2T746m95TMOkWDqb0XZcmG/9wqU7G7zK2SepSJ2NLe8WJ7qnxEt63Cbwek=
X-Received: by 2002:a67:fa4b:: with SMTP id j11mr4500806vsq.155.1582956571084;
 Fri, 28 Feb 2020 22:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20200226035914.23582-1-yamada.masahiro@socionext.com> <20200226035914.23582-2-yamada.masahiro@socionext.com>
In-Reply-To: <20200226035914.23582-2-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 29 Feb 2020 15:08:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQzYMbZwyt75yWbrVgj-4cOHC20RFLVz7kqnx8vUa-baA@mail.gmail.com>
Message-ID: <CAK7LNAQzYMbZwyt75yWbrVgj-4cOHC20RFLVz7kqnx8vUa-baA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: uniphier: rename NAND node names to
 follow json-schema
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
> 'make ARCH=arm64 dtbs_check' will show a warning like this:
>
>   nand@68000000: $nodename:0: 'nand@68000000' does not match '^nand-controller(@.*)?'
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-uniphier.


>
>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 +-
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 +-
>  arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> index 2e53daca9f5c..d61da3a62712 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> @@ -621,7 +621,7 @@
>                         };
>                 };
>
> -               nand: nand@68000000 {
> +               nand: nand-controller@68000000 {
>                         compatible = "socionext,uniphier-denali-nand-v5b";
>                         status = "disabled";
>                         reg-names = "nand_data", "denali_reg";
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> index be984200a70e..98f0f4eb0649 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> @@ -925,7 +925,7 @@
>                         socionext,syscon = <&soc_glue>;
>                 };
>
> -               nand: nand@68000000 {
> +               nand: nand-controller@68000000 {
>                         compatible = "socionext,uniphier-denali-nand-v5b";
>                         status = "disabled";
>                         reg-names = "nand_data", "denali_reg";
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> index 994fea7b12c1..4c6cd3ec541d 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> @@ -783,7 +783,7 @@
>                         socionext,syscon = <&soc_glue>;
>                 };
>
> -               nand: nand@68000000 {
> +               nand: nand-controller@68000000 {
>                         compatible = "socionext,uniphier-denali-nand-v5b";
>                         status = "disabled";
>                         reg-names = "nand_data", "denali_reg";
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
