Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17991C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1522087E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586362189;
	bh=kIreA496xvIapaRTLuMlFLqanuB0f3Kepl2wTRTpIrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ucA6JDOg8742lFzvAAXBAGLLzuvHAhmypHeu91aoyWEqS6H9jsJWe5m8gokvG23qc
	 AZ3IUka1pUtH+h91vwY7mf7DyUSeqoo0AZvuYbnnxlIH9OmHpP6VftoW38RDVAnxgX
	 ylh8SI5xdIh/Db7zMCR3SgRKg+a3zcfVRCgJFvgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbgDHQJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730191AbgDHQJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:09:43 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A371206F5;
        Wed,  8 Apr 2020 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586362182;
        bh=kIreA496xvIapaRTLuMlFLqanuB0f3Kepl2wTRTpIrQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AoEtzue8Eqfa+5ETZ4xoX852d8hgX6nzAq5CipUt2NoS4jErtK5FBjsxuWED09Bf2
         gXlds6dSYRSMAH9PQsIh0coJEKmU8SZw4H/nKH0iXc+e1IQkfBPekD4e8lKblQBpvv
         PpD69Duh/TS9CZZDUV2J/9GOWC+dO0Ut70IVAtLw=
Received: by mail-ed1-f51.google.com with SMTP id c7so9312563edl.2;
        Wed, 08 Apr 2020 09:09:42 -0700 (PDT)
X-Gm-Message-State: AGi0PuZWjzOFgk8GLOHrLcNQe2AAJlIQphOSSs4g+x93BBZ/sb7CB2Jn
        0oRGCpAt3UPOxGexA1R4O/tP2ijGaPWxBpilRg==
X-Google-Smtp-Source: APiQypKguSiBz1WDycjJcK/7zfMUMEOKbNsIYCiMlmWJEDxjESIp2hRMSGNObcV5FtbjDF7rs+6Ju+PzFKHvOfilMAI=
X-Received: by 2002:aa7:c544:: with SMTP id s4mr7300400edr.271.1586362178940;
 Wed, 08 Apr 2020 09:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191118104252.228406-1-hsinyi@chromium.org> <CAFqH_528vidMhTFxNZ=b7SFD2K12UwtdX3uTUzW4YUgeDWkg5A@mail.gmail.com>
