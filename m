Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E56AC11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EE424676
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgBTJ6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:58:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:37319 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgBTJ6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:58:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 01:58:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,464,1574150400"; 
   d="scan'208";a="259225619"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2020 01:58:36 -0800
Received: from [10.226.39.49] (unknown [10.226.39.49])
        by linux.intel.com (Postfix) with ESMTP id 8A86E580270;
        Thu, 20 Feb 2020 01:58:33 -0800 (PST)
From:   Dilip Kota <eswara.kota@linux.intel.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add YAML schemas for Intel
 Combophy
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
References: <208fcb9660abd560aeab077442d158d84a3dddee.1582021248.git.eswara.kota@linux.intel.com>
 <CAL_JsqL56Ucpm2FK4BPKS+N=5Zxn1iQht7OdJK1pE7cPxtWL-w@mail.gmail.com>
Message-ID: <6f4cad61-b094-78e5-9921-9de0a1d7dbd7@linux.intel.com>
Date:   Thu, 20 Feb 2020 17:58:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL56Ucpm2FK4BPKS+N=5Zxn1iQht7OdJK1pE7cPxtWL-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/19/2020 10:42 PM, Rob Herring wrote:
> On Tue, Feb 18, 2020 at 9:31 PM Dilip Kota<eswara.kota@linux.intel.com>  wrote:
>> Combophy subsystem provides PHY support to various
>> controllers, viz. PCIe, SATA and EMAC.
>> Adding YAML schemas for the same.
>>
>> Signed-off-by: Dilip Kota<eswara.kota@linux.intel.com>
>> ---
>> Changes on v2:
>>
>>   Add custom 'select'
>>   Pass hardware instance entries with phandles and
>>     remove cell-index and bid entries
>>   Clock, register address space, are same for the children.
>>     So move them to parent node.
>>   Two PHY instances cannot run in different modes,
>>     so move the phy-mode entry to parent node.
>>   Add second child entry in the DT example.
>>
>>   .../devicetree/bindings/phy/intel,combo-phy.yaml   | 138 +++++++++++++++++++++
>>   1 file changed, 138 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>> new file mode 100644
>> index 000000000000..8e65a2a71e7f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>> @@ -0,0 +1,138 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:http://devicetree.org/schemas/phy/intel,combo-phy.yaml#
>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Intel Combophy Subsystem
>> +
>> +maintainers:
>> +  - Dilip Kota<eswara.kota@linux.intel.com>
>> +
>> +description: |
>> +  Intel Combophy subsystem supports PHYs for PCIe, EMAC and SATA
>> +  controllers. A single Combophy provides two PHY instances.
>> +
>> +# We need a select here so we don't match all nodes with 'simple-bus'
>> +select:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        const: intel,combo-phy
>> +  required:
>> +    - compatible
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^combophy@[0-9]+$"
> Unit addresses are hex.
Will fix it.
>
>> +
>> +  compatible:
>> +    items:
>> +      - const: intel,combo-phy
> Needs to be an SoC specific compatible.
Sure, will update it to intel, combophy-lgm
>
>> +      - const: simple-bus
>> +
>> +  clocks:
>> +    description: |
>> +      List of phandle and clock specifier pairs as listed
>> +      in clock-names property. Configure the clocks according
>> +      to the PHY mode.
> How many?
>
> No need to redefine a common property name, drop description. Plus,
> where's clock-names?
Its only one clock, i will add maxItems:1 and remove the description.
>
>> +
>> +  reg:
>> +    items:
>> +      - description: ComboPhy core registers
>> +      - description: PCIe app core control registers
>> +
>> +  reg-names:
>> +    items:
>> +      - const: core
>> +      - const: app
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
>> +    description: Chip configuration registers handle and ComboPhy instance id
>> +
>> +  intel,hsio:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: HSIO registers handle and ComboPhy instance id on NOC
>> +
>> +  intel,aggregation:
>> +    description: |
>> +      Specify the flag to confiure ComboPHY in dual lane mode.
>> +    type: boolean
>> +
>> +  intel,phy-mode:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 2
>> +    description: |
>> +      Configure the mode of the PHY.
>> +        0 - PCIe
>> +        1 - xpcs
>> +        2 - sata
> Doesn't this need to be per PHY? Or the 2 PHYs have to be the same mode?
>
> Use the types defined in include/dt-bindings/phy/phy.h. You'll need to
Sure, will define the types in header file.
> add XPCS which maybe should be more specific to distinguish 1G, 10G,
> etc. Also, we typically put the mode into the 'phys' cells so the mode
> lives with the client node.
Two PHYs must be in same mode.
actual mode configuration is done for the ComboPhy to work as a two 
individual PHYs in PCIe/XPCS/SATA mode or as a single PHY providing dual 
physical lanes in PCIe/XPCS.
And mode configuration is dependent on the 'intel,aggregation' flag.
So, placed the phy-mode here itself, to make sure all the mode related 
parameters are at one location. Also, avoids setting individual PHYs in 
different modes.

>> +
>> +patternProperties:
>> +  "^cb[0-9]phy@[0-9]+$":
> ^phy@...

Sure, will fix it.

Regards,
Dilip

>
