Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F67AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF532076E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rj+vboY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHSO3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:29:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58488 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgHSO3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:29:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07JESq9h061954;
        Wed, 19 Aug 2020 09:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597847332;
        bh=otgbGWwb3UhDFUjBDSNCt0tc9BFNVg6jezhPK5rBtvs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rj+vboY7Qk7a04Sc54mBzQhcy5l/J3ufrpLb99EZBcmpseX5MONXa8RgO/nWlCwAc
         BmYw92X0OYMOihS9jV3XBqnSvWWMTQFEhctL6o5s015eh08HG7f+MLcLxvQlcoWKIr
         UD9m4Ng1Ndx5+JZYcQIgS2o5/ayL1Q3E1A80qnfc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07JESqBp068440;
        Wed, 19 Aug 2020 09:28:52 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 19
 Aug 2020 09:28:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 19 Aug 2020 09:28:52 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07JESoYv050647;
        Wed, 19 Aug 2020 09:28:50 -0500
Subject: Re: [PATCH v4 3/3] phy: omap-usb2-phy: disable PHY charger detect
To:     Jan Kiszka <jan.kiszka@siemens.com>, <kishon@ti.com>
CC:     <robh+dt@kernel.org>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bin Liu <b-liu@ti.com>
References: <20200716082252.21266-1-rogerq@ti.com>
 <20200716082252.21266-4-rogerq@ti.com>
 <ef391fb2-c75e-5b35-b3e2-96db21c66ab3@siemens.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5961c75e-f0a5-6493-7d4a-7113ebea14dc@ti.com>
Date:   Wed, 19 Aug 2020 17:28:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ef391fb2-c75e-5b35-b3e2-96db21c66ab3@siemens.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2020 12:02, Jan Kiszka wrote:
> On 16.07.20 10:22, Roger Quadros wrote:
>> AM654x PG1.0 has a silicon bug that D+ is pulled high after POR, which
>> could cause enumeration failure with some USB hubs.  Disabling the
>> USB2_PHY Charger Detect function will put D+ into the normal state.
>>
>> Using property "ti,disable-charger-det" in the DT usb2-phy node to
>> enable this workaround for AM654x PG1.0.
>>
>> This addresses Silicon Errata:
>> i2075 - "USB2PHY: USB2PHY Charger Detect is Enabled by Default Without VBUS
>> Presence"
>>
>> Signed-off-by: Bin Liu <b-liu@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/phy/ti/phy-omap-usb2.c | 35 +++++++++++++++++++++++++++-------
>>   1 file changed, 28 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
>> index cb2dd3230fa7..21c3904d4efc 100644
>> --- a/drivers/phy/ti/phy-omap-usb2.c
>> +++ b/drivers/phy/ti/phy-omap-usb2.c
>> @@ -26,6 +26,10 @@
>>   #define USB2PHY_ANA_CONFIG1		0x4c
>>   #define USB2PHY_DISCON_BYP_LATCH	BIT(31)
>>   
>> +#define USB2PHY_CHRG_DET			0x14
>> +#define USB2PHY_CHRG_DET_USE_CHG_DET_REG	BIT(29)
>> +#define USB2PHY_CHRG_DET_DIS_CHG_DET		BIT(28)
>> +
>>   /* SoC Specific USB2_OTG register definitions */
>>   #define AM654_USB2_OTG_PD		BIT(8)
>>   #define AM654_USB2_VBUS_DET_EN		BIT(5)
>> @@ -43,6 +47,7 @@
>>   #define OMAP_USB2_HAS_START_SRP			BIT(0)
>>   #define OMAP_USB2_HAS_SET_VBUS			BIT(1)
>>   #define OMAP_USB2_CALIBRATE_FALSE_DISCONNECT	BIT(2)
>> +#define OMAP_USB2_DISABLE_CHRG_DET		BIT(3)
>>   
>>   struct omap_usb {
>>   	struct usb_phy		phy;
>> @@ -236,6 +241,13 @@ static int omap_usb_init(struct phy *x)
>>   		omap_usb_writel(phy->phy_base, USB2PHY_ANA_CONFIG1, val);
>>   	}
>>   
>> +	if (phy->flags & OMAP_USB2_DISABLE_CHRG_DET) {
>> +		val = omap_usb_readl(phy->phy_base, USB2PHY_CHRG_DET);
>> +		val |= USB2PHY_CHRG_DET_USE_CHG_DET_REG |
>> +		       USB2PHY_CHRG_DET_DIS_CHG_DET;
>> +		omap_usb_writel(phy->phy_base, USB2PHY_CHRG_DET, val);
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>> @@ -366,14 +378,12 @@ static int omap_usb2_probe(struct platform_device *pdev)
>>   	phy->mask		= phy_data->mask;
>>   	phy->power_on		= phy_data->power_on;
>>   	phy->power_off		= phy_data->power_off;
>> +	phy->flags		= phy_data->flags;
>>   
>> -	if (phy_data->flags & OMAP_USB2_CALIBRATE_FALSE_DISCONNECT) {
>> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -		phy->phy_base = devm_ioremap_resource(&pdev->dev, res);
>> -		if (IS_ERR(phy->phy_base))
>> -			return PTR_ERR(phy->phy_base);
>> -		phy->flags |= OMAP_USB2_CALIBRATE_FALSE_DISCONNECT;
>> -	}
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	phy->phy_base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(phy->phy_base))
>> +		return PTR_ERR(phy->phy_base);
>>   
>>   	phy->syscon_phy_power = syscon_regmap_lookup_by_phandle(node,
>>   							"syscon-phy-power");
>> @@ -405,6 +415,17 @@ static int omap_usb2_probe(struct platform_device *pdev)
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * Errata i2075: USB2PHY: USB2PHY Charger Detect is Enabled by
>> +	 * Default Without VBUS Presence.
>> +	 *
>> +	 * AM654x SR1.0 has a silicon bug due to which D+ is pulled high after
>> +	 * POR, which could cause enumeration failure with some USB hubs.
>> +	 * Disabling the USB2_PHY Charger Detect function will put D+
>> +	 * into the normal state.
>> +	 */
>> +	if (of_property_read_bool(node, "ti,disable-charger-det"))
>> +		phy->flags |= OMAP_USB2_DISABLE_CHRG_DET;
>>   
>>   	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
>>   	if (IS_ERR(phy->wkupclk)) {
>>
> 
> Why a property, rather than SoC detection like in [1] and your previous
> downstream version?

I agree, that SoC detection is better way. Will spin a v5.

> 
> Jan
> 
> [1] https://patchwork.kernel.org/patch/11710643/
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
