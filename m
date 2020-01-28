Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DB9C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685A924686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RwfwFUC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgA1KEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:04:47 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47568 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgA1KEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:04:47 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00SA4aSh116455;
        Tue, 28 Jan 2020 04:04:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580205876;
        bh=KaBVDF333d50tyl+ezVv+2/YjxyaZOF6yYfqChbDnm0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RwfwFUC+3OZgG55Y5WffvYH2axkDc1vCft/1dhMzn/IsYRHNp+ye+ilUOHj3kuTrp
         kzxZUm+3k1YZ4PXvZkCFb6Jl4Ku+ETn8XrR6A2E6k1RITfACCXSO/zQ6PLXuXDoGGg
         9qDCh1T/ceYXHk2cBLmifw3LJwYXHs0/RRrXklzk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00SA4a9U113766
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jan 2020 04:04:36 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 28
 Jan 2020 04:04:35 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 28 Jan 2020 04:04:35 -0600
Received: from [10.1.3.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00SA4WJN092468;
        Tue, 28 Jan 2020 04:04:33 -0600
Subject: Re: [PATCH v3 13/14] dt-bindings: phy: phy-cadence-torrent: Add
 subnode bindings.
To:     Rob Herring <robh@kernel.org>, Yuti Amonkar <yamonkar@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <mark.rutland@arm.com>, <maxime@cerno.tech>,
        <tomi.valkeinen@ti.com>, <praneeth@ti.com>, <mparab@cadence.com>,
        <sjakhade@cadence.com>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
 <1579689918-7181-14-git-send-email-yamonkar@cadence.com>
 <20200127164235.GA7662@bogus>
From:   Jyri Sarha <jsarha@ti.com>
Autocrypt: addr=jsarha@ti.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3e5d7620-d1ec-ba37-0b5b-e28ed74e49d9@ti.com>
Date:   Tue, 28 Jan 2020 12:04:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200127164235.GA7662@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2020 18:42, Rob Herring wrote:
> On Wed, Jan 22, 2020 at 11:45:17AM +0100, Yuti Amonkar wrote:
>> From: Swapnil Jakhade <sjakhade@cadence.com>
>>
>> Add sub-node bindings for each group of PHY lanes based on PHY
>> type. Only PHY_TYPE_DP is supported currently. Each sub-node
> 
> What the driver supports is not relevant to the binding. Define all 
> modes.
> 
>> includes properties such as master lane number, link reset, phy
>> type, number of lanes etc.
> 
> Given the conversion and this have no compatibility, just make the 
> commits delete the old binding and add this new binding. I'd rather not 
> have reviewed what just gets deleted here.
> 
>>
>> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
>> ---
>>  .../bindings/phy/phy-cadence-torrent.yaml          | 90 ++++++++++++++++++----
>>  1 file changed, 73 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
>> index dbb8aa5..eb21615 100644
>> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
>> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
>> @@ -19,6 +19,12 @@ properties:
>>        - cdns,torrent-phy
>>        - ti,j721e-serdes-10g
>>  
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>>    clocks:
>>      maxItems: 1
>>      description:
>> @@ -41,44 +47,94 @@ properties:
>>        - const: torrent_phy
>>        - const: dptx_phy
>>  
>> -  "#phy-cells":
>> -    const: 0
>> +  resets:
>> +    description:
>> +      Must contain an entry for each in reset-names.
>> +      See Documentation/devicetree/bindings/reset/reset.txt
> 
> How many reset entries? Needs a 'maxItems: 1' or an 'items' list if more 
> than 1.
> 
>>  
>> -  num_lanes:
>> +  reset-names:
>>      description:
>> -      Number of DisplayPort lanes.
>> -    allOf:
>> -      - $ref: /schemas/types.yaml#/definitions/uint32
>> -      - enum: [1, 2, 4]
>> +      Must be "torrent_reset". It controls the reset to the
> 
> Should be a schema, not freeform text. However, not really a useful name 
> as there's only 1, so I'd just remove 'reset-names'.
> 

This binding is trying to follow "cdns,sierra-phy-t0" binding [1] when
it makes sense. Sierra defines two resets here. But if we can not name
the other reset now (at least I can not), I guess we can just drop the
reset-names here.

>> +      torrent PHY.
>>  
>> -  max_bit_rate:
>> +patternProperties:
>> +  '^torrent-phy@[0-7]+$':
>> +    type: object
>>      description:
>> -      Maximum DisplayPort link bit rate to use, in Mbps
>> -    allOf:
>> -      - $ref: /schemas/types.yaml#/definitions/uint32
>> -      - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
>> +      Each group of PHY lanes with a single master lane should be represented as a sub-node.
>> +    properties:
>> +      reg:
>> +        description:
>> +          The master lane number. This is the lowest numbered lane in the lane group.
> 
> Why not make it the list of lane numbers. Then you don't need num-lanes.
> 

Sierra binding already defines this method [1] and my plan was to rely
on this method when selecting the lane types in the
"ti,phy-j721e-wiz"-driver [2].

IOW, I would like the both Sierra and Torrent bindings (which both are
wrapped by the wiz wrapper IP) to be compatible enough for wiz driver to
peek the lane types from the wrapped phy-node.

>> +
>> +      resets:
>> +        description:
>> +          Contains list of resets to get all the link lanes out of reset.
> 
> Needs a schema for how many? 1 per lane?
> 

That is what the current implementation is, but do we have to lock it
down in the binding? There can hardly be more than 1 / lane, but I can
imagine it to be just one for a number of lanes.

>> +
>> +      "#phy-cells":
>> +        description:
>> +          Generic PHY binding.
> 
> Not a useful description. Remove.
> 
>> +        const: 0
>> +
>> +      cdns,phy-type:
>> +        description:
>> +          Should be PHY_TYPE_DP.
> 
> Sounds like a constraint.
> 

I do not think there is point to limit this to PHY_TYPE_DP only. The
current implementation may not support anything else but DP, but we
should not limit the binding because of it. I think referring to the
include/dt-bindings/phy/phy.h header here would be appropriate.

>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +      cdns,num-lanes:
>> +        description:
>> +          Number of DisplayPort lanes.
>> +        allOf:
>> +          - $ref: /schemas/types.yaml#/definitions/uint32
>> +          - enum: [1, 2, 4]
>> +
>> +      cdns,max-bit-rate:
>> +        description:
>> +          Maximum DisplayPort link bit rate to use, in Mbps
>> +        allOf:
>> +          - $ref: /schemas/types.yaml#/definitions/uint32
>> +          - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
>> +
>> +    required:
>> +      - reg
>> +      - resets
>> +      - "#phy-cells"
>> +      - cdns,phy-type
> 
> Add (for the child nodes):
> 
>        addtionalProperties: false
> 
>>  
>>  required:
>>    - compatible
>> +  - "#address-cells"
>> +  - "#size-cells"
>>    - clocks
>>    - clock-names
>>    - reg
>>    - reg-names
>> -  - "#phy-cells"
>> +  - resets
>> +  - reset-names
>>  
>>  additionalProperties: false
>>  
>>  examples:
>>    - |
>> -    dp_phy: phy@f0fb500000 {
>> +    #include <dt-bindings/phy/phy.h>
>> +    torrent_phy: phy@f0fb500000 {
>>            compatible = "cdns,torrent-phy";
>>            reg = <0xf0 0xfb500000 0x0 0x00100000>,
>>                  <0xf0 0xfb030a00 0x0 0x00000040>;
>>            reg-names = "torrent_phy", "dptx_phy";
>> -          num_lanes = <4>;
>> -          max_bit_rate = <8100>;
>> -          #phy-cells = <0>;
>> +          resets = <&phyrst 0>;
>> +          reset-names = "torrent_reset";
>>            clocks = <&ref_clk>;
>>            clock-names = "refclk";
>> +          #address-cells = <1>;
>> +          #size-cells = <0>;
>> +          torrent_phy_dp: torrent-phy@0 {
> 
> Just 'phy@...'
> 
>> +                    reg = <0>;
>> +                    resets = <&phyrst 1>;
>> +                    #phy-cells = <0>;
>> +                    cdns,phy-type = <PHY_TYPE_DP>;
>> +                    cdns,num-lanes = <4>;
>> +                    cdns,max-bit-rate = <8100>;
>> +          };
>>      };
>>  ...
>> -- 
>> 2.4.5
>>

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/tree/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt?h=next

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/tree/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml?h=next

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
