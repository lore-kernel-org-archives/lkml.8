Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB0CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C61520708
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594345814;
	bh=R/qvQtOapBzQfjgp1F+VIsMPD3+hFH2lYsvvxiVRsrs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iB1q9e89seJzZr89u4jotERrnQSJ9L33XJJXWb35jiPYH94ycIBOyBEtwv/4YNEia
	 rIaHtY68kMn2fIf4rkDUXgjGzM3V1ucJWf8brVNK9wqgq0FrujZN4lR+vtMIJnq5I3
	 A/MZKWH/QTSk/ASLCrDcj6NOxSskJYic7BgMCgMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGJBuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:50:13 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:28776 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgGJBuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:50:13 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 06A1nxnI015769;
        Fri, 10 Jul 2020 10:49:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 06A1nxnI015769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594345799;
        bh=Gvm+g/WdTbueU8JPboyyP1wbcG28Ei9VuntqPk2mzHE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Thx0DZv4GPO9epHZUAoaYDzag+dAUQQQiqtzN6kf34r8XEL2Tv2cqci0boXcTjQYX
         jF9SbvHvpTRA510CguVcKToatU4SOkpNRupbn52jgkatGETwxR5tQ+bEWArb78P6Ki
         LruGjd37AKo4/0t9leoVAp03bpqF4JMio72PYm8LshPmcpCZtE0Kz6eTzI89hrVDuz
         vktnWTTmlDwyHcNQ/i4XbciSg5Vjc4hXh+cwjCQIN6BnoHQ/f3C7une7dz9V0pltNh
         qIfyLYL/BLgtpIPpkCW33AXv0/jPsOGGrPthOwbYzCDXaQHCLFAs65sH1kdJ0vPfbt
         f+GJ1pQGVQvDw==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id q15so1337219uap.4;
        Thu, 09 Jul 2020 18:49:59 -0700 (PDT)
X-Gm-Message-State: AOAM531vyuf+RY9bDItKC5ZyVSvgf62wiP5JpFUkcwfOJtG1rZnt+up6
        uBnbWPyPsPwFbE6g0xquozQ/m+Z6inQzo4HXe0E=
X-Google-Smtp-Source: ABdhPJw78ViM4Wbi6CPTVoIpEk8EDcs586MtfpjU2widRKRiXIbdD0Zwe61bDGZFwCuGkFP4OUY8RS8a2TH0fyxfEhk=
X-Received: by 2002:ab0:44e5:: with SMTP id n92mr9280862uan.121.1594345798317;
 Thu, 09 Jul 2020 18:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <1594198320-28900-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1594198320-28900-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 10 Jul 2020 10:49:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASAvC2aF9530Dc24dcVfVH_SK3ZpdkjSmSEj9xw+mXr6A@mail.gmail.com>
Message-ID: <CAK7LNASAvC2aF9530Dc24dcVfVH_SK3ZpdkjSmSEj9xw+mXr6A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: uniphier: Add PCIe endpoint and PHY node for Pro5
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

On Wed, Jul 8, 2020 at 5:52 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> This adds PCIe endpoint controller and PHY nodes for Pro5 SoC,
> and also adds pinctrl node for PCIe.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>


Applied.


> ---
>  arch/arm/boot/dts/uniphier-pinctrl.dtsi |  5 +++++
>  arch/arm/boot/dts/uniphier-pro5.dtsi    | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
> index bfdfb76..c0fd029 100644
> --- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
> @@ -126,6 +126,11 @@
>                 function = "nand";
>         };
>
> +       pinctrl_pcie: pcie {
> +               groups = "pcie";
> +               function = "pcie";
> +       };
> +
>         pinctrl_sd: sd {
>                 groups = "sd";
>                 function = "sd";
> diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
> index feadb4a..3525125 100644
> --- a/arch/arm/boot/dts/uniphier-pro5.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
> @@ -613,6 +613,36 @@
>                         };
>                 };
>
> +               pcie_ep: pcie-ep@66000000 {
> +                       compatible = "socionext,uniphier-pro5-pcie-ep",
> +                                    "snps,dw-pcie-ep";
> +                       status = "disabled";
> +                       reg-names = "dbi", "dbi2", "link", "addr_space";
> +                       reg = <0x66000000 0x1000>, <0x66001000 0x1000>,
> +                             <0x66010000 0x10000>, <0x67000000 0x400000>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&pinctrl_pcie>;
> +                       clock-names = "gio", "link";
> +                       clocks = <&sys_clk 12>, <&sys_clk 24>;
> +                       reset-names = "gio", "link";
> +                       resets = <&sys_rst 12>, <&sys_rst 24>;
> +                       num-ib-windows = <16>;
> +                       num-ob-windows = <16>;
> +                       num-lanes = <4>;
> +                       phy-names = "pcie-phy";
> +                       phys = <&pcie_phy>;
> +               };
> +
> +               pcie_phy: phy@66038000 {
> +                       compatible = "socionext,uniphier-pro5-pcie-phy";
> +                       reg = <0x66038000 0x4000>;
> +                       #phy-cells = <0>;
> +                       clock-names = "gio", "link";
> +                       clocks = <&sys_clk 12>, <&sys_clk 24>;
> +                       reset-names = "gio", "link";
> +                       resets = <&sys_rst 12>, <&sys_rst 24>;
> +               };
> +
>                 nand: nand-controller@68000000 {
>                         compatible = "socionext,uniphier-denali-nand-v5b";
>                         status = "disabled";
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
