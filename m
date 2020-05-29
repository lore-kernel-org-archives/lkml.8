Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2993FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E491D2078C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YYxA8WvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438034AbgE2AXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:23:37 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38306 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438014AbgE2AXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:23:31 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04T0NMtD029760;
        Thu, 28 May 2020 19:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590711802;
        bh=aHNu/nBir3IZGHHHmcRbtuDPSMKgqYMMsI/tOJtCbqk=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=YYxA8WvQWaBwiecc/4Zz6fwql7gDQvB+szY+QZmfvkU7xQycSHi2onjQ7yWS3z5t9
         dRJEnXnfZ0WdUgaP+njuuTldJf4uMIrrjne/+iFRfAwrr+RhoGqS7XCxswIrs1AX5P
         RCzmL6M9bLr6YI2+5U0kUV8elZAyUgAwqmcCZl3M=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04T0NM3l071729
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 19:23:22 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 May 2020 19:23:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 May 2020 19:23:21 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04T0NLrA076843;
        Thu, 28 May 2020 19:23:21 -0500
Subject: Re: [PATCH v2 2/4] dt-bindings: remoteproc: Add bindings for C66x
 DSPs on TI K3 SoCs
From:   Suman Anna <s-anna@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200521001006.2725-1-s-anna@ti.com>
 <20200521001006.2725-3-s-anna@ti.com> <20200528223228.GA785633@bogus>
 <594b649d-eca6-1cd4-3621-c8297a6a9492@ti.com>
Message-ID: <12a97fce-9246-18c4-78e9-e25c76b5abdd@ti.com>
Date:   Thu, 28 May 2020 19:23:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <594b649d-eca6-1cd4-3621-c8297a6a9492@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 5/28/20 5:47 PM, Suman Anna wrote:
> Hi Rob,
> 
> On 5/28/20 5:32 PM, Rob Herring wrote:
>> On Wed, May 20, 2020 at 07:10:04PM -0500, Suman Anna wrote:
>>> Some Texas Instruments K3 family of SoCs have one of more Digital Signal
>>> Processor (DSP) subsystems that are comprised of either a TMS320C66x
>>> CorePac and/or a next-generation TMS320C71x CorePac processor subsystem.
>>> Add the device tree bindings document for the C66x DSP devices on these
>>> SoCs. The added example illustrates the DT nodes for the first C66x DSP
>>> device present on the K3 J721E family of SoCs.
>>>
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>> ---
>>> v2:
>>>   - Updated the example to include the root-node to fix the bot 
>>> errors from v1
>>
>> Pretty sure that was not why you had errors.
> 
> It is because of the default values used for #address-cells and 
> #size-cells in the example_template and example_start variables used in 
> the dt-extract-example script. They are 1 by default, so the generated 
> template ended up with the root-node using 1, and the actual example 
> using 2 resulting in the mismatch.
> 
> When I updated the script to use 2 for both #address-cells and 
> #size-cells, then the warnings go away. This is the reason, dtbs_check 
> on my actual dts files goes through fine.

Just to clarify, the warnings were only because of the mismatched 
'ranges'. If I limit the example to just the dsp node, eliminating all 
ranges usage, then it passes fine.

So, you would see this with any example that uses ranges with 
#address-cells and #size-cells as 2 without explicitly using the 
appropriate top-level #address-cells and #size-cells.

> 
>>
>>>   - Added maxItems to resets, mboxes, memory-region, sram properties
>>>   - Changed the ti,sci-proc-ids $ref to uint-array from uint-matrix
>>>   - Addressed the minor review comments from Mathieu
>>> v1: https://patchwork.kernel.org/patch/11458571/
>>>
>>>   .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 190 ++++++++++++++++++
>>>   1 file changed, 190 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml 
>>> b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
>>> new file mode 100644
>>> index 000000000000..cdf649655838
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
>>> @@ -0,0 +1,190 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: TI K3 DSP devices
>>> +
>>> +maintainers:
>>> +  - Suman Anna <s-anna@ti.com>
>>> +
>>> +description: |
>>> +  The TI K3 family of SoCs usually have one or more TI DSP Core 
>>> sub-systems
>>> +  that are used to offload some of the processor-intensive tasks or 
>>> algorithms,
>>> +  for achieving various system level goals.
>>> +
>>> +  These processor sub-systems usually contain additional sub-modules 
>>> like
>>> +  L1 and/or L2 caches/SRAMs, an Interrupt Controller, an external 
>>> memory
>>> +  controller, a dedicated local power/sleep controller etc. The DSP 
>>> processor
>>> +  cores in the K3 SoCs are usually either a TMS320C66x CorePac 
>>> processor or a
>>> +  TMS320C71x CorePac processor.
>>> +
>>> +  Each DSP Core sub-system is represented as a single DT node. Each 
>>> node has a
>>> +  number of required or optional properties that enable the OS 
>>> running on the
>>> +  host processor (Arm CorePac) to perform the device management of 
>>> the remote
>>> +  processor and to communicate with the remote processor.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: ti,j721e-c66-dsp
>>> +    description:
>>> +      Use "ti,j721e-c66-dsp" for C66x DSPs on K3 J721E SoCs
>>
>> What else are you going to use? There's only one compatible string. Drop
>> description.
> 
> Is updated in a subsequent binding update where I added the C71 support.

