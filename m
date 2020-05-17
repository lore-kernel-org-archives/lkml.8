Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E05AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 06:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8A8206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 06:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgEQGRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 02:17:15 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:51714 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgEQGRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 02:17:15 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7C71F8052B;
        Sun, 17 May 2020 08:17:11 +0200 (CEST)
Date:   Sun, 17 May 2020 08:17:10 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, od@zcrc.me,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 02/12] dt-bindings: display: Add ingenic,ipu.yaml
Message-ID: <20200517061710.GB609600@ravnborg.org>
References: <20200516215057.392609-1-paul@crapouillou.net>
 <20200516215057.392609-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516215057.392609-2-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=gEfo2CItAAAA:8 a=e5mUnYsNAAAA:8
        a=b0PC0ugUiK8WXcUa1NUA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=sptkURWiP4Gy88Gu7hUp:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.
On Sat, May 16, 2020 at 11:50:47PM +0200, Paul Cercueil wrote:
> Add documentation of the Device Tree bindings for the Image Processing
> Unit (IPU) found in most Ingenic SoCs.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

For me it fails like this:

/Documentation/devicetree/bindings/display/ingenic,ipu.yaml: ignoring, error in schema: properties: compatible: oneOf: 1: items
warning: no schema found in file: Documentation/devicetree/bindings/display/ingenic,ipu.yaml
make[2]: *** [Documentation/devicetree/bindings/Makefile:42: Documentation/devicetree/bindings/processed-schema.yaml] Error 255
make[2]: *** Waiting for unfinished jobs....
Documentation/devicetree/bindings/display/ingenic,ipu.yaml: properties:compatible:oneOf:1:items: ['ingenic,jz4770-ipu', 'ingenic,jz4760-ipu'] is not valid under any of the given schemas (Possible causes of the failure):
	Documentation/devicetree/bindings/display/ingenic,ipu.yaml: properties:compatible:oneOf:1:items: ['ingenic,jz4770-ipu', 'ingenic,jz4760-ipu'] is not of type 'object', 'boolean'
	Documentation/devicetree/bindings/display/ingenic,ipu.yaml: properties:compatible:oneOf:1:items:0: 'ingenic,jz4770-ipu' is not of type 'object', 'boolean'
	Documentation/devicetree/bindings/display/ingenic,ipu.yaml: properties:compatible:oneOf:1:items:1: 'ingenic,jz4760-ipu' is not of type 'object', 'boolean'


	Sam

> ---
>  .../bindings/display/ingenic,ipu.yaml         | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/ingenic,ipu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/ingenic,ipu.yaml b/Documentation/devicetree/bindings/display/ingenic,ipu.yaml
> new file mode 100644
> index 000000000000..22fe02ca866d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ingenic,ipu.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/ingenic,ipu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ingenic SoCs Image Processing Unit (IPU) devicetree bindings
> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +        - ingenic,jz4725b-ipu
> +        - ingenic,jz4760-ipu
> +      - items:
> +        - ingenic,jz4770-ipu
> +        - ingenic,jz4760-ipu
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ipu
> +
> +patternProperties:
> +  "^ports?$":
> +    description: OF graph bindings (specified in bindings/graph.txt).
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/jz4770-cgu.h>
> +    ipu@13080000 {
> +      compatible = "ingenic,jz4770-ipu", "ingenic,jz4760-ipu";
> +      reg = <0x13080000 0x800>;
> +
> +      interrupt-parent = <&intc>;
> +      interrupts = <29>;
> +
> +      clocks = <&cgu JZ4770_CLK_IPU>;
> +      clock-names = "ipu";
> +
> +      port {
> +        ipu_ep: endpoint {
> +          remote-endpoint = <&lcdc_ep>;
> +        };
> +      };
> +    };
> -- 
> 2.26.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
