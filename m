Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDF4C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A91420767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503771AbgDNSS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:18:58 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:43818 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503749AbgDNSSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:18:52 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id ABE0380441;
        Tue, 14 Apr 2020 20:18:48 +0200 (CEST)
Date:   Tue, 14 Apr 2020 20:18:47 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     dri-devel@lists.freedesktop.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: Document the Synopsys ARC HDMI TX
 bindings
Message-ID: <20200414181847.GB21071@ravnborg.org>
References: <20200414144402.27643-1-Eugeniy.Paltsev@synopsys.com>
 <20200414144402.27643-3-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414144402.27643-3-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=jIQo8A4GAAAA:8
        a=7gkXJVJtAAAA:8 a=gEfo2CItAAAA:8 a=_sfh-jedi5NWomO9Eu8A:9
        a=Bidoa8gpE23jXAbx:21 a=7WcnEqVqqvUY8Xlb:21 a=CjuIK1q_8ugA:10
        a=Lf5xNeLK5dgiOs8hzIjU:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=sptkURWiP4Gy88Gu7hUp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugeniy.

On Tue, Apr 14, 2020 at 05:44:02PM +0300, Eugeniy Paltsev wrote:
> This patch adds documentation of device tree bindings for the Synopsys
> HDMI 2.0 TX encoder driver for ARC SoCs.
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

with a few nits addressed.

As already mentioned - the filename confuses.
Maybe tell why in changelog - og fix filename to follow compatible.

> ---
>  .../display/bridge/snps,arc-dw-hdmi.yaml      | 131 ++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/snps,arc-dw-hdmi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/snps,arc-dw-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/snps,arc-dw-hdmi.yaml
> new file mode 100644
> index 000000000000..f52fc3b114b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/snps,arc-dw-hdmi.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/snps,arc-dw-hdmi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare HDMI 2.0 TX encoder driver
> +
> +maintainers:
> +  - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> +
> +description: |
> +  The HDMI transmitter is a Synopsys DesignWare HDMI 2.0 TX controller IP
> +  with a companion of Synopsys DesignWare HDMI 2.0 TX PHY IP.
> +
> +  These DT bindings follow the Synopsys DWC HDMI TX bindings defined in
> +  Documentation/devicetree/bindings/display/bridge/dw_hdmi.txt
> +  with the following device-specific properties.
> +
> +properties:
> +  compatible:
> +    const: snps,dw-hdmi-hsdk
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      Memory mapped base address and length of the DWC HDMI TX registers.
> +
> +  clocks:
> +    items:
> +      - description: The bus clock for AHB / APB
> +      - description: The internal register configuration clock
> +
> +  clock-names:
> +    items:
> +      - const: iahb
> +      - const: isfr
> +
> +  reg-io-width:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [1, 4]
> +        description:
> +          Width of the registers specified by the reg property. The
> +          value is expressed in bytes and must be equal to 1 or 4 if specified.
> +          The register width defaults to 1 if the property is not present.
> +
> +  ports:
> +    type: object
> +    description: |
> +      A ports node with endpoint definitions as defined in
> +      Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      port@0:
> +        type: object
> +        description: |
> +          Video input endpoints of the controller.
> +          Usually the associated with PGU.
Please rephrase this sentence. I am not sure how to read it.

> +
> +      port@1:
> +        type: object
> +        description: |
> +          Output endpoints of the controller. HDMI connector.
> +
> +    required:
> +      - "#address-cells"
> +      - "#size-cells"
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hdmi: hdmi@0x10000 {
hdmi
> +        compatible = "snps,dw-hdmi-hsdk";
> +        reg = <0x10000 0x10000>;
> +        reg-io-width = <4>;
> +        interrupts = <14>;
> +        clocks = <&apbclk>, <&hdmi_pix_clk>;
> +        clock-names = "iahb", "isfr";
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                hdmi_enc_input: endpoint {
> +                    remote-endpoint = <&pgu_output>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +                hdmi_enc_out: endpoint {
> +                    remote-endpoint = <&hdmi_con>;
> +                };
> +            };
> +        };
> +    };
> +
> +    hdmi-out {
> +        port {
> +            hdmi_con: endpoint {
> +                remote-endpoint = <&hdmi_enc_out>;
> +            };
> +        };
> +    };
> +
> +    pgu {
> +        port_o: port {
> +            pgu_output: endpoint {
> +                remote-endpoint = <&hdmi_enc_input>;
> +            };
> +        };
> +    };
> -- 
> 2.21.1
