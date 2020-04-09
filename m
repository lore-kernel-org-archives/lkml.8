Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801C2C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FC920768
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586448527;
	bh=TOT/Mzl4w6vmAGDWGhPKnT+4PELnslGlsvCk7rJDnzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qLvUB0IVhxEGacidFon5c6f/AJZfEtFQtaTYIv3UNlO4BkJPYV31E7RXNwNGfPMXW
	 opmFOuuxh9sdBrfW4pGxKn2rJF81dXqi5Sp+/2+9w108DpJaiaws+IVuS371o31ri4
	 uEJ8l4d+PtBecpuD9iSLINm04Ww85Cj0xA3rhkC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgDIQIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgDIQIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:08:45 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89005208E4;
        Thu,  9 Apr 2020 16:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586448524;
        bh=TOT/Mzl4w6vmAGDWGhPKnT+4PELnslGlsvCk7rJDnzE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QBCvXXzoS+RU5UsWnBtsz4E4MHaY7nxvY8jMC6PtPJDpKW+PMVeNy0aQXSDKAgnUG
         x47OnmsO1Z7aE5yw/d7znpeDhpvchrKN/hovaCz1pApHeVqW6NHRWJ+Lx5Lfv5TAqF
         6+vK3kpheyU/Hmnx2V9Iat4G9BejPoZa8i9/KPNM=
Received: by mail-ed1-f51.google.com with SMTP id v1so390189edq.8;
        Thu, 09 Apr 2020 09:08:44 -0700 (PDT)
X-Gm-Message-State: AGi0Puak/YBQ2T/Mn83onKVPAXM2xtu9GCwBeKSpmBua+OkemOTlMqw/
        D52nB8mY+V1TrKiZBj/L+g5VhlJR0mmv2aC7MA==
X-Google-Smtp-Source: APiQypI+MGlIlAQIPn+88qW5Z3iOShPT8da+gGggfEYATb3irxEdImO6ejY5HXdb4Cdf8Lc+YiDb+ROl/NqElrYEHCo=
X-Received: by 2002:a05:6402:b70:: with SMTP id cb16mr741631edb.48.1586448522950;
 Thu, 09 Apr 2020 09:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200409055012.199320-1-hsinyi@chromium.org>
