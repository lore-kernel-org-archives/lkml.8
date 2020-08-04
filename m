Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A3FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5343D2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cQpkxL4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgHDPXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:23:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:53353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgHDPXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596554545;
        bh=sjy/7cbvWFDMn93C7JAJB2eqqf8LM8odrGp9n3IbZGk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cQpkxL4hhhXpPxZQ+R3FkwSJH+yJQ71UhitSB3H854cKFCgN+OUrO7WPyJmejWVIP
         3Wi4A3baqTW7qzOP0DDx3TS5fHWDRaOc7fOu4vw/RWlFgGGZfPw+40py8e7rwrVgt9
         +sFA8x66BQmOfLrlVUc/XN7kh4WaEeXvEsMZBSlE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.144.119] ([217.61.144.119]) by web-mail.gmx.net
 (3c-app-gmx-bap28.server.lan [172.19.172.98]) (via HTTP); Tue, 4 Aug 2020
 17:22:25 +0200
MIME-Version: 1.0
Message-ID: <trinity-e5fb1e73-2aa9-4dd2-a115-3ef216a6336e-1596554545050@3c-app-gmx-bap28>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        chunhui dai <chunhui.dai@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        CK Hu <ck.hu@mediatek.com>, Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Aw: Re: [PATCH v3 5/5] arm: dts: mt7623: add display subsystem
 related device nodes
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 4 Aug 2020 17:22:25 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAAOTY_9aDqz3muo6ynqX9r0VjW7tD5vvZOiQyR8UZOTUct8oVA@mail.gmail.com>
References: <20200804105849.70876-1-linux@fw-web.de>
 <20200804105849.70876-6-linux@fw-web.de>
 <CAAOTY_9aDqz3muo6ynqX9r0VjW7tD5vvZOiQyR8UZOTUct8oVA@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:7BhFM7ZWcvyKxzn6X4OC4HJ8PW9UUMcnuJQtOpn6fq0ut1vX7rAoKcI91P7RKJEfeCOqY
 I7ot1zQTlWvDkGkrGRSwc/lkJY+S4g36GnrQ5NxM/dnbOI8JKOzLX4hTuObrTliv53GWrt2CH808
 EB+hekE8X9q28nNguT6jIHaJrES3w4QS0pDwZOrkCZ2OW/g+CjeHYytnnCQu5LXkTmsN04KJPo0Y
 e+L5vmaIR6gKZMLOS2YdrJArq4nbjh33LgekvMS14m097X6q2beSmbCZ88D3fUNUe5HurO/Ctvje
 Sc=
