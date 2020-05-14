Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA60C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8423A206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="q9SDnPWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgENQhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:37:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47725 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbgENQhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:37:41 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EGWUkS001136;
        Thu, 14 May 2020 18:37:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=KReqvoQOPXTJ96JZDs+ZdzVVbAczUMc3zsxTmPWmvxI=;
 b=q9SDnPWOFfhSi8oN1yhwBaEHSxFMYJHp6DY9Kht8l6w6vp727CguRfUP0zmT+TDhBNg5
 Vg66vfw4+mCdtUFhe6MRyK0sjWIcir+Ex8Rjh1KrHKp0EHI+QWvF+pxBf/WQzSR+r5iK
 mIimbDtnRsq8zWgd0I22mt/aOy9sT9XTCeLotWd0OnAGBFpnVKeCMC0aB7CJj6xS0deq
 StHUou5unUoz62fMhPHc729MaXgbQ6vsQpPv7cb/HzURhv908YQC+8pNPbRL4tpFI39u
 4g3pzNAXYIJ1lE/GtF7NMMAi2OrkbD8wCk5eDWyIIgI6hqU8CcYqxAoALXJhJ27s9dyI HQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3100vqmfvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 18:37:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B311A10002A;
        Thu, 14 May 2020 18:37:09 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7EC3A2AA60E;
        Thu, 14 May 2020 18:37:09 +0200 (CEST)
Received: from [10.211.8.23] (10.75.127.47) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 May
 2020 18:37:08 +0200
Subject: Re: [PATCH v4 07/10] dt-bindings: memory-controller: add STM32 FMC2
 EBI controller documentation
To:     Rob Herring <robh@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
References: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
 <1588756279-17289-8-git-send-email-christophe.kerello@st.com>
 <20200514150730.GA10372@bogus>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <99d7f354-ed80-ef9f-beb1-4b104eb7e3b6@st.com>
Date:   Thu, 14 May 2020 18:37:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200514150730.GA10372@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 5/14/20 5:07 PM, Rob Herring wrote:
> On Wed, May 06, 2020 at 11:11:16AM +0200, Christophe Kerello wrote:
>> This patch adds the documentation of the device tree bindings for the STM32
>> FMC2 EBI controller.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>> ---
>> Changes in v4:
>>   - fix filename: st,stm32-fmc2-ebi.yaml
>>
>> Changes in v3:
>>   - pattern name has been modified
>>   - vendor properties have been modified
>>     - s/_/-/
>>     - add unit suffix (-ns) on timing properties
>>
>>   .../memory-controllers/st,stm32-fmc2-ebi.yaml      | 261 +++++++++++++++++++++
>>   1 file changed, 261 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml b/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
>> new file mode 100644
>> index 0000000..bf130c3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
>> @@ -0,0 +1,261 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/memory-controllers/st,stm32-fmc2-ebi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STMicroelectronics Flexible Memory Controller 2 (FMC2) Bindings
>> +
>> +description: |
>> +  The FMC2 functional block makes the interface with: synchronous and
>> +  asynchronous static devices (such as PSNOR, PSRAM or other memory-mapped
>> +  peripherals) and NAND flash memories.
>> +  Its main purposes are:
>> +    - to translate AXI transactions into the appropriate external device
>> +      protocol
>> +    - to meet the access time requirements of the external devices
>> +  All external devices share the addresses, data and control signals with the
>> +  controller. Each external device is accessed by means of a unique Chip
>> +  Select. The FMC2 performs only one access at a time to an external device.
>> +
>> +maintainers:
>> +  - Christophe Kerello <christophe.kerello@st.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: st,stm32mp1-fmc2-ebi
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  "#address-cells":
>> +    const: 2
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  ranges:
>> +    description: |
>> +      Reflects the memory layout with four integer values per bank. Format:
>> +      <bank-number> 0 <address of the bank> <size>
>> +
>> +patternProperties:
>> +  "^.*@[0-4],[a-f0-9]+$":
>> +    type: object
>> +
>> +    properties:
>> +      reg:
>> +        description: Bank number, base address and size of the device.
>> +
>> +      st,fmc2-ebi-cs-transaction-type:
>> +        description: |
>> +                     Select one of the transactions type supported
> 
> Indent should be 2 more than 'description'.

Ok, it will be part of v5.

