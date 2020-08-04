Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B166C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC76A208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596556911;
	bh=ts4DiOIK31WOiPOomXTChPl+/Bcxf6Gu7FQwjpiYcDs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fKmPIRY49Yd+kutpsI/U7JCDQ2abMgXlArIjIl6/siAQOsx1vaWhvdny6So9OR7P1
	 5QCMl5SQvpMhDZ6gWrxvypdBH4I09YTg/KEvuVVSNzonSFo1tFGQMqk7CgNU76aque
	 fCuSGgEDz7HWMhmKM63PgsuH27H7NmOMQzYbiiDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgHDQBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgHDQBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:01:44 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 922B122CB2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596556903;
        bh=ts4DiOIK31WOiPOomXTChPl+/Bcxf6Gu7FQwjpiYcDs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VDA3GQ39CYhBDogsBHSlpvpzjjPXH+DnWJj59ptiEDTrzik30OgM7KxH6u0l2Co1f
         /F5c90jm2hrHfjWg/t5eC0QuFo4Z+XgmaoufZSadgkifwuzN2D6UhQbbufr30bTdtL
         gNOKrsNo48vUkWDfrxTKckBhHAM5RhBp/G0vHsZU=
Received: by mail-ej1-f50.google.com with SMTP id c16so22641254ejx.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 09:01:43 -0700 (PDT)
X-Gm-Message-State: AOAM532O9IbRZfrA8ABjOym9QFtzM2dHcnyAy57NAnsnoXe7YaEbf6lj
        fVubQFI+I41PPrsNpDdznu7RgAADJhNpdWNAhg==
X-Google-Smtp-Source: ABdhPJwMR9BzPODACxzGrDzlaXaeEp0KNiENuLTwjjsevYdEOA5TXJbNMK4Wn44k38pxfkBN0NOnavkcBi49b+lnhCE=
X-Received: by 2002:a17:906:7492:: with SMTP id e18mr21774016ejl.375.1596556902019;
 Tue, 04 Aug 2020 09:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200804105849.70876-1-linux@fw-web.de> <20200804105849.70876-6-linux@fw-web.de>
 <CAAOTY_9aDqz3muo6ynqX9r0VjW7tD5vvZOiQyR8UZOTUct8oVA@mail.gmail.com> <trinity-e5fb1e73-2aa9-4dd2-a115-3ef216a6336e-1596554545050@3c-app-gmx-bap28>
