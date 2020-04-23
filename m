Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFFFC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D971820781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3MX+cfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgDWSU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbgDWSU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:20:26 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B73C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:20:24 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w29so5689009qtv.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cT5ATBuUiTdXH82UTD5odx305gB5xjb75K740f5eMPs=;
        b=o3MX+cfGQ8qSY+2N9+UlkZSOhS2dfjgCFVabO/QNwiXpnSSc9WWra2U9f2xEQUYcUc
         IHf0TCV0P8QFI5hz9/HaRUyHi8SjisWGLTQkBzgmDGIuS75gOsTzp8NcpFWwsYZr7L3E
         G+m0fY2La0uEHOQIqhlpDYpoIua0wNUtrc3aH00DEPsmPVoEriDd+q5nUW99DZY11hTc
         VGk3Zi68G48DUwTPkthkbeobo9Ky+iYCf/3DSPXtNgB2mwV07DfgMqcex4dz2CtaOTDO
         Pcu5LuRrWoRuRk9VUL6Ll+fajn8HdU2bU6ly87taZYPa1mRK2ZIbnb1L3nd6Rrte3tLx
         OKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cT5ATBuUiTdXH82UTD5odx305gB5xjb75K740f5eMPs=;
        b=tnPTkWrjZpOetYh6Tc5o8HRfkTSnyZboYYBirZv9cKE6/c4i2Sd/M5VINCp5aEIy8K
         eqW6PGJfHZGaOP1gwCNNPo8GeBvThQPfES1XUVeEx06HegP2v4XJzmMta3MFuGxFdICW
         npop8GVCLH780AqKClSLb0bDC/1xbRugAheGkbvIErzcvFhmyCnTp2/XlaFARAni9bAu
         TavOx9Lz5RLhxQQgxvfK0pG1J0vJpW2SAIt7J+BMDC0tyCGWhFGHMPFnUBRUL5aMQzSq
         z1wewG00/M/cDGT0pwYefLapRoUoaKJ/xSxIqnnE0GPLgNg1d5tN1+igaD9XfnSxA05M
         ckQw==
X-Gm-Message-State: AGi0PuaCxxtkuUCr99oolGJHkP6zMnrPzL5NIA3TjRtKLSYJvIPsLx4G
        01SY03iu4UcNuAZkxkg8GQkDi+GoxdbZfiWr4ME=
X-Google-Smtp-Source: APiQypLQ+A5G+am3KfrM/gyUvuSvnsHkNi9N1yvzsrOeq9ZksxmdWo6aDMZE9VUwTHe86G4UpkAKY7Gw2tqumq4Ti/c=
X-Received: by 2002:ac8:7681:: with SMTP id g1mr5259933qtr.311.1587666023963;
 Thu, 23 Apr 2020 11:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com> <1584689540-5227-3-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1584689540-5227-3-git-send-email-weiyi.lu@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 23 Apr 2020 20:20:12 +0200
Message-ID: <CAFqH_523KpaCwhhHDKVCKaJgJUPc+7r03f6U=1XiNNQ1PaNN5w@mail.gmail.com>
Subject: Re: [PATCH v13 02/11] dt-bindings: soc: Add MT8183 power dt-bindings
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiyi Lu,

Thank you for the patch. Just a trivial comment below.