In-Reply-To: <CAFqH_528vidMhTFxNZ=b7SFD2K12UwtdX3uTUzW4YUgeDWkg5A@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 9 Apr 2020 00:09:27 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8RMboOuKVKPANZ1QN+mt0jvOr13o84VhWKGY1QZqbPDg@mail.gmail.com>
Message-ID: <CAAOTY_8RMboOuKVKPANZ1QN+mt0jvOr13o84VhWKGY1QZqbPDg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8173: Add gce setting in mmsys and display node
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Enric Balletbo Serra <eballetbo@gmail.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=
=888=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:48=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dl., 18 de nov.
> 2019 a les 11:43:
> >
> > In order to use GCE function, we need add some informations
> > into display node (mboxes, mediatek,gce-client-reg, mediatek,gce-events=
).
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> With the fix provided by Hsin-Yi [1] and after the mmsys patches
> landed I get GCE function working on mt8173, so
>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> [1] https://lore.kernel.org/lkml/20200406051131.225748-1-hsinyi@chromium.=
org/
>
> Thanks,
>  Enric
>
> > ---
> > - This is based on series "support gce on mt8183 platform"
> >   https://patchwork.kernel.org/cover/11208309/
> > - gce setting in 8183:
> >   https://patchwork.kernel.org/patch/11127105/
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8173.dtsi
> > index 15f1842f6df3..e84ec3f95d81 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -911,6 +911,11 @@ mmsys: clock-controller@14000000 {
> >                         assigned-clocks =3D <&topckgen CLK_TOP_MM_SEL>;
> >                         assigned-clock-rates =3D <400000000>;
> >                         #clock-cells =3D <1>;
> > +                       mboxes =3D <&gce 0 CMDQ_THR_PRIO_HIGHEST 1>,
> > +                                <&gce 1 CMDQ_THR_PRIO_HIGHEST 1>;

Because of patch [1], atomic_exec parameter should be removed.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20200408&id=3D19d8e335d58a961a7ed377e5e2e63664b92c0b9c

> > +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0 0x1000>;
> > +                       mediatek,gce-events =3D <CMDQ_EVENT_MUTEX0_STRE=
AM_EOF>,
> > +                                             <CMDQ_EVENT_MUTEX1_STREAM=
_EOF>;

Because of patch [2], these events should be moved to mutex node.

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?h=3Dv5.6&id=3D60fa8c13ab1a33b8b958efb1510ec2fd8a064bcc

Regards,
Chun-Kuang.

> >                 };
> >
> >                 mdp_rdma0: rdma@14001000 {
> > @@ -991,6 +996,7 @@ ovl0: ovl@1400c000 {
> >                         clocks =3D <&mmsys CLK_MM_DISP_OVL0>;
> >                         iommus =3D <&iommu M4U_PORT_DISP_OVL0>;
> >                         mediatek,larb =3D <&larb0>;
> > +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0xc000 0x1000>;
> >                 };
> >
> >                 ovl1: ovl@1400d000 {
> > @@ -1001,6 +1007,7 @@ ovl1: ovl@1400d000 {
> >                         clocks =3D <&mmsys CLK_MM_DISP_OVL1>;
> >                         iommus =3D <&iommu M4U_PORT_DISP_OVL1>;
> >                         mediatek,larb =3D <&larb4>;
> > +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0xd000 0x1000>;
> >                 };
> >
> >                 rdma0: rdma@1400e000 {
> > @@ -1011,6 +1018,7 @@ rdma0: rdma@1400e000 {
> >                         clocks =3D <&mmsys CLK_MM_DISP_RDMA0>;
> >                         iommus =3D <&iommu M4U_PORT_DISP_RDMA0>;
> >                         mediatek,larb =3D <&larb0>;
> > +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0xe000 0x1000>;
> >                 };
> >
> >                 rdma1: rdma@1400f000 {
> > @@ -1021,6 +1029,7 @@ rdma1: rdma@1400f000 {
> >                         clocks =3D <&mmsys CLK_MM_DISP_RDMA1>;
> >                         iommus =3D <&iommu M4U_PORT_DISP_RDMA1>;
> >                         mediatek,larb =3D <&larb4>;
> > +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1400XX=
XX 0xf000 0x1000>;
> >                 };
> >
> >                 rdma2: rdma@14010000 {
> > @@ -1031,6 +1040,7 @@ rdma2: rdma@14010000 {
> >                         clocks =3D <&mmsys CLK_MM_DISP_RDMA2>;
> >                         iommus =3D <&iommu M4U_PORT_DISP_RDMA2>;
> >                         mediatek,larb =3D <&larb4>;
> > +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XX=
XX 0 0x1000>;
> >                 };
> >
> >                 wdma0: wdma@14011000 {
> > @@ -1041,6 +1051,7 @@ wdma0: wdma@14011000 {
> >                         clocks =3D <&mmsys CLK_MM_DISP_WDMA0>;
> >                         iommus =3D <&iommu M4U_PORT_DISP_WDMA0>;
> >                         mediatek,larb =3D <&larb0>;
> > +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XX=
XX 0x1000 0x1000>;
> >                 };
> >
> >                 wdma1: wdma@14012000 {
> > @@ -1051,6 +1062,7 @@ wdma1: wdma@14012000 {
> >                         clocks =3D <&mmsys CLK_MM_DISP_WDMA1>;
> >                         iommus =3D <&iommu M4U_PORT_DISP_WDMA1>;
> >                         mediatek,larb =3D <&larb4>;
> > +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XX=
XX 0x2000 0x1000>;
> >                 };
> >
> >                 color0: color@14013000 {
> > @@ -1059,6 +1071,7 @@ color0: color@14013000 {
> >                         interrupts =3D <GIC_SPI 187 IRQ_TYPE_LEVEL_LOW>=
;
> >                         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_=
MM>;
> >                         clocks =3D <&mmsys CLK_MM_DISP_COLOR0>;
> > +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XX=
XX 0x3000 0x1000>;
> >                 };
> >
> >                 color1: color@14014000 {
> > @@ -1067,6 +1080,7 @@ color1: color@14014000 {
> >                         interrupts =3D <GIC_SPI 188 IRQ_TYPE_LEVEL_LOW>=
;
> >                         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_=
MM>;
> >                         clocks =3D <&mmsys CLK_MM_DISP_COLOR1>;
> > +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XX=
XX 0x4000 0x1000>;
> >                 };
> >
> >                 aal@14015000 {
> > @@ -1075,6 +1089,7 @@ aal@14015000 {
> >                         interrupts =3D <GIC_SPI 189 IRQ_TYPE_LEVEL_LOW>=
;
> >                         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_=
MM>;
> >                         clocks =3D <&mmsys CLK_MM_DISP_AAL>;
> > +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XX=
XX 0x5000 0x1000>;
> >                 };
> >
> >                 gamma@14016000 {
> > @@ -1083,6 +1098,7 @@ gamma@14016000 {
> >                         interrupts =3D <GIC_SPI 190 IRQ_TYPE_LEVEL_LOW>=
;
> >                         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_=
MM>;
> >                         clocks =3D <&mmsys CLK_MM_DISP_GAMMA>;
> > +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XX=
XX 0x6000 0x1000>;
> >                 };
> >
> >                 merge@14017000 {
> > --
> > 2.24.0.432.g9d3f5f5b63-goog
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
