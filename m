Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA26C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35BDC20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586968263;
	bh=WUC8Bsx6n4kPP/2IvmXcJuk2IZsO1uij3Y2K4ebkwag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UlscGlUQGVAr1k6udOOxF/bxCxp3cmXxPJm7UnbxZIUZ+e4GRtERSdrOE8D0GD/AM
	 M4uMnGZnaM7K8ITEyNYlFoypebsdIqDqclqJQJVYA2Vsm61DfRHmNNrfpvE6KPsUjk
	 qWX2uUWe4Jpvs4fXV9wyKO/YOpX+XsVUDCjPb7Kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416069AbgDOQbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415869AbgDOQaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:30:52 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9308A20737;
        Wed, 15 Apr 2020 16:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586968250;
        bh=WUC8Bsx6n4kPP/2IvmXcJuk2IZsO1uij3Y2K4ebkwag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VSNg3Z3X30deKJh7htdB+FeC2GCn1KVh6gkkB9WpXoQrnElTk8ipYlfjjk3bHKc64
         fwTsNSSb6+YhX8ws7uAdURtfuValrmgvx2/fWYgaIRgmpEwNPob79V4rypL1I5uFDy
         qG9ZUregTlRKGEuRyu8SkEx4IS/+s0uS8uLS/V3g=
Received: by mail-ed1-f53.google.com with SMTP id i7so5730740edq.3;
        Wed, 15 Apr 2020 09:30:50 -0700 (PDT)
X-Gm-Message-State: AGi0PuahOdW0blAKtK2u29AqYWh22TxOwOxh+myWOM812B5Q8548FR7U
        0oQf3ZRhjTGMpx7cwSBB4EGGScJ8zEVUX3LqNw==
X-Google-Smtp-Source: APiQypLfzJMiKrjaHEhydOXdTWRa66BOG1MrE7lZ2rSnRI+v5Qgh7UJQS5J8mNuhBAJkynBr6SvIvV6gJxqWvKUSWUc=
X-Received: by 2002:a17:906:124f:: with SMTP id u15mr5582102eja.360.1586968247593;
 Wed, 15 Apr 2020 09:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <1586949506-22990-1-git-send-email-anthony.huang@mediatek.com> <1586949506-22990-2-git-send-email-anthony.huang@mediatek.com>
In-Reply-To: <1586949506-22990-2-git-send-email-anthony.huang@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 16 Apr 2020 00:30:35 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8VbgUtzCTv7NpCkZ0qVx4aXmX6ZWa_QA0Ph2JGx2GTfA@mail.gmail.com>
Message-ID: <CAAOTY_8VbgUtzCTv7NpCkZ0qVx4aXmX6ZWa_QA0Ph2JGx2GTfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: mediatek: Add document for mmdvfs driver
To:     Anthony Huang <anthony.huang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Anthony:

Anthony Huang <anthony.huang@mediatek.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=
=8815=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:19=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This document describes the properties what mtk mmdvfs
> device node support.
>
> Signed-off-by: Anthony Huang <anthony.huang@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mmdvfs.yaml   |  198 ++++++++++++++=
++++++
>  1 file changed, 198 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mmdvfs=
.yaml
>
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mmdvfs.yaml b=
/Documentation/devicetree/bindings/soc/mediatek/mmdvfs.yaml
> new file mode 100644
> index 0000000..9ef1833
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mmdvfs.yaml
> @@ -0,0 +1,198 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/mediatek/mmdvfs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MMDVFS driver binding
> +
> +maintainers:
> +  - Rob Herring <robh+dt@kernel.org>
> +  - Mark Rutland <mark.rutland@arm.com>
> +
> +description: |
> +  The Mediatek MMDVFS(Multimedia Dynamic Voltage and Frequency Scaling) =
driver
> +  is used to set clk for Mediatek multimedia hardwares, such as display,
> +  camera, mdp and video codec. MMDVFS driver reads which clock muxes and=
 clock
> +  sources are used on this platform from DTS, and sets current clock acc=
ording
> +  to current voltage informed by regulator callback.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mmdvfs
> +
> +  operating-points-v2:
> +    description:
> +      Contains any one of opp tables for multimedia modules.
> +      MMDVFS uses it to get voltage setting on this platform.
> +
> +  mediatek,support_mux:
> +    description: A list of clock mux names defined in clock-names.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/string-array
> +
> +  clocks:
> +    description:
> +      A list of phandles of clock muxes and clock sources for
> +      multimedia hardwares.
> +
> +  clock-names:
> +    description:
> +      A list of name strings of clock muxes and clock sources for
> +      multimedia hardwares.
> +
> +  # If the platform needs frequency hopping for some clock sources, thes=
e
> +  # following properties should be set.
> +
> +  mediatek,support_hopping:
> +    description: a list of clock names supporting frequency hopping.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/string-array
> +
> +  mediatek,action:
> +    description:
> +      A cell with one entry.
> +      It represents the action taken when setting clocks.
> +      0 means not setting frequency hopping and just set clock mux.
> +      1 means setting frequency hopping first if the voltage is increasi=
ng, but
> +      setting clock mux first if the voltage is decreasing.
> +    allOf:
> +      - $ref: "/schemas/types.yaml#/definitions/uint32"
> +      - enum: [0, 1]
> +    maxItems: 1
> +
> +patternProperties:
> +  "^mediatek,mux_+$":
> +    description:
> +      A series of properties with "mediatek,mux_" prefix.
> +      Each property represents one clock mux, and its value is a list of=
 all