> 
>> +                       0: Asynchronous mode 1 SRAM/FRAM.
>> +                       1: Asynchronous mode 1 PSRAM.
>> +                       2: Asynchronous mode A SRAM/FRAM.
>> +                       3: Asynchronous mode A PSRAM.
>> +                       4: Asynchronous mode 2 NOR.
>> +                       5: Asynchronous mode B NOR.
>> +                       6: Asynchronous mode C NOR.
>> +                       7: Asynchronous mode D NOR.
>> +                       8: Synchronous read synchronous write PSRAM.
>> +                       9: Synchronous read asynchronous write PSRAM.
>> +                       10: Synchronous read synchronous write NOR.
>> +                       11: Synchronous read asynchronous write NOR.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        minimum: 0
>> +        maximum: 11
>> +
>> +      st,fmc2-ebi-cs-cclk-enable:
>> +        description: Continuous clock enable (first bank must be configured
>> +                     in synchronous mode). The FMC_CLK is generated continuously
>> +                     during asynchronous and synchronous access. By default, the
>> +                     FMC_CLK is only generated during synchronous access.
> 
> Indent 2 more than 'description'. You can run this through yaml-format
> in dtschema repo and it will re-flow everything for you.

Ok, it will be part of v5.

Regards,
Christophe Kerello.

