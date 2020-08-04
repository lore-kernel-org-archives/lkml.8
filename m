Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74A9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35FB207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596553257;
	bh=UGKz0laAMAeoRRMQ/WBIHLisQCLwq1BVQrmk9x1SlPo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hpNBwnIUiZzpvAa1fDrvGXSRuKcvYFWtn4RnZGOzD8glGWYsgAOgOzn0cJ/mxJuIk
	 v+xG/V4Rc3AMtt7ysCRrQQB/87JzefVu26SvqcrWhQrdbd+58hiXrWK2izJynCmLaV
	 WHUGL0qMluOzveWe6RRr4hW4SC/qP3FLETDILqlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgHDPAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbgHDPAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:00:19 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CA9D22CB2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596553218;
        bh=UGKz0laAMAeoRRMQ/WBIHLisQCLwq1BVQrmk9x1SlPo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hBmXwqbAD0aEV/RyYT8DMQykRoxAtVj0av0RbXEIsl6QY6lW7RRWsYvqXC4zuixUB
         X2f1x6fQHOTI40vGFC2qD6o3lMRBfLWEaT3I/gTEJytRbbOlhQr7iIlvO/wCitSdeN
         bKIYMjAiqMcnBEddhlDUeoUuBM1o+SJ4K1IBHZ04=
Received: by mail-ed1-f42.google.com with SMTP id a14so13147403edx.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 08:00:18 -0700 (PDT)
X-Gm-Message-State: AOAM532FpzgAcWoFRC0zjqeVATkIzEbAMAitoCRG60FM1An2SxLWIPV1
        opAZnYfRXvNfCfNiuZy31vyaqRm0+7TRIgjsUw==
X-Google-Smtp-Source: ABdhPJwunoyDTQhiThZnToQGxQmEkNellltv3DDrPfUVrB3+uPJo4Mn8HeFaGnvA7CheyZl6LWSmvuv4dbDt9K7/sas=
X-Received: by 2002:aa7:c606:: with SMTP id h6mr8396427edq.288.1596553216689;
 Tue, 04 Aug 2020 08:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200804105849.70876-1-linux@fw-web.de> <20200804105849.70876-6-linux@fw-web.de>
In-Reply-To: <20200804105849.70876-6-linux@fw-web.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 4 Aug 2020 23:00:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9aDqz3muo6ynqX9r0VjW7tD5vvZOiQyR8UZOTUct8oVA@mail.gmail.com>
Message-ID: <CAAOTY_9aDqz3muo6ynqX9r0VjW7tD5vvZOiQyR8UZOTUct8oVA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm: dts: mt7623: add display subsystem related
 device nodes
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        David Airlie <airlied@linux.ie>,
        chunhui dai <chunhui.dai@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        CK Hu <ck.hu@mediatek.com>, Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <linux@fw-web.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=884=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:00=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Ryder Lee <ryder.lee@mediatek.com>
