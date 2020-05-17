Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68260C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 14:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D4E2081A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 14:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgEQOoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 10:44:25 -0400
Received: from mail-mw2nam10olkn2032.outbound.protection.outlook.com ([40.92.42.32]:8768
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727928AbgEQOoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 10:44:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXf5yWNQD8XF1ua0oI8be2kVgKyirsANrB4rc+8mK3R2ELyrrWQF3JN7qF0lKnAe9n0SFIyCk0+n9sacwZEFne31UIffG3JevYR6XdDb3I1paEEfS0b/sHHTY/3kWi1+REDVdbnHMJJrENm2kfwuhAs33/jcJQP9tO/KyIshsLl3RMMR9e3BqPlAhsw6pVDcxk3ZT8k8YTXqRMt7dfooWXJsACrSXc+zpWIdY5uJonUarj2znStSZKj9NCimau9XHPUwewYza1uLqX+Th7V17ZYBNBmqJXtDJisOE5VhZKZ8H+/zTx8jKh5JXFC1Whgv0Rn3GtVS8rU/yTe55g1iEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f+6I5yVx/3RTW/3o6B3F9kbVBIMW5EdrK9B38JAnjM=;
 b=BZ7DD9hGDytwqB/knRvqPs/iBKXZyC7LVe5RWAHTPhKB5Ed9Gp6kunc7L7bdObHRHtSonImWPvOoJ9ziqyEEDuMxwfhU2H5k7w6aJQUMB/BJHBKad0I5Nd3dIZMkozaFvAncD+TsfvJR3qcZjzpHMPWQB40v1Ks8xTFr3itFjuHXf3pd7y+M1yWONj8dp/QVS3oTZZDhaCiLLIGvC5ibL9+C0whH1HWwZJf6d2WkqH8mlWEKiEXswtaWDBoR/c4njuJIOzKrSRMor9qs7n7oG3MWjTB92w9DR2JTTBkWBTeXdGen4ehBBwMmA6louom8WB9a34f3eiLrsE+vDL25Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM10FT005.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e86::4f) by
 DM6NAM10HT111.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e86::260)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Sun, 17 May
 2020 14:44:21 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e86::53) by DM6NAM10FT005.mail.protection.outlook.com
 (2a01:111:e400:7e86::87) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Sun, 17 May 2020 14:44:21 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:A79863CBE265326627B32FDF0DD66038C44259B2EADAD121ED5CD72E804A167E;UpperCasedChecksum:E4D52E452244C2926AC4F0C41C94D127C367A311F99C4163C491BD11FB54AB18;SizeAsReceived:9107;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Sun, 17 May 2020
 14:44:21 +0000
Subject: Re: [PATCH 2/2] regulator: max8998: Add charger regulator
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200516194759.7643-1-xc-racer2@live.ca>
 <BN6PR04MB0660E1F4A3D5A348BE88311CA3BA0@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660FEB069277F16499AD12AA3BB0@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Sun, 17 May 2020 07:44:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <BN6PR04MB0660E1F4A3D5A348BE88311CA3BA0@BN6PR04MB0660.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR18CA0059.namprd18.prod.outlook.com
 (2603:10b6:104:2::27) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <c6ffc9f9-ea3b-af4a-4fa5-c90fd04624eb@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by CO2PR18CA0059.namprd18.prod.outlook.com (2603:10b6:104:2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Sun, 17 May 2020 14:44:20 +0000
X-Microsoft-Original-Message-ID: <c6ffc9f9-ea3b-af4a-4fa5-c90fd04624eb@live.ca>
X-TMN:  [fuT6fOWFNZQcvINDbd1XRsYGaSsxQddj5WWOFtUJn2crn4wCuImjeWg0/o/Dghid]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 20fa8f4a-6561-4bb2-365f-08d7fa70c8f5
X-MS-TrafficTypeDiagnostic: DM6NAM10HT111:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1FTLS241CljazLGTM3ovymnNtyVF3GKvIgcstRdGiQKgwcuzrb9XbOiw3wZ4+5c4lJWHxh+cXwrLrgRkXxHm0z05SXzmA4JpchhIQ2yuGVjEQy2hBpnu2IdWPLDVRyZuDzwOno3sIsWKq4A1wB03IEZRRuXcwezwMk81yddn6u7EwyPK57DcE4YYoP2eefZMa0Ch/oEmoEGojCGn5gyT6xUdeyUSN9uA1+nYPmOte3gQY9w7RX0MdMf6Wi/6d/Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: KhIlqCC+wSR7QEZGWBKE+uVLPC4qtR15nRZcpXZ4Wj10v3yhkYn+DENScC+KpoQ0SCCDvIahlAx0woAEkGBJiS3ad3MSiP/H09h0FOQs7UoxS7Vk53/6sXyy8E8YhpmceTHuzvkfceEFNBFJt6yvNqXeGhsKLnm0Qz38zon9AXMmsKhupyNCIl3s1rnOeEJQ+cDL2IcwDNU3FYxdDx2ijA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fa8f4a-6561-4bb2-365f-08d7fa70c8f5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2020 14:44:21.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM10HT111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, while searching around looking for documentation on other parts of the charging
system for max8998, I've come across the originally patch for charger regulator(1).
It turns out the lp3974 has different current values.

It was never merged, as, to quote Mark Brown(2),

"As I've said before I'm still not really happy that these regulators can
meaningfully be generic regulator drivers rather than just being handled
as part of the PMU driver."

My use case for the generic regulator is so that the charger can be controlled
via charger-manager and the currents changed based on what type of cable is
connected (ie dedicated charger or USB charger).  The other reason that I'm
looking to use charger-manager is you can specify the over-temp and over-voltage
values (when there's external monitoring) while this part of the max8998/lp3974
isn't documented in the least (and based on registers sizes there a max of 4
options for each).

Is it worthwhile me spinning up a v2 with corrected currents for lp3974?

Thanks,
Jonathan

1) https://lore.kernel.org/lkml/1308909859-3674-3-git-send-email-dg77.kim@samsung.com/
2) https://lore.kernel.org/lkml/20110709030853.GA23634@opensource.wolfsonmicro.com/

