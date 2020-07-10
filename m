Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33E4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882F2207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH56qud2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgGJKmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgGJKl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:41:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83002C08C5CE;
        Fri, 10 Jul 2020 03:41:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so5420135wmi.4;
        Fri, 10 Jul 2020 03:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jJUd39bjlIspvI1o1u2naIJgRgatARb46UKsj3YoryU=;
        b=DH56qud2+QsVfrK8NLDzF6y3pDUvhI1TiiWC9GaXIDY+mjOyJsz5RrWGxvnr98N6em
         Nae2lMEO9/PQm+iyD0C4QFfenRe4mMqw0YWsEQ88YAy9XZZ2llLQnNiO9bwoXrHLj5hy
         f4IF0+t/glYSyA/C/vbq/600XYSZPlbprs8fEJruKudcF3XSp1LkDkVQFk6nCHj2JJSg
         pf+47vfnif9+zsGTdSNw7weQvui+2SSxAfu8u9NEaBEoM6Tzai0nnckyXWjqWLFT+dHh
         F/f3qhdwiK3je5hhCuS0bc8y1qDq5X5Pa86goGdiZCi42yRSpDohJRQNQEEHMcxBNYPk
         xfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jJUd39bjlIspvI1o1u2naIJgRgatARb46UKsj3YoryU=;
        b=DmGSQHI9fQmcRThUa98FZ6evyBXGrad8Fap6zopsa67GsAPijM+tOLGPb9H4OuuwEx
         cvol3jCYOC6BmEBlIKNTnwIfc0r9Mv31bzvHpAn0/XmNoJbPuMdzKEHUy0d3AJYFw4LA
         wx+oLedYiYVbAN5yXDL/aOVs9MDTILsWuiBVbLq9kDFmjqIcb/VQIhlbsh9y1Ad/pjdQ
         DuSesWmkcLr5kSEJWMHivK/AsQgN2OI+GMA1SUV6X9IiEIIMKtZU6rnNrdyiSi+XnGLZ
         QBktaEtbl4p7FHYQxJ5R7oHtUrClYz6+EA7ec0YPDqUayUnNa3eXlkLhn0tml7H/KJCZ
         5mFA==
X-Gm-Message-State: AOAM5330AFyw6zsHE1xZEDPDIMS7DhoYYrHK/Daw5u7X1VqHnQED15dM
        l2GIP9xr64e60JQb1nBa6Y2EYqmmv+U=
X-Google-Smtp-Source: ABdhPJxcOlZwyO5x1hX0CUcQEPIZG+vWvNQwfyRKiWOJNQTc49ZTOFqDxgJLOxgU2UD9pmY0t6+Xgg==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr4429409wmi.148.1594377718256;
        Fri, 10 Jul 2020 03:41:58 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id a4sm10470215wrg.80.2020.07.10.03.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 03:41:57 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: devapc: add bindings for mtk-devapc
To:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>, wsd_upstream@mediatek.com
References: <1594285927-1840-1-git-send-email-neal.liu@mediatek.com>
 <1594285927-1840-2-git-send-email-neal.liu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a0a58181-525c-f7a3-4385-d778a113d60c@gmail.com>
Date:   Fri, 10 Jul 2020 12:41:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594285927-1840-2-git-send-email-neal.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/2020 11:12, Neal Liu wrote:
> Add bindings for mtk-devapc.
> 
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---
>   .../devicetree/bindings/soc/mediatek/devapc.yaml   |   82 ++++++++++++++++++++
>   1 file changed, 82 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> new file mode 100644
> index 0000000..f08243e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# # Copyright 2020 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/mediatek/devapc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MediaTek Device Access Permission Control driver
> +
> +description: |
> +  MediaTek bus fabric provides TrustZone security support and data
> +  protection to prevent slaves from being accessed by unexpected masters.
> +  The security violation is logged and sent to the processor for further
> +  analysis and countermeasures.
> +
> +maintainers:
> +  - Neal Liu <neal.liu@mediatek.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6779-devapc
> +
> +  reg:
> +    description: The base address of devapc register bank
> +    maxItems: 1
> +
> +  interrupts:
> +    description: A single interrupt specifier
> +    maxItems: 1
> +
> +  clocks:
> +    description: Contains module clock source and clock names
> +    maxItems: 1
> +
> +  clock-names:
> +    description: Names of the clocks list in clocks property
> +    maxItems: 1
> +
> +  mediatek-slv_type_num:
> +    description: Numbers of slave type in mediatek platform
> +    maxItems: 1

This should go in the DT data, have a look for example at:
https://elixir.bootlin.com/linux/latest/source/drivers/soc/mediatek/mtk-pmic-wrap.c#L1842
and
https://elixir.bootlin.com/linux/latest/source/drivers/soc/mediatek/mtk-pmic-wrap.c#L1777

> +
> +  mediatek-vio_dbgs:
> +    description: The mask bit and start bit of devapc violation debug registers
> +    maxItems: 5
> +

same here

> +  mediatek-pds_offset:
> +    description: The offset of devapc pds registers
> +    maxItems: 1

same here

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - mediatek-slv_type_num
> +  - mediatek-vio_dbgs
> +  - mediatek-pds_offset
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt6779-clk.h>
> +
> +    devapc: devapc@10207000 {
> +      compatible = "mediatek,mt6779-devapc";
> +      reg = <0x10207000 0x1000>;
> +      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_LOW>;
> +      clocks = <&infracfg_ao CLK_INFRA_DEVICE_APC>;
> +      clock-names = "devapc-infra-clock";
> +
> +      mediatek-slv_type_num = /bits/ 8 <1>;
> +      mediatek-vio_dbgs = <0x0000FFFF 0x0>,
> +                          <0x003F0000 0x10>,
> +                          <0x00400000 0x16>,
> +                          <0x00800000 0x17>,
> +                          <0x0F000000 0x18>;
> +      mediatek-pds_offset = <0x0 0x400 0x900 0x904
> +                             0xF00 0xF10 0xF14 0xF20>;
> +    };
> 
