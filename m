Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A906CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 815CE20658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597930071;
	bh=S0XMEVf2aAQ3IiYG7eOURhdsLOivgIMyT7tA6HisgHs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qwCrpMoGK05JGu650T0/qHx5+LRMLxiS10P3hpuEUvamBdk+NH2mPUhj0fRTy2DMj
	 LBYSBQZ6whhHU0AuNxpMaiHLzbOvZeGCM2a118PSuHYU2hQzCd5Qpw9U4XJRFtcY06
	 i8KBSR3DnWxa36Dn33sn4cTZ4AjYx/RqiCYXrrO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgHTN1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbgHTNXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:23:54 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25EA722B47;
        Thu, 20 Aug 2020 13:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597929832;
        bh=S0XMEVf2aAQ3IiYG7eOURhdsLOivgIMyT7tA6HisgHs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jIbFDbvKf1LKfEz1PAe5BHtw0D3gtcKxDyHF6BpQYmu9zRaFWSw6l4DaI8PLfmjC0
         jkHOBxdB0Hql2UpP9CiEAb4a5elCgqB/wu0zt6qUxXJkc0809OUaJSYradCp0i3dl8
         h54YWie3tOWixj6Mav8bOxGGR7n+8HxHWEZ/Blos=
Received: by mail-ot1-f42.google.com with SMTP id r21so1407605ota.10;
        Thu, 20 Aug 2020 06:23:52 -0700 (PDT)
X-Gm-Message-State: AOAM5305GimIlIrcoo++m5jHnAG2xc2zSVCwdwkmXUsz4FpC0RxxJqYM
        C1i55MZjb3eGlodz6WsaFmtaOpYk1EXJxkeDZw==
X-Google-Smtp-Source: ABdhPJy4Fpviz3cjhVdHhhI5/I15s9IDqxEnlJNHzLguk6qFyLHNnIlZuwb5D0ctTnUeBkXCLYg81ebaPBQ23C3ysz8=
X-Received: by 2002:a9d:7f84:: with SMTP id t4mr2189699otp.192.1597929831438;
 Thu, 20 Aug 2020 06:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com> <1597903458-8055-22-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1597903458-8055-22-git-send-email-yongqiang.niu@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 20 Aug 2020 07:23:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKy3kNOVuU3dbGmXBWuggzxx_NQpQL2wEvRQRVrn3pKgA@mail.gmail.com>
