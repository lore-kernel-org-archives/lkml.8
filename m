Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01152C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A9C2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgGNJ0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:26:21 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:60178 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbgGNJ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:26:21 -0400
Received: from [78.134.114.177] (port=53776 helo=[192.168.77.62])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jvHCb-0004n6-TG; Tue, 14 Jul 2020 11:26:17 +0200
Subject: Re: [PATCH v3 2/4] dt-bindings: mfd: lp87565: convert to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Keerthy <j-keerthy@ti.com>, Axel Lin <axel.lin@ingics.com>
References: <20200622204329.11147-1-luca@lucaceresoli.net>
 <20200622204329.11147-3-luca@lucaceresoli.net>
 <20200713190107.GA538448@bogus>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <fda84ebc-a484-fa88-3bdf-00a4272512e7@lucaceresoli.net>
Date:   Tue, 14 Jul 2020 11:26:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713190107.GA538448@bogus>
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

On 13/07/20 21:01, Rob Herring wrote:
> On Mon, Jun 22, 2020 at 10:43:27PM +0200, Luca Ceresoli wrote:
>> The definition of "xxx-in-supply" was generic, thus define in detail the
>> possible cases for each chip variant.
>>
>> Also document that the only possible I2C slave address is 0x60 as per the
>> datasheet and fix the second example accordingly.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

[...]

>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - ti,lp87565
>> +              - ti,lp87565-q1
>> +    then:
>> +      properties:
>> +        buck10-in-supply:
>> +          description:
>> +            Phandle to parent supply node for BUCK0 and BUCK1 converters.
>> +
>> +        buck23-in-supply:
>> +          description:
>> +            Phandle to parent supply node for BUCK2 and BUCK3 converters.
>> +
>> +      required:
>> +        - buck10-in-supply
>> +        - buck23-in-supply
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - ti,lp87561-q1
>> +    then:
>> +      properties:
>> +        buck3210-in-supply:
>> +          description:
>> +            Phandle to parent supply node for all the four BUCK converters.
>> +
>> +      required:
>> +        - buck3210-in-supply
> 
> I think this should probably be 2 schema documents (and a 3rd for the 
> next patch)...

No problem, will do.

Is there a specific rule to know when to split, or is it just when the
amount of changes is relevant?

>> +
>> +examples:
>> +  - |
>> +    /* TI LP87565-Q1 PMIC (dual 2-phase output configuration) */
>> +    i2c@0 {
>> +        reg = <0x0 0x100>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        pmic@60 {
>> +            compatible = "ti,lp87565-q1";
>> +            reg = <0x60>;
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +
>> +            buck10-in-supply = <&vsys_3v3>;
>> +            buck23-in-supply = <&vsys_3v3>;
>> +
>> +            regulators {
>> +                buck10_reg: buck10 {
> 
> The regulators also need to be documented.

OK.

-- 
Luca
