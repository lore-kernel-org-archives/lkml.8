Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A09C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04EC206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599494134;
	bh=didKp76csgGZimpkMDv9EfwKiNMrmTt45u/TK/QOI+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GF1ZJ8vm16wyzrOXAcGqWsIBtLI1KL4SRozXYDHEf8CIa52kTc/o0DUvUS4gRJZpk
	 p4DQ0wI/hEkkYRpgQG0LP/JoQWNyai9OCryeiJNDtBHW8SBICGzUQ8ZWh977VynJzj
	 c0VMeCqB83wjlEyUiKHfq1ibUmX4ocmiwkSbzkWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgIGPzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730022AbgIGPy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:54:29 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A82B217BA;
        Mon,  7 Sep 2020 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599494063;
        bh=didKp76csgGZimpkMDv9EfwKiNMrmTt45u/TK/QOI+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QEfaPeqrFas+T6JdHzlQBgCY3Jv952GITwUQVDE0V96PM1yXf+bumfe6F2n3NXRfP
         SPl2/VpYxBZjhpr1a4uTBWZ47uKpHk7wsOptyZuj4lyxgS+XGh06/iWaRHJ5xiUzR5
         cF8qNNWVy3nWhyClQkhxl0sSWLLodjLUMowZICWo=
Received: by mail-ej1-f46.google.com with SMTP id j11so18865147ejk.0;
        Mon, 07 Sep 2020 08:54:23 -0700 (PDT)
X-Gm-Message-State: AOAM53368DSexuk9KYM6UtD9z1y9/7pdbBOB+ci5vwHEHbT362zyAF7O
        rQw2meF1A5yhHuWrzUgiMezv5H+dRcK5nrHu9A==
X-Google-Smtp-Source: ABdhPJxXPVlZj3RCi1Y3eSrUHPh+uVwXgw1M0XCT7L9V9jWXHdKH75SPUrkHiLk8+/IgV/XF29v3SA/iwSsSyJlF1WI=
X-Received: by 2002:a17:906:b756:: with SMTP id fx22mr20832412ejb.245.1599494061997;
 Mon, 07 Sep 2020 08:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200907125646.1946282-1-fparent@baylibre.com>
In-Reply-To: <20200907125646.1946282-1-fparent@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 7 Sep 2020 23:54:09 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9HYvxEygv-oz9wf+JjiSfp+Zn1u5okMftz3SncfK0G5A@mail.gmail.com>
Message-ID: <CAAOTY_9HYvxEygv-oz9wf+JjiSfp+Zn1u5okMftz3SncfK0G5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: mediatek: add bindings for MT8167 clocks
To:     Fabien Parent <fparent@baylibre.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        masahiroy@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        mars.cheng@mediatek.com, macpaul.lin@mediatek.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        mtk01761 <wendell.lin@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fabien:

Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add binding documentation for topckgen, apmixedsys, infracfg, audsys,
> imgsys, mfgcfg, mmsys, vdecsys on MT8167 SoC.

Why don't you add compatible of "mediatek,mt8167-mmsys"?

Regards,
Chun-Kuang.

