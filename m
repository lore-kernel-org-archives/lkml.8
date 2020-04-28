Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3F3C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958692070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgD1XdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:33:04 -0400
Received: from mail-dm6nam10olkn2050.outbound.protection.outlook.com ([40.92.41.50]:15705
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbgD1XdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:33:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8eqUuq1gn79QO2jbX/txYXTnyphDqvJEW0Wi+YjTBjSyx8jXMxtaLxVJrJqWY8CEBNO6w62xcd8G0r/v5Mek83fg81lclj6c2oOIQ0xP4lY1B8x26wkPs3R2/AxTzYXOCr2wSHz/DJahsjaVt8Nywc8o2fUcCEu9hxagN5oZeNPR3RGRz6M9RroF7mhprAxs9fr6nSybddlLiL72X/g9myc0Ml06o1q+HBrAKRmchMiMG5XzQv8rGN+Xg7zf8iYT1KZGFPmRAFIafm7os2Zbqq+NbkkuH2IbBsIEEkKRq3xqleqpm4fxRy5MqdJdQ+8aKF9oRzQjkh8Z5ncKDCJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Zg3O2l8L0fVqBf9ngqboroh8jJ/adoLezWfK4t5jH8=;
 b=HqtxYAaDYRTEYv43A38YT75+sUiTCRonWTqYGVgWzTjfaOrO1T1FbJ/am4KhDs1Xu0iKDSkKMTMojJHnSKKFHb3uzTPjDQ8yS9l3Rsw0tKAzFHNRvVeYtVIKokkSKEefH2mVOUs5UI+SmS/AKjEQBWAraT1J5JIo8LEw14jsCRQO+67XVhCkBoR1K0HTbVwyDiFkXmFymlebCMk2APkfd1Yc+000+wVqQOwDMCNvL3JJ4tGJJRoj7bqdNM8LY3ftNCBLUKVRBqQIgn3qIudz1h21XJuAZw3X8+mbjjVvQJ++4pA/xQST376EdtiptLCUi6Ij2r5i6vmLlCh3t9b5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM10FT005.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e86::47) by
 DM6NAM10HT067.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e86::233)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Tue, 28 Apr
 2020 23:33:01 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e86::4c) by DM6NAM10FT005.mail.protection.outlook.com
 (2a01:111:e400:7e86::87) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Tue, 28 Apr 2020 23:33:01 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:4C4BFC1E138AF698EC9B74CB087DB01D929962F2314EDE3F00C46125092DE321;UpperCasedChecksum:203ABE6D764C7B541D71C37161A2EB21880CF28E9A587BC16C39A7BCA3067930;SizeAsReceived:9245;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 23:33:01 +0000
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
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660776A38353DBDF0E2E3F9A3AC0@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Tue, 28 Apr 2020 16:32:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200428102026.GB23963@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:300:115::27) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <2fcf0fb1-9a47-d481-4285-a894858e54ae@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb67:7300:9f89:4b96:de0b:cd14] (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by MWHPR11CA0041.namprd11.prod.outlook.com (2603:10b6:300:115::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 23:32:59 +0000
X-Microsoft-Original-Message-ID: <2fcf0fb1-9a47-d481-4285-a894858e54ae@live.ca>
X-TMN:  [9vG9gbXJ2RZlfiyMEIrXeVQDYngTwG4wO7h96rawItU0gFaCpX8McFh59mHeLYGH]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 3ad98ce3-6ada-4509-75cd-08d7ebcc7d60
X-MS-TrafficTypeDiagnostic: DM6NAM10HT067:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MmDDFUt7wttFgZwz7MtFVy9qcqFBtdzbVa4RvNlnG/z33w0t15URo43dhWdt0heKlwngIE+OHRN2DSjLZO63387KzfmgpvBsCd6DarntjR2X4E8UAVRqz8CSlB+vp6ugpmo1aZpXi+ldpZOSSoD9ra3AapUbb+hrR9dK9pBYyhXnX75l2iv8AK8Gsq18WJQQ+alIOuvAZfFyxreHOmCbCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: txiL8uXO9f/42y7dMy5bxmC9WSddtjzo753nNlpH7VFQgSrY6hdyrInghmdJ8OOChZIaDL3kMSgFTiL+e3Qyde8dDGDl7dG/+pPOjZC+i4AhBpzW3c9+VAlvRQhV3ydJtCqUhylBDmvnwWgeFierHM3tnNSpR4FzwZLh8OVgjiiO5f7s4Mo+pOjoy+TBi84CPKxG+1GwOcanPFn6pEYj1A==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad98ce3-6ada-4509-75cd-08d7ebcc7d60
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 23:33:00.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM10HT067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2020-04-28 3:20 a.m., Krzysztof Kozlowski wrote:
> On Sun, Apr 26, 2020 at 11:35:57AM -0700, Jonathan Bakker wrote:
>> Add support for following devices:
>>   - touchkeys connected over i2c-gpio
>>   - s6e63m0 panel connected over spi-gpio
>>   - fsa9480 microusb switch over i2c-gpio
>>   - wm8994 over i2c-gpio (no machine driver yet)
>>   - all common i2c-gpio devices
> 
> Please split it per functionality, e.g.:
> 1. Add sound,
> 2. Add panel,
> 3. Add touchkeys (unless part of panel),
> 4. The remaining i2c-gpio devices without bindings could go as one.

Ok, will do.

> 
>>
>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
>> ---
>>  arch/arm/boot/dts/s5pv210-aries.dtsi      | 282 ++++++++++++++++++++--
>>  arch/arm/boot/dts/s5pv210-fascinate4g.dts |   6 +
>>  2 files changed, 270 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
>> index f83df426f2b6..ef966d13d83d 100644
>> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
>> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
>> @@ -12,8 +12,14 @@
>>  	compatible = "samsung,aries", "samsung,s5pv210";
>>  
>>  	aliases {
>> +		i2c4 = &i2c_sound;
>> +		i2c5 = &i2c_accel;
>>  		i2c6 = &i2c_pmic;
>> +		i2c7 = &i2c_musb;
>>  		i2c9 = &i2c_fuel;
>> +		i2c10 = &i2c_touchkey;
>> +		i2c11 = &i2c_prox;
>> +		i2c12 = &i2c_magnetometer;
>>  	};
>>  
>>  	memory@30000000 {
>> @@ -48,6 +54,18 @@
>>  		gpio = <&gpj1 1 GPIO_ACTIVE_HIGH>;
>>  	};
>>  
>> +	touchkey_vdd: regulator-fixed-1 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VTOUCH_3.3V";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		enable-active-high;
>> +		gpio = <&gpj3 2 GPIO_ACTIVE_HIGH>;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&touchkey_vdd_ena>;
>> +	};
>> +
>>  	wifi_pwrseq: wifi-pwrseq {
>>  		compatible = "mmc-pwrseq-simple";
>>  		reset-gpios = <&gpg1 2 GPIO_ACTIVE_LOW>;
>> @@ -57,7 +75,69 @@
>>  		power-off-delay-us = <500>;
>>  	};
>>  
>> -	i2c_pmic: i2c-gpio-0 {
>> +	i2c_sound: i2c-gpio-0 {
>> +		compatible = "i2c-gpio";
>> +		sda-gpios = <&mp05 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +		scl-gpios = <&mp05 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +		i2c-gpio,delay-us = <2>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&sound_i2c_pins>;
>> +
>> +		wm8994: wm8994@1a {
>> +			compatible = "wlf,wm8994";
>> +			reg = <0x1a>;
>> +
>> +			#sound-dai-cells = <0>;
>> +
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +
>> +			clocks = <&clocks MOUT_CLKOUT>;
>> +			clock-names = "MCLK1";
>> +
>> +			AVDD2-supply = <&buck3_reg>;
>> +			DBVDD-supply = <&buck3_reg>;
> 
> No such supply, check the bindings.
> 

Well, it may not be in the bindings, but the driver definitely requires it :) See drivers/mfd/wm8994-core.c

What's the best way of dealing with this situation?

>> +			CPVDD-supply = <&buck3_reg>;
>> +			SPKVDD1-supply = <&buck3_reg>;
>> +			SPKVDD2-supply = <&buck3_reg>;
>> +
>> +			wlf,gpio-cfg = <0xa101 0x8100 0x0100 0x0100 0x8100
>> +					0xa101 0x0100 0x8100 0x0100 0x0100
>> +					0x0100>;
>> +
>> +			wlf,ldo1ena = <&gpf3 4 GPIO_ACTIVE_HIGH>;
>> +			wlf,ldo2ena = <&gpf3 4 GPIO_ACTIVE_HIGH>;
>> +
>> +			wlf,lineout1-se;
>> +			wlf,lineout2-se;
>> +
>> +			assigned-clocks = <&clocks MOUT_CLKOUT>;
>> +			assigned-clock-rates = <0>;
>> +			assigned-clock-parents = <&xusbxti>;
>> +
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&codec_ldo>;
>> +		};
>> +	};
>> +
>> +	i2c_accel: i2c-gpio-1 {
>> +		compatible = "i2c-gpio";
>> +		sda-gpios = <&gpj3 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +		scl-gpios = <&gpj3 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +		i2c-gpio,delay-us = <2>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&accel_i2c_pins>;
>> +
>> +		/* bma023 accelerometer, no mainline binding */
> 
> status disabled ... unless you need it for user-space I2C tools?
> 

Nope, but wanted to add them all in due to adding the si4709 in galaxys.  I was having
issues with accidentally overwriting previously named nodes (ie having i2c-gpio-0 in
both the common dtsi and the device specific dts) so I wanted to get the numbers
nailed down.



<snip>

>>  
>>  &pwm {
>> diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
>> index 94dcb9b64b9a..42e6e2de197d 100644
>> --- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
>> +++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
>> @@ -278,3 +278,9 @@
>>  		PIN_SLP(mp07-7, INPUT, DOWN);
>>  	};
>>  };
>> +
>> +&wm8994 {
>> +	/* GPIO3 (BCLK2) and GPIO4 (LRCLK2) as outputs */
>> +	wlf,gpio-cfg = <0xa101 0x8100 0x8100 0x8100 0x8100 0xa101
>> +		0x0100 0x8100 0x0100 0x0100 0x0100>;
> 
> Indent the line till opening <.

Will do.

> 
> Best regards,
> Krzysztof
> 


Thanks,
Jonathan