Missatge de Weiyi Lu <weiyi.lu@mediatek.com> del dia dv., 20 de mar=C3=A7
2020 a les 8:33:
>
> Add power dt-bindings of MT8183 and introduces "BASIC" and
> "SUBSYS" clock types in binding document.
> The "BASIC" type is compatible to the original power control with
> clock name [a-z]+[0-9]*, e.g. mm, vpu1.
> The "SUBSYS" type is used for bus protection control with clock
> name [a-z]+-[0-9]+, e.g. isp-0, cam-1.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 20 ++++++++++++++--=
-
>  include/dt-bindings/power/mt8183-power.h           | 26 ++++++++++++++++=
++++++
>  2 files changed, 43 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/power/mt8183-power.h
>
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/=
Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> index 2bc3677..1baaa6f 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> @@ -15,6 +15,7 @@ power/power-domain.yaml. It provides the power domains =
defined in
>  - include/dt-bindings/power/mt2701-power.h
>  - include/dt-bindings/power/mt2712-power.h
>  - include/dt-bindings/power/mt7622-power.h
> +- include/dt-bindings/power/mt8183-power.h
>
>  Required properties:
>  - compatible: Should be one of:
> @@ -27,12 +28,16 @@ Required properties:
>         - "mediatek,mt7623a-scpsys": For MT7623A SoC
>         - "mediatek,mt7629-scpsys", "mediatek,mt7622-scpsys": For MT7629 =
SoC
>         - "mediatek,mt8173-scpsys"
> +       - "mediatek,mt8183-scpsys"
>  - #power-domain-cells: Must be 1
>  - reg: Address range of the SCPSYS unit
>  - infracfg: must contain a phandle to the infracfg controller
> -- clock, clock-names: clocks according to the common clock binding.
> -                      These are clocks which hardware needs to be
> -                      enabled before enabling certain power domains.
> +- clock, clock-names: Clocks according to the common clock binding.
> +                      Some SoCs have to groups of clocks.
> +                      BASIC clocks need to be enabled before enabling th=
e
> +                      corresponding power domain.
> +                      SUBSYS clocks need to be enabled before releasing =
the
> +                      bus protection.
>         Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
>         Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio=
", "vdec"
>         Required clocks for MT6765: MUX: "mm", "mfg"
> @@ -43,6 +48,15 @@ Required properties:
>         Required clocks for MT7622 or MT7629: "hif_sel"
>         Required clocks for MT7623A: "ethif"
>         Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
> +       Required clocks for MT8183: BASIC: "audio", "mfg", "mm", "cam", "=
isp",
> +                                          "vpu", "vpu1", "vpu2", "vpu3"
> +                                   SUBSYS: "mm-0", "mm-1", "mm-2", "mm-3=
",
> +                                           "mm-4", "mm-5", "mm-6", "mm-7=
",
> +                                           "mm-8", "mm-9", "isp-0", "isp=
-1",
> +                                           "cam-0", "cam-1", "cam-2", "c=
am-3",
> +                                           "cam-4", "cam-5", "cam-6", "v=
pu-0",
> +                                           "vpu-1", "vpu-2", "vpu-3", "v=
pu-4",
> +                                           "vpu-5"
>
>  Optional properties:
>  - vdec-supply: Power supply for the vdec power domain
> diff --git a/include/dt-bindings/power/mt8183-power.h b/include/dt-bindin=
gs/power/mt8183-power.h
> new file mode 100644
> index 0000000..5c0c8c7
> --- /dev/null
> +++ b/include/dt-bindings/power/mt8183-power.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0

This line should end with a '*/'

> + *

And this line start with a '/'


> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Weiyi Lu <weiyi.lu@mediatek.com>
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_MT8183_POWER_H
> +#define _DT_BINDINGS_POWER_MT8183_POWER_H
> +
> +#define MT8183_POWER_DOMAIN_AUDIO      0
> +#define MT8183_POWER_DOMAIN_CONN       1
> +#define MT8183_POWER_DOMAIN_MFG_ASYNC  2
> +#define MT8183_POWER_DOMAIN_MFG                3
> +#define MT8183_POWER_DOMAIN_MFG_CORE0  4
> +#define MT8183_POWER_DOMAIN_MFG_CORE1  5
> +#define MT8183_POWER_DOMAIN_MFG_2D     6
> +#define MT8183_POWER_DOMAIN_DISP       7
> +#define MT8183_POWER_DOMAIN_CAM                8
> +#define MT8183_POWER_DOMAIN_ISP                9
> +#define MT8183_POWER_DOMAIN_VDEC       10
> +#define MT8183_POWER_DOMAIN_VENC       11
> +#define MT8183_POWER_DOMAIN_VPU_TOP    12
> +#define MT8183_POWER_DOMAIN_VPU_CORE0  13
> +#define MT8183_POWER_DOMAIN_VPU_CORE1  14
> +
> +#endif /* _DT_BINDINGS_POWER_MT8183_POWER_H */
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