See https://patchwork.kernel.org/patch/11563231/.

Let me know if you prefer that I combine both of them. Any changes to 
this patch will also affect the other.

> 
>>
>>> +
>>> +  reg:
>>> +    description: |
>>> +      Should contain an entry for each value in 'reg-names'.
>>> +      Each entry should have the memory region's start address
>>> +      and the size of the region, the representation matching
>>> +      the parent node's '#address-cells' and '#size-cells' values.
>>
>> Don't need generic descriptions. That's every 'reg'.
>>
>> What you can do is an 'items' list describing what each region is.
> 
> OK, I am bit confused here. I have listed the items under the reg-names, 
> while using just the minItems or maxItems here. What is the convention, 
> aren't reg and reg-names associative.
> 
>>
>>> +    minItems: 3
>>> +    maxItems: 3
>>> +
>>> +  reg-names:
>>> +    description: |
>>> +      Should contain strings with the names of the specific internal
>>> +      memory regions, and should be defined in this order
>>
>> Again, drop.
> 
> OK
> 
>>
>>> +    maxItems: 3
>>> +    items:
>>> +      - const: l2sram
>>> +      - const: l1pram
>>> +      - const: l1dram
>>> +
>>> +  ti,sci:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description:
>>> +      Should be a phandle to the TI-SCI System Controller node
>>> +
>>> +  ti,sci-dev-id:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: |
>>> +      Should contain the TI-SCI device id corresponding to the DSP 
>>> core.
>>> +      Please refer to the corresponding System Controller documentation
>>> +      for valid values for the DSP cores.
>>> +
>>> +  ti,sci-proc-ids:
>>> +    description: Should contain a single tuple of <proc_id host_id>.
>>> +    allOf:
>>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +      - maxItems: 1
>>> +        items:
>>> +          items:
>>> +            - description: TI-SCI processor id for the DSP core device
>>> +            - description: TI-SCI host id to which processor control
>>> +                           ownership should be transferred to
>>
>> I assume these properties appear in multiple TI nodes? We don't need
>> them defined multiple times. Create a schema for them that you can
>> include here.
> 
> Only the remoteprocs, so they are limited to this binding and one more 
> R5F remoteproc binding.

Can you confirm if these are the properties you want moved - ti,sci, 
ti,sci-dev-id and ti,sci-proc-ids? Any recommended path I should be 
using, is remoteproc folder still fine for this?

regards
Suman

