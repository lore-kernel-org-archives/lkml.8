Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72978C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EB120678
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s8ZN2g2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgFBMge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:36:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54792 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgFBMge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:36:34 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 052CaW1v086241;
        Tue, 2 Jun 2020 07:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591101392;
        bh=fFGspWtMZRHNuJijyv/XxS0KUeZmp81UfpxM0oy4uJQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=s8ZN2g2psIwYj7lFc+zqFuWddwZ0akXgtYoFhQV9+EXkhdLl+vA97FP7mP/Pg85Dr
         MQ+V1zqcTPWGR+iLrB2jxQKiNEiNA6Cz8TLVlI++hYXgcl6aODAibpwRNWrEJpOvgx
         u07Wvuqwtuyct2jAiB3a8jwH30Kn8GS50dOx3HEE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 052CaWGW026766
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Jun 2020 07:36:32 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 2 Jun
 2020 07:36:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 2 Jun 2020 07:36:31 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 052CaTpA039892;
        Tue, 2 Jun 2020 07:36:30 -0500
Subject: Re: [PATCH 1/3] dt-bindings: usb: convert keystone-usb.txt to YAML
To:     Rob Herring <robh@kernel.org>
CC:     <balbi@kernel.org>, <vigneshr@ti.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200513130709.10239-1-rogerq@ti.com>
 <20200513130709.10239-2-rogerq@ti.com> <20200527013715.GA847644@bogus>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <4cb847d1-32b0-419f-a7e5-9945bc32b890@ti.com>
Date:   Tue, 2 Jun 2020 15:36:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527013715.GA847644@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

Thanks for the review. Since this patch was already picked up I will
address the issues in a follow up patch.

cheers,
-roger

On 27/05/2020 04:37, Rob Herring wrote:
> On Wed, May 13, 2020 at 04:07:07PM +0300, Roger Quadros wrote:
>> Convert keystone-usb documentation to YAML format.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   .../devicetree/bindings/usb/keystone-usb.txt  | 56 ----------------
>>   .../bindings/usb/ti,keystone-dwc3.yaml        | 67 +++++++++++++++++++
>>   2 files changed, 67 insertions(+), 56 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/usb/keystone-usb.txt
>>   create mode 100644 Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/usb/keystone-usb.txt b/Documentation/devicetree/bindings/usb/keystone-usb.txt
>> deleted file mode 100644
>> index 77df82e36138..000000000000
>> --- a/Documentation/devicetree/bindings/usb/keystone-usb.txt
>> +++ /dev/null
>> @@ -1,56 +0,0 @@
>> -TI Keystone Soc USB Controller
>> -
>> -DWC3 GLUE
>> -
>> -Required properties:
>> - - compatible: should be
>> -		"ti,keystone-dwc3" for Keystone 2 SoCs
>> -		"ti,am654-dwc3" for AM654 SoC
>> - - #address-cells, #size-cells : should be '1' if the device has sub-nodes
>> -   with 'reg' property.
>> - - reg : Address and length of the register set for the USB subsystem on
>> -   the SOC.
>> - - interrupts : The irq number of this device that is used to interrupt the
>> -   MPU.
>> - - ranges: allows valid 1:1 translation between child's address space and
>> -   parent's address space.
>> -
>> -SoC-specific Required Properties:
>> -The following are mandatory properties for Keystone 2 66AK2HK, 66AK2L and 66AK2E
>> -SoCs only:
>> -
>> -- clocks:		Clock ID for USB functional clock.
>> -- clock-names:		Must be "usb".
>> -
>> -
>> -The following are mandatory properties for 66AK2G and AM654:
>> -
>> -- power-domains:	Should contain a phandle to a PM domain provider node
>> -			and an args specifier containing the USB device id
>> -			value. This property is as per the binding,
>> -			Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>> -
>> -Sub-nodes:
>> -The dwc3 core should be added as subnode to Keystone DWC3 glue.
>> -- dwc3 :
>> -   The binding details of dwc3 can be found in:
>> -   Documentation/devicetree/bindings/usb/dwc3.txt
>> -
>> -Example:
>> -	usb: usb@2680000 {
>> -		compatible = "ti,keystone-dwc3";
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>> -		reg = <0x2680000 0x10000>;
>> -		clocks = <&clkusb>;
>> -		clock-names = "usb";
>> -		interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
>> -		ranges;
>> -
>> -		dwc3@2690000 {
>> -			compatible = "synopsys,dwc3";
>> -			reg = <0x2690000 0x70000>;
>> -			interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
>> -			usb-phy = <&usb_phy>, <&usb_phy>;
>> -		};
>> -	};
>> diff --git a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
>> new file mode 100644
>> index 000000000000..14d2fe329b93
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
>> @@ -0,0 +1,67 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/usb/ti,keystone-dwc3.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI Keystone Soc USB Controller
>> +
>> +maintainers:
>> +  - Roger Quadros <rogerq@ti.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: "ti,keystone-dwc3"
>> +      - const: "ti,am654-dwc3"
> 
> Use enum rather than oneOf+const.
> 
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: Address and length of the register set for the USB subsystem on
>> +      the SOC.
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description: The irq number of this device that is used to interrupt the MPU.
> 
> No need for genericish descriptions when a single item.
> 
>> +
>> +
>> +  clocks:
>> +    description: Clock ID for USB functional clock.
> 
> How many?
> 
>> +
>> +  power-domains:
>> +    description: Should contain a phandle to a PM domain provider node
>> +      and an args specifier containing the USB device id
>> +      value. This property is as per the binding,
>> +      Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> 
> How many?
> 
>> +
>> +  dwc3:
> 
> This doesn't work because there's a unit address. You need a pattern.
> 
>> +    description: This is the node representing the DWC3 controller instance
>> +      Documentation/devicetree/bindings/usb/dwc3.txt
> 
> type: object
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
> 
> additionalProperties: false
> 
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    usb: usb@2680000 {
>> +      compatible = "ti,keystone-dwc3";
>> +      #address-cells = <1>;
>> +      #size-cells = <1>;
> 
> These have to be documented.
> 
>> +      reg = <0x2680000 0x10000>;
>> +      clocks = <&clkusb>;
>> +      clock-names = "usb";
>> +      interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
>> +      ranges;
> 
> This too.
> 
>> +
>> +      dwc3@2690000 {
>> +        compatible = "synopsys,dwc3";
>> +        reg = <0x2690000 0x70000>;
>> +        interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
>> +        usb-phy = <&usb_phy>, <&usb_phy>;
>> +      };
>> +    };
>> -- 
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
