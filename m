Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3A5C5518C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3582082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgDVSGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726082AbgDVSGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:06:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2FAC03C1A9;
        Wed, 22 Apr 2020 11:06:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id A29F02611BF
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>, kernel@collabora.com,
        linux-stm32@st-md-mailman.stormreply.com, linux-imx@nxp.com,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>,
        Adrian Pop <pop.adrian61@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH v7 5/8] dt-bindings: display: add i.MX6 MIPI DSI host
 controller doc
In-Reply-To: <20200422005832.GK5983@pendragon.ideasonboard.com>
References: <20200421161610.1501827-1-adrian.ratiu@collabora.com>
 <20200421161610.1501827-6-adrian.ratiu@collabora.com>
 <20200422005832.GK5983@pendragon.ideasonboard.com>
Date:   Wed, 22 Apr 2020 21:07:22 +0300
Message-ID: <87zhb3iecl.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020, Laurent Pinchart 
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Adrian, 
> 
> Thank you for the patch. 
> 
> On Tue, Apr 21, 2020 at 07:16:07PM +0300, Adrian Ratiu wrote: 
>> This provides an example DT binding for the MIPI DSI host 
>> controller present on the i.MX6 SoC based on Synopsis 
>> DesignWare v1.01 IP.   Cc: Rob Herring <robh@kernel.org> Cc: 
>> Neil Armstrong <narmstrong@baylibre.com> Cc: Fabio Estevam 
>> <festevam@gmail.com> Cc: Laurent Pinchart 
>> <laurent.pinchart@ideasonboard.com> Cc: 
>> devicetree@vger.kernel.org Tested-by: Adrian Pop 
>> <pop.adrian61@gmail.com> Tested-by: Arnaud Ferraris 
>> <arnaud.ferraris@collabora.com> Signed-off-by: Sjoerd Simons 
>> <sjoerd.simons@collabora.com> Signed-off-by: Martyn Welch 
>> <martyn.welch@collabora.com> Signed-off-by: Adrian Ratiu 
>> <adrian.ratiu@collabora.com> --- Changes since v6: 
>>   - Added ref to the newly created snps,dw-mipi-dsi.yaml 
>>   (Laurent) - Moved *-cells properties outside 
>>   patternProperties (Laurent) - Removed the panel port 
>>   documentation (Laurent) - Wrapped lines at 80 chars, typo 
>>   fixes, sort includes (Laurent) 
>>  Changes since v5: 
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
>>  .../display/imx/fsl,mipi-dsi-imx6.yaml        | 135 
>>  ++++++++++++++++++ 1 file changed, 135 insertions(+) create 
>>  mode 100644 
>>  Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml 
>>  diff --git 
>> a/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml 
>> b/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml 
>> new file mode 100644 index 0000000000000..b73e3ae33a852 --- 
>> /dev/null +++ 
>> b/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml 
>> @@ -0,0 +1,135 @@ +# SPDX-License-Identifier: (GPL-2.0-only OR 
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
>> with +  the following device-specific properties.  + +allOf: + 
>> - $ref: ../bridge/snps,dw-mipi-dsi.yaml# + +properties: + 
>> '#address-cells': +    const: 1 + +  '#size-cells': +    const: 
>> 0 + +  compatible: +    items: +      - const: 
>> fsl,imx6q-mipi-dsi +      - const: snps,dw-mipi-dsi + +  reg: + 
>> maxItems: 1 + +  interrupts: +    maxItems: 1 + +  clocks: + 
>> items: +      - description: Module Clock +      - description: 
>> DSI bus clock + +  clock-names: +    items: +      - const: ref 
>> +      - const: pclk + +  fsl,gpr: +    description: + 
>> Phandle to the iomuxc-gpr region containing the multiplexer 
>> ctrl register.  +    $ref: 
>> /schemas/types.yaml#/definitions/phandle + +  ports: +    type: 
>> object +    description: | +      A node containing DSI input & 
>> output port nodes with endpoint +      definitions as 
>> documented in + 
>> Documentation/devicetree/bindings/media/video-interfaces.txt + 
>> Documentation/devicetree/bindings/graph.txt +    properties: + 
>> port@0: +        type: object +        description: + 
>> DSI input port node, connected to the ltdc rgb output port.  + 
>> +      port@1: +        type: object +        description: + 
>> RGB output port node, connected to a panel or a bridge input 
>> port. 
> 
> Isn't it the other way around, doesn't the bridge take RGB input 
> and output DSI ? And to be precise, it's not about RGB, but 
> about the input being parallel interface (DSI will also carry 
> RGB). 
> 
> I would add 
> 
>     required: 
>       - port@0 - port@1 
> 

Sorry for the confusions and omissions :) Will fix the names to 
avoid ambiguities and also add the required property and the 
missing port@0 in the example below in v8.

Many thanks,
Adrian

>
>> +
>> +additionalProperties: false
>> +
>> +patternProperties:
>> +  "^panel@[0-3]$":
>> +    type: object
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
>> +examples:
>> +  - |+
>> +    #include <dt-bindings/clock/imx6qdl-clock.h>
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
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
>
> port@0 is missing.
>
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
