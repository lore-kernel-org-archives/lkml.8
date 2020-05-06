Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F53C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3B22075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgEFVAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:00:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58120 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgEFVAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:00:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 66E942A22DB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v14 02/11] dt-bindings: soc: Add MT8183 power dt-bindings
To:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        Fan Chen <fan.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>
References: <1588752963-19934-1-git-send-email-weiyi.lu@mediatek.com>
 <1588752963-19934-3-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <30046b88-0fb7-5506-7460-bf0fba320c3d@collabora.com>
Date:   Wed, 6 May 2020 23:00:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588752963-19934-3-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiyi,

Thank you for your patch. You should cc devicetree@vger.kernel.org, otherwise
this patch might be ignored.

On 6/5/20 10:15, Weiyi Lu wrote:
> Add power dt-bindings of MT8183 and introduces "BASIC" and
> "SUBSYS" clock types in binding document.
> The "BASIC" type is compatible to the original power control with
> clock name [a-z]+[0-9]*, e.g. mm, vpu1.
> The "SUBSYS" type is used for bus protection control with clock
> name [a-z]+-[0-9]+, e.g. isp-0, cam-1.
> And add an optional smi-comm property for phandle to smi-common
> controller.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 21 ++++++++++++++---
>  include/dt-bindings/power/mt8183-power.h           | 26 ++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/power/mt8183-power.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> index 2bc3677..5424e66 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> @@ -15,6 +15,7 @@ power/power-domain.yaml. It provides the power domains defined in
>  - include/dt-bindings/power/mt2701-power.h
>  - include/dt-bindings/power/mt2712-power.h
>  - include/dt-bindings/power/mt7622-power.h
> +- include/dt-bindings/power/mt8183-power.h
>  
>  Required properties:
>  - compatible: Should be one of:
> @@ -27,12 +28,16 @@ Required properties:
>  	- "mediatek,mt7623a-scpsys": For MT7623A SoC
>  	- "mediatek,mt7629-scpsys", "mediatek,mt7622-scpsys": For MT7629 SoC
>  	- "mediatek,mt8173-scpsys"
> +	- "mediatek,mt8183-scpsys"
>  - #power-domain-cells: Must be 1
>  - reg: Address range of the SCPSYS unit
>  - infracfg: must contain a phandle to the infracfg controller
> -- clock, clock-names: clocks according to the common clock binding.
> -                      These are clocks which hardware needs to be
> -                      enabled before enabling certain power domains.
> +- clock, clock-names: Clocks according to the common clock binding.
> +                      Some SoCs have to groups of clocks.
> +                      BASIC clocks need to be enabled before enabling the
> +                      corresponding power domain.
> +                      SUBSYS clocks need to be enabled before releasing the
> +                      bus protection.
>  	Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
>  	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
>  	Required clocks for MT6765: MUX: "mm", "mfg"
> @@ -43,6 +48,15 @@ Required properties:
>  	Required clocks for MT7622 or MT7629: "hif_sel"
>  	Required clocks for MT7623A: "ethif"
>  	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
> +	Required clocks for MT8183: BASIC: "audio", "mfg", "mm", "cam", "isp",
> +					   "vpu", "vpu1", "vpu2", "vpu3"
> +				    SUBSYS: "mm-0", "mm-1", "mm-2", "mm-3",
> +					    "mm-4", "mm-5", "mm-6", "mm-7",
> +					    "mm-8", "mm-9", "isp-0", "isp-1",
> +					    "cam-0", "cam-1", "cam-2", "cam-3",
> +					    "cam-4", "cam-5", "cam-6", "vpu-0",
> +					    "vpu-1", "vpu-2", "vpu-3", "vpu-4",
> +					    "vpu-5"
>  
>  Optional properties:
>  - vdec-supply: Power supply for the vdec power domain
> @@ -55,6 +69,7 @@ Optional properties:
>  - mfg_async-supply: Power supply for the mfg_async power domain
>  - mfg_2d-supply: Power supply for the mfg_2d power domain
>  - mfg-supply: Power supply for the mfg power domain
> +- smi_comm: a phandle to the smi-common controller


I think that in device-tree hyphen are preferred and kind of a must for new
properties, also I think you should prefix this property with "mediatek,". Can I
suggest you to use "mediatek,smi" like is done in the mediatek,smi-larb binding?
AFAICS is the same phandle right?

Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt:
- mediatek,smi : a phandle to the smi_common node.


>  
>  Example:
>  
> diff --git a/include/dt-bindings/power/mt8183-power.h b/include/dt-bindings/power/mt8183-power.h
> new file mode 100644
> index 0000000..d6b25f8
> --- /dev/null
> +++ b/include/dt-bindings/power/mt8183-power.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.

You probably want to update the copyright to 2020.

> + * Author: Weiyi Lu <weiyi.lu@mediatek.com>
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_MT8183_POWER_H
> +#define _DT_BINDINGS_POWER_MT8183_POWER_H
> +
> +#define MT8183_POWER_DOMAIN_AUDIO	0
> +#define MT8183_POWER_DOMAIN_CONN	1
> +#define MT8183_POWER_DOMAIN_MFG_ASYNC	2
> +#define MT8183_POWER_DOMAIN_MFG		3
> +#define MT8183_POWER_DOMAIN_MFG_CORE0	4
> +#define MT8183_POWER_DOMAIN_MFG_CORE1	5
> +#define MT8183_POWER_DOMAIN_MFG_2D	6
> +#define MT8183_POWER_DOMAIN_DISP	7
> +#define MT8183_POWER_DOMAIN_CAM		8
> +#define MT8183_POWER_DOMAIN_ISP		9
> +#define MT8183_POWER_DOMAIN_VDEC	10
> +#define MT8183_POWER_DOMAIN_VENC	11
> +#define MT8183_POWER_DOMAIN_VPU_TOP	12
> +#define MT8183_POWER_DOMAIN_VPU_CORE0	13
> +#define MT8183_POWER_DOMAIN_VPU_CORE1	14
> +
> +#endif /* _DT_BINDINGS_POWER_MT8183_POWER_H */
> 
