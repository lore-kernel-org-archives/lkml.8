Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2C9C3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C610A215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583338540;
	bh=VvKrAZFOSRZVsonXXhzM0ppD0dERScxsXi3DIaqeq78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YyYSKDcwpJK0Hf4iH5HkFbGOS/QG8ViTJ9y6+W23Qv6Q2N5inbi1A4TsRWAjKX5IT
	 AcNnK3zngbx3MohtiJUv2Zzrizw0Vgl1SN4usOK7caNXbGCS4zQtxhWXzES3BjSABX
	 XwjvzbWWlzzhqLMYn9vmeOjvySfHUwCWwDKQ6v6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbgCDQPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:15:40 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44264 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDQPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:15:39 -0500
Received: by mail-oi1-f195.google.com with SMTP id d62so2604253oia.11;
        Wed, 04 Mar 2020 08:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G/m9Dnt93HLh8ZZeYopXZOgJzRYkBJrpgZdowTke/ZA=;
        b=L7n10FCrkw01jAghMOOReCAs/sbDtLbEesLrEQYqoCP2ahyG9H8g3Eb5rFOQbtMgvu
         hEibq6E6uYWcr/675ZKZUmuWRrdXZw7vtXoQURWQdohhIHspjA5GnDe3iM1CBOMANI7+
         PMheEcDLNWHwaA4mTsbJeREXt26VM/BMFlhcr1nwVGpYJOziOSCgGILEICAZ1+eSXOOw
         U/SVe3E2jxQzrhB667SzdCN3q8vie/ILFtDLP9/K+f13gDDc29N3+qWCWVvxoQX10n7C
         ZUMneBKJDe7Y6uaAPjJhegGS8qokkoRaLriX/unOkwbfKo9CllRCodugB0CuWwpGzNxL
         LgqQ==
X-Gm-Message-State: ANhLgQ2AAyjfiHkjUTpq+do1rjBZ6H9dVuCX3Fst7PhXEwclANcT79W8
        NYlmmc8jHjWatGKJCRUFKg==
X-Google-Smtp-Source: ADFU+vvQPKn3HTHYpHagUTruHe80jgRcAKAs1iIPLjepLVEiIsroKoDtfMT7OCsZXUt/LNxDyx47Yw==
X-Received: by 2002:aca:a9d4:: with SMTP id s203mr2347678oie.106.1583338538421;
        Wed, 04 Mar 2020 08:15:38 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v65sm965478oib.17.2020.03.04.08.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:15:37 -0800 (PST)
Received: (nullmailer pid 26064 invoked by uid 1000);
        Wed, 04 Mar 2020 16:15:36 -0000
Date:   Wed, 4 Mar 2020 10:15:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com, huijuan.xie@mediatek.com
Subject: Re: [PATCH v12 4/6] dt-bindings: display: mediatek: convert the
 document format from txt to yaml
Message-ID: <20200304161536.GA20736@bogus>
References: <20200303052722.94795-1-jitao.shi@mediatek.com>
 <20200303052722.94795-5-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303052722.94795-5-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 01:27:20PM +0800, Jitao Shi wrote:
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../display/mediatek/mediatek,dpi.txt         | 45 ---------
>  .../display/mediatek/mediatek,dpi.yaml        | 92 +++++++++++++++++++
>  2 files changed, 92 insertions(+), 45 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml

You need to run 'make dt_binding_check' on this and fix the errors.

[...]

> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> new file mode 100644
> index 000000000000..eb2b0cb5eb5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek,dpi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: mediatek DPI Controller Device Tree Bindings
> +
> +maintainers:
> +  - CK Hu <ck.hu@mediatek.com>
> +  - Jitao shi <jitao.shi@mediatek.com>
> +
> +description: |
> +  The Mediatek DPI function block is a sink of the display subsystem and
> +  provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a parallel
> +  output bus.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt2701-dpi
> +      - mediatek,mt8173-dpi
> +      - mediatek,mt8183-dpi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Pixel Clock
> +      - description: Engine Clock
> +      - description: DPI PLL
> +
> +  clock-names:
> +    items:
> +      - const: pixel
> +      - const: engine
> +      - const: pll
> +
> +  pinctrl-names:
> +    items:
> +      - const: default
> +      - const: sleep

Doesn't match what you just added to the binding...

> +
> +  port:
> +    type: object
> +    description:
> +      Output port node with endpoint definitions as described in
> +      Documentation/devicetree/bindings/graph.txt. This port should be connected
> +      to the input port of an attached HDMI or LVDS encoder chip.
> +
> +    properties:
> +      pclk-sample:
> +      description: refer Documentation/devicetree/bindings/media/video-interfaces.txt.

This is wrong in multiple ways. 'description' is missing indentation, so 
you are defining 'description' to be a property.

And 'pclk-sample' is not a property of 'port' node, but 'endpoint'.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dpi0: dpi@1401d000 {
> +        compatible = "mediatek,mt8173-dpi";
> +        reg = <0 0x1401d000 0 0x1000>;
> +        interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
> +        clocks = <&mmsys CLK_MM_DPI_PIXEL>,
> +             <&mmsys CLK_MM_DPI_ENGINE>,
> +             <&apmixedsys CLK_APMIXED_TVDPLL>;

Examples are built now and you need to add includes for these defines.

> +        clock-names = "pixel", "engine", "pll";
> +        pinctrl-names = "default", "sleep";
> +        pinctrl-0 = <&dpi_pin_func>;
> +        pinctrl-1 = <&dpi_pin_idle>;
> +
> +        port {
> +            reg = <0>;

Drop 'reg'.

> +            dpi0_out: endpoint {
> +                pclk-sample = <0>;
> +                remote-endpoint = <&hdmi0_in>;
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.21.0