In-Reply-To: <trinity-e5fb1e73-2aa9-4dd2-a115-3ef216a6336e-1596554545050@3c-app-gmx-bap28>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 5 Aug 2020 00:01:29 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9uuCT2BiOzVngHz4df7ajY+ZTRBdnVAJfk2tjPQ2tWFA@mail.gmail.com>
Message-ID: <CAAOTY_9uuCT2BiOzVngHz4df7ajY+ZTRBdnVAJfk2tjPQ2tWFA@mail.gmail.com>
Subject: Re: Re: [PATCH v3 5/5] arm: dts: mt7623: add display subsystem
 related device nodes
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Frank Wunderlich <linux@fw-web.de>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <frank-w@public-files.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=884=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:23=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi
>
> Except mmsys (i added in Patch #1) all mt7623-compatibles are not defined=
 in code and fallback (mt2701-x/mt8173-x) is used. If i add it in dt-bindin=
g, it should be added in code too, right? or should i remove mt7623 compati=
bles and only add documentation for new mmsys?

You should add mt7623 compatibles in binding document and device node
(like mmsys node). The driver is optional to have it. If driver does
not implement mt7623, it would fallback to mt2701.

Regards,
Chun-Kuang.

>
> regards Frank
>
>
> > Gesendet: Dienstag, 04. August 2020 um 17:00 Uhr
> > Von: "Chun-Kuang Hu" <chunkuang.hu@kernel.org>
> > An: "Frank Wunderlich" <linux@fw-web.de>
> > > +       mipi_tx0: mipi-dphy@10010000 {
> > > +               compatible =3D "mediatek,mt7623-mipi-tx",
> >
> > In mediatek,dsi.txt [1], "mediatek,mt7623-mipi-tx" is undefined.
> >
> > [1] https://www.kernel.org/doc/Documentation/devicetree/bindings/displa=
y/mediatek/mediatek%2Cdsi.txt
>
> in drivers/gpu/drm/mediatek/mtk_mipi_tx.c only the compatible for mt2701 =
is defined (which is fallback in dts). So should i remove mt7623 compatible=
 here and in the other occurences?
>
> >
> > > +                            "mediatek,mt2701-mipi-tx";
>
> > > +
> > > +       cec: cec@10012000 {
> > > +               compatible =3D "mediatek,mt7623-cec",
> >
> > Please explicitly define "mediatek,mt7623-cec" in mediatek,hdmi.txt [2]=
.
> >
> > [2] https://www.kernel.org/doc/Documentation/devicetree/bindings/displa=
y/mediatek/mediatek%2Chdmi.txt
> >
> > > +                            "mediatek,mt8173-cec";
>
> same here...only mt8173-cec is defined in drivers/gpu/drm/mediatek/mtk_ce=
c.c
>
> > >         cir: cir@10013000 {
> > >                 compatible =3D "mediatek,mt7623-cir";
> > >                 reg =3D <0 0x10013000 0 0x1000>;
> > > @@ -369,6 +393,18 @@ apmixedsys: syscon@10209000 {
> > >                 #clock-cells =3D <1>;
> > >         };
> > >
> > > +       hdmi_phy: phy@10209100 {
> > > +               compatible =3D "mediatek,mt7623-hdmi-phy",
> >
> > Ditto.
> >
> > > +                            "mediatek,mt2701-hdmi-phy";
> same as above (./drivers/gpu/drm/mediatek/mtk_hdmi_phy.c)
>
> > > +       hdmiddc0: i2c@11013000 {
> > > +               compatible =3D "mediatek,mt7623-hdmi-ddc",
> >
> > Ditto.
> >
> > > +                            "mediatek,mt8173-hdmi-ddc";
> > > +               interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
> > > +               reg =3D <0 0x11013000 0 0x1C>;
> > > +               clocks =3D <&pericfg CLK_PERI_I2C3>;
> > > +               clock-names =3D "ddc-i2c";
> > > +               status =3D "disabled";
> > > +       };
> > > +
> > >         nor_flash: spi@11014000 {
> > >                 compatible =3D "mediatek,mt7623-nor",
> > >                              "mediatek,mt8173-nor";
> > > @@ -766,6 +812,84 @@ mmsys: syscon@14000000 {
> > >                 #clock-cells =3D <1>;
> > >         };
> > >
> > > +       display_components: dispsys@14000000 {
> > > +               compatible =3D "mediatek,mt7623-mmsys",
> > > +                            "mediatek,mt2701-mmsys";
> >
> > In mediatek,mmsys.txt [3], this should be:
> >
> > mmsys: syscon@14000000 {
> >         compatible =3D "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys"=
, "syscon"
> >
> > [3] https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/me=
diatek/mediatek%2Cmmsys.txt
>
> as i added this in driver, i add this to documentation (and maybe remove =
the fallback because it results in wrong routing?)
>
> >
> > > +               reg =3D <0 0x14000000 0 0x1000>;
> > > +               power-domains =3D <&scpsys MT2701_POWER_DOMAIN_DISP>;
> > > +       };
> > > +
> > > +       ovl@14007000 {
> > > +               compatible =3D "mediatek,mt7623-disp-ovl",
> >
> > This is not defined in mediatek,disp.txt [4].
> >
> > [4] https://www.kernel.org/doc/Documentation/devicetree/bindings/displa=
y/mediatek/mediatek%2Cdisp.txt
> also not defined in drivers/gpu/drm/mediatek/mtk_drm_drv.c so again fallb=
ack used
>
> >
> > > +                            "mediatek,mt2701-disp-ovl";
>
> > > +               reg =3D <0 0x14007000 0 0x1000>;
> > > +               interrupts =3D <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
> > > +               clocks =3D <&mmsys CLK_MM_DISP_OVL>;
> > > +               iommus =3D <&iommu MT2701_M4U_PORT_DISP_OVL_0>;
> > > +               mediatek,larb =3D <&larb0>;
> > > +       };
> > > +
> > > +       rdma0: rdma@14008000 {
> > > +               compatible =3D "mediatek,mt7623-disp-rdma",
> > > +                            "mediatek,mt2701-disp-rdma";
> > > +               reg =3D <0 0x14008000 0 0x1000>;
> > > +               interrupts =3D <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
> > > +               clocks =3D <&mmsys CLK_MM_DISP_RDMA>;
> > > +               iommus =3D <&iommu MT2701_M4U_PORT_DISP_RDMA>;
> > > +               mediatek,larb =3D <&larb0>;
> > > +       };
> > > +
> > > +       wdma@14009000 {
> > > +               compatible =3D "mediatek,mt7623-disp-wdma",
> > > +                            "mediatek,mt2701-disp-wdma";
> > > +               reg =3D <0 0x14009000 0 0x1000>;
> > > +               interrupts =3D <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
> > > +               clocks =3D <&mmsys CLK_MM_DISP_WDMA>;
> > > +               iommus =3D <&iommu MT2701_M4U_PORT_DISP_WDMA>;
> > > +               mediatek,larb =3D <&larb0>;
> > > +       };
> > > +
> > > +       bls: pwm@1400a000 {
> > > +               compatible =3D "mediatek,mt7623-disp-pwm",
> > > +                            "mediatek,mt2701-disp-pwm";
> > > +               reg =3D <0 0x1400a000 0 0x1000>;
> > > +               #pwm-cells =3D <2>;
> > > +               clocks =3D <&mmsys CLK_MM_MDP_BLS_26M>,
> > > +                        <&mmsys CLK_MM_DISP_BLS>;
> > > +               clock-names =3D "main", "mm";
> > > +               status =3D "disabled";
> > > +       };
> > > +
> > > +       color@1400b000 {
> > > +               compatible =3D "mediatek,mt7623-disp-color",
> > > +                            "mediatek,mt2701-disp-color";
> > > +               reg =3D <0 0x1400b000 0 0x1000>;
> > > +               interrupts =3D <GIC_SPI 156 IRQ_TYPE_LEVEL_LOW>;
> > > +               clocks =3D <&mmsys CLK_MM_DISP_COLOR>;
> > > +       };
> > > +
> > > +       dsi: dsi@1400c000 {
> > > +               compatible =3D "mediatek,mt7623-dsi",
> >
> > This is not defined in mediatek,dsi.txt [1].
> >
> > > +                            "mediatek,mt2701-dsi";
> also fallback used (drivers/gpu/drm/mediatek/mtk_drm_drv.c)
>
>
> > > +       dpi0: dpi@14014000 {
> > > +               compatible =3D "mediatek,mt7623-dpi",
> >
> > This is not defined in mediatek,dpi.txt [5].
> >
> > [5] https://www.kernel.org/doc/Documentation/devicetree/bindings/displa=
y/mediatek/mediatek%2Cdpi.txt
> >
> > > +                            "mediatek,mt2701-dpi";
>
