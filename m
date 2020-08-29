Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DA3C43461
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE012098B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgH2VRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 17:17:17 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:52324 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbgH2VRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:17:17 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 5ED11804A4;
        Sat, 29 Aug 2020 23:17:12 +0200 (CEST)
Date:   Sat, 29 Aug 2020 23:17:11 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: display: panel: Add bindings for
 Novatek nt36672a
Message-ID: <20200829211711.GG796939@ravnborg.org>
References: <20200826160308.18911-1-sumit.semwal@linaro.org>
 <20200826160308.18911-2-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826160308.18911-2-sumit.semwal@linaro.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=A5ZCwZeG c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=gEfo2CItAAAA:8
        a=xFcjBYEOGyEuSvEduM8A:9 a=Db_w-kWPBOb70CbA:21 a=7NJuBFbGk0mHmiph:21
        a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
        a=sptkURWiP4Gy88Gu7hUp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit.

On Wed, Aug 26, 2020 at 09:33:07PM +0530, Sumit Semwal wrote:
> Novatek nt36672a is a display driver IC that can drive DSI panel. It
> is also present in the Tianma video mode panel, which is a FHD+ panel
> with a resolution of 1080x2246 and 6.18 inches size. It is found in
> some of the Poco F1 phones.
> 
> This patch adds the display driver for the IC, with support added for
> this tianma fhd video mode panel.
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Looks fine, just a few comments in the following.
Should be easy to fix.

	Sam

> 
> ---
> v2: remove ports node, making port@0 directly under panel@0 node.
> v3: updated to replace port@0 to just 'port'.
> v5: renamed to novatek,nt36672a, since the binding is for the IC and not
>       the panel.
> ---
>  .../display/panel/novatek,nt36672a.yaml       | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> new file mode 100644
> index 000000000000..7f8d1097bee0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/novatek,nt36672a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Novatek NT36672A based DSI display Panels
> +
> +maintainers:
> +  - Sumit Semwal <sumit.semwal@linaro.org>
> +
> +description: |
> +  The nt36672a IC from Novatek is a generic DSI Panel IC used to drive dsi
> +  panels.
> +  Right now, support is added only for a Tianma FHD+ LCD display panel with a
> +  resolution of 1080x2246. It is a video mode DSI panel.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: tianma,fhd-video
> +      - const: novatek,nt36672a

Similar bindings uses following pattaern:
properties:
  compatible:
    items:
      - enum:
          - dlink,dir-685-panel
      - const: ilitek,ili9322

See ow an "- enum" is used for the part where we expect to add more
compatible in the future. And const for the fixed part.
Notice the indent - this is right.


> +    description: This indicates the panel manufacturer of the panel that is
> +      in turn using the NT36672A panel driver. This compatible string
> +      determines how the NT36672A panel driver is configured for the indicated
> +      panel. The novatek,nt36672a compatible shall always be provided as a fallback.
> +
> +  reg: true
> +  reset-gpios:
> +    description: phandle of gpio for reset line - This should be 8mA, gpio
> +      can be configured using mux, pinctrl, pinctrl-names (active high)
add empty line, or rely on the generic description in panel-common.
> +  vddio-supply:
> +    description: phandle of the regulator that provides the supply voltage
> +      Power IC supply
add empty line
> +  vddpos-supply:
> +    description: phandle of the positive boost supply regulator
add empty line
> +  vddneg-supply:
> +    description: phandle of the negative boost supply regulator
add empty line
> +  port: true
Maybe group all the ": true" properties.

> +
> +required:
> +  - compatible
> +  - reg
> +  - vddi0-supply
> +  - vddpos-supply
> +  - vddneg-supply
> +  - reset-gpios
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |+
> +    #include <dt-bindings/gpio/gpio.h>
empty line
> +    dsi0 {
My personal preference is indent examples with 4 spaces - it increased
readability.
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      panel@0 {
> +        compatible = "tianma,fhd-video", "novatek,nt36672a";
> +        reg = <0>;
> +        vddi0-supply = <&vreg_l14a_1p88>;
> +        vddpos-supply = <&lab>;
> +        vddneg-supply = <&ibb>;
> +
> +        reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        port {
> +          tianma_nt36672a_in_0: endpoint {
> +            remote-endpoint = <&dsi0_out>;
> +          };
> +        };
> +      };
> +    };
> +
> +...
> -- 
> 2.28.0