> +      the clock sources for it. The postfix and every item in the proper=
ty
> +      must be from the clock-names.
> +
> +  "^mediatek,hopping_+$":
> +    description:
> +      A cell with the same size as opp numbers of an opp table for any M=
M module
> +      and each entry represents the clock rate for each opp. For example=
, the
> +      first entry is the clock rate set in opp-0, and the second entry i=
s the
> +      clock rate set in opp-1.
> +
> +required:
> +  - compatible
> +  - operating-points-v2
> +  - mediatek,support_mux
> +  - clock
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt6779-clk.h>
> +
> +    opp_table_mm: opp-table-mm {
> +        compatible =3D "operating-points-v2";
> +
> +        opp-0 {
> +            opp-hz =3D /bits/ 64 <315000000>;
> +            opp-microvolt =3D <650000>;
> +        };
> +        opp-1 {
> +            opp-hz =3D /bits/ 64 <450000000>;
> +            opp-microvolt =3D <725000>;
> +        };
> +        opp-2 {
> +            opp-hz =3D /bits/ 64 <606000000>;
> +            opp-microvolt =3D <825000>;
> +        };
> +    };
> +
> +    opp_table_cam: opp-table-cam {
> +        compatible =3D "operating-points-v2";
> +
> +        opp-0 {
> +            opp-hz =3D /bits/ 64 <315000000>;
> +            opp-microvolt =3D <650000>;
> +        };
> +        opp-1 {
> +            opp-hz =3D /bits/ 64 <416000000>;
> +            opp-microvolt =3D <725000>;
> +        };
> +        opp-2 {
> +            opp-hz =3D /bits/ 64 <560000000>;
> +            opp-microvolt =3D <825000>;
> +        };
> +    };
> +
> +    /* Other opp tables for multimedia modules */
> +
> +    mmdvfs {
> +        compatible =3D "mediatek,mmdvfs";
> +
> +        operating-points-v2 =3D <&opp_table_mm>;
> +
> +        mediatek,support_mux =3D "mm", "cam", "img", "ipe",
> +            "venc", "vdec", "dpe", "ccu";
> +
> +        mediatek,mux_mm =3D "clk_mmpll_d5_d2",
> +            "clk_mmpll_d7", "clk_tvdpll_mainpll_d2_ck";
> +        mediatek,mux_cam =3D "clk_mmpll_d5_d2",
> +            "clk_univpll_d3", "clk_adsppll_d5";
> +        mediatek,mux_img =3D "clk_mmpll_d5_d2",
> +            "clk_univpll_d3", "clk_tvdpll_mainpll_d2_ck";
> +        mediatek,mux_ipe =3D "clk_mmpll_d5_d2",
> +            "clk_univpll_d3", "clk_mainpll_d2";
> +        mediatek,mux_venc =3D "clk_mainpll_d3",
> +            "clk_mmpll_d7", "clk_mmpll_d5";
> +        mediatek,mux_vdec =3D "clk_univpll_d2_d2",
> +            "clk_univpll_d3", "clk_univpll_d2";
> +        mediatek,mux_dpe =3D "clk_mainpll_d3",
> +            "clk_mmpll_d7", "clk_mainpll_d2";
> +        mediatek,mux_ccu =3D "clk_mmpll_d5_d2",
> +            "clk_univpll_d3", "clk_adsppll_d5";
> +
> +        mediatek,support_hopping =3D "clk_mmpll_ck";
> +        mediatek,hopping_clk_mmpll_ck =3D <630000000 630000000 650000000=
>;
> +        mediatek,action =3D <1>;
> +
> +
> +        clocks =3D <&topckgen CLK_TOP_MM>,
> +                <&topckgen CLK_TOP_CAM>,
> +                <&topckgen CLK_TOP_IMG>,
> +                <&topckgen CLK_TOP_IPE>,
> +                <&topckgen CLK_TOP_VENC>,
> +                <&topckgen CLK_TOP_VDEC>,
> +                <&topckgen CLK_TOP_DPE>,
> +                <&topckgen CLK_TOP_CCU>,
> +                <&topckgen CLK_TOP_MMPLL_D5>,
> +                <&topckgen CLK_TOP_UNIVPLL_D2>,
> +                <&topckgen CLK_TOP_TVDPLL_MAINPLL_D2_CK>,
> +                <&topckgen CLK_TOP_ADSPPLL_D5>,
> +                <&topckgen CLK_TOP_MAINPLL_D2>,
> +                <&topckgen CLK_TOP_MMPLL_D6>,
> +                <&topckgen CLK_TOP_MMPLL_D7>,
> +                <&topckgen CLK_TOP_UNIVPLL_D3>,
> +                <&topckgen CLK_TOP_MAINPLL_D3>,
> +                <&topckgen CLK_TOP_MMPLL_D5_D2>,
> +                <&topckgen CLK_TOP_UNIVPLL_D2_D2>,
> +                <&topckgen CLK_TOP_MMPLL_CK>;
> +        clock-names =3D "mm",
> +                "cam",
> +                "img",
> +                "ipe",
> +                "venc",
> +                "vdec",
> +                "dpe",
> +                "ccu",
> +                "clk_mmpll_d5",
> +                "clk_univpll_d2",
> +                "clk_tvdpll_mainpll_d2_ck",
> +                "clk_adsppll_d5",
> +                "clk_mainpll_d2",
> +                "clk_mmpll_d6",
> +                "clk_mmpll_d7",
> +                "clk_univpll_d3",
> +                "clk_mainpll_d3",
> +                "clk_mmpll_d5_d2",
> +                "clk_univpll_d2_d2",
> +                "clk_mmpll_ck";
> +    };

We do not like a virtual device which does not map to a real hardware
because device tree is used to describe hardware. All mmdvfs driver do
is to controll the clock, so I think you should move the driver into
drivers/clk/mediatek, move opp_table into driver, and forget anything
in device tree.

Regards,
Chun-Kuang.

> +...
> --
> 1.7.9.5
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
