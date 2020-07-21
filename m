Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB096C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE3120792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgGUQkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:40:20 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:40142 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727058AbgGUQkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:40:20 -0400
Received: from [78.134.114.177] (port=56136 helo=[192.168.77.62])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jxvJP-00075K-2R; Tue, 21 Jul 2020 18:40:15 +0200
Subject: Re: [PATCH v2 4/4] dt-bindings: clk: versaclock5: convert to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Adam Ford <aford173@gmail.com>
References: <20200708074035.31595-1-luca@lucaceresoli.net>
 <20200708074035.31595-4-luca@lucaceresoli.net>
 <20200714031109.GA1210492@bogus>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <3862d1f3-ada7-7af4-2f98-8874413e5252@lucaceresoli.net>
Date:   Tue, 21 Jul 2020 18:40:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714031109.GA1210492@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 14/07/20 05:11, Rob Herring wrote:
> On Wed, Jul 08, 2020 at 09:40:35AM +0200, Luca Ceresoli wrote:
>> Convert to yaml the VersaClock bindings document. The mapping between
>> clock specifier and physical pins cannot be described formally in yaml
>> schema, then keep it verbatim in the description field.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> ---
>>  .../bindings/clock/idt,versaclock5.txt        | 125 --------------
>>  .../bindings/clock/idt,versaclock5.yaml       | 160 ++++++++++++++++++
>>  MAINTAINERS                                   |   1 +
>>  3 files changed, 161 insertions(+), 125 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/clock/idt,versaclock5.txt
>>  create mode 100644 Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
>> deleted file mode 100644
>> index 9656d4cf221c..000000000000
>> --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
>> +++ /dev/null
>> @@ -1,125 +0,0 @@
>> -Binding for IDT VersaClock 5,6 programmable i2c clock generators.
>> -
>> -The IDT VersaClock 5 and VersaClock 6 are programmable i2c clock
>> -generators providing from 3 to 12 output clocks.
>> -
>> -==I2C device node==
>> -
>> -Required properties:
>> -- compatible:	shall be one of
>> -		"idt,5p49v5923"
>> -		"idt,5p49v5925"
>> -		"idt,5p49v5933"
>> -		"idt,5p49v5935"
>> -		"idt,5p49v6901"
>> -		"idt,5p49v6965"
>> -- reg:		i2c device address, shall be 0x68 or 0x6a.
>> -- #clock-cells:	from common clock binding; shall be set to 1.
>> -- clocks:	from common clock binding; list of parent clock handles,
>> -		- 5p49v5923 and
>> -		  5p49v5925 and
>> -		  5p49v6901: (required) either or both of XTAL or CLKIN
>> -					reference clock.
>> -		- 5p49v5933 and
>> -		- 5p49v5935: (optional) property not present (internal
>> -					Xtal used) or CLKIN reference
>> -					clock.
>> -- clock-names:	from common clock binding; clock input names, can be
>> -		- 5p49v5923 and
>> -		  5p49v5925 and
>> -		  5p49v6901: (required) either or both of "xin", "clkin".
>> -		- 5p49v5933 and
>> -		- 5p49v5935: (optional) property not present or "clkin".
>> -
>> -For all output ports, a corresponding, optional child node named OUT1,
>> -OUT2, etc. can represent a each output, and the node can be used to
>> -specify the following:
>> -
>> -- idt,mode: can be one of the following:
>> -                 - VC5_LVPECL
>> -                 - VC5_CMOS
>> -                 - VC5_HCSL33
>> -                 - VC5_LVDS
>> -                 - VC5_CMOS2
>> -                 - VC5_CMOSD
>> -                 - VC5_HCSL25
>> -
>> -- idt,voltage-microvolts:  can be one of the following
>> -                 - 1800000
>> -                 - 2500000
>> -                 - 3300000
>> --  idt,slew-percent: Percent of normal, can be one of
>> -                 - 80
>> -                 - 85
>> -                 - 90
>> -                 - 100
>> -
>> -==Mapping between clock specifier and physical pins==
>> -
>> -When referencing the provided clock in the DT using phandle and
>> -clock specifier, the following mapping applies:
>> -
>> -5P49V5923:
>> -	0 -- OUT0_SEL_I2CB
>> -	1 -- OUT1
>> -	2 -- OUT2
>> -
>> -5P49V5933:
>> -	0 -- OUT0_SEL_I2CB
>> -	1 -- OUT1
>> -	2 -- OUT4
>> -
>> -5P49V5925 and
>> -5P49V5935:
>> -	0 -- OUT0_SEL_I2CB
>> -	1 -- OUT1
>> -	2 -- OUT2
>> -	3 -- OUT3
>> -	4 -- OUT4
>> -
>> -5P49V6901:
>> -	0 -- OUT0_SEL_I2CB
>> -	1 -- OUT1
>> -	2 -- OUT2
>> -	3 -- OUT3
>> -	4 -- OUT4
>> -
>> -==Example==
>> -
>> -/* 25MHz reference crystal */
>> -ref25: ref25m {
>> -	compatible = "fixed-clock";
>> -	#clock-cells = <0>;
>> -	clock-frequency = <25000000>;
>> -};
>> -
>> -i2c-master-node {
>> -
>> -	/* IDT 5P49V5923 i2c clock generator */
>> -	vc5: clock-generator@6a {
>> -		compatible = "idt,5p49v5923";
>> -		reg = <0x6a>;
>> -		#clock-cells = <1>;
>> -
>> -		/* Connect XIN input to 25MHz reference */
>> -		clocks = <&ref25m>;
>> -		clock-names = "xin";
>> -
>> -		OUT1 {
>> -			idt,mode = <VC5_CMOS>;
>> -			idt,voltage-microvolts = <1800000>;
>> -			idt,slew-percent = <80>;
>> -		};
>> -		OUT2 {
>> -			...
>> -		};
>> -		...
>> -	};
>> -};
>> -
>> -/* Consumer referencing the 5P49V5923 pin OUT1 */
>> -consumer {
>> -	...
>> -	clocks = <&vc5 1>;
>> -	...
>> -}
>> diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
>> new file mode 100644
>> index 000000000000..4bdfd6187b48
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
>> @@ -0,0 +1,160 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/idt,versaclock5.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Binding for IDT VersaClock 5 and 6 programmable I2C clock generators
>> +
>> +description: |
>> +  The IDT VersaClock 5 and VersaClock 6 are programmable I2C
>> +  clock generators providing from 3 to 12 output clocks.
>> +
>> +  When referencing the provided clock in the DT using phandle and clock
>> +  specifier, the following mapping applies:
>> +
>> +  - 5P49V5923:
>> +    0 -- OUT0_SEL_I2CB
>> +    1 -- OUT1
>> +    2 -- OUT2
>> +
>> +  - 5P49V5933:
>> +    0 -- OUT0_SEL_I2CB
>> +    1 -- OUT1
>> +    2 -- OUT4
>> +
>> +  - other parts:
>> +    0 -- OUT0_SEL_I2CB
>> +    1 -- OUT1
>> +    2 -- OUT2
>> +    3 -- OUT3
>> +    4 -- OUT4
>> +
>> +maintainers:
>> +  - Luca Ceresoli <luca@lucaceresoli.net>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - idt,5p49v5923
>> +      - idt,5p49v5925
>> +      - idt,5p49v5933
>> +      - idt,5p49v5935
>> +      - idt,5p49v6901
>> +      - idt,5p49v6965
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: I2C device address, shall be 0x68 or 0x6a.
> 
> Can be a schema:
> 
> enum: [ 0x68, 0x6a ]
> 
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +patternProperties:
>> +  "^OUT[1-4]$":
>> +    type: object
>> +    description:
>> +      Description of one of the outputs (OUT1..OUT4). See "Clock1 Output
>> +      Configuration" in the Versaclock 5/6/6E Family Register Description
>> +      and Programming Guide.
>> +    properties:
>> +      idt,mode:
>> +        description:
>> +          The output drive mode. Values defined in dt-bindings/clk/versaclock.h
>> +        enum:
>> +          - VC5_LVPECL
> 
> This is defining a string. Can't use defines here.
> 
>> +          - VC5_CMOS
>> +          - VC5_HCSL33
>> +          - VC5_LVDS
>> +          - VC5_CMOS2
>> +          - VC5_CMOSD
>> +          - VC5_HCSL25
>> +      idt,voltage-microvolts:
>> +        description: The output drive voltage.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
> 
> Standard unit suffixes have a type already, so drop.

After better studying json schema, v3 is coming with this change, but...

> 
>> +        enum: [ 1800000, 2500000, 3300000 ]
>> +      idt,slew-percent:
>> +        description: The Slew rate control for CMOS single-ended.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
> 
> Here too.

...not this one. It doesn't look like "percent" or similar is a standard
unit, and reading [0] confirms that. Should it be added?

[0]
https://github.com/robherring/dt-schema/blob/master/schemas/property-units.yaml

Thanks.
-- 
Luca
