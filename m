Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA68CC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 17:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8ADC20578
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 17:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgGZR2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 13:28:55 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:59246 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgGZR2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 13:28:55 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 76B1420024;
        Sun, 26 Jul 2020 19:28:50 +0200 (CEST)
Date:   Sun, 26 Jul 2020 19:28:48 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch,
        Laurent.pinchart@ideasonboard.com, robh+dt@kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mparab@cadence.com, yamonkar@cadence.com, praneeth@ti.com,
        nsekhar@ti.com, jsarha@ti.com, tomi.valkeinen@ti.com
Subject: Re: [PATCH v7 1/3] dt-bindings: drm/bridge: Document Cadence MHDP
 bridge bindings
Message-ID: <20200726172848.GI3275923@ravnborg.org>
References: <1595403640-12816-1-git-send-email-sjakhade@cadence.com>
 <1595403640-12816-2-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595403640-12816-2-git-send-email-sjakhade@cadence.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=Br2UW1UjAAAA:8 a=VwQbUJbxAAAA:8 a=P1BnusSwAAAA:8
        a=gEfo2CItAAAA:8 a=e5mUnYsNAAAA:8 a=mR2CUQfSIlaI1iu9EAcA:9
        a=9YCI5GxjMFfZpiDd:21 a=72FgsJ9k7mFNgR8O:21 a=CjuIK1q_8ugA:10
        a=WmXOPjafLNExVIMTj843:22 a=AjGcO6oz07-iQ99wixmX:22
        a=D0XLA9XvdZm18NrgonBM:22 a=sptkURWiP4Gy88Gu7hUp:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil.

On Wed, Jul 22, 2020 at 09:40:38AM +0200, Swapnil Jakhade wrote:
> From: Yuti Amonkar <yamonkar@cadence.com>
> 
> Document the bindings used for the Cadence MHDP DPI/DP bridge in
> yaml format.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp.yaml    | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> new file mode 100644
> index 000000000000..cdf5760d4ec5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/bridge/cdns,mhdp.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence MHDP bridge
> +
> +maintainers:
> +  - Swapnil Jakhade <sjakhade@cadence.com>
> +  - Yuti Amonkar <yamonkar@cadence.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,mhdp8546
> +      - ti,j721e-mhdp8546
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description:
> +          Register block of mhdptx apb registers up to PHY mapped area (AUX_CONFIG_P).
> +          The AUX and PMA registers are not part of this range, they are instead
> +          included in the associated PHY.
> +      - description:
> +          Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: mhdptx
> +      - const: j721e-intg
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      DP bridge clock, used by the IP to know how to translate a number of
> +      clock cycles into a time (which is used to comply with DP standard timings
> +      and delays).
> +
> +  phys:
> +    description:
> +      phandle to the DisplayPort PHY.
> +
> +  ports:
> +    type: object
> +    description:
> +      Ports as described in Documentation/devicetree/bindings/graph.txt.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +      port@0:
> +        type: object
> +        description:
> +          Input port representing the DP bridge input.
> +
> +      port@1:
> +        type: object
> +        description:
> +          Output port representing the DP bridge output.
> +
> +    required:
> +      - port@0
> +      - port@1
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,j721e-mhdp8546
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +        reg-names:
> +          minItems: 2
> +
> +required:
> +  - compatible
> +  - clocks
> +  - reg
> +  - reg-names
> +  - phys
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mhdp: dp-bridge@f0fb000000 {
> +        compatible = "cdns,mhdp8546";
> +        reg = <0xf0 0xfb000000 0x0 0x1000000>;
> +        reg-names = "mhdptx";
> +        clocks = <&mhdp_clock>;
> +        phys = <&dp_phy>;
> +
> +        ports {

Please be consistent in indent.
We do not aling below '{'.
Keep using 4 spaces for indent for the full example.

	Sam

> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              port@0 {
> +                     reg = <0>;
> +                     dp_bridge_input: endpoint {
> +                        remote-endpoint = <&xxx_dpi_output>;
> +                     };
> +              };
> +
> +              port@1 {
> +                     reg = <1>;
> +                     dp_bridge_output: endpoint {
> +                        remote-endpoint = <&xxx_dp_connector_input>;
> +                     };
> +              };
> +        };
> +    };
> +...
> -- 
> 2.26.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
