Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECD7C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160F5206F8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wUE2PPjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgCXIA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 04:00:27 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59692 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgCXIA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 04:00:26 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02O80NgD037166;
        Tue, 24 Mar 2020 03:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585036823;
        bh=tStaEol+foMzTzOEWkdx/YQLYwvMF/sZHm9qFFRXitc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wUE2PPjFJJIzS8NXR7vT3KmY9J/J0KvjfzD3XZ/+NZW/VXjNG+jDujzqt4l1pw+59
         pI3A005+TJjYpR8CYcPDqrgjlwix8uki7Mk6Xh1twHgLCAoIp+cEmmPJqFfOyAblt2
         OFUkdZ8ql6VF/0QfXjCJ1tIrARhWLbXGl+aM4Ck0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02O80NaG120284;
        Tue, 24 Mar 2020 03:00:23 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 24
 Mar 2020 03:00:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 24 Mar 2020 03:00:22 -0500
Received: from [10.1.3.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02O80Kfx087754;
        Tue, 24 Mar 2020 03:00:20 -0500
Subject: Re: [PATCH v2 2/2] phy: ti: j721e-wiz: Implement DisplayPort mode to
 the wiz driver
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>
CC:     <tomi.valkeinen@ti.com>, <praneeth@ti.com>, <yamonkar@cadence.com>,
        <sjakhade@cadence.com>, <robh+dt@kernel.org>, <rogerq@ti.com>
References: <cover.1578471433.git.jsarha@ti.com>
 <08f35af7ad6b948bd6ccab9f0807e36b6ddfb1c3.1578471433.git.jsarha@ti.com>
 <7c793ac4-59ae-1fcb-227c-2029240cf009@ti.com>
From:   Jyri Sarha <jsarha@ti.com>
Autocrypt: addr=jsarha@ti.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <26f98d1b-2f5a-dfbd-c9f8-b034c3c054c3@ti.com>
Date:   Tue, 24 Mar 2020 10:00:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7c793ac4-59ae-1fcb-227c-2029240cf009@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2020 09:44, Kishon Vijay Abraham I wrote:
> Hi Jyri,
> 
> On 08/01/20 2:00 PM, Jyri Sarha wrote:
>> For DisplayPort use we need to set WIZ_CONFIG_LANECTL register's
>> P_STANDARD_MODE bits to "mode 3". In the DisplayPort use also the
>> P_ENABLE bits of the same register are set to P_ENABLE instead of
>> P_ENABLE_FORCE, so that the DisplayPort driver can enable and disable
>> the lane as needed. The DisplayPort mode is selected according to
>> "cdns,phy-type"-properties found in link subnodes under the managed
>> serdes (see "ti,sierra-phy-t0" and "ti,j721e-serdes-10g" devicetree
>> bindings for details). All other values of "cdns,phy-type"-property
>> but PHY_TYPE_DP will set P_STANDARD_MODE bits to 0 and P_ENABLE bits
>> to force enable.
>>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>>  drivers/phy/ti/phy-j721e-wiz.c | 59 +++++++++++++++++++++++++++++++---
>>  1 file changed, 55 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
>> index b5f6019e5c7d..22bc04846cdb 100644
>> --- a/drivers/phy/ti/phy-j721e-wiz.c
>> +++ b/drivers/phy/ti/phy-j721e-wiz.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/regmap.h>
>>  #include <linux/reset-controller.h>
>> +#include <dt-bindings/phy/phy.h>
>>  
>>  #define WIZ_SERDES_CTRL		0x404
>>  #define WIZ_SERDES_TOP_CTRL	0x408
>> @@ -78,6 +79,8 @@ static const struct reg_field p_enable[WIZ_MAX_LANES] = {
>>  	REG_FIELD(WIZ_LANECTL(3), 30, 31),
>>  };
>>  
>> +enum p_enable { P_ENABLE = 2, P_ENABLE_FORCE = 1, P_ENABLE_DISABLE = 0 };
>> +
>>  static const struct reg_field p_align[WIZ_MAX_LANES] = {
>>  	REG_FIELD(WIZ_LANECTL(0), 29, 29),
>>  	REG_FIELD(WIZ_LANECTL(1), 29, 29),
>> @@ -220,6 +223,7 @@ struct wiz {
>>  	struct reset_controller_dev wiz_phy_reset_dev;
>>  	struct gpio_desc	*gpio_typec_dir;
>>  	int			typec_dir_delay;
>> +	u32 lane_phy_type[WIZ_MAX_LANES];
>>  };
>>  
>>  static int wiz_reset(struct wiz *wiz)
>> @@ -242,12 +246,17 @@ static int wiz_reset(struct wiz *wiz)
>>  static int wiz_mode_select(struct wiz *wiz)
>>  {
>>  	u32 num_lanes = wiz->num_lanes;
>> +	enum wiz_lane_standard_mode mode;
>>  	int ret;
>>  	int i;
>>  
>>  	for (i = 0; i < num_lanes; i++) {
>> -		ret = regmap_field_write(wiz->p_standard_mode[i],
>> -					 LANE_MODE_GEN4);
>> +		if (wiz->lane_phy_type[i] == PHY_TYPE_DP)
>> +			mode = LANE_MODE_GEN1;
>> +		else
>> +			mode = LANE_MODE_GEN4;
>> +
>> +		ret = regmap_field_write(wiz->p_standard_mode[i], mode);
>>  		if (ret)
>>  			return ret;
>>  	}
>> @@ -707,7 +716,7 @@ static int wiz_phy_reset_assert(struct reset_controller_dev *rcdev,
>>  		return ret;
>>  	}
>>  
>> -	ret = regmap_field_write(wiz->p_enable[id - 1], false);
>> +	ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE_DISABLE);
>>  	return ret;
>>  }
>>  
>> @@ -734,7 +743,11 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
>>  		return ret;
>>  	}
>>  
>> -	ret = regmap_field_write(wiz->p_enable[id - 1], true);
>> +	if (wiz->lane_phy_type[id - 1] == PHY_TYPE_DP)
>> +		ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE);
>> +	else
>> +		ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE_FORCE);
>> +
>>  	return ret;
>>  }
>>  
>> @@ -761,6 +774,40 @@ static const struct of_device_id wiz_id_table[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, wiz_id_table);
>>  
>> +static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
>> +{
>> +	struct device_node *serdes, *subnode;
>> +
>> +	serdes = of_get_child_by_name(dev->of_node, "serdes");
>> +	if (!serdes) {
>> +		dev_err(dev, "%s: Getting \"serdes\"-node failed\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	for_each_child_of_node(serdes, subnode) {
>> +		u32 reg, num_lanes = 1, phy_type = PHY_NONE;
>> +		int ret, i;
>> +
>> +		ret = of_property_read_u32(subnode, "reg", &reg);
>> +		if (ret) {
>> +			dev_err(dev,
>> +				"%s: Reading \"reg\" from \"%s\" failed: %d\n",
>> +				__func__, subnode->name, ret);
>> +			return ret;
>> +		}
>> +		of_property_read_u32(subnode, "cdns,num-lanes", &num_lanes);
>> +		of_property_read_u32(subnode, "cdns,phy-type", &phy_type);
> This would require the Torrent bindings to be Reviewed and Acked.
> 

I think they are now in your next branch. Could you please pick this one
up too?

BR,
Jyri


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