>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../arm/mediatek/mediatek,apmixedsys.txt      |   1 +
>  .../bindings/arm/mediatek/mediatek,audsys.txt |   1 +
>  .../bindings/arm/mediatek/mediatek,imgsys.txt |   1 +
>  .../arm/mediatek/mediatek,infracfg.txt        |   1 +
>  .../bindings/arm/mediatek/mediatek,mfgcfg.txt |   1 +
>  .../arm/mediatek/mediatek,topckgen.txt        |   1 +
>  .../arm/mediatek/mediatek,vdecsys.txt         |   1 +
>  include/dt-bindings/clock/mt8167-clk.h        | 131 ++++++++++++++++++
>  8 files changed, 138 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt8167-clk.h
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmi=
xedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixe=
dsys.txt
> index bd7a0fa5801b..ea827e8763de 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.=
txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.=
txt
> @@ -15,6 +15,7 @@ Required Properties:
>         - "mediatek,mt7623-apmixedsys", "mediatek,mt2701-apmixedsys"
>         - "mediatek,mt7629-apmixedsys"
>         - "mediatek,mt8135-apmixedsys"
> +       - "mediatek,mt8167-apmixedsys", "syscon"
>         - "mediatek,mt8173-apmixedsys"
>         - "mediatek,mt8183-apmixedsys", "syscon"
>         - "mediatek,mt8516-apmixedsys"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,auds=
ys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> index 38309db115f5..b32d374193c7 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> @@ -11,6 +11,7 @@ Required Properties:
>         - "mediatek,mt6779-audio", "syscon"
>         - "mediatek,mt7622-audsys", "syscon"
>         - "mediatek,mt7623-audsys", "mediatek,mt2701-audsys", "syscon"
> +       - "mediatek,mt8167-audiosys", "syscon"
>         - "mediatek,mt8183-audiosys", "syscon"
>         - "mediatek,mt8516-audsys", "syscon"
>  - #clock-cells: Must be 1
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgs=
ys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
> index 1e1f00718a7d..dce4c9241932 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
> @@ -12,6 +12,7 @@ Required Properties:
>         - "mediatek,mt6779-imgsys", "syscon"
>         - "mediatek,mt6797-imgsys", "syscon"
>         - "mediatek,mt7623-imgsys", "mediatek,mt2701-imgsys", "syscon"
> +       - "mediatek,mt8167-imgsys", "syscon"
>         - "mediatek,mt8173-imgsys", "syscon"
>         - "mediatek,mt8183-imgsys", "syscon"
>  - #clock-cells: Must be 1
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infr=
acfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg=
.txt
> index 49a968be1a80..eb3523c7a7be 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.tx=
t
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.tx=
t
> @@ -16,6 +16,7 @@ Required Properties:
>         - "mediatek,mt7623-infracfg", "mediatek,mt2701-infracfg", "syscon=
"
>         - "mediatek,mt7629-infracfg", "syscon"
>         - "mediatek,mt8135-infracfg", "syscon"
> +       - "mediatek,mt8167-infracfg", "syscon"
>         - "mediatek,mt8173-infracfg", "syscon"
>         - "mediatek,mt8183-infracfg", "syscon"
>         - "mediatek,mt8516-infracfg", "syscon"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgc=
fg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
> index ad5f9d2f6818..054424fb64b4 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
> @@ -8,6 +8,7 @@ Required Properties:
>  - compatible: Should be one of:
>         - "mediatek,mt2712-mfgcfg", "syscon"
>         - "mediatek,mt6779-mfgcfg", "syscon"
> +       - "mediatek,mt8167-mfgcfg", "syscon"
>         - "mediatek,mt8183-mfgcfg", "syscon"
>  - #clock-cells: Must be 1
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topc=
kgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen=
.txt
> index 9b0394cbbdc9..5ce7578cf274 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.tx=
t
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.tx=
t
> @@ -15,6 +15,7 @@ Required Properties:
>         - "mediatek,mt7623-topckgen", "mediatek,mt2701-topckgen"
>         - "mediatek,mt7629-topckgen"
>         - "mediatek,mt8135-topckgen"
> +       - "mediatek,mt8167-topckgen", "syscon"
>         - "mediatek,mt8173-topckgen"
>         - "mediatek,mt8183-topckgen", "syscon"
>         - "mediatek,mt8516-topckgen"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdec=
sys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.t=
xt
> index 7894558b7a1c..98195169176a 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
> @@ -11,6 +11,7 @@ Required Properties:
>         - "mediatek,mt6779-vdecsys", "syscon"
>         - "mediatek,mt6797-vdecsys", "syscon"
>         - "mediatek,mt7623-vdecsys", "mediatek,mt2701-vdecsys", "syscon"
> +       - "mediatek,mt8167-vdecsys", "syscon"
>         - "mediatek,mt8173-vdecsys", "syscon"
>         - "mediatek,mt8183-vdecsys", "syscon"
>  - #clock-cells: Must be 1
> diff --git a/include/dt-bindings/clock/mt8167-clk.h b/include/dt-bindings=
/clock/mt8167-clk.h
> new file mode 100644
> index 000000000000..a96158edd817
> --- /dev/null
> +++ b/include/dt-bindings/clock/mt8167-clk.h
> @@ -0,0 +1,131 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + * Copyright (c) 2020 BayLibre, SAS.
> + * Author: James Liao <jamesjj.liao@mediatek.com>
> + *         Fabien Parent <fparent@baylibre.com>
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_MT8167_H
> +#define _DT_BINDINGS_CLK_MT8167_H
> +
> +/* MT8167 is based on MT8516 */
> +#include <dt-bindings/clock/mt8516-clk.h>
> +
> +/* APMIXEDSYS */
> +
> +#define CLK_APMIXED_TVDPLL             (CLK_APMIXED_NR_CLK + 0)
> +#define CLK_APMIXED_LVDSPLL            (CLK_APMIXED_NR_CLK + 1)
> +#define CLK_APMIXED_HDMI_REF           (CLK_APMIXED_NR_CLK + 2)
> +#define MT8167_CLK_APMIXED_NR_CLK      (CLK_APMIXED_NR_CLK + 3)
> +
> +/* TOPCKGEN */
> +
> +#define CLK_TOP_DSI0_LNTC_DSICK                (CLK_TOP_NR_CLK + 0)
> +#define CLK_TOP_VPLL_DPIX              (CLK_TOP_NR_CLK + 1)
> +#define CLK_TOP_LVDSTX_CLKDIG_CTS      (CLK_TOP_NR_CLK + 2)
> +#define CLK_TOP_HDMTX_CLKDIG_CTS       (CLK_TOP_NR_CLK + 3)
> +#define CLK_TOP_LVDSPLL                        (CLK_TOP_NR_CLK + 4)
> +#define CLK_TOP_LVDSPLL_D2             (CLK_TOP_NR_CLK + 5)
> +#define CLK_TOP_LVDSPLL_D4             (CLK_TOP_NR_CLK + 6)
> +#define CLK_TOP_LVDSPLL_D8             (CLK_TOP_NR_CLK + 7)
> +#define CLK_TOP_MIPI_26M               (CLK_TOP_NR_CLK + 8)
> +#define CLK_TOP_TVDPLL                 (CLK_TOP_NR_CLK + 9)
> +#define CLK_TOP_TVDPLL_D2              (CLK_TOP_NR_CLK + 10)
> +#define CLK_TOP_TVDPLL_D4              (CLK_TOP_NR_CLK + 11)
> +#define CLK_TOP_TVDPLL_D8              (CLK_TOP_NR_CLK + 12)
> +#define CLK_TOP_TVDPLL_D16             (CLK_TOP_NR_CLK + 13)
> +#define CLK_TOP_PWM_MM                 (CLK_TOP_NR_CLK + 14)
> +#define CLK_TOP_CAM_MM                 (CLK_TOP_NR_CLK + 15)
> +#define CLK_TOP_MFG_MM                 (CLK_TOP_NR_CLK + 16)
> +#define CLK_TOP_SPM_52M                        (CLK_TOP_NR_CLK + 17)
> +#define CLK_TOP_MIPI_26M_DBG           (CLK_TOP_NR_CLK + 18)
> +#define CLK_TOP_SCAM_MM                        (CLK_TOP_NR_CLK + 19)
> +#define CLK_TOP_SMI_MM                 (CLK_TOP_NR_CLK + 20)
> +#define CLK_TOP_26M_HDMI_SIFM          (CLK_TOP_NR_CLK + 21)
> +#define CLK_TOP_26M_CEC                        (CLK_TOP_NR_CLK + 22)
> +#define CLK_TOP_32K_CEC                        (CLK_TOP_NR_CLK + 23)
> +#define CLK_TOP_GCPU_B                 (CLK_TOP_NR_CLK + 24)
> +#define CLK_TOP_RG_VDEC                        (CLK_TOP_NR_CLK + 25)
> +#define CLK_TOP_RG_FDPI0               (CLK_TOP_NR_CLK + 26)
> +#define CLK_TOP_RG_FDPI1               (CLK_TOP_NR_CLK + 27)
> +#define CLK_TOP_RG_AXI_MFG             (CLK_TOP_NR_CLK + 28)
> +#define CLK_TOP_RG_SLOW_MFG            (CLK_TOP_NR_CLK + 29)
> +#define CLK_TOP_GFMUX_EMI1X_SEL                (CLK_TOP_NR_CLK + 30)
> +#define CLK_TOP_CSW_MUX_MFG_SEL                (CLK_TOP_NR_CLK + 31)
> +#define CLK_TOP_CAMTG_MM_SEL           (CLK_TOP_NR_CLK + 32)
> +#define CLK_TOP_PWM_MM_SEL             (CLK_TOP_NR_CLK + 33)
> +#define CLK_TOP_SPM_52M_SEL            (CLK_TOP_NR_CLK + 34)
> +#define CLK_TOP_MFG_MM_SEL             (CLK_TOP_NR_CLK + 35)
> +#define CLK_TOP_SMI_MM_SEL             (CLK_TOP_NR_CLK + 36)
> +#define CLK_TOP_SCAM_MM_SEL            (CLK_TOP_NR_CLK + 37)
> +#define CLK_TOP_VDEC_MM_SEL            (CLK_TOP_NR_CLK + 38)
> +#define CLK_TOP_DPI0_MM_SEL            (CLK_TOP_NR_CLK + 39)
> +#define CLK_TOP_DPI1_MM_SEL            (CLK_TOP_NR_CLK + 40)
> +#define CLK_TOP_AXI_MFG_IN_SEL         (CLK_TOP_NR_CLK + 41)
> +#define CLK_TOP_SLOW_MFG_SEL           (CLK_TOP_NR_CLK + 42)
> +#define MT8167_CLK_TOP_NR_CLK          (CLK_TOP_NR_CLK + 43)
> +
> +/* MFGCFG */
> +
> +#define CLK_MFG_BAXI                   0
> +#define CLK_MFG_BMEM                   1
> +#define CLK_MFG_BG3D                   2
> +#define CLK_MFG_B26M                   3
> +#define CLK_MFG_NR_CLK                 4
> +
> +/* MMSYS */
> +
> +#define CLK_MM_SMI_COMMON              0
> +#define CLK_MM_SMI_LARB0               1
> +#define CLK_MM_CAM_MDP                 2
> +#define CLK_MM_MDP_RDMA                        3
> +#define CLK_MM_MDP_RSZ0                        4
> +#define CLK_MM_MDP_RSZ1                        5
> +#define CLK_MM_MDP_TDSHP               6
> +#define CLK_MM_MDP_WDMA                        7
> +#define CLK_MM_MDP_WROT                        8
> +#define CLK_MM_FAKE_ENG                        9
> +#define CLK_MM_DISP_OVL0               10
> +#define CLK_MM_DISP_RDMA0              11
> +#define CLK_MM_DISP_RDMA1              12
> +#define CLK_MM_DISP_WDMA               13
> +#define CLK_MM_DISP_COLOR              14
> +#define CLK_MM_DISP_CCORR              15
> +#define CLK_MM_DISP_AAL                        16
> +#define CLK_MM_DISP_GAMMA              17
> +#define CLK_MM_DISP_DITHER             18
> +#define CLK_MM_DISP_UFOE               19
> +#define CLK_MM_DISP_PWM_MM             20
> +#define CLK_MM_DISP_PWM_26M            21
> +#define CLK_MM_DSI_ENGINE              22
> +#define CLK_MM_DSI_DIGITAL             23
> +#define CLK_MM_DPI0_ENGINE             24
> +#define CLK_MM_DPI0_PXL                        25
> +#define CLK_MM_LVDS_PXL                        26
> +#define CLK_MM_LVDS_CTS                        27
> +#define CLK_MM_DPI1_ENGINE             28
> +#define CLK_MM_DPI1_PXL                        29
> +#define CLK_MM_HDMI_PXL                        30
> +#define CLK_MM_HDMI_SPDIF              31
> +#define CLK_MM_HDMI_ADSP_BCK           32
> +#define CLK_MM_HDMI_PLL                        33
> +#define CLK_MM_NR_CLK                  34
> +
> +/* IMGSYS */
> +
> +#define CLK_IMG_LARB1_SMI              0
> +#define CLK_IMG_CAM_SMI                        1
> +#define CLK_IMG_CAM_CAM                        2
> +#define CLK_IMG_SEN_TG                 3
> +#define CLK_IMG_SEN_CAM                        4
> +#define CLK_IMG_VENC                   5
> +#define CLK_IMG_NR_CLK                 6
> +
> +/* VDECSYS */
> +
> +#define CLK_VDEC_CKEN                  0
> +#define CLK_VDEC_LARB1_CKEN            1
> +#define CLK_VDEC_NR_CLK                        2
> +
> +#endif /* _DT_BINDINGS_CLK_MT8167_H */
> --
> 2.28.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