> 
> With these fixed,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> 
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +
>> +      st,fmc2-ebi-cs-mux-enable:
>> +        description: Address/Data multiplexed on databus (valid only with
>> +                     NOR and PSRAM transactions type). By default, Address/Data
>> +                     are not multiplexed.
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +
>> +      st,fmc2-ebi-cs-buswidth:
>> +        description: Data bus width
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum: [ 8, 16 ]
>> +        default: 16
>> +
>> +      st,fmc2-ebi-cs-waitpol-high:
>> +        description: Wait signal polarity (NWAIT signal active high).
>> +                     By default, NWAIT is active low.
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +
>> +      st,fmc2-ebi-cs-waitcfg-enable:
>> +        description: The NWAIT signal indicates wheither the data from the
>> +                     device are valid or if a wait state must be inserted when
>> +                     accessing the device in synchronous mode. By default, the
>> +                     NWAIT signal is active one data cycle before wait state.
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +
>> +      st,fmc2-ebi-cs-wait-enable:
>> +        description: The NWAIT signal is enabled (its level is taken into
>> +                     account after the programmed latency period to insert wait
>> +                     states if asserted). By default, the NWAIT signal is
>> +                     disabled.
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +
>> +      st,fmc2-ebi-cs-asyncwait-enable:
>> +        description: The NWAIT signal is taken into account during asynchronous
>> +                     transactions. By default, the NWAIT signal is not taken
>> +                     into account during asynchronous transactions.
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +
>> +      st,fmc2-ebi-cs-cpsize:
>> +        description: CRAM page size. The controller splits the burst access
>> +                     when the memory page is reached. By default, no burst
>> +                     split when crossing page boundary.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum: [ 0, 128, 256, 512, 1024 ]
>> +        default: 0
>> +
>> +      st,fmc2-ebi-cs-byte-lane-setup-ns:
>> +        description: This property configures the byte lane setup timing
>> +                     defined in nanoseconds from NBLx low to Chip Select NEx
>> +                     low.
>> +
>> +      st,fmc2-ebi-cs-address-setup-ns:
>> +        description: This property defines the duration of the address setup
>> +                     phase in nanoseconds used for asynchronous read/write
>> +                     transactions.
>> +
>> +      st,fmc2-ebi-cs-address-hold-ns:
>> +        description: This property defines the duration of the address hold
>> +                     phase in nanoseconds used for asynchronous multiplexed
>> +                     read/write transactions.
>> +
>> +      st,fmc2-ebi-cs-data-setup-ns:
>> +        description: This property defines the duration of the data setup phase
>> +                     in nanoseconds used for asynchronous read/write
>> +                     transactions.
>> +
>> +      st,fmc2-ebi-cs-bus-turnaround-ns:
>> +        description: This property defines the delay in nanoseconds between the
>> +                     end of current read/write transaction and the next
>> +                     transaction.
>> +
>> +      st,fmc2-ebi-cs-data-hold-ns:
>> +        description: This property defines the duration of the data hold phase
>> +                     in nanoseconds used for asynchronous read/write
>> +                     transactions.
>> +
>> +      st,fmc2-ebi-cs-clk-period-ns:
>> +        description: This property defines the FMC_CLK output signal period in
>> +                     nanoseconds.
>> +
>> +      st,fmc2-ebi-cs-data-latency-ns:
>> +        description: This property defines the data latency before reading or
>> +                     writing the first data in nanoseconds.
>> +
>> +      st,fmc2_ebi-cs-write-address-setup-ns:
>> +        description: This property defines the duration of the address setup
>> +                     phase in nanoseconds used for asynchronous write
>> +                     transactions.
>> +
>> +      st,fmc2-ebi-cs-write-address-hold-ns:
>> +        description: This property defines the duration of the address hold
>> +                     phase in nanoseconds used for asynchronous multiplexed
>> +                     write transactions.
>> +
>> +      st,fmc2-ebi-cs-write-data-setup-ns:
>> +        description: This property defines the duration of the data setup
>> +                     phase in nanoseconds used for asynchronous write
>> +                     transactions.
>> +
>> +      st,fmc2-ebi-cs-write-bus-turnaround-ns:
>> +        description: This property defines the delay between the end of current
>> +                     write transaction and the next transaction in nanoseconds.
>> +
>> +      st,fmc2-ebi-cs-write-data-hold-ns:
>> +        description: This property defines the duration of the data hold phase
>> +                     in nanoseconds used for asynchronous write transactions.
>> +
>> +      st,fmc2-ebi-cs-max-low-pulse-ns:
>> +        description: This property defines the maximum chip select low pulse
>> +                     duration in nanoseconds for synchronous transactions. When
>> +                     this timing reaches 0, the controller splits the current
>> +                     access, toggles NE to allow device refresh and restarts a
>> +                     new access.
>> +
>> +    required:
>> +      - reg
>> +
>> +required:
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - ranges
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/stm32mp1-clks.h>
>> +    #include <dt-bindings/reset/stm32mp1-resets.h>
>> +    memory-controller@58002000 {
>> +      #address-cells = <2>;
>> +      #size-cells = <1>;
>> +      compatible = "st,stm32mp1-fmc2-ebi";
>> +      reg = <0x58002000 0x1000>;
>> +      clocks = <&rcc FMC_K>;
>> +      resets = <&rcc FMC_R>;
>> +
>> +      ranges = <0 0 0x60000000 0x04000000>, /* EBI CS 1 */
>> +               <1 0 0x64000000 0x04000000>, /* EBI CS 2 */
>> +               <2 0 0x68000000 0x04000000>, /* EBI CS 3 */
>> +               <3 0 0x6c000000 0x04000000>, /* EBI CS 4 */
>> +               <4 0 0x80000000 0x10000000>; /* NAND */
>> +
>> +      psram@0,0 {
>> +        compatible = "mtd-ram";
>> +        reg = <0 0x00000000 0x100000>;
>> +        bank-width = <2>;
>> +
>> +        st,fmc2-ebi-cs-transaction-type = <1>;
>> +        st,fmc2-ebi-cs-address-setup-ns = <60>;
>> +        st,fmc2-ebi-cs-data-setup-ns = <30>;
>> +        st,fmc2-ebi-cs-bus-turnaround-ns = <5>;
>> +      };
>> +
>> +      nand-controller@4,0 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        compatible = "st,stm32mp15-fmc2";
>> +        reg = <4 0x00000000 0x1000>,
>> +              <4 0x08010000 0x1000>,
>> +              <4 0x08020000 0x1000>,
>> +              <4 0x01000000 0x1000>,
>> +              <4 0x09010000 0x1000>,
>> +              <4 0x09020000 0x1000>;
>> +        interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>> +        dmas = <&mdma1 20 0x2 0x12000a02 0x0 0x0>,
>> +               <&mdma1 20 0x2 0x12000a08 0x0 0x0>,
>> +               <&mdma1 21 0x2 0x12000a0a 0x0 0x0>;
>> +        dma-names = "tx", "rx", "ecc";
>> +
>> +        nand@0 {
>> +          reg = <0>;
>> +          nand-on-flash-bbt;
>> +          #address-cells = <1>;
>> +          #size-cells = <1>;
>> +        };
>> +      };
>> +    };
>> +
>> +...
>> -- 
>> 1.9.1
>>
