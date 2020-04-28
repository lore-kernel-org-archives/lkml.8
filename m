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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83844C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C58A20730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD1W1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:27:04 -0400
Received: from mail-mw2nam12olkn2016.outbound.protection.outlook.com ([40.92.23.16]:8416
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbgD1W1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:27:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkdx0M1xi5DH7btJElQCubeiZ9tdLpuBSwLlxyOe5UpWa2g4pUyydm+HKc4ollnxhfpmP8vwowk9PfXQnTAuebN+UiH+DvbQ+L/akIy5xp5UJL9VidxRppHBJM75xdSpbo1IKoAlvAGcNQaqcmJdw3mHqNRLaMOM/oTXNq8rddCnfK6r0CtzwkNBE8cWHMFcVpAtRSUZFf1sGs2D0M4JFyybTygn0ePuryvLw8CNiQd1ItukndrwbE1mI6d7Wnq4/74u6dAYG2JOQqn3TkMwYKPk4aKSfH5wp1U6u0tKrhuhLEohGTInQbSNCrYk3YmBEPWoXLIhg2LtFlTjwznGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7itvH72Lf8/BIyooOhXrufjzxN5TetRYwA38SP+/GMY=;
 b=BePJ9u7IFynQgmgs9a9jGKW0IU7CoY1ZNA38+TfKj69yBX797kYfCGHWtRNeT977jAh14r95KeIksjMAMOy/OIoJ6uuBte8n7rp8eAzt6LVjVYE/6X7tVH2IfeRGFQi4aQRHY/zds+s4tBTgpp6Z2DZJelHxHf+3u358H8210ljh6RQrIi1survo4McVcN201gDQYZ5vPkSof7pHsqu8VPQWxR2ATAn7sMUsozVUUutvCgH90KpQsGmUUNpq407xkvYmqjWrVIy22D4Qn9A1rJrGBtRaWCVqY+b+eWr5ZHFMo42sY1e3el/2flrK9aS9DxnVpe1bbhLzFiMn/Aq3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM12FT011.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc66::41) by
 BN8NAM12HT167.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc66::356)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Tue, 28 Apr
 2020 22:27:02 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc66::50) by BN8NAM12FT011.mail.protection.outlook.com
 (2a01:111:e400:fc66::402) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Tue, 28 Apr 2020 22:27:02 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:C7DCDD148CB2087ED420E081F5EBC88E5527FCA1C4FC3D1128897164CF3F6BBD;UpperCasedChecksum:92D1B590B52F58DDB75D61BDCAD58885F096AAB589AA0F9A23CB0AFBE2B9C046;SizeAsReceived:9151;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 22:27:02 +0000
Subject: Re: [PATCH 10/13] arm: dts: s5pv210: aries: Enable ADC node
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <BN6PR04MB0660998092302F2A78065E79A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200428102921.GD23963@kozik-lap>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660AB5103CCD61C5288D653A3AC0@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Tue, 28 Apr 2020 15:26:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200428102921.GD23963@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0042.namprd18.prod.outlook.com
 (2603:10b6:320:31::28) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <62ca9795-c76b-12b3-3211-bcdb26889b2d@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb67:7300:9f89:4b96:de0b:cd14] (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by MWHPR18CA0042.namprd18.prod.outlook.com (2603:10b6:320:31::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Tue, 28 Apr 2020 22:27:00 +0000
X-Microsoft-Original-Message-ID: <62ca9795-c76b-12b3-3211-bcdb26889b2d@live.ca>
X-TMN:  [NFK4o9QntSLW+rPc3Qww0XOsZPTQLu6IRnItikB7u8yhWHTWDbeWNksYhRdkoTBA]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 52bc821a-f3f4-4d63-b8df-08d7ebc345b1
X-MS-TrafficTypeDiagnostic: BN8NAM12HT167:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BGQXLYY1NsFi8RNUvS/keKHBv3MiB9uJUsm7AhxaFax/oygZul1DklhHPYgpuAvl3vDBrHdj7g5KX1Oi+iXYic25Md/5uw5UC6fwlLoadeS1HlzzYLrenYdN8VRDFx64JVZN6P345IjcNCyxQBTa9RhHhulpAUGW5tHAzj06rWwjPkVFhYCiThf4z6g27RgBTJy1AZtc8p8YwX1F1rWXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: kxv6flq79EBs4EWlkvxXzKtkTR+OWen7+u62Iqmion7HpLKPkg0ESNaPxzNlk1RBqPjcMzavVLndc/1GAEfyemBeGU4C8990/8s2/YPxfn9MNclk33K4OwXxCmuy7IBYBl8eYEbzU9AjHupw3QI7ncWHXk3M/qLsqxIVag3h21ZCitONVIWYLiDc986SxgDBEBlGNTcWrdG6xn5XXng+QQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bc821a-f3f4-4d63-b8df-08d7ebc345b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 22:27:02.0208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM12HT167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2020-04-28 3:29 a.m., Krzysztof Kozlowski wrote:
> On Sun, Apr 26, 2020 at 11:36:01AM -0700, Jonathan Bakker wrote:
>> On aries boards, the ADC is used for things such as jack detection
>> and battery temperature monitoring.  It is connected to ldo4 of max8998,
>> so only enable that regulator when we are actually using the ADC.
>>
>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>> ---
>>  arch/arm/boot/dts/s5pv210-aries.dtsi | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
>> index f30bdcb9c083..a103ddb0d720 100644
>> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
>> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
>> @@ -193,11 +193,6 @@
>>  					regulator-name = "VADC_3.3V";
>>  					regulator-min-microvolt = <3300000>;
>>  					regulator-max-microvolt = <3300000>;
>> -					regulator-always-on;
>> -
>> -					regulator-state-mem {
>> -						regulator-off-in-suspend;
>> -					};
> 
> I would expect to keep it disabled during suspend. Why you had to remove
> this part?

It was my thinking that if nothing was using it, then it would automatically be disabled and stay
that way over suspend.

However, looking at things again, it does make sense to make sure that it is disabled as it serves
no purpose to stay enabled over suspend.  I'll remove this change for v2.

> 
> Best regards,
> Krzysztof
> 

Thanks,
Jonathan