On 2020-05-16 12:47 p.m., Jonathan Bakker wrote:
> The max8998 has a current regulator for charging control.  The
> charger driver in drivers/power/supply/max8998_charger.c has a
> comment in it stating that 'charger control is done by a current
> regulator "CHARGER"', but this regulator was never added until
> now.
> 
> The current values have been extracted from a downstream driver
> for the SGH-T959V.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  drivers/regulator/max8998.c | 105 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max8998.h |   1 +
>  2 files changed, 106 insertions(+)
> 
> diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
> index 60599c3bb845..668ced006417 100644
> --- a/drivers/regulator/max8998.c
> +++ b/drivers/regulator/max8998.c
> @@ -33,6 +33,10 @@ struct max8998_data {
>  	unsigned int		buck2_idx;
>  };
>  
> +static const unsigned int charger_current_table[] = {
> +	90000, 380000, 475000, 550000, 570000, 600000, 700000, 800000,
> +};
> +
>  static int max8998_get_enable_register(struct regulator_dev *rdev,
>  					int *reg, int *shift)
>  {
> @@ -63,6 +67,10 @@ static int max8998_get_enable_register(struct regulator_dev *rdev,
>  		*reg = MAX8998_REG_CHGR2;
>  		*shift = 7 - (ldo - MAX8998_ESAFEOUT1);
>  		break;
> +	case MAX8998_CHARGER:
> +		*reg = MAX8998_REG_CHGR2;
> +		*shift = 0;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -88,6 +96,11 @@ static int max8998_ldo_is_enabled(struct regulator_dev *rdev)
>  	return val & (1 << shift);
>  }
>  
> +static int max8998_ldo_is_enabled_inverted(struct regulator_dev *rdev)
> +{
> +	return (!max8998_ldo_is_enabled(rdev));
> +}
> +
>  static int max8998_ldo_enable(struct regulator_dev *rdev)
>  {
>  	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
> @@ -358,6 +371,74 @@ static int max8998_set_voltage_buck_time_sel(struct regulator_dev *rdev,
>  	return 0;
>  }
>  
> +int max8998_set_current_limit(struct regulator_dev *rdev,
> +			      int min_uA, int max_uA)
> +{
> +	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
> +	struct i2c_client *i2c = max8998->iodev->i2c;
> +	unsigned int n_currents = rdev->desc->n_current_limits;
> +	int i, sel = -1;
> +
> +	if (n_currents == 0)
> +		return -EINVAL;
> +
> +	if (rdev->desc->curr_table) {
> +		const unsigned int *curr_table = rdev->desc->curr_table;
> +		bool ascend = curr_table[n_currents - 1] > curr_table[0];
> +
> +		/* search for closest to maximum */
> +		if (ascend) {
> +			for (i = n_currents - 1; i >= 0; i--) {
> +				if (min_uA <= curr_table[i] &&
> +				    curr_table[i] <= max_uA) {
> +					sel = i;
> +					break;
> +				}
> +			}
> +		} else {
> +			for (i = 0; i < n_currents; i++) {
> +				if (min_uA <= curr_table[i] &&
> +				    curr_table[i] <= max_uA) {
> +					sel = i;
> +					break;
> +				}
> +			}
> +		}
> +	}
> +
> +	if (sel < 0)
> +		return -EINVAL;
> +
> +	sel <<= ffs(rdev->desc->csel_mask) - 1;
> +
> +	return max8998_update_reg(i2c, rdev->desc->csel_reg,
> +				  sel, rdev->desc->csel_mask);
> +}
> +
> +int max8998_get_current_limit(struct regulator_dev *rdev)
> +{
> +	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
> +	struct i2c_client *i2c = max8998->iodev->i2c;
> +	u8 val;
> +	int ret;
> +
> +	ret = max8998_read_reg(i2c, rdev->desc->csel_reg, &val);
> +	if (ret != 0)
> +		return ret;
> +
> +	val &= rdev->desc->csel_mask;
> +	val >>= ffs(rdev->desc->csel_mask) - 1;
> +
> +	if (rdev->desc->curr_table) {
> +		if (val >= rdev->desc->n_current_limits)
> +			return -EINVAL;
> +
> +		return rdev->desc->curr_table[val];
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static const struct regulator_ops max8998_ldo_ops = {
>  	.list_voltage		= regulator_list_voltage_linear,
>  	.map_voltage		= regulator_map_voltage_linear,
> @@ -379,6 +460,15 @@ static const struct regulator_ops max8998_buck_ops = {
>  	.set_voltage_time_sel	= max8998_set_voltage_buck_time_sel,
>  };
>  
> +static const struct regulator_ops max8998_charger_ops = {
> +	.set_current_limit	= max8998_set_current_limit,
> +	.get_current_limit	= max8998_get_current_limit,
> +	.is_enabled		= max8998_ldo_is_enabled_inverted,
> +	/* Swapped as register is inverted */
> +	.enable			= max8998_ldo_disable,
> +	.disable		= max8998_ldo_enable,
> +};
> +
>  static const struct regulator_ops max8998_others_ops = {
>  	.is_enabled		= max8998_ldo_is_enabled,
>  	.enable			= max8998_ldo_enable,
> @@ -397,6 +487,19 @@ static const struct regulator_ops max8998_others_ops = {
>  		.owner = THIS_MODULE, \
>  	}
>  
> +#define MAX8998_CURRENT_REG(_name, _ops, _table, _reg, _mask) \
> +	{ \
> +		.name = #_name, \
> +		.id = MAX8998_##_name, \
> +		.ops = _ops, \
> +		.curr_table = _table, \
> +		.n_current_limits = ARRAY_SIZE(_table), \
> +		.csel_reg = _reg, \
> +		.csel_mask = _mask, \
> +		.type = REGULATOR_CURRENT, \
> +		.owner = THIS_MODULE, \
> +	}
> +
>  #define MAX8998_OTHERS_REG(_name, _id) \
>  	{ \
>  		.name = #_name, \
> @@ -432,6 +535,8 @@ static const struct regulator_desc regulators[] = {
>  	MAX8998_OTHERS_REG(ENVICHG, MAX8998_ENVICHG),
>  	MAX8998_OTHERS_REG(ESAFEOUT1, MAX8998_ESAFEOUT1),
>  	MAX8998_OTHERS_REG(ESAFEOUT2, MAX8998_ESAFEOUT2),
> +	MAX8998_CURRENT_REG(CHARGER, &max8998_charger_ops,
> +			    charger_current_table, MAX8998_REG_CHGR1, 0x7),
>  };
>  
>  static int max8998_pmic_dt_parse_dvs_gpio(struct max8998_dev *iodev,
> diff --git a/include/linux/mfd/max8998.h b/include/linux/mfd/max8998.h
> index 061af220dcd3..79c020bd0c70 100644
> --- a/include/linux/mfd/max8998.h
> +++ b/include/linux/mfd/max8998.h
> @@ -39,6 +39,7 @@ enum {
>  	MAX8998_ENVICHG,
>  	MAX8998_ESAFEOUT1,
>  	MAX8998_ESAFEOUT2,
> +	MAX8998_CHARGER,
>  };
>  
>  /**
> 