>
> Add display subsystem related device nodes for MT7623.
>
> Cc: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changed v2->v3:
>   drop bls to dpi routing
> ---
>  arch/arm/boot/dts/mt7623.dtsi                 | 177 ++++++++++++++++++
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  72 +++++++
>  arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  72 +++++++
>  3 files changed, 321 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dts=
i
> index a106c0d90a52..d584a3d678ba 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -24,6 +24,11 @@ / {
>         #address-cells =3D <2>;
>         #size-cells =3D <2>;
>
> +       aliases {
> +               rdma0 =3D &rdma0;
> +               rdma1 =3D &rdma1;
> +       };
> +
>         cpu_opp_table: opp-table {
>                 compatible =3D "operating-points-v2";
>                 opp-shared;
> @@ -321,6 +326,25 @@ pwrap: pwrap@1000d000 {
>                 clock-names =3D "spi", "wrap";
>         };
>
> +       mipi_tx0: mipi-dphy@10010000 {
> +               compatible =3D "mediatek,mt7623-mipi-tx",

In mediatek,dsi.txt [1], "mediatek,mt7623-mipi-tx" is undefined.

[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/display/me=
diatek/mediatek%2Cdsi.txt

> +                            "mediatek,mt2701-mipi-tx";
> +               reg =3D <0 0x10010000 0 0x90>;
> +               clocks =3D <&clk26m>;
> +               clock-output-names =3D "mipi_tx0_pll";
> +               #clock-cells =3D <0>;
> +               #phy-cells =3D <0>;
> +       };
> +
> +       cec: cec@10012000 {
> +               compatible =3D "mediatek,mt7623-cec",

Please explicitly define "mediatek,mt7623-cec" in mediatek,hdmi.txt [2].

[2] https://www.kernel.org/doc/Documentation/devicetree/bindings/display/me=
diatek/mediatek%2Chdmi.txt

> +                            "mediatek,mt8173-cec";
> +               reg =3D <0 0x10012000 0 0xbc>;
> +               interrupts =3D <GIC_SPI 182 IRQ_TYPE_LEVEL_LOW>;
> +               clocks =3D <&infracfg CLK_INFRA_CEC>;
> +               status =3D "disabled";
> +       };
> +
>         cir: cir@10013000 {
>                 compatible =3D "mediatek,mt7623-cir";
>                 reg =3D <0 0x10013000 0 0x1000>;
> @@ -369,6 +393,18 @@ apmixedsys: syscon@10209000 {
>                 #clock-cells =3D <1>;
>         };
>
> +       hdmi_phy: phy@10209100 {
> +               compatible =3D "mediatek,mt7623-hdmi-phy",

Ditto.

> +                            "mediatek,mt2701-hdmi-phy";
> +               reg =3D <0 0x10209100 0 0x24>;
> +               clocks =3D <&apmixedsys CLK_APMIXED_HDMI_REF>;
> +               clock-names =3D "pll_ref";
> +               clock-output-names =3D "hdmitx_dig_cts";
> +               #clock-cells =3D <0>;
> +               #phy-cells =3D <0>;
> +               status =3D "disabled";
> +       };
> +
>         rng: rng@1020f000 {
>                 compatible =3D "mediatek,mt7623-rng";
>                 reg =3D <0 0x1020f000 0 0x1000>;
> @@ -568,6 +604,16 @@ bch: ecc@1100e000 {
>                 status =3D "disabled";
>         };
>
> +       hdmiddc0: i2c@11013000 {
> +               compatible =3D "mediatek,mt7623-hdmi-ddc",

Ditto.

> +                            "mediatek,mt8173-hdmi-ddc";
> +               interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
> +               reg =3D <0 0x11013000 0 0x1C>;
> +               clocks =3D <&pericfg CLK_PERI_I2C3>;
> +               clock-names =3D "ddc-i2c";
> +               status =3D "disabled";
> +       };
> +
>         nor_flash: spi@11014000 {
>                 compatible =3D "mediatek,mt7623-nor",
>                              "mediatek,mt8173-nor";
> @@ -766,6 +812,84 @@ mmsys: syscon@14000000 {
>                 #clock-cells =3D <1>;
>         };
>
> +       display_components: dispsys@14000000 {
> +               compatible =3D "mediatek,mt7623-mmsys",
> +                            "mediatek,mt2701-mmsys";

In mediatek,mmsys.txt [3], this should be:

mmsys: syscon@14000000 {
        compatible =3D "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys", "s=
yscon"

[3] https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/mediat=
ek/mediatek%2Cmmsys.txt

> +               reg =3D <0 0x14000000 0 0x1000>;
> +               power-domains =3D <&scpsys MT2701_POWER_DOMAIN_DISP>;
> +       };
> +
> +       ovl@14007000 {
> +               compatible =3D "mediatek,mt7623-disp-ovl",

This is not defined in mediatek,disp.txt [4].

[4] https://www.kernel.org/doc/Documentation/devicetree/bindings/display/me=
diatek/mediatek%2Cdisp.txt

> +                            "mediatek,mt2701-disp-ovl";
> +               reg =3D <0 0x14007000 0 0x1000>;
> +               interrupts =3D <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
> +               clocks =3D <&mmsys CLK_MM_DISP_OVL>;
> +               iommus =3D <&iommu MT2701_M4U_PORT_DISP_OVL_0>;
> +               mediatek,larb =3D <&larb0>;
> +       };
> +
> +       rdma0: rdma@14008000 {
> +               compatible =3D "mediatek,mt7623-disp-rdma",
> +                            "mediatek,mt2701-disp-rdma";
> +               reg =3D <0 0x14008000 0 0x1000>;
> +               interrupts =3D <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
> +               clocks =3D <&mmsys CLK_MM_DISP_RDMA>;
> +               iommus =3D <&iommu MT2701_M4U_PORT_DISP_RDMA>;
> +               mediatek,larb =3D <&larb0>;
> +       };
> +
> +       wdma@14009000 {
> +               compatible =3D "mediatek,mt7623-disp-wdma",
> +                            "mediatek,mt2701-disp-wdma";
> +               reg =3D <0 0x14009000 0 0x1000>;
> +               interrupts =3D <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
> +               clocks =3D <&mmsys CLK_MM_DISP_WDMA>;
> +               iommus =3D <&iommu MT2701_M4U_PORT_DISP_WDMA>;
> +               mediatek,larb =3D <&larb0>;
> +       };
> +
> +       bls: pwm@1400a000 {
> +               compatible =3D "mediatek,mt7623-disp-pwm",
> +                            "mediatek,mt2701-disp-pwm";
> +               reg =3D <0 0x1400a000 0 0x1000>;
> +               #pwm-cells =3D <2>;
> +               clocks =3D <&mmsys CLK_MM_MDP_BLS_26M>,
> +                        <&mmsys CLK_MM_DISP_BLS>;
> +               clock-names =3D "main", "mm";
> +               status =3D "disabled";
> +       };
> +
> +       color@1400b000 {
> +               compatible =3D "mediatek,mt7623-disp-color",
> +                            "mediatek,mt2701-disp-color";
> +               reg =3D <0 0x1400b000 0 0x1000>;
> +               interrupts =3D <GIC_SPI 156 IRQ_TYPE_LEVEL_LOW>;
> +               clocks =3D <&mmsys CLK_MM_DISP_COLOR>;
> +       };
> +
> +       dsi: dsi@1400c000 {
> +               compatible =3D "mediatek,mt7623-dsi",

This is not defined in mediatek,dsi.txt [1].

> +                            "mediatek,mt2701-dsi";
> +               reg =3D <0 0x1400c000 0 0x1000>;
> +               interrupts =3D <GIC_SPI 157 IRQ_TYPE_LEVEL_LOW>;
> +               clocks =3D <&mmsys CLK_MM_DSI_ENGINE>,
> +                        <&mmsys CLK_MM_DSI_DIG>,
> +                        <&mipi_tx0>;
> +               clock-names =3D "engine", "digital", "hs";
> +               phys =3D <&mipi_tx0>;
> +               phy-names =3D "dphy";
> +               status =3D "disabled";
> +       };
> +
> +       mutex: mutex@1400e000 {
> +               compatible =3D "mediatek,mt7623-disp-mutex",
> +                            "mediatek,mt2701-disp-mutex";
> +               reg =3D <0 0x1400e000 0 0x1000>;
> +               interrupts =3D <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
> +               clocks =3D <&mmsys CLK_MM_MUTEX_32K>;
> +       };
> +
>         larb0: larb@14010000 {
>                 compatible =3D "mediatek,mt7623-smi-larb",
>                              "mediatek,mt2701-smi-larb";
> @@ -778,6 +902,44 @@ larb0: larb@14010000 {
>                 power-domains =3D <&scpsys MT2701_POWER_DOMAIN_DISP>;
>         };
>
> +       rdma1: rdma@14012000 {
> +               compatible =3D "mediatek,mt7623-disp-rdma",
> +                            "mediatek,mt2701-disp-rdma";
> +               reg =3D <0 0x14012000 0 0x1000>;
> +               interrupts =3D <GIC_SPI 164 IRQ_TYPE_LEVEL_LOW>;
> +               clocks =3D <&mmsys CLK_MM_DISP_RDMA1>;
> +               iommus =3D <&iommu MT2701_M4U_PORT_DISP_RDMA1>;
> +               mediatek,larb =3D <&larb0>;
> +       };
> +
> +       dpi0: dpi@14014000 {
> +               compatible =3D "mediatek,mt7623-dpi",

This is not defined in mediatek,dpi.txt [5].

[5] https://www.kernel.org/doc/Documentation/devicetree/bindings/display/me=
diatek/mediatek%2Cdpi.txt

Regards,
Chun-Kuang.

> +                            "mediatek,mt2701-dpi";
> +               reg =3D <0 0x14014000 0 0x1000>;
> +               interrupts =3D <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
> +               clocks =3D <&mmsys CLK_MM_DPI1_DIGL>,
> +                        <&mmsys CLK_MM_DPI1_ENGINE>,
> +                        <&apmixedsys CLK_APMIXED_TVDPLL>;
> +               clock-names =3D "pixel", "engine", "pll";
> +               status =3D "disabled";
> +       };
> +
> +       hdmi0: hdmi@14015000 {
> +               compatible =3D "mediatek,mt7623-hdmi",
> +                            "mediatek,mt8173-hdmi";
> +               reg =3D <0 0x14015000 0 0x400>;
> +               clocks =3D <&mmsys CLK_MM_HDMI_PIXEL>,
> +                        <&mmsys CLK_MM_HDMI_PLL>,
> +                        <&mmsys CLK_MM_HDMI_AUDIO>,
> +                        <&mmsys CLK_MM_HDMI_SPDIF>;
> +               clock-names =3D "pixel", "pll", "bclk", "spdif";
> +               phys =3D <&hdmi_phy>;
> +               phy-names =3D "hdmi";
> +               mediatek,syscon-hdmi =3D <&mmsys 0x900>;
> +               cec =3D <&cec>;
> +               status =3D "disabled";
> +       };
> +
