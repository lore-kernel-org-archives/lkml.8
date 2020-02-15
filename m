Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A5FC7114E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 12:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B01F2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 12:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yh5pGwWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgBOMhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 07:37:46 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35320 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgBOMhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 07:37:45 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01FCbde6090028;
        Sat, 15 Feb 2020 06:37:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581770259;
        bh=97kZJ1UjjgCaml1kp4DusKVaxtjMSaE55gWgFzl2plA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Yh5pGwWTogms3kZHEmliVaEjnWhjt9N4Z65dOWUUj2/S0iwRpKyvSab5/AjxvuFcj
         pcT907kPwtnDQOOlqPY/C4L1hBLU9kH12q5K/+VmOyXUmvPTQn4+LfaHPvqf2i99GA
         KI5inI3J3t4tz3prQx5Dks2BW7K/1tDnMOKLFLAA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01FCbdRq079201;
        Sat, 15 Feb 2020 06:37:39 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sat, 15
 Feb 2020 06:37:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sat, 15 Feb 2020 06:37:39 -0600
Received: from [10.250.133.210] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01FCbZvJ044715;
        Sat, 15 Feb 2020 06:37:35 -0600
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add binding documentation for
 TI syscon gate clock
To:     Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>
References: <20200207044425.32398-1-vigneshr@ti.com>
 <20200207044425.32398-2-vigneshr@ti.com>
 <158136034652.94449.4389789192412792346@swboyd.mtv.corp.google.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <f42d90ca-0078-7ae4-c9b1-a9d23dd251e3@ti.com>
Date:   Sat, 15 Feb 2020 18:07:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <158136034652.94449.4389789192412792346@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/11/2020 12:15 AM, Stephen Boyd wrote:
> Quoting Vignesh Raghavendra (2020-02-06 20:44:24)
[...]
>> +  - Vignesh Raghavendra <vigneshr@ti.com>
>> +
>> +description: |
>> +
>> +  This binding uses common clock bindings
>> +  Documentation/devicetree/bindings/clock/clock-bindings.txt
> 
> Maybe have a real description instead of this line which is mostly
> useless.
> 

Will drop this line..

>> +
>> +properties:
>> +  compatible:
>> +    items:
> 
> I think you can drop items.
> 
>> +      - const: ti,am654-ehrpwm-tbclk
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +  ti,tbclk-syscon:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to the system controller node that has bits to
>> +      control eHRPWM's TBCLK
>> +
>> +required:
>> +  - compatible
>> +  - "#clock-cells"
>> +  - ti,tbclk-syscon
>> +
>> +examples:
>> +  - |
>> +    tbclk_ctrl: tbclk_ctrl@4140 {
>> +        compatible = "syscon";
>> +        reg = <0x4140 0x18>;
>> +    };
>> +
>> +    ehrpwm_tbclk: clk0 {
>> +        compatible = "ti,am654-ehrpwm-tbclk";
>> +        #clock-cells = <1>;
>> +        ti,tbclk-syscon = <&tbclk_ctrl>;
>> +    };
> 
> I don't understand the binding. Why can't the syscon node register clks
> and have #clock-cells?
> 

I did not know that would work. Will make syscon code to register clks..
Thanks!

Regards
Vignesh
