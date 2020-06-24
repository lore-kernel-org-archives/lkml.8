Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A66C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17F620706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 10:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="baM/hVab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390394AbgFXK0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 06:26:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33940 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387962AbgFXK0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 06:26:53 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OAQoVv008419;
        Wed, 24 Jun 2020 05:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592994410;
        bh=3d+dfb4oHTkTtmlTJ7R3Bg06ZNgxLk207tvorVnD36A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=baM/hVabuTXttyv3UXOUhiB7dNMv5FfDm4Gyxk2Xit2M8NiZeKPcDR+BRUItsApo7
         ju6gLl5MK2YTpRxsHRhmsmjHKEP71lyFeNdDD4NPevwOS40ZiZMWGNHnoZEeW2x5vE
         Wo2CQHoBp1R0zJvnPAwhd06lwW7jV02jKldl+pyw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OAQoxn005008
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 05:26:50 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 05:26:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 05:26:50 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OAQnge013371;
        Wed, 24 Jun 2020 05:26:49 -0500
Subject: Re: [PATCH v2] dt-bindings: usb: ti,keystone-dwc3.yaml: Improve
 schema
To:     Rob Herring <robh@kernel.org>
CC:     <balbi@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200602124055.1680-1-rogerq@ti.com>
 <5f81187b-0558-3815-051b-e40685fd047a@ti.com>
 <20200615174156.GA2008179@bogus>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <b7dc1ee0-36a8-259f-391e-61c256623301@ti.com>
Date:   Wed, 24 Jun 2020 13:26:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615174156.GA2008179@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/06/2020 20:41, Rob Herring wrote:
> On Fri, Jun 05, 2020 at 10:52:15AM +0300, Roger Quadros wrote:
>> There were some review comments after the patch was integrated.
>> Address those.
>>
>> Fixes: 1883a934e156 ("dt-bindings: usb: convert keystone-usb.txt to YAML")
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>
>> Changelog:
>> v2
>> - don't use quotes for enum/const string
>> - use phandle instead of phandle-array for phys
>> - add maxItems for phy-names
>>
>>   .../bindings/usb/ti,keystone-dwc3.yaml        | 50 ++++++++++++++-----
>>   1 file changed, 37 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
>> index f127535feb0b..394e47d2f5d7 100644
>> --- a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
>> @@ -11,64 +11,88 @@ maintainers:
>>   properties:
>>     compatible:
>> -    oneOf:
>> -      - const: "ti,keystone-dwc3"
>> -      - const: "ti,am654-dwc3"
>> +    items:
>> +      - enum:
>> +        - ti,keystone-dwc3
>> +        - ti,am654-dwc3
>>     reg:
>>       maxItems: 1
>> -    description: Address and length of the register set for the USB subsystem on
>> -      the SOC.
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 1
>> +
>> +  ranges: true
> 
> blank line

There is a blank line before interrupts.

> 
>>     interrupts:
>>       maxItems: 1
>> -    description: The irq number of this device that is used to interrupt the MPU.
>> -
>>     clocks:
>> +    $ref: /schemas/types.yaml#definitions/phandle-array
> 
> Common property. It already has a type and doesn't need to be
> redefined here.
> 
> Just "maxItems: 1" if it is a single clock is enough, or an 'items' list
> for each entry if more than 1.

Some nodes need 1 and some need 2. So "minItems: 1" and "maxItems: 2"?
The driver doesn't really care, and relies of device/clock framework
to just set the right clock parent.

In this case do I need to add items list?

cheers,
-roger

> 
>>       description: Clock ID for USB functional clock.
> 
> Drop.
> 
>> +  assigned-clocks:
>> +    $ref: /schemas/types.yaml#definitions/phandle-array
> 
> 
>> +
>> +  assigned-clock-parents:
>> +    $ref: /schemas/types.yaml#definitions/phandle-array
>> +
>>     power-domains:
>> +    $ref: /schemas/types.yaml#definitions/phandle-array
> 
> Same as 'clocks'.
> 
>>       description: Should contain a phandle to a PM domain provider node
>>         and an args specifier containing the USB device id
>>         value. This property is as per the binding,
>>         Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>     phys:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
> 
> Same as 'clocks'.
> 
>>       description:
>>         PHY specifier for the USB3.0 PHY. Some SoCs need the USB3.0 PHY
>>         to be turned on before the controller.
>>         Documentation/devicetree/bindings/phy/phy-bindings.txt
>>     phy-names:
>> +    maxItems: 1
>>       items:
>> -      - const: "usb3-phy"
>> +      - const: usb3-phy
> 
> Don't need maxItems as that's implied by the length of 'items'.
> 
>> +
>> +  dma-coherent: true
>> -  dwc3:
>> +  dma-ranges: true
>> +
>> +patternProperties:
>> +  "usb@[a-f0-9]+$":
>> +    type: object
>>       description: This is the node representing the DWC3 controller instance
>>         Documentation/devicetree/bindings/usb/dwc3.txt
>>   required:
>>     - compatible
>>     - reg
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - ranges
>>     - interrupts
>> -  - clocks
>> +
>> +additionalProperties: false
>>   examples:
>>     - |
>>       #include <dt-bindings/interrupt-controller/arm-gic.h>
>> -    usb: usb@2680000 {
>> +    dwc3@2680000 {
>>         compatible = "ti,keystone-dwc3";
>>         #address-cells = <1>;
>>         #size-cells = <1>;
>>         reg = <0x2680000 0x10000>;
>>         clocks = <&clkusb>;
>> -      clock-names = "usb";
>>         interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
>>         ranges;
>> -      dwc3@2690000 {
>> +      usb@2690000 {
>>           compatible = "synopsys,dwc3";
>>           reg = <0x2690000 0x70000>;
>>           interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
>> -- 
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>
>>

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
