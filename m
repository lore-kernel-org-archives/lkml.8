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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B17C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E02520730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgD1W1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:27:41 -0400
Received: from mail-bn8nam12olkn2107.outbound.protection.outlook.com ([40.92.21.107]:65505
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbgD1W1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:27:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOcKzJUu/HBtEGb4Rq1OWt15pCgAtVlc6xpBlppMoXp7QKZ2wnv497cPxvz7XCC8d0brlPH08NqHs3A9cEQKEpGbKMPqnIKLLA2jlsjTwTkXT0jCWNWI2R9J9F1XAu3yTfyZ+Cov6I3d6bg0qCClzAbtt7I2V/VZHjek5vgVRVYCVWqFtbpsw2FLXUYVBgV7Dh7sFW+Z5gK7x0m5mIsM0my5jhWOjs3RxTPRV+eW17199PL3BRd6LMym5+bvM2kThxbrGkYG9kPJ6xHtzWyz76iW1aXFWrG4n3Fiogs4wGH5N3I7dan8QuctH5PATUx1R2/RCNg+meenzsltc8tFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG7yoz8CpP1VbRGUwXWWM3Es+pjJKUEEsVCea9/2a/k=;
 b=gzEHLO0AOiPrzBQAX7baJUlMA+pspL4u5sNO5hQHFIYHutPJtpqgJmfNgs/g2FOPgdRC87QIM7LCq91FROIuv/GPnrtPD3+Cur0nAc0u3QEwsHfDY/RmLEXoa7imYkRcAqX7fQ+WGsaR8mBfGTxtKR8IZpGPeSzhpZl5e2PGQzl6F4Ttx4l9sahVepXPPsbO5sTyeeAVwrwtaY160uu4zg+mPW9s4WhocbnGmiEwh6H6gqMjXFyYFsgTclPcgAq0RpDfRq9OIQf+v9JoxybbxlenUEWcA1maQ/o3AbkaxKDRZfi+mJvyDCdxGpHf3Z77kxbm9sfo2ufkja3l/CPPSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM12FT011.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc66::4b) by
 BN8NAM12HT194.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc66::287)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Tue, 28 Apr
 2020 22:27:38 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc66::50) by BN8NAM12FT011.mail.protection.outlook.com
 (2a01:111:e400:fc66::402) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Tue, 28 Apr 2020 22:27:38 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:97146EB3F292A1A719A45F48C03934682D06B869623E4619B343E0C7780A1A99;UpperCasedChecksum:1E288598A2B3A13AC314EC2960A07BC134CEE73BBC153CE93CB0D39B8879D640;SizeAsReceived:9143;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 22:27:38 +0000
Subject: Re: [PATCH 09/13] arm: dts: s5pv210: Add an ADC node
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <BN6PR04MB0660AAB00F5D36E2FEE22DE8A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200428102600.GC23963@kozik-lap>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660ADCC0D4DE7E5161FAEFAA3AC0@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Tue, 28 Apr 2020 15:27:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200428102600.GC23963@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0045.namprd18.prod.outlook.com
 (2603:10b6:320:31::31) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <2453ddf6-e8d3-a21c-5850-04760a78b15d@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb67:7300:9f89:4b96:de0b:cd14] (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by MWHPR18CA0045.namprd18.prod.outlook.com (2603:10b6:320:31::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Tue, 28 Apr 2020 22:27:37 +0000
X-Microsoft-Original-Message-ID: <2453ddf6-e8d3-a21c-5850-04760a78b15d@live.ca>
X-TMN:  [xgDifCYnbaqJEzc0AG5otUX7EwdpAWXD9/rrM0f7z9VXuxlnTDUPICmYlS3F7eBz]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 5dba31ec-b12f-4ee8-0966-08d7ebc35b44
X-MS-TrafficTypeDiagnostic: BN8NAM12HT194:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYBy3KONfWV6iJtTpsojYfaWdGdttjjCSzm7fqvk01hDn35J7SH6ubu4WmdZTyn4t+joWFSZrJsNS4PWkdikn8adFKPtN8TBiYStilhbwpHTPtiWD5f7WxyQ+9GKbBSnCXcpQeARWFzthbgJygzc3VKoru96o9KjlkQFZW6AIGxlSGpVRjjuoWKu6Smx3W6EjykZbJW7jpFkW7L+XtJUgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: DpyqLQOJSsGSdkN92cLrd2WbnZFyMOGLVbUL22MPMsFrx3mUESKKi47IKtEJHoaMdEIqC4thi8Z8ShpsOxLJ8css2EnGPvMju0tbo6+8bI4tionhx6gmQFGmmH4Vhpo9pWPhEGA4xX3qM2EKe8ThXe7xDVVSxBkHqQm7BOww3mdcK2o7BHcCa+cQgpK8+xxHZQqaeMb+9KFMkSDRMq43xA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dba31ec-b12f-4ee8-0966-08d7ebc35b44
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 22:27:38.1698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM12HT194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2020-04-28 3:26 a.m., Krzysztof Kozlowski wrote:
> On Sun, Apr 26, 2020 at 11:36:00AM -0700, Jonathan Bakker wrote:
>> The exynos-adc driver now supports the S5PV210, so add the DT
>> node so that devices can use it.
>>
>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>> ---
>>  arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
>> index 2ad642f51fd9..b3b6ad2889f9 100644
>> --- a/arch/arm/boot/dts/s5pv210.dtsi
>> +++ b/arch/arm/boot/dts/s5pv210.dtsi
>> @@ -159,6 +159,18 @@
>>  			};
>>  		};
>>  
>> +		adc: adc@126c0000 {
>> +			compatible = "samsung,s5pv210-adc";
>> +			reg = <0xe1700000 0x1000>;
> 
> reg does not match the node address.
> 
> Run "make dtbs W=1" and be sure there are no new warnings.

Thanks, will change for v2.

> 
> Best regards,
> Krzysztof
> 
> 
>> +			interrupt-parent = <&vic2>;
>> +			interrupts = <23>, <24>;
>> +			clocks = <&clocks CLK_TSADC>;
>> +			clock-names = "adc";
>> +			#io-channel-cells = <1>;
>> +			io-channel-ranges;
>> +			status = "disabled";
>> +		};
>> +
>>  		spi0: spi@e1300000 {
>>  			compatible = "samsung,s5pv210-spi";
>>  			reg = <0xe1300000 0x1000>;
>> -- 
>> 2.20.1
>>

Jonathan