> 
>>
>>> +
>>> +  resets:
>>> +    description: |
>>> +      Should contain the phandle to the reset controller node
>>> +      managing the local resets for this device, and a reset
>>> +      specifier. Please refer to the following reset bindings
>>> +      for the reset argument specifier,
>>> +      Documentation/devicetree/bindings/reset/ti,sci-reset.txt
>>
>> Drop.
> 
> Entire description or just the reference to the reset bindings file?
> 
>>
>>> +    maxItems: 1
>>> +
>>> +  firmware-name:
>>> +    description: |
>>> +      Should contain the name of the default firmware image
>>> +      file located on the firmware search path
>>> +
>>> +  mboxes:
>>> +    description: |
>>> +      OMAP Mailbox specifier denoting the sub-mailbox, to be used for
>>> +      communication with the remote processor. This property should 
>>> match
>>> +      with the sub-mailbox node used in the firmware image. The 
>>> specifier
>>> +      format is as per the bindings,
>>> +      Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
>>
>> Drop. What mailbox provider is used is outside the scope of this
>> binding.
> 
> OK.
> 
>>
>>> +    maxItems: 1
>>> +
>>> +  memory-region:
>>> +    minItems: 2
>>> +    maxItems: 8
>>> +    description: |
>>> +      phandle to the reserved memory nodes to be associated with the 
>>> remoteproc
>>> +      device. There should be at least two reserved memory nodes 
>>> defined - the
>>> +      first one would be used for dynamic DMA allocations like 
>>> vrings and vring
>>> +      buffers, and the remaining ones used for the firmware image 
>>> sections. The
>>> +      reserved memory nodes should be carveout nodes, and should be 
>>> defined as
>>> +      per the bindings in
>>> +      
>>> Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>>
>> items:
>>    - description: dynamic DMA allocations like vrings and vring buffers
>>    - description: firmware image section ???
>>    - description: firmware image section ???
> 
> Yeah, this is scalable if we will have multiple separate DDR regions. I 
> had to choose a decent maxItems value, so I chose 8. Wouldn't listing 
> the individual items override the number of minItems/maxItems?
> 
>>
>>> +
>>> +# Optional properties:
>>> +# --------------------
>>> +
>>> +  sram:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    minItems: 1
>>> +    maxItems: 4
>>> +    description: |
>>> +      phandles to one or more reserved on-chip SRAM regions. The 
>>> regions
>>> +      should be defined as child nodes of the respective SRAM node, and
>>> +      should be defined as per the generic bindings in,
>>> +      Documentation/devicetree/bindings/sram/sram.yaml
>>> +
>>> +required:
>>> + - compatible
>>> + - reg
>>> + - reg-names
>>> + - ti,sci
>>> + - ti,sci-dev-id
>>> + - ti,sci-proc-ids
>>> + - resets
>>> + - firmware-name
>>> + - mboxes
>>> + - memory-region
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    / {
>>> +        model = "Texas Instruments K3 J721E SoC";
>>> +        compatible = "ti,j721e";
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +
>>> +        /* DSP Carveout reserved memory nodes */
>>> +        reserved-memory {
>>> +            #address-cells = <2>;
>>> +            #size-cells = <2>;
>>> +            ranges;
>>> +
>>> +            c66_0_dma_memory_region: c66-dma-memory@a6000000 {
>>> +                compatible = "shared-dma-pool";
>>> +                reg = <0x00 0xa6000000 0x00 0x100000>;
>>> +                no-map;
>>> +            };
>>> +
>>> +            c66_0_memory_region: c66-memory@a6100000 {
>>> +                compatible = "shared-dma-pool";
>>> +                reg = <0x00 0xa6100000 0x00 0xf00000>;
>>> +                no-map;
>>> +            };
>>> +        };
>>
>> Drop all of this. Outside the scope of this binding. And will likely
>> start failing validation as schemas become more complete.
> 
> This is a complete example because of the memory-region references below.
> 
>>
>>> +
>>> +        cbass_main: bus@100000 {
>>
>> Drop unused labels.
> 
> OK.
> 
> regards
> Suman
> 
>>
>>> +            compatible = "simple-bus";
>>> +            #address-cells = <2>;
>>> +            #size-cells = <2>;
>>> +            ranges = <0x00 0x00100000 0x00 0x00100000 0x00 
>>> 0x00020000>, /* ctrl mmr */
>>> +                     <0x4d 0x80800000 0x4d 0x80800000 0x00 
>>> 0x00800000>, /* C66_0 */
>>> +                     <0x4d 0x81800000 0x4d 0x81800000 0x00 
>>> 0x00800000>; /* C66_1 */
>>> +
>>> +            /* J721E C66_0 DSP node */
>>> +            c66_0: dsp@4d80800000 {
>>> +                compatible = "ti,j721e-c66-dsp";
>>> +                reg = <0x4d 0x80800000 0x00 0x00048000>,
>>> +                      <0x4d 0x80e00000 0x00 0x00008000>,
>>> +                      <0x4d 0x80f00000 0x00 0x00008000>;
>>> +                reg-names = "l2sram", "l1pram", "l1dram";
>>> +                ti,sci = <&dmsc>;
>>> +                ti,sci-dev-id = <142>;
>>> +                ti,sci-proc-ids = <0x03 0xFF>;
>>> +                resets = <&k3_reset 142 1>;
>>> +                firmware-name = "j7-c66_0-fw";
>>> +                memory-region = <&c66_0_dma_memory_region>,
>>> +                                <&c66_0_memory_region>;
>>> +                mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
>>> +            };
>>> +        };
>>> +    };
>>> -- 
>>> 2.26.0
>>>
> 

