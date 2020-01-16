Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A20C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5E1206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgAPKHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 05:07:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:59282 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgAPKHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:07:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 02:07:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,325,1574150400"; 
   d="scan'208";a="220320640"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2020 02:07:42 -0800
Received: from [10.226.39.11] (unknown [10.226.39.11])
        by linux.intel.com (Postfix) with ESMTP id B42475805A3;
        Thu, 16 Jan 2020 02:07:40 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add YAML schemas for Intel Combo
 phy
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
References: <9f3df8c403bba3633391551fc601cbcd2f950959.1576824311.git.eswara.kota@linux.intel.com>
 <20200108141855.GA14868@bogus>
 <0e797d57-66a6-39ec-6388-5af47e9b0726@linux.intel.com>
 <CAL_JsqLaiiYxaWjWRr3S7Q8j5YCxB_v2Lt_m5fwHnZU1e27MdA@mail.gmail.com>
 <bee95b99-027e-45eb-d2f2-bfa5bbfda9cd@linux.intel.com>
 <CAL_JsqK9_EKsrkd3anmwZ062+a0sEmVTwKa1EZRpeLjmfwi7zg@mail.gmail.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <b27e9c8e-8959-95ae-1c4b-45ae8cd5d949@linux.intel.com>
Date:   Thu, 16 Jan 2020 18:07:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK9_EKsrkd3anmwZ062+a0sEmVTwKa1EZRpeLjmfwi7zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/16/2020 3:51 AM, Rob Herring wrote:
> On Wed, Jan 15, 2020 at 1:52 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>>
>> On 1/14/2020 10:31 PM, Rob Herring wrote:
>>> On Tue, Jan 14, 2020 at 3:18 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>>>> On 1/8/2020 10:18 PM, Rob Herring wrote:
>>>>> On Fri, Dec 20, 2019 at 03:28:27PM +0800, Dilip Kota wrote:
>>>>>> Combo phy subsystem provides PHY support to number of
>>>>>> controllers, viz. PCIe, SATA and EMAC.
>>>>>> Adding YAML schemas for the same.
>>>>>>
>>>>>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>>>>>> ---
>>>>>>     .../devicetree/bindings/phy/intel,combo-phy.yaml   | 147 +++++++++++++++++++++
>>>>>>     1 file changed, 147 insertions(+)
>>>>>>     create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..fc9cbad9dd88
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>>>>>> @@ -0,0 +1,147 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/phy/intel,combo-phy.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Intel Combo phy Subsystem
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Dilip Kota <eswara.kota@linux.intel.com>
>>>>>> +
>>>>>> +description: |
>>>>>> +  Intel combo phy subsystem supports PHYs for PCIe, EMAC and SATA
>>>>>> +  controllers. A single combo phy provides two PHY instances.
>>>>>> +
>>>>>> +properties:
>>>>>> +  $nodename:
>>>>>> +    pattern: "^combophy@[0-9]+$"
>>>>>> +
>>>>>> +  compatible:
>>>>>> +    items:
>>>>>> +      - const: intel,combo-phy
>>>>>> +      - const: simple-bus
>>>>> This will cause the schema to be applied to every 'simple-bus'. You need
>>>>> a custom 'select' to prevent that. There's several examples in the tree.
>>>> Ok, i will add as below:
>>>>
>>>> # We need a select here so we don't match all nodes with 'simple-bus'
>>>> select:
>>>>      properties:
>>>>        compatible:
>>>>          contains:
>>>>            const: intel,combo-phy
>>>>      required:
>>>>        - compatible
>>>>
>>>>> Though I'm not sure you need child nodes here.
>>>>>
>>>>>> +
>>>>>> +  cell-index:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +    description: Index of Combo phy hardware instance.
>>>>> Drop this. Not used for FDT.
>>>> Ok, I will remove this and use the 'aliases' to get the hardware instance.
>>>>>> +
>>>>>> +  resets:
>>>>>> +    maxItems: 2
>>>>>> +
>>>>>> +  reset-names:
>>>>>> +    items:
>>>>>> +      - const: phy
>>>>>> +      - const: core
>>>>>> +
>>>>>> +  intel,syscfg:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>>> +    description: Chip configuration registers handle
>>>>>> +
>>>>>> +  intel,hsio:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>>> +    description: HSIO registers handle
>>>>>> +
>>>>>> +  intel,bid:
>>>>>> +    description: Index of HSIO bus
>>>>>> +    allOf:
>>>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +      - minimum: 0
>>>>>> +      - maximum: 1
>>>>> If this is related to intel,hsio, just make it an args cell for
>>>>> intel,hsio.
>>>> No. Actually, this is specific to the combophy instance on the HSIO bus.
>>>> I see , this can be removed and value can be derived from the hardware
>>>> instance value mentioned through 'aliases'
>>> Generally, 'aliases' should be optional. Why do you need an index?
>>> What's the difference between the blocks?
>>>
>>> If it wasn't clear, I was suggesting doing:
>>>
>>> intel,hsio = <&hsio 1>;
>> On the SoC, total 4 combophy (0,1,2 and 3) instances are present ->
>> 'cell-index'
>> 2 instances (0,1) are present on the HSIOL NoC
>> Other 2 instances (2,3) are present on the HSIOR NoC
>> On the both HSIO NoCs, combophy instances are referred as 0 and 1 -> 'bid'
> So you would have:
>
> <&hsiol 0>
> <&hsiol 1>
> <&hsior 0>
> <&hsior 1>
>
> However, if HSIO is a bus and the combo phys are not on any other bus,
> then perhaps you should be describing the buses in DT and then this
> property goes away as these would be child nodes of the bus and
> whatever addressing identifiers there are would go in 'reg'.
>
>> 'bid' is required while accessing the registers in hsio block, to
>> configure the COMBOPHY mode and clock
>> 'cell-index' is required while accessing sysconfig registers to enable
>> the pcie phy pad ref clock.
> Do the same thing for the sysconfig handle:
>
> <&sysconfig 0|1>
>
> This is the common pattern for these types of properties with misc
> extra register bits to go configure. Though more typically the cell
> value is a register offset and bit position.
>
>> <&hsio 1>
>> 'bid' is specific to the combophy, not all the DT nodes using &hsio has
>> a need.
>> I think it is better to pass the bid value as a entry of combophy DT node.
> intel,hsio is an entry in the combo phy. The meaning of any arg cells
> is defined by the combo phy binding (and driver).
>
>> I will add dt entry something like 'hw-instance-id' instead of
>> cell-index or aliases.
> As I said, we don't do h/w index properties.

Ok, then i will pass it as you suggested -> <&hsiol 1>

Regards,
Dilip

>
> Rob
