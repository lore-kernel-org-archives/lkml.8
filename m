Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48C4C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F07C20731
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgD1WbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:31:13 -0400
Received: from mail-bn8nam12olkn2036.outbound.protection.outlook.com ([40.92.21.36]:17985
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbgD1WbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:31:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHFYFYFT+NNhL8Gf2Rob6wPOUyn42FPUQTmDrUCjS+9aloWYRmin1YRA79Z6oF3HDfilQHORLPwy8wxfPYrkVyFjmmQMobscNBad5jrqXxJiFaa6cSnSJi4ZZCGf1YzKdWh46kebRSDo47S/ckBWzVi/h+2vJfWV0Cfg+Gw/HDFTqIi5XOD50PjCEa4F32ImD7Df0pXB6b/WTgl5Y8+5MRTx0xVjMsopEOqUAukChdlNFRTs9mhjwFOj7/bzo7SZHaerhyBebS945xRc83RpUiO5T3/LdHVM5n6ZJL8kS/mqWDA9+9LdBW8CEccv5YileI1tXL1tHDxTXu/9wFfN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2qWdPJZz4Zzhfrj8E0eIofLLUGSm5kfqPwW48VbiFI=;
 b=nIeRhzQinJlOxIQHOQZ9rDOmQqu/X/9mmCaw0czDZP8F2n12u6tK/MT8FEnTS83NGyQ79KHONZQJ9QQIwcPBnggVHAp0cLm8iSyh5rvlmWQtfIKwKgqgS3I4ZlkS1qW+zanaqQ4posz7KR1OWBunDGDq9WDrmjjzj6lhP20P+EQvcib8SVkDPqmUV0PGey8EJlXdOry4rhFW5SKzQsJwAL2iQDa+0KxB05JZSTtvqpLwCXuvcJmPNtyVgrfk2npdmK77fAfSjyLmJ45ESRV2mOPdJsXHlmDz0QUNy3Eqh8PxGe5pVFNHVMuhSUBywYIRo0oZuIQf0D1d/mLk8k4PmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM12FT011.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc66::50) by
 BN8NAM12HT017.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc66::434)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Tue, 28 Apr
 2020 22:31:10 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc66::50) by BN8NAM12FT011.mail.protection.outlook.com
 (2a01:111:e400:fc66::402) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Tue, 28 Apr 2020 22:31:10 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:697F5ED126EDE6A7D81B1E7EACB6E94E0326C1B8340501C12C0B11E558E631A2;UpperCasedChecksum:D70EF6C1EC65C27F0AF916B928DF8392BFD6562A9B809E62B15EB7ADC349900B;SizeAsReceived:9149;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 22:31:10 +0000
Subject: Re: [PATCH 12/13] arm: dts: s5pv210: Correct FIMC definitions
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <BN6PR04MB0660823C87DE000BCDF36C3AA3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200428103227.GE23963@kozik-lap>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB06604F79534ACDC1B9858C8AA3AC0@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Tue, 28 Apr 2020 15:31:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200428103227.GE23963@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:102:1::42) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <3bef38dd-6961-bd4b-c072-8cf8dfdea9e3@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb67:7300:9f89:4b96:de0b:cd14] (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by CO2PR04CA0074.namprd04.prod.outlook.com (2603:10b6:102:1::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 22:31:09 +0000
X-Microsoft-Original-Message-ID: <3bef38dd-6961-bd4b-c072-8cf8dfdea9e3@live.ca>
X-TMN:  [ehx5ThymiI4OMgOw5XMu5bidgHISPDa0HrYyte0VCEo7f3N3PycJnHY4AujSP/M2]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 55b68448-f5a3-4c0f-1f2e-08d7ebc3d9cb
X-MS-TrafficTypeDiagnostic: BN8NAM12HT017:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ByN29Rle9wGajZprsqZKcVcdpf/W4asGXQ0le1v/XjbMcOxgodkHo/XgWbc5GZNAxyqO691PAZtB3/Q0f3O+iuJXKnC30APq+fQ9PTKfJHhQZnEGSifESHX5D9ZT1RiH7NboyBmCxJAj0/qBDBaDQm03JJtZDegb8BmWChPvGn7ecZduK92t7x/bfJDzro8zoaPAtzR9HLzMZPaAcXy2+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: NBhDf4Oof5KD5B3cX3R9Gm99/YnCt1lrUu7FitkkTAko2pY3D5HICJF7v8P7bxrh9tNigLoCj081K2E9SwPpU8I/XwVMpVdukVLfJI0MlsZP/yPEthuaOAEiajyJoab2FdQn6CosS9QXT6FSPOoARiYfPdrFsrNbxnz/HKsqVL1jiS9J+fFOYP6kPvZPWcWxzvvfoDWcs9eimyHX5HUwlA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b68448-f5a3-4c0f-1f2e-08d7ebc3d9cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 22:31:10.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM12HT017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2020-04-28 3:32 a.m., Krzysztof Kozlowski wrote:
> On Sun, Apr 26, 2020 at 11:36:03AM -0700, Jonathan Bakker wrote:
>> The extended mainscaler is only available on FIMC1 and there
>> are minimum pixel alignments that differ from the default.
>> Additionally, the cam-if interface is available on all three
>> while FIMC2 has no rotators.  The lcd-wb interface is supported
>> on FIMC1.
>>
>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>> ---
>>  arch/arm/boot/dts/s5pv210.dtsi | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
>> index b3b6ad2889f9..3cbf6c05f42a 100644
>> --- a/arch/arm/boot/dts/s5pv210.dtsi
>> +++ b/arch/arm/boot/dts/s5pv210.dtsi
>> @@ -626,7 +626,7 @@
>>  				clock-names = "fimc",
>>  						"sclk_fimc";
>>  				samsung,pix-limits = <4224 8192 1920 4224>;
>> -				samsung,mainscaler-ext;
>> +				samsung,min-pix-alignment = <16 8>;
>>  				samsung,cam-if;
>>  			};
>>  
>> @@ -639,9 +639,11 @@
>>  						<&clocks SCLK_FIMC1>;
>>  				clock-names = "fimc",
>>  						"sclk_fimc";
>> -				samsung,pix-limits = <4224 8192 1920 4224>;
>>  				samsung,mainscaler-ext;
>> +				samsung,min-pix-alignment = <1 1>;
>> +				samsung,pix-limits = <4224 8192 1920 4224>;
> 
> The line just moved around. I guess this was not intended?

Correct, will fix in v2.

> 
> Best regards,
> Krzysztof
> 

Thanks,
Jonathan
