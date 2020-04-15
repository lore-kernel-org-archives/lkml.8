Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8098AC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D6020575
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896979AbgDOL2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896945AbgDOL1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:27:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3BBC061A0C;
        Wed, 15 Apr 2020 04:27:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id BB2FA2A0A37
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>,
        Adrian Pop <pop.adrian61@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH v6 5/8] dt-bindings: display: add i.MX6 MIPI DSI host
 controller doc
In-Reply-To: <20200414204202.GL19819@pendragon.ideasonboard.com>
References: <20200414151955.311949-1-adrian.ratiu@collabora.com>
 <20200414151955.311949-6-adrian.ratiu@collabora.com>
 <20200414204202.GL19819@pendragon.ideasonboard.com>
Date:   Wed, 15 Apr 2020 14:28:25 +0300
Message-ID: <87wo6hj8di.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020, Laurent Pinchart 
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Adrian, 
> 
> Thank you for the patch. 

Hi Laurent,

Thank you for the review - you raised some good points which will 
be addressed in the next revision (will leave this on review a bit 
more).

I will also convert the dw_mipi_dsi.txt to yaml as you suggest and 
send that as a separate patch.

Best wishes,
Adrian

> 
> On Tue, Apr 14, 2020 at 06:19:52PM +0300, Adrian Ratiu wrote: 
>> This provides an example DT binding for the MIPI DSI host 
>> controller present on the i.MX6 SoC based on Synopsis 
>> DesignWare v1.01 IP.   Cc: Rob Herring <robh@kernel.org> Cc: 
>> Neil Armstrong <narmstrong@baylibre.com> Cc: Fabio Estevam 
>> <festevam@gmail.com> Cc: devicetree@vger.kernel.org Tested-by: 
>> Adrian Pop <pop.adrian61@gmail.com> Tested-by: Arnaud Ferraris 
>> <arnaud.ferraris@collabora.com> Signed-off-by: Sjoerd Simons 
>> <sjoerd.simons@collabora.com> Signed-off-by: Martyn Welch 
>> <martyn.welch@collabora.com> Signed-off-by: Adrian Ratiu 
>> <adrian.ratiu@collabora.com> --- Changes since v5: 
>>   - Fixed missing reg warning (Fabio) - Updated dt-schema and 
>>   fixed warnings (Rob) 
>>  Changes since v4: 
>>   - Fixed yaml binding to pass `make dt_binding_check 
>>   dtbs_check` and addressed received binding feedback (Rob) 
>>  Changes since v3: 
>>   - Added commit message (Neil) - Converted to yaml format 
>>   (Neil) - Minor dt node + driver fixes (Rob) - Added small 
>>   panel example to the host controller binding 
>>  Changes since v2: 
>>   - Fixed commit tags (Emil) 
>> --- 
>>  .../display/imx/fsl,mipi-dsi-imx6.yaml        | 139 
>>  ++++++++++++++++++ 1 file changed, 139 insertions(+) create 
>>  mode 100644 
>>  Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml 
>>  diff --git 
>> a/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml 
>> b/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml 
>> new file mode 100644 index 000000000000..10e289ea219a --- 
>> /dev/null +++ 
>> b/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml 
>> @@ -0,0 +1,139 @@ +# SPDX-License-Identifier: (GPL-2.0-only OR 
>> BSD-2-Clause) +%YAML 1.2 +--- +$id: 
>> http://devicetree.org/schemas/display/imx/fsl,mipi-dsi-imx6.yaml# 
>> +$schema: http://devicetree.org/meta-schemas/core.yaml# + 
>> +title: Freescale i.MX6 DW MIPI DSI Host Controller + 
>> +maintainers: +  - Adrian Ratiu <adrian.ratiu@collabora.com> + 
>> +description: | +  The i.MX6 DSI host controller is a Synopsys 
>> DesignWare MIPI DSI v1.01 +  IP block with a companion PHY IP. 
>> + +  These DT bindings follow the Synopsys DW MIPI DSI bindings 
>> defined in + 
>> Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt 
>> with +  the following device-specific properties. 
> 
> Not necessarily a prerequisite for this patch, but it would be 
> nice to get that converted to yaml, and included here with 
> 
> allOf: 
>   $ref: ../bridge/snps,dw-mipi-dsi.yaml# 
> 
> (assuming that's how the file will be called). 
>

Yes, I will do this conversion but in a separate patch to avoid 
making this series bigger.

Thanks,
Adrian

>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: fsl,imx6q-mipi-dsi
>> +      - const: snps,dw-mipi-dsi
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Module Clock
>> +      - description: DSI bus clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: ref
>> +      - const: pclk
>> +
>> +  fsl,gpr:
>> +    description: Phandle to the iomuxc-gpr region containing the multiplexer control register.
>
> Could you please wrap liens at a 80 columns boundary ?
>
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  ports:
>> +    type: object
>> +    description: |
>> +      A node containing DSI input & output port nodes with endpoint
>> +      definitions as documented in
>> +      Documentation/devicetree/bindings/media/video-interfaces.txt
>> +      Documentation/devicetree/bindings/graph.txt
>> +    properties:
>
> You should add
>
>        '#address-cells':
>          const: 1
>
>        '#size-cells':
>          const: 0
>
>> +      port@0:
>> +        type: object
>> +        description:
>> +          DSI input port node, connected to the ltdc rgb output port.
>> +
>> +      port@1:
>> +        type: object
>> +        description:
>> +          DSI output port node, connected to a panel or a bridge input port"
>
>
> Should this be "RGB output port node" ? And s/"/./
>
> And here you should add
>
>        additionalProperties: false
>
>> +
>> +patternProperties:
>> +  "^panel@[0-3]$":
>> +    type: object
>> +    description: |
>> +      A node containing the panel or bridge description as documented in
>> +      Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
>> +    properties:
>> +      port:
>> +        type: object
>> +        description:
>> +          Panel or bridge port node, connected to the DSI output port (port@1)
>
> Does this belong here ? I think the port property for the panel needs to
> be described in the panel's binding instead.
>
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>
> These two properties are not pattern properties, right ? Should they be
> listed under the properties above ?
>
>> +
>> +required:
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - ports
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |+
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/imx6qdl-clock.h>
>> +    #include <dt-bindings/gpio/gpio.h>
>
> Alphabetical order ?
>
>> +
>> +    dsi: dsi@21e0000 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        compatible = "fsl,imx6q-mipi-dsi", "snps,dw-mipi-dsi";
>> +        reg = <0x021e0000 0x4000>;
>> +        interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
>> +        fsl,gpr = <&gpr>;
>> +        clocks = <&clks IMX6QDL_CLK_MIPI_CORE_CFG>,
>> +                 <&clks IMX6QDL_CLK_MIPI_IPG>;
>> +        clock-names = "ref", "pclk";
>> +
>> +        ports {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            port@1 {
>> +                reg = <1>;
>> +                dsi_out: endpoint {
>> +                    remote-endpoint = <&panel_in>;
>> +                };
>> +            };
>> +        };
>> +
>> +        panel@0 {
>> +            compatible = "sharp,ls032b3sx01";
>> +            reg = <0>;
>> +            reset-gpios = <&gpio6 8 GPIO_ACTIVE_LOW>;
>> +            ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +                port@0 {
>> +                    reg = <0>;
>> +                    panel_in: endpoint {
>> +                        remote-endpoint = <&dsi_out>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
>> +
>> +...
>
> -- 
> Regards,
>
> Laurent Pinchart