X-UI-Out-Filterresults: notjunk:1;V03:K0:n7pknJx/PMc=:jYzmEzGpoiLpdjr8CLGEVU
 xgdSkHEUheng6dfd/mOS6rlbAmsK9UtntmoXDI5vg2mGGnQ8m8jD2MY8hZS5SEblnHeYQkT4v
 NHVIAXocNqblBarVIZF9gR5RSDnH7Eoo9fouYWm4HxJfdGECFSM3AWf7uWzosqigLZt7G/h9K
 wD77NPmX4H1fmpBZhK674+wuxQyv+YEQDBE2qiwIId0nKkESLvYzU+sOYbO6VmsKybX8ah/kG
 CSYXZ4piQV4bhxMwhp4TvsksOMoKc7hAJ7EFHgkEGPc9IBzVXFvhq5hCMVD1LRkHuC43og0lp
 tHzbbuEFuC47drEqr3KmVf5uDu36aVMztcpTFC9yGZVAPuXltw7rpReAnh41oLx8s8amzcI1Z
 Lzss8TcVNRyl8sMHW8lNZKg01uaunbwLrbF7MdwN6DBQrDPUJVVdCEPjejT/O3L56N/uk5EJV
 xdGLZcAeY/AFekB4U3r4qsWvuTl43XOhNgtIZCU/B4aN14vtukWafnYuRi2xNKEOzKNh+wRl7
 7uCqWLuBd56okF/gE89sihIgbTzTvakgPDCJBOJXQ9crq48EM6jtgF5SEct4zIU1oDrrfnvaV
 cQ76SjFDTD00YBTd9GwVwmxgcya3zTgiAANKBga4jzRNqjf3b/FSoQv3P90nnCKni275L3G6K
 rBsvblDim8x8Encjmp0zKDc7mK1tPVMdL4AvbwlA0gpThU40nhflV3U7kQ4DbW61yQZw=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Except mmsys (i added in Patch #1) all mt7623-compatibles are not defined =
in code and fallback (mt2701-x/mt8173-x) is used. If i add it in dt-bindin=
g, it should be added in code too, right? or should i remove mt7623 compat=
ibles and only add documentation for new mmsys?

regards Frank


> Gesendet: Dienstag, 04. August 2020 um 17:00 Uhr
> Von: "Chun-Kuang Hu" <chunkuang.hu@kernel.org>
> An: "Frank Wunderlich" <linux@fw-web.de>
> > +       mipi_tx0: mipi-dphy@10010000 {
> > +               compatible =3D "mediatek,mt7623-mipi-tx",
>
> In mediatek,dsi.txt [1], "mediatek,mt7623-mipi-tx" is undefined.
>
> [1] https://www.kernel.org/doc/Documentation/devicetree/bindings/display=
/mediatek/mediatek%2Cdsi.txt

in drivers/gpu/drm/mediatek/mtk_mipi_tx.c only the compatible for mt2701 i=
s defined (which is fallback in dts). So should i remove mt7623 compatible=
 here and in the other occurences?

>
> > +                            "mediatek,mt2701-mipi-tx";

> > +
> > +       cec: cec@10012000 {
> > +               compatible =3D "mediatek,mt7623-cec",
>
> Please explicitly define "mediatek,mt7623-cec" in mediatek,hdmi.txt [2].
>
> [2] https://www.kernel.org/doc/Documentation/devicetree/bindings/display=
/mediatek/mediatek%2Chdmi.txt
>
> > +                            "mediatek,mt8173-cec";

same here...only mt8173-cec is defined in drivers/gpu/drm/mediatek/mtk_cec=
.c

> >         cir: cir@10013000 {
> >                 compatible =3D "mediatek,mt7623-cir";
> >                 reg =3D <0 0x10013000 0 0x1000>;
> > @@ -369,6 +393,18 @@ apmixedsys: syscon@10209000 {
> >                 #clock-cells =3D <1>;
> >         };
> >
> > +       hdmi_phy: phy@10209100 {
> > +               compatible =3D "mediatek,mt7623-hdmi-phy",
>
> Ditto.
>
> > +                            "mediatek,mt2701-hdmi-phy";
same as above (./drivers/gpu/drm/mediatek/mtk_hdmi_phy.c)

> > +       hdmiddc0: i2c@11013000 {
> > +               compatible =3D "mediatek,mt7623-hdmi-ddc",
>
> Ditto.
>
> > +                            "mediatek,mt8173-hdmi-ddc";
> > +               interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
> > +               reg =3D <0 0x11013000 0 0x1C>;
> > +               clocks =3D <&pericfg CLK_PERI_I2C3>;
> > +               clock-names =3D "ddc-i2c";
> > +               status =3D "disabled";
> > +       };
> > +
> >         nor_flash: spi@11014000 {
> >                 compatible =3D "mediatek,mt7623-nor",
> >                              "mediatek,mt8173-nor";
> > @@ -766,6 +812,84 @@ mmsys: syscon@14000000 {
> >                 #clock-cells =3D <1>;
> >         };
> >
> > +       display_components: dispsys@14000000 {
> > +               compatible =3D "mediatek,mt7623-mmsys",
> > +                            "mediatek,mt2701-mmsys";
>
> In mediatek,mmsys.txt [3], this should be:
>
> mmsys: syscon@14000000 {
>         compatible =3D "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys",=
 "syscon"
>
> [3] https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/med=
iatek/mediatek%2Cmmsys.txt

as i added this in driver, i add this to documentation (and maybe remove t=
he fallback because it results in wrong routing?)

>
> > +               reg =3D <0 0x14000000 0 0x1000>;
> > +               power-domains =3D <&scpsys MT2701_POWER_DOMAIN_DISP>;
> > +       };
> > +
> > +       ovl@14007000 {
> > +               compatible =3D "mediatek,mt7623-disp-ovl",
>
> This is not defined in mediatek,disp.txt [4].
>
> [4] https://www.kernel.org/doc/Documentation/devicetree/bindings/display=
/mediatek/mediatek%2Cdisp.txt
also not defined in drivers/gpu/drm/mediatek/mtk_drm_drv.c so again fallba=
ck used

>
> > +                            "mediatek,mt2701-disp-ovl";

> > +               reg =3D <0 0x14007000 0 0x1000>;
> > +               interrupts =3D <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
> > +               clocks =3D <&mmsys CLK_MM_DISP_OVL>;
> > +               iommus =3D <&iommu MT2701_M4U_PORT_DISP_OVL_0>;
> > +               mediatek,larb =3D <&larb0>;
> > +       };
> > +
> > +       rdma0: rdma@14008000 {
> > +               compatible =3D "mediatek,mt7623-disp-rdma",
> > +                            "mediatek,mt2701-disp-rdma";
> > +               reg =3D <0 0x14008000 0 0x1000>;
> > +               interrupts =3D <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
> > +               clocks =3D <&mmsys CLK_MM_DISP_RDMA>;
> > +               iommus =3D <&iommu MT2701_M4U_PORT_DISP_RDMA>;
> > +               mediatek,larb =3D <&larb0>;
> > +       };
> > +
> > +       wdma@14009000 {
> > +               compatible =3D "mediatek,mt7623-disp-wdma",
> > +                            "mediatek,mt2701-disp-wdma";
> > +               reg =3D <0 0x14009000 0 0x1000>;
> > +               interrupts =3D <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
> > +               clocks =3D <&mmsys CLK_MM_DISP_WDMA>;
> > +               iommus =3D <&iommu MT2701_M4U_PORT_DISP_WDMA>;
> > +               mediatek,larb =3D <&larb0>;
> > +       };
> > +
> > +       bls: pwm@1400a000 {
> > +               compatible =3D "mediatek,mt7623-disp-pwm",
> > +                            "mediatek,mt2701-disp-pwm";
> > +               reg =3D <0 0x1400a000 0 0x1000>;
> > +               #pwm-cells =3D <2>;
> > +               clocks =3D <&mmsys CLK_MM_MDP_BLS_26M>,
> > +                        <&mmsys CLK_MM_DISP_BLS>;
> > +               clock-names =3D "main", "mm";
> > +               status =3D "disabled";
> > +       };
> > +
> > +       color@1400b000 {
> > +               compatible =3D "mediatek,mt7623-disp-color",
> > +                            "mediatek,mt2701-disp-color";
> > +               reg =3D <0 0x1400b000 0 0x1000>;
> > +               interrupts =3D <GIC_SPI 156 IRQ_TYPE_LEVEL_LOW>;
> > +               clocks =3D <&mmsys CLK_MM_DISP_COLOR>;
> > +       };
> > +
> > +       dsi: dsi@1400c000 {
> > +               compatible =3D "mediatek,mt7623-dsi",
>
> This is not defined in mediatek,dsi.txt [1].
>
> > +                            "mediatek,mt2701-dsi";
also fallback used (drivers/gpu/drm/mediatek/mtk_drm_drv.c)


> > +       dpi0: dpi@14014000 {
> > +               compatible =3D "mediatek,mt7623-dpi",
>
> This is not defined in mediatek,dpi.txt [5].
>
> [5] https://www.kernel.org/doc/Documentation/devicetree/bindings/display=
/mediatek/mediatek%2Cdpi.txt
>
> > +                            "mediatek,mt2701-dpi";