In-Reply-To: <20200409055012.199320-1-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 10 Apr 2020 00:08:31 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8fOHW7cm_mPGY9J1DL6xnY76+cRmbBEBmuZLWeRe9dFg@mail.gmail.com>
Message-ID: <CAAOTY_8fOHW7cm_mPGY9J1DL6xnY76+cRmbBEBmuZLWeRe9dFg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: mt8173: Add gce setting in mmsys and
 display node
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2020=E5=B9=B44=E6=9C=889=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> In order to use GCE function, we need add some informations
> into display node (mboxes, mediatek,gce-client-reg, mediatek,gce-events).
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
> change log:
> v1->v2: align with
> 19d8e335d58a ("dt-binding: gce: remove atomic_exec in mboxes property")
> 60fa8c13ab1a ("drm/mediatek: Move gce event property to mutex device node=
")
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8173.dtsi
> index ccb8e88a60c5..8337ba42845d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -549,7 +549,7 @@ gce: mailbox@10212000 {
>                         interrupts =3D <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
>                         clocks =3D <&infracfg CLK_INFRA_GCE>;
>                         clock-names =3D "gce";
> -                       #mbox-cells =3D <3>;
> +                       #mbox-cells =3D <2>;
>                 };
>
>                 mipi_tx0: mipi-dphy@10215000 {
> @@ -916,6 +916,9 @@ mmsys: clock-controller@14000000 {
>                         assigned-clocks =3D <&topckgen CLK_TOP_MM_SEL>;
>                         assigned-clock-rates =3D <400000000>;
>                         #clock-cells =3D <1>;
> +                       mboxes =3D <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
> +                                <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX=
 0 0x1000>;
>                 };
>
>                 mdp_rdma0: rdma@14001000 {
> @@ -996,6 +999,7 @@ ovl0: ovl@1400c000 {
>                         clocks =3D <&mmsys CLK_MM_DISP_OVL0>;
>                         iommus =3D <&iommu M4U_PORT_DISP_OVL0>;
>                         mediatek,larb =3D <&larb0>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX=
 0xc000 0x1000>;
>                 };
>
>                 ovl1: ovl@1400d000 {
> @@ -1006,6 +1010,7 @@ ovl1: ovl@1400d000 {
>                         clocks =3D <&mmsys CLK_MM_DISP_OVL1>;
>                         iommus =3D <&iommu M4U_PORT_DISP_OVL1>;
>                         mediatek,larb =3D <&larb4>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX=
 0xd000 0x1000>;
>                 };
>
>                 rdma0: rdma@1400e000 {
> @@ -1016,6 +1021,7 @@ rdma0: rdma@1400e000 {
>                         clocks =3D <&mmsys CLK_MM_DISP_RDMA0>;
>                         iommus =3D <&iommu M4U_PORT_DISP_RDMA0>;
>                         mediatek,larb =3D <&larb0>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX=
 0xe000 0x1000>;
>                 };
>
>                 rdma1: rdma@1400f000 {
> @@ -1026,6 +1032,7 @@ rdma1: rdma@1400f000 {
>                         clocks =3D <&mmsys CLK_MM_DISP_RDMA1>;
>                         iommus =3D <&iommu M4U_PORT_DISP_RDMA1>;
>                         mediatek,larb =3D <&larb4>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX=
 0xf000 0x1000>;
>                 };
>
>                 rdma2: rdma@14010000 {
> @@ -1036,6 +1043,7 @@ rdma2: rdma@14010000 {
>                         clocks =3D <&mmsys CLK_MM_DISP_RDMA2>;
>                         iommus =3D <&iommu M4U_PORT_DISP_RDMA2>;
>                         mediatek,larb =3D <&larb4>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX=
 0 0x1000>;
>                 };
>
>                 wdma0: wdma@14011000 {
> @@ -1046,6 +1054,7 @@ wdma0: wdma@14011000 {
>                         clocks =3D <&mmsys CLK_MM_DISP_WDMA0>;
>                         iommus =3D <&iommu M4U_PORT_DISP_WDMA0>;
>                         mediatek,larb =3D <&larb0>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX=
 0x1000 0x1000>;
>                 };
>
>                 wdma1: wdma@14012000 {
> @@ -1056,6 +1065,7 @@ wdma1: wdma@14012000 {
>                         clocks =3D <&mmsys CLK_MM_DISP_WDMA1>;
>                         iommus =3D <&iommu M4U_PORT_DISP_WDMA1>;
>                         mediatek,larb =3D <&larb4>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX=
 0x2000 0x1000>;
>                 };
>
>                 color0: color@14013000 {
> @@ -1064,6 +1074,7 @@ color0: color@14013000 {
>                         interrupts =3D <GIC_SPI 187 IRQ_TYPE_LEVEL_LOW>;
>                         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM=
>;
>                         clocks =3D <&mmsys CLK_MM_DISP_COLOR0>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX=
 0x3000 0x1000>;
>                 };
>
>                 color1: color@14014000 {
> @@ -1072,6 +1083,7 @@ color1: color@14014000 {
>                         interrupts =3D <GIC_SPI 188 IRQ_TYPE_LEVEL_LOW>;
>                         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM=
>;
>                         clocks =3D <&mmsys CLK_MM_DISP_COLOR1>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX=
 0x4000 0x1000>;
>                 };
>
>                 aal@14015000 {
> @@ -1080,6 +1092,7 @@ aal@14015000 {
>                         interrupts =3D <GIC_SPI 189 IRQ_TYPE_LEVEL_LOW>;
>                         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM=
>;
>                         clocks =3D <&mmsys CLK_MM_DISP_AAL>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX=
 0x5000 0x1000>;
>                 };
>
>                 gamma@14016000 {
> @@ -1088,6 +1101,7 @@ gamma@14016000 {
>                         interrupts =3D <GIC_SPI 190 IRQ_TYPE_LEVEL_LOW>;
>                         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM=
>;
>                         clocks =3D <&mmsys CLK_MM_DISP_GAMMA>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX=
 0x6000 0x1000>;
>                 };
>
>                 merge@14017000 {
> @@ -1193,6 +1207,8 @@ mutex: mutex@14020000 {
>                         interrupts =3D <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
>                         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM=
>;
>                         clocks =3D <&mmsys CLK_MM_MUTEX_32K>;
> +                       mediatek,gce-events =3D <CMDQ_EVENT_MUTEX0_STREAM=
_EOF>,
> +                                              <CMDQ_EVENT_MUTEX1_STREAM_=
EOF>;
>                 };
>
>                 larb0: larb@14021000 {
> --
> 2.26.0.292.g33ef6b2f38-goog
>
