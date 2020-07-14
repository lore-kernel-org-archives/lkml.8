Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27386C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D1321D7B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGNJP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:15:59 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:53085 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725833AbgGNJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:15:59 -0400
Received: from [78.134.114.177] (port=53704 helo=[192.168.77.62])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jvH2Z-000H1H-17; Tue, 14 Jul 2020 11:15:55 +0200
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
Message-ID: <6177ebd1-b39a-3b53-3f5b-92f8d1f9881b@lucaceresoli.net>
Date:   Tue, 14 Jul 2020 11:15:52 +0200
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

thanks for you review!

On 14/07/20 05:11, Rob Herring wrote:
> On Wed, Jul 08, 2020 at 09:40:35AM +0200, Luca Ceresoli wrote:
>> Convert to yaml the VersaClock bindings document. The mapping between
>> clock specifier and physical pins cannot be described formally in yaml
>> schema, then keep it verbatim in the description field.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

[...]

>> +  reg:
>> +    maxItems: 1
>> +    description: I2C device address, shall be 0x68 or 0x6a.
> 
> Can be a schema:
> 
> enum: [ 0x68, 0x6a ]

Nice, will fix.

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

How do I use the defines from include/dt-bindings then? Or should I just
use the numeric values then, like:

  idt,mode:
    description:
      The output drive mode. Values defined in
      dt-bindings/clk/versaclock.h
    minimum: 0
    maximum: 6

?

>> +      idt,voltage-microvolts:
>> +        description: The output drive voltage.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
> 
> Standard unit suffixes have a type already, so drop.

Ok.

>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - idt,5p49v5933
>> +              - idt,5p49v5935
>> +    then:
>> +      # Devices with builtin crystal, optional external input
>> +      properties:
>> +        clock-names:
>> +          const: clkin
>> +        clocks:
>> +          maxItems: 1
>> +    else:
>> +      # Devices without builtin crystal
>> +      properties:
>> +        clock-names:
>> +          anyOf:
>> +            - required: [ xin ]
>> +            - required: [ clkin ]
> 
> This isn't valid. I think you want:
> 
> clock-names:
>   minItems: 1
>   items:
>     - const: xin
>     - const: clkin
> 
> This would mean 'xin' is always required, clkin is optional.

No, what I wanted to mean is that allowed cases are:
 * for idt,5p49v5933 and idt,5p49v5935:
   - only 'xin' (required)
 * for the other parts one of these:
   - only 'xin'
   - only 'clkin'
   - both 'xin' and 'clkin'

How do I express that?


A general note: as a newcomer to yaml bindings I found a steep learning
curve. Finding a correct construct (not to mention the best one) for
each situation is time consuming and frustrating. I've been looking at
existing files for suitable examples but it doesn't work very well.

Is there any guide to yaml bindings for beginners with examples of
typical cases? It would greatly help in producing better patches and
saving time for everybody.

Thanks,
-- 
Luca
