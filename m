Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E7DC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 19:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4B921775
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 19:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgEATnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 15:43:33 -0400
Received: from mail-oln040092011109.outbound.protection.outlook.com ([40.92.11.109]:6976
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726377AbgEATnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 15:43:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EF8/jKLXSW5oG6jNL1H/7p2NOv6QBmBPF7VaqCBhzqS4YKdb4t9AZ8P9yS6U3u/5QxB2BKuaF/2mJUabWJKQ7bX53uNclkfkCJogZAXL1/doxcfaUweO7JA/ZoyLFP2SQDfeNQ81HIxTp/LeA5e8t+z/mTJadoq4uZAXHRDsI18XicXLtuYhbJqj+MLMmb/K/igTOKyR70kPl2fOzUYhPvPBN7mb8NLKdlBCnjm96Y6Q8JnfKZV6VNIcO03yiPVFMvtPFlELxpnWBPRCapEPBMn1u4zxXLO283nICavZEUgLZG8WQrcKboym5dW3Pm9QpVv8/JsFBeFdnyrJQZb73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH/TJZbNKmzhtbk6sZZ2JUGew5jvBXVJ255lY6T+NU8=;
 b=L7lfd8Naphkflaiy7NnRrPc0c2h6iJ2ddkhoEbhFYR9CkzR9il6FxsWWKjCjJnjqHfe17Ve69qWZCNunee5bNK7G/hecHaAEPOtf5oqmDjfLtSMwSAo/JhrqtgZfwKY0c2GFVphy/fPYPKuIF3DHO3grvM6IQbEU95hdG+aMcA6jNENPf/bEq6vLPY06muzqyKSs8JKBhUSeG0DwYigvIuoEbRkbsoEmIFwLgPanNPB/6o9B3K27qsS2r80meoTFL1QF97LKkNxJf8w9v1QYslyU4Z9VXt/KdRalp9DW1ux+UUFjIoAVsxemRXuyCj0G/fhOx0T0LPuqJMFdXcjyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN3NAM04FT054.eop-NAM04.prod.protection.outlook.com
 (10.152.92.59) by BN3NAM04HT237.eop-NAM04.prod.protection.outlook.com
 (10.152.93.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Fri, 1 May
 2020 19:43:30 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e4e::4e) by BN3NAM04FT054.mail.protection.outlook.com
 (2a01:111:e400:7e4e::281) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Fri, 1 May 2020 19:43:30 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:4C3C78BA7B24904F3141361325C0E94504C034693C60E9507E5FCBB25CBA21A9;UpperCasedChecksum:1F9B4BC42460895D13257AFF6BC56E043FD38E7B777AF1C981B68449DA8E9F82;SizeAsReceived:9337;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 19:43:30 +0000
Subject: Re: [PATCH 06/13] arm: dts: s5pv210: aries: Add support for more
 devices
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <BN6PR04MB0660563639D091548BFCCFF2A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200428102026.GB23963@kozik-lap>
 <BN6PR04MB0660776A38353DBDF0E2E3F9A3AC0@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200501133100.GB5154@kozik-lap>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660515AC7EEF023734A3B40A3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Fri, 1 May 2020 12:43:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200501133100.GB5154@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2001CA0013.namprd20.prod.outlook.com
 (2603:10b6:301:15::23) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <7d8d2b14-b4cf-906d-12a3-a31357981e39@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR2001CA0013.namprd20.prod.outlook.com (2603:10b6:301:15::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 19:43:29 +0000
X-Microsoft-Original-Message-ID: <7d8d2b14-b4cf-906d-12a3-a31357981e39@live.ca>
X-TMN:  [XQB1P+NURnOaok6vULUuxYx08LeLf9hPR7YaTTrUJzCCbFhX7MUTlssKspFccpFQ]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: a629765e-bad3-471c-ec6c-08d7ee07eced
X-MS-TrafficTypeDiagnostic: BN3NAM04HT237:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6kMjwMYEgyG8a4fbJ00QDtxoVOGpCJ2OZWSfxBQ397bpzDxzkYp2WqmVRyUuNQTuS5ShRpxcJOmnaGF+naDhxet0eqJObHb38ZJ56/JpBLvvjg+CPj4a8OtG3qw9jnZKqip2C2+As/AX8AxU3Ch5EAwctKNSjG/HzXMVyVNrWz4BSdXXLzkg0oTKVeUMCdDTzGd4I6vMqKlbuYWEVuPXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: uOKRFay/5axZZYVMU+A2xuoChtHJzImB5hap/NeUt7+AUt58MiAk/I+nEiMCprzX6snktXZghLoRLVa9XNcyqCZLD4ef4VkPmfnFGbUE9BdY34r7T3mxNCaVmvY9TLcKjgcP8X0cUSQn9kqqys5ylmscof52+eRgd0O9MClVPq7cY5qJYE9nRy1sFI2xvTpsfQKnBGHofelk98QcsG9WwQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a629765e-bad3-471c-ec6c-08d7ee07eced
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 19:43:30.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3NAM04HT237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2020-05-01 6:31 a.m., Krzysztof Kozlowski wrote:
>>
>> Well, it may not be in the bindings, but the driver definitely requires it :) See drivers/mfd/wm8994-core.c
>>
>> What's the best way of dealing with this situation?
> 
> I'll send a patch fixing the bindings. However don't you miss the
> AVDD1-supply in such case? Driver should report error.
> 

Thanks for sending the patch.

AVDD1 and DCVDD are provided internally, via drivers/regulator/wm8994.c and are enabled
by wlf,ldo1ena and wlf,ldo2ena pins.  It's a bit messy, but that's how it's done.

>>
>>>> +			CPVDD-supply = <&buck3_reg>;
>>>> +			SPKVDD1-supply = <&buck3_reg>;
>>>> +			SPKVDD2-supply = <&buck3_reg>;
>>>> +
>>>> +			wlf,gpio-cfg = <0xa101 0x8100 0x0100 0x0100 0x8100
>>>> +					0xa101 0x0100 0x8100 0x0100 0x0100
>>>> +					0x0100>;
>>>> +
>>>> +			wlf,ldo1ena = <&gpf3 4 GPIO_ACTIVE_HIGH>;
>>>> +			wlf,ldo2ena = <&gpf3 4 GPIO_ACTIVE_HIGH>;
>>>> +
>>>> +			wlf,lineout1-se;
>>>> +			wlf,lineout2-se;
>>>> +
>>>> +			assigned-clocks = <&clocks MOUT_CLKOUT>;
>>>> +			assigned-clock-rates = <0>;
>>>> +			assigned-clock-parents = <&xusbxti>;
>>>> +
>>>> +			pinctrl-names = "default";
>>>> +			pinctrl-0 = <&codec_ldo>;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	i2c_accel: i2c-gpio-1 {
>>>> +		compatible = "i2c-gpio";
>>>> +		sda-gpios = <&gpj3 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>>>> +		scl-gpios = <&gpj3 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>>>> +		i2c-gpio,delay-us = <2>;
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>>> +
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&accel_i2c_pins>;
>>>> +
>>>> +		/* bma023 accelerometer, no mainline binding */
>>>
>>> status disabled ... unless you need it for user-space I2C tools?
>>>
>>
>> Nope, but wanted to add them all in due to adding the si4709 in galaxys.  I was having
>> issues with accidentally overwriting previously named nodes (ie having i2c-gpio-0 in
>> both the common dtsi and the device specific dts) so I wanted to get the numbers
>> nailed down.
> 
> So add them with status disabled. This will document the HW without
> enabling empty I2C GPIO bus.

Sounds good, will do.

> 
> Best regards,
> Krzysztof
> 


Thanks,
Jonathan
