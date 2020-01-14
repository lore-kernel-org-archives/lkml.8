Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E26C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9BD2187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgANJS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:18:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:19090 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgANJSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:18:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 01:18:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,432,1571727600"; 
   d="scan'208";a="397449438"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2020 01:18:53 -0800
Received: from [10.226.39.11] (unknown [10.226.39.11])
        by linux.intel.com (Postfix) with ESMTP id 018B25802B1;
        Tue, 14 Jan 2020 01:18:50 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add YAML schemas for Intel Combo
 phy
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
References: <9f3df8c403bba3633391551fc601cbcd2f950959.1576824311.git.eswara.kota@linux.intel.com>
 <20200108141855.GA14868@bogus>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <0e797d57-66a6-39ec-6388-5af47e9b0726@linux.intel.com>
Date:   Tue, 14 Jan 2020 17:18:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200108141855.GA14868@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/8/2020 10:18 PM, Rob Herring wrote:
> On Fri, Dec 20, 2019 at 03:28:27PM +0800, Dilip Kota wrote:
>> Combo phy subsystem provides PHY support to number of
>> controllers, viz. PCIe, SATA and EMAC.
>> Adding YAML schemas for the same.
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>>   .../devicetree/bindings/phy/intel,combo-phy.yaml   | 147 +++++++++++++++++++++
>>   1 file changed, 147 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>> new file mode 100644
>> index 000000000000..fc9cbad9dd88
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>> @@ -0,0 +1,147 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/intel,combo-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Intel Combo phy Subsystem
>> +
>> +maintainers:
>> +  - Dilip Kota <eswara.kota@linux.intel.com>
>> +
>> +description: |
>> +  Intel combo phy subsystem supports PHYs for PCIe, EMAC and SATA
>> +  controllers. A single combo phy provides two PHY instances.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^combophy@[0-9]+$"
>> +
>> +  compatible:
>> +    items:
>> +      - const: intel,combo-phy
>> +      - const: simple-bus
> This will cause the schema to be applied to every 'simple-bus'. You need
> a custom 'select' to prevent that. There's several examples in the tree.

Ok, i will add as below:

# We need a select here so we don't match all nodes with 'simple-bus'
select:
   properties:
     compatible:
       contains:
         const: intel,combo-phy
   required:
     - compatible

>
> Though I'm not sure you need child nodes here.
>
>> +
>> +  cell-index:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Index of Combo phy hardware instance.
> Drop this. Not used for FDT.
Ok, I will remove this and use the 'aliases' to get the hardware instance.
>
>> +
>> +  resets:
>> +    maxItems: 2
>> +
>> +  reset-names:
>> +    items:
>> +      - const: phy
>> +      - const: core
>> +
>> +  intel,syscfg:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Chip configuration registers handle
>> +
>> +  intel,hsio:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: HSIO registers handle
>> +
>> +  intel,bid:
>> +    description: Index of HSIO bus
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>> +      - minimum: 0
>> +      - maximum: 1
> If this is related to intel,hsio, just make it an args cell for
> intel,hsio.
No. Actually, this is specific to the combophy instance on the HSIO bus.
I see , this can be removed and value can be derived from the hardware 
instance value mentioned through 'aliases'
>> +
>> +  intel,cap-pcie-only:
>> +    description: |
>> +      This flag specifies capability of the combo phy.
>> +      If it is set, combo phy has only PCIe capability.
>> +      Else it has PCIe, XPCS and SATA PHY capabilities.
>> +    type: boolean
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  ranges: true
>> +
>> +patternProperties:
>> +  "^cb[0-9]phy@[0-9]+$":
>> +    type: object
>> +
>> +    properties:
>> +      compatible:
>> +        const: intel,phydev
>> +
>> +      "#phy-cells":
>> +        const: 0
>> +
>> +      reg:
>> +        description: Offset and size of pcie phy control registers
>> +
>> +      intel,phy-mode:
>> +        description: |
>> +          Configure the mode of the PHY.
>> +            0 - PCIe
>> +            1 - xpcs
>> +            2 - sata
> PHY mode is normally a cell in the client's phys property. There's
> already common defines for this.
Sure, will update the code to use phys property and remove this entry,
>
>> +        allOf:
>> +          - $ref: /schemas/types.yaml#/definitions/uint32
>> +          - minimum: 0
>> +          - maximum: 2
>> +
>> +      clocks:
>> +        description: |
>> +          List of phandle and clock specifier pairs as listed
>> +          in clock-names property. Configure the clocks according
>> +          to the PHY mode.
>> +
>> +      resets:
>> +        description: |
>> +          reset handle according to the PHY mode.
>> +          See ../reset/reset.txt for details.
>> +
>> +    required:
>> +      - compatible
>> +      - reg
>> +      - "#phy-cells"
>> +      - clocks
>> +      - intel,phy-mode
>> +
>> +required:
>> +  - compatible
>> +  - cell-index
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - ranges
>> +  - intel,syscfg
>> +  - intel,hsio
>> +  - intel,bid
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    combophy@0 {
>> +        compatible = "intel,combo-phy", "simple-bus";
>> +        cell-index = <0>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges;
>> +        resets = <&rcu0 0x50 6>,
>> +        	 <&rcu0 0x50 17>;
>> +        reset-names = "phy", "core";
>> +        intel,syscfg = <&sysconf>;
>> +        intel,hsio = <&hsiol>;
>> +        intel,bid = <0>;
>> +
>> +        cb0phy0:cb0phy@0 {
>> +            compatible = "intel,phydev";
>> +            #phy-cells = <0>;
>> +            reg = <0xd0a40000 0x1000>;
>> +            clocks = <&cgu0 1>;
>> +            resets = <&rcu0 0x50 23>;
>> +            intel,phy-mode = <0>;
>> +        };
> If you only have 1 child, then you don't need a child node here. Is this
> example complete?
2 children are required, as it is an example i just added one.
I will add the other child too.

Thanks for reviewing and giving the inputs.


Regards,
Dilip

>> +    };
>> +
>> +
>> -- 
>> 2.11.0
>>
