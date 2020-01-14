Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48293C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FBF24679
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FxFJ9mdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgANLzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:55:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37446 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANLzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:55:05 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00EBsije112647;
        Tue, 14 Jan 2020 05:54:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579002884;
        bh=fL4wb7qxhS863dp+nYgiM3uom70qjY56tgWdTfNmElg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FxFJ9mdiPIVGIbIDLrJz7hDEuRqZ3iR3bjrKVDg5mLN5u0ZIJxAw42IiJK6fEE1HM
         FyL2/ptwaXIN2RCQ2+6ETu+UtqlxZkMxUOIvbihBeqyJKbz/ERdoil0NcvXVJ3OvY8
         NfR0b96Ob22RWTw3k9UJcytOLS7jZTIpydKU5zdc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00EBsiwI000606;
        Tue, 14 Jan 2020 05:54:44 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 14
 Jan 2020 05:54:43 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 14 Jan 2020 05:54:44 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00EBsft7013663;
        Tue, 14 Jan 2020 05:54:41 -0600
Subject: Re: [PATCH 1/2] dt-bindings: display: bridge: Add documentation for
 Toshiba tc358768
To:     Rob Herring <robh@kernel.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <mark.rutland@arm.com>,
        <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <tomi.valkeinen@ti.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>
References: <20191217101506.18910-1-peter.ujfalusi@ti.com>
 <20191217101506.18910-2-peter.ujfalusi@ti.com> <20191226222449.GA8816@bogus>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <7a7067ef-3c1c-ea20-8322-6d90c2c4c680@ti.com>
Date:   Tue, 14 Jan 2020 13:55:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191226222449.GA8816@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/12/2019 0.24, Rob Herring wrote:
> On Tue, Dec 17, 2019 at 12:15:05PM +0200, Peter Ujfalusi wrote:
>> TC358768/TC358778 is a Parallel RGB to MIPI DSI bridge.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  .../display/bridge/toshiba,tc358768.yaml      | 158 ++++++++++++++++++
>>  1 file changed, 158 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
>> new file mode 100644
>> index 000000000000..8f96867caca0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
>> @@ -0,0 +1,158 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/bridge/toshiba,tc358768.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Toschiba TC358768/TC358778 Parallel RGB to MIPI DSI bridge
>> +
>> +maintainers:
>> +  - Peter Ujfalusi <peter.ujfalusi@ti.com>
>> +
>> +description: |
>> +  The TC358768/TC358778 is bridge device which converts RGB to DSI.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - toshiba,tc358768
>> +      - toshiba,tc358778
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: base I2C address of the device
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description: GPIO connected to active low RESX pin
>> +
>> +  vddc-supply:
>> +    maxItems: 1
> 
> Drop this. Not an array. *-supply doesn't need further constraints.

OK.

> 
>> +    description: Regulator for 1.2V internal core power.
>> +
>> +  vddmipi-supply:
>> +    maxItems: 1
>> +    description: Regulator for 1.2V for the MIPI.
>> +
>> +  vddio-supply:
>> +    maxItems: 1
>> +    description: Regulator for 1.8V - 3.3V IO power.
> 
> Blank line here.

Oops, I'll fix it.

> 
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: refclk
>> +
>> +  ports:
>> +    type: object
>> +
>> +    properties:
>> +      "#address-cells":
>> +        const: 1
>> +
>> +      "#size-cells":
>> +        const: 0
>> +
>> +      port@0:
>> +        type: object
>> +        additionalProperties: false
>> +
>> +        description: |
>> +          Video port for RGB input
>> +
>> +        properties:
>> +          reg:
>> +            const: 0
>> +
>> +        patternProperties:
>> +          endpoint:
>> +            type: object
>> +            additionalProperties: false
>> +
>> +            properties:
>> +              data-lines:
>> +                enum: [ 16, 18, 24 ]
>> +
>> +              remote-endpoint: true
>> +
>> +        required:
>> +          - reg
>> +
>> +      port@1:
>> +        type: object
>> +        description: |
>> +          Video port for DSI output (panel or connector).
>> +
>> +        properties:
>> +          reg:
>> +            const: 1
>> +
>> +        patternProperties:
>> +          endpoint:
>> +            type: object
>> +            additionalProperties: false
>> +
>> +            properties:
>> +              remote-endpoint: true
>> +
>> +        required:
>> +          - reg
> 
> No additionalProperties on this one?

Correct, I have missed the additionalProperties: false

I'll update the binding documents when I get comments for the driver.

Thank you,
- Péter

> 
>> +
>> +    required:
>> +      - "#address-cells"
>> +      - "#size-cells"
>> +      - port@0
>> +      - port@1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - vddc-supply
>> +  - vddmipi-supply
>> +  - vddio-supply
>> +  - ports
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c1 {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      dsi_bridge: tc358768@0e {
>> +        compatible = "toshiba,tc358768";
>> +        reg = <0x0e>;
>> +
>> +        clocks = <&tc358768_refclk>;
>> +        clock-names = "refclk";
>> +
>> +        /* GPIO line is inverted before going to the bridge */
>> +        reset-gpios = <&pcf_display_board 0 1 /* GPIO_ACTIVE_LOW */>;
>> +
>> +        vddc-supply = <&v1_2d>;
>> +        vddmipi-supply = <&v1_2d>;
>> +        vddio-supply = <&v3_3d>;
>> +
>> +        dsi_bridge_ports: ports {
>> +          #address-cells = <1>;
>> +          #size-cells = <0>;
>> +
>> +          port@0 {
>> +            reg = <0>;
>> +            rgb_in: endpoint {
>> +              remote-endpoint = <&dpi_out>;
>> +              data-lines = <24>;
>> +            };
>> +          };
>> +
>> +          port@1 {
>> +            reg = <1>;
>> +            dsi_out: endpoint {
>> +              remote-endpoint = <&lcd_in>;
>> +            };
>> +          };
>> +        };
>> +      };
>> +    };
>> +    
>> -- 
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
