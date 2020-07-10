Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095B3C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB1E20772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594346246;
	bh=G5No4QQMFOOR+XKtWR3GqfhwAfTLEtJ8Ooml73TEfUI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=b2whFk/eaYBFWW64R4NWfkCgHcLQjzhWOBpDnI+8ilBVQHX9D/7sIXm5NDu24wTtP
	 LERhWwnGW3sLB9OxjwMcXOuLJNe0qLg50lbO80XP0lA5oPEGJ9ZAMIF21X/tIe4aJV
	 awW9LiCmo3033Jh1DUAznSNz/g7fVFczPTxrXh9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGJB5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:57:25 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:46122 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgGJB5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:57:20 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 06A1v2Y1028227;
        Fri, 10 Jul 2020 10:57:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 06A1v2Y1028227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594346223;
        bh=uO2lDE1kilvU2pB4wwi5Hz6kjCZnaiBVrjicmeG0AOk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qoNopYMTIJRGEQaL+l6jI1z2ziQtxoUtdqc4M+ebYQQlE4ullLJ1j7/ruuXIVOXwJ
         We86cIxqvtYHl4BvMah6Huk6SwYPj6BeSU0fjUfo/W2EjyJq+j78IvnJrKYXMjveGH
         YGT6qjC4i0xLwpW2oKMmEpvRpNWPojzYhKfeB27oBQxz5MUKXJdrK8RlR4O6Tg5qUZ
         S5pNRxIzEPwgtGAhJoaDvGHCwzRlANLU8k9Y8hV/PVoYtavUzKpx8u1+VGV2g8Hpuv
         NrGerYUkWZmaRi8PuOMI+7xAORFDv0A2FU3ULO/Te8Ta5orZeXzI8VgDERI3J6s7JA
         wYI61twCOBRFA==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id c7so1348438uap.0;
        Thu, 09 Jul 2020 18:57:03 -0700 (PDT)
X-Gm-Message-State: AOAM532EQeau/smtVwoSUrGOYCj1EOKgF4Ei4HvBakwwhDD7GHDq+q6V
        1ew485LeiDEAjLXO6kPc0vNYCFtCH5aR404heOU=
X-Google-Smtp-Source: ABdhPJx2dxGT5lyml19QVwxhhUAvR6nwXJ8INt5lZOEojSS14wiISMBP4Ld/J+OTZCDid1Pn8kEfFawQTzijpmN5tiQ=
X-Received: by 2002:ab0:21c6:: with SMTP id u6mr31465767uan.109.1594346222029;
 Thu, 09 Jul 2020 18:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <1594198578-29238-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1594198578-29238-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 10 Jul 2020 10:56:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQdrqGmCDwEfd2GUYJrteNHs-PrTYmzKZO9v6y5a0ZHLQ@mail.gmail.com>
Message-ID: <CAK7LNAQdrqGmCDwEfd2GUYJrteNHs-PrTYmzKZO9v6y5a0ZHLQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: uniphier: Add missing clock-names and
 reset-names to pcie-phy
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 5:56 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> This adds missing clock-names and reset-names to pcie-phy node according to
> Documentation/devicetree/bindings/phy/socionext,uniphier-pcie.yaml.


Applied, but I tend to consider
b36a2472539293bcab0521bcbc284d6be0448d4b
was a misconversion (or intentional breakage)
because the original uniphier-pcie-phy.txt
did not require clock/reset-names
for ld20, pxs3.



> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 ++
>  arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> index f4a56b2..a87b8a6 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> @@ -936,7 +936,9 @@
>                         compatible = "socionext,uniphier-ld20-pcie-phy";
>                         reg = <0x66038000 0x4000>;
>                         #phy-cells = <0>;
> +                       clock-names = "link";
>                         clocks = <&sys_clk 24>;
> +                       reset-names = "link";
>                         resets = <&sys_rst 24>;
>                         socionext,syscon = <&soc_glue>;
>                 };
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> index 72f1688..0e52dadf 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> @@ -833,7 +833,9 @@
>                         compatible = "socionext,uniphier-pxs3-pcie-phy";
>                         reg = <0x66038000 0x4000>;
>                         #phy-cells = <0>;
> +                       clock-names = "link";
>                         clocks = <&sys_clk 24>;
> +                       reset-names = "link";
>                         resets = <&sys_rst 24>;
>                         socionext,syscon = <&soc_glue>;
>                 };
> --
> 2.7.4
>


--
Best Regards
Masahiro Yamada