Message-ID: <CAL_JsqKy3kNOVuU3dbGmXBWuggzxx_NQpQL2wEvRQRVrn3pKgA@mail.gmail.com>
Subject: Re: [PATCH v1 21/21] arm64: dts: mt8192: add display node
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 12:06 AM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> add display node
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 126 +++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 931e1ca..d2a814d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -17,6 +17,13 @@
>         #address-cells = <2>;
>         #size-cells = <2>;
>
> +        aliases {
> +               ovl0 = &ovl0;
> +               ovl_2l0 = &ovl_2l0;
> +               ovl_2l2 = &ovl_2l2;
> +               rdma0 = &rdma0;
> +               rdma4 = &rdma4;

No, please don't add a bunch of custom aliases that you probably don't need.

> +       };
>         clk26m: oscillator@0 {
>                 compatible = "fixed-clock";
>                 #clock-cells = <0>;
> @@ -449,6 +456,125 @@
>                         #clock-cells = <1>;
>                 };
>
> +                mutex: mutex@14001000 {
> +                       compatible = "mediatek,mt8192-disp-mutex";
> +                       reg = <0 0x14001000 0 0x1000>;
> +                       interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks = <&mmsys CLK_MM_DISP_CONFIG>,
> +                                <&mmsys CLK_MM_26MHZ>,
> +                                <&mmsys CLK_MM_DISP_MUTEX0>;
> +               };
> +               ovl0: ovl@14005000 {
> +                       compatible = "mediatek,mt8192-disp-ovl";
> +                       reg = <0 0x14005000 0 0x1000>;
> +                       interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks = <&mmsys CLK_MM_DISP_OVL0>;
> +                       //iommus = <&iommu0 M4U_PORT_L0_OVL_RDMA0>,
> +                       //       <&iommu0 M4U_PORT_L0_OVL_RDMA0_HDR>;
> +                       power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
> +                       //mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
> +               };
> +
> +               ovl_2l0: ovl@14006000 {
> +                       compatible = "mediatek,mt8192-disp-ovl-2l";
> +                       reg = <0 0x14006000 0 0x1000>;
> +                       interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
> +                       clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
> +                       //iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0>,
> +                       //       <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0_HDR>;
> +                       //mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
> +               };
> +
> +               rdma0: rdma@14007000 {
> +                       compatible = "mediatek,mt8192-disp-rdma";
> +                       reg = <0 0x14007000 0 0x1000>;
> +                       interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks = <&mmsys CLK_MM_DISP_RDMA0>;
> +                       //iommus = <&iommu0 M4U_PORT_L0_DISP_RDMA0>;
> +                       mediatek,rdma_fifo_size = <5>;
> +                       power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
> +                       //mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x7000 0x1000>;
> +               };
> +
> +               color0: color@14009000 {
> +                       compatible = "mediatek,mt8192-disp-color",
> +                                    "mediatek,mt8173-disp-color";
> +                       reg = <0 0x14009000 0 0x1000>;
> +                       interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
> +                       clocks = <&mmsys CLK_MM_DISP_COLOR0>;
> +                       //mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x9000 0x1000>;
> +               };
> +
> +               ccorr0: ccorr@1400a000 {
> +                       compatible = "mediatek,mt8192-disp-ccorr";
> +                       reg = <0 0x1400a000 0 0x1000>;
> +                       interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
> +                       clocks = <&mmsys CLK_MM_DISP_CCORR0>;
> +                       //mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xa000 0x1000>;
> +               };
> +
> +               aal0: aal@1400b000 {
> +                       compatible = "mediatek,mt8192-disp-aal";
> +                       reg = <0 0x1400b000 0 0x1000>;
> +                       interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
> +                       clocks = <&mmsys CLK_MM_DISP_AAL0>;
> +                       //mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
> +               };
> +
> +               gamma0: gamma@1400c000 {
> +                       compatible = "mediatek,mt8192-disp-gamma";
> +                       reg = <0 0x1400c000 0 0x1000>;
> +                       interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
> +                       clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
> +                       //mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
> +               };
> +
> +               postmask0: postmask@1400d000 {
> +                       compatible = "mediatek,mt8192-disp-postmask";
> +                       reg = <0 0x1400d000 0 0x1000>;
> +                       interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
> +                       clocks = <&mmsys CLK_MM_DISP_POSTMASK0>;
> +                       //iommus = <&iommu0 M4U_PORT_L0_DISP_POSTMASK0>;
> +                       //mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
> +               };
> +
> +               dither0: dither@1400e000 {
> +                       compatible = "mediatek,mt8192-disp-dither";
> +                       reg = <0 0x1400e000 0 0x1000>;
> +                       interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
> +                       clocks = <&mmsys CLK_MM_DISP_DITHER0>;
> +                       //mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
> +               };
> +
> +               ovl_2l2: ovl@14014000 {
> +                       compatible = "mediatek,mt8192-disp-ovl-2l";
> +                       reg = <0 0x14014000 0 0x1000>;
> +                       interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
> +                       clocks = <&mmsys CLK_MM_DISP_OVL2_2L>;
> +                       //iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2>,
> +                       //       <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2_HDR>;
> +                       //mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x4000 0x1000>;
> +               };
> +
> +               rdma4: rdma@14015000 {
> +                       compatible = "mediatek,mt8192-disp-rdma";
> +                       reg = <0 0x14015000 0 0x1000>;
> +                       interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
> +                       clocks = <&mmsys CLK_MM_DISP_RDMA4>;
> +                       //iommus = <&iommu0 M4U_PORT_L1_DISP_RDMA4>;
> +                       mediatek,rdma_fifo_size = <2>;
> +                       //mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
> +               };
> +
>                 imgsys: imgsys@15020000 {
>                         compatible = "mediatek,mt8192-imgsys", "syscon";
>                         reg = <0 0x15020000 0 0x1000>;
> --
> 1.8.1.1.dirty
