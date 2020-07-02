Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B8AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1AD20874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OHI23XSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgGBFHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgGBFHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:07:22 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F9DC08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 22:07:22 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i25so27627003iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 22:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEqgfz4dMPy0M8UdIl/OP3qCi5/0HDdWhm7+x1JpE8k=;
        b=OHI23XSwOoCtKab9Yrumej03I6gMMsQ5SpRG7rrzTOpLPZPhQBysLX48g5rqWJUmR8
         QrBW5CeLisMKbOFKtg8gbHTK50mBkqkv7GZiOxihU/SU3qE+QAeq6z9A9jASZ+geI9Ib
         wpCuDzRKDdfr0EEUrvTKzx4t0U8xDkCAR91o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEqgfz4dMPy0M8UdIl/OP3qCi5/0HDdWhm7+x1JpE8k=;
        b=PcS8dHP2avM4RAk34KVytx1x4mttY0ltswxjq0DxO6l/vKtbk++EqzVBgHdQfI1PD/
         HdDcyYmCvQgsmJG62ypIiOZ6TebHqNiXoIzBtDfjQBbqCW/JX6lLypNW+oPwMVmaTnl+
         W5noWaLKZKQ2ZH/4LuaTV9BvVychfT0wlgmvSO03rtW4PlKpXre2WhCy+55rVTKyOjEg
         tyb+b1fl1g2d/5CRl0gsilXkT8uvUcbYNiHvm9o4Uil/2t9CheXWMQ2nJ+fatOqVue9O
         4z8Zap/TCnbtHK782e68yYDdpDRZgwVJpit35joBbsIwvpBDuvSPVCtBpjyhT30bNcw8
         KEPg==
X-Gm-Message-State: AOAM530j1PBNG5Vq1qdgztyaMxulpD5GgcG91rLJM1fThtahKRLnmEM3
        n7EQ27IFmqw4aLM1LuPvOEou1UQKCVNkDMlZWWkZFA==
X-Google-Smtp-Source: ABdhPJzARNPpL/MZGeCd0M+vUHJWSbbCFc9ks584J5OlpKLVXK1oxKo3tdUOmzXarQh4NOVw2SgC++mS/VX9KJKONhk=
X-Received: by 2002:a02:30c4:: with SMTP id q187mr31283874jaq.102.1593666441584;
 Wed, 01 Jul 2020 22:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200625101757.101775-1-enric.balletbo@collabora.com> <20200625101757.101775-7-enric.balletbo@collabora.com>
In-Reply-To: <20200625101757.101775-7-enric.balletbo@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 2 Jul 2020 13:06:55 +0800
Message-ID: <CAJMQK-iocK5eH9QTQQKNFHtBvpc1C2=U=3kFPXkXiUOiRxrucA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] arm64: dts: mt8183: Add USB3.0 support
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        erwanaliasr1@gmail.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 6:18 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Add the USB3.0 phyter and controller for the MediaTek's MT8183 SoC.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>
> Changes in v2:
> - Move adding #phy-cells to this patch. (Matthias Brugger)
>
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 58 ++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 6c00ffa275202..102105871db25 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/reset-controller/mt8183-resets.h>
> +#include <dt-bindings/phy/phy.h>
>  #include "mt8183-pinfunc.h"
>
>  / {
> @@ -648,6 +649,36 @@ i2c8: i2c@1101b000 {
>                         status = "disabled";
>                 };
>
> +               ssusb: usb@11201000 {
> +                       compatible ="mediatek,mt8183-mtu3", "mediatek,mtu3";
> +                       reg = <0 0x11201000 0 0x2e00>,
> +                             <0 0x11203e00 0 0x0100>;
> +                       reg-names = "mac", "ippc";
> +                       interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
> +                       phys = <&u2port0 PHY_TYPE_USB2>,
> +                              <&u3port0 PHY_TYPE_USB3>;
> +                       clocks = <&infracfg CLK_INFRA_UNIPRO_SCK>,
> +                                <&infracfg CLK_INFRA_USB>;
> +                       clock-names = "sys_ck", "ref_ck";
> +                       mediatek,syscon-wakeup = <&pericfg 0x400 0>;
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges;
> +                       status = "disabled";
> +
> +                       usb_host: xhci@11200000 {
> +                               compatible = "mediatek,mt8183-xhci",
> +                                            "mediatek,mtk-xhci";
> +                               reg = <0 0x11200000 0 0x1000>;
> +                               reg-names = "mac";
> +                               interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_LOW>;
> +                               clocks = <&infracfg CLK_INFRA_UNIPRO_SCK>,
> +                                        <&infracfg CLK_INFRA_USB>;
> +                               clock-names = "sys_ck", "ref_ck";
> +                               status = "disabled";
> +                       };
> +               };
> +
>                 audiosys: syscon@11220000 {
>                         compatible = "mediatek,mt8183-audiosys", "syscon";
>                         reg = <0 0x11220000 0 0x1000>;
> @@ -684,6 +715,33 @@ efuse: efuse@11f10000 {
>                         reg = <0 0x11f10000 0 0x1000>;
>                 };
>
> +               u3phy: usb-phy@11f40000 {
> +                       compatible = "mediatek,mt8183-tphy",
> +                                    "mediatek,generic-tphy-v2";
> +                       #address-cells = <1>;
> +                       #phy-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges = <0 0 0x11f40000 0x1000>;
> +                       status = "okay";
> +
> +                       u2port0: usb-phy@0 {
> +                               reg = <0x0 0x700>;
> +                               clocks = <&clk26m>;
> +                               clock-names = "ref";
> +                               #phy-cells = <1>;
> +                               mediatek,discth = <15>;
> +                               status = "okay";
> +                       };
> +
> +                       u3port0: usb-phy@0700 {
> +                               reg = <0x0700 0x900>;
> +                               clocks = <&clk26m>;
> +                               clock-names = "ref";
> +                               #phy-cells = <1>;
> +                               status = "okay";
> +                       };
> +               };
> +
>                 mfgcfg: syscon@13000000 {
>                         compatible = "mediatek,mt8183-mfgcfg", "syscon";
>                         reg = <0 0x13000000 0 0x1000>;
> --
> 2.27.0
>
