Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DABC11D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54A92465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgBTJ6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:58:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:16156 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgBTJ6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:58:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 01:58:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,464,1574150400"; 
   d="scan'208";a="239971150"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2020 01:58:44 -0800
Received: from [10.226.39.49] (unknown [10.226.39.49])
        by linux.intel.com (Postfix) with ESMTP id 40882580270;
        Thu, 20 Feb 2020 01:58:42 -0800 (PST)
Subject: Re: [PATCH v2 2/2] phy: intel: Add driver support for Combophy
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
References: <208fcb9660abd560aeab077442d158d84a3dddee.1582021248.git.eswara.kota@linux.intel.com>
 <b49e2f94631da003fb4b1409adc42fb81f77877b.1582021248.git.eswara.kota@linux.intel.com>
 <20200219101435.GM10400@smile.fi.intel.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <3c73c805-55a6-dcc0-4cd4-dd452f1d002d@linux.intel.com>
Date:   Thu, 20 Feb 2020 17:58:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200219101435.GM10400@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/19/2020 6:14 PM, Andy Shevchenko wrote:
> On Wed, Feb 19, 2020 at 11:31:30AM +0800, Dilip Kota wrote:
>> Combophy subsystem provides PHYs for various
>> controllers like PCIe, SATA and EMAC.
> ...
>
>> +static const char *const intel_iphy_names[] = {"pcie", "xpcs", "sata"};
> + blank line
Typo, will fix it.
>
>> +#define CLK_100MHZ		100000000
>> +#define CLK_156_25MHZ		156250000
> ...
>
>> +enum {
>> +	PHY_0 = 0,
> Aren't enum:s start with 0 by the standard?
> Ditto for all enum:s.
> (Or, if it represents value from hardware, perhaps makes sense to put a comment
>   to each of such enum and then all values must be explicit)
Values are related to h/w registers, will add the description in the 
comments.
>
>> +	PHY_1,
>> +	PHY_MAX_NUM,
>> +};
> ...
>
>> +struct intel_cbphy_iphy {
>> +	struct phy		*phy;
>> +	struct device		*dev;
> Can dev be derived from phy? Or phy from dev?
I see, there is no need of storing phy. Will remove it in the next patch 
version.
>
>> +	bool			enable;
>> +	struct intel_combo_phy	*parent;
>> +	struct reset_control	*app_rst;
>> +	u32			id;
>> +};
> ...
>
>> +static int intel_cbphy_iphy_enable(struct intel_cbphy_iphy *iphy, bool set)
>> +{
>> +	struct intel_combo_phy *cbphy = iphy->parent;
>> +	u32 val, bitn;
>> +
>> +	bitn = cbphy->phy_mode * 2 + iphy->id;
> Why not
>
> 	u32 mask = BIT(cbphy->phy_mode * 2 + iphy->id);
> 	u32 val;
Looks more better, i will update it.
>
>> +	/* Register: 0 is enable, 1 is disable */
>> +	val =  set ? 0 : BIT(bitn);
> 	val = set ? 0 : mask;
>
> (why double space?)
Typo error. Will correct it.
>
>> +
>> +	return regmap_update_bits(cbphy->hsiocfg, REG_CLK_DISABLE(cbphy->bid),
>> +				 BIT(bitn), val);
> 	return regmap_update_bits(..., mask, val);
>
> ?
Still it is taking more than 80 characters with mask, need to be in 2 lines

return regmap_update_bits(...,
                                                      mask, val);

>
>> +}
>> +
>> +static int intel_cbphy_pcie_refclk_cfg(struct intel_cbphy_iphy *iphy, bool set)
>> +{
>> +	struct intel_combo_phy *cbphy = iphy->parent;
>> +	const u32 pad_dis_cfg_off = 0x174;
>> +	u32 val, bitn;
>> +
>> +	bitn = cbphy->id * 2 + iphy->id;
>> +
>> +	/* Register: 0 is enable, 1 is disable */
>> +	val = set ? 0 : BIT(bitn);
>> +
>> +	return regmap_update_bits(cbphy->syscfg, pad_dis_cfg_off, BIT(bitn),
>> +				 val);
> Ditto.
Here it can with go in single line with mask,
>
>> +}
> ...
>
>> +static int intel_cbphy_iphy_cfg(struct intel_cbphy_iphy *iphy,
>> +				int (*phy_cfg)(struct intel_cbphy_iphy *))
>> +{
>> +	struct intel_combo_phy *cbphy = iphy->parent;
>> +	struct intel_cbphy_iphy *sphy;
>> +	int ret;
>> +
>> +	ret = phy_cfg(iphy);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (cbphy->aggr_mode == PHY_DL_MODE) {
> 	if (x != y)
> 		return 0;
>
>> +		sphy = &cbphy->iphy[PHY_1];
>> +		ret = phy_cfg(sphy);
>> +	}
>> +
>> +	return ret;
> 	return phy_cfg(...);
>
>> +}
> ...
>
>> +	switch (mode) {
>> +	case PHY_PCIE_MODE:
>> +		cb_mode = (aggr == PHY_DL_MODE) ?
>> +			  PCIE_DL_MODE : PCIE0_PCIE1_MODE;
> I think one line is okay here.

its taking 82 characters.

>
>> +		break;
>> +
>> +	case PHY_XPCS_MODE:
>> +		cb_mode = (aggr == PHY_DL_MODE) ? RXAUI_MODE : XPCS0_XPCS1_MODE;
>> +		break;
>> +
>> +	case PHY_SATA_MODE:
>> +		if (aggr == PHY_DL_MODE) {
>> +			dev_err(dev, "CBPHY%u mode:%u not support dual lane!\n",
>> +				cbphy->id, mode);
>> +			return -EINVAL;
>> +		}
>> +
>> +		cb_mode = SATA0_SATA1_MODE;
>> +		break;
>> +
>> +	default:
>> +		dev_err(dev, "CBPHY%u mode:%u not supported!\n",
>> +			cbphy->id, mode);
>> +		return -EINVAL;
>> +	}
> ...
>
>
>> +	if (!atomic_read(&cbphy->init_cnt)) {
> Here it can be 0.
>
>> +		ret = clk_prepare_enable(cbphy->core_clk);
>> +		if (ret) {
>> +			dev_err(cbphy->dev, "Clock enable failed!\n");
>> +			return ret;
>> +		}
>> +
>> +		ret = clk_set_rate(cbphy->core_clk, cbphy->clk_rate);
>> +		if (ret) {
>> +			dev_err(cbphy->dev, "Clock freq set to %lu failed!\n",
>> +				cbphy->clk_rate);
>> +			goto clk_err;
>> +		}
>> +
>> +		intel_cbphy_rst_assert(cbphy);
>> +		ret = intel_cbphy_set_mode(cbphy);
>> +		if (ret)
>> +			goto clk_err;
>> +	}
>> +
>> +	ret = intel_cbphy_iphy_enable(iphy, true);
>> +	if (ret) {
>> +		dev_err(dev, "Failed enabling Phy core\n");
>> +		goto clk_err;
>> +	}
>> +
>> +	if (!atomic_read(&cbphy->init_cnt))
> Here it can be 1.
True,
I will fix this.
Thanks for pointing it.
>
>> +		intel_cbphy_rst_deassert(cbphy);
> Is it correct way to go?
>
>> +	ret = reset_control_deassert(iphy->app_rst);
>> +	if (ret) {
>> +		dev_err(dev, "PHY(%u:%u) phy deassert failed!\n",
>> +			COMBO_PHY_ID(iphy), PHY_ID(iphy));
>> +		goto clk_err;
>> +	}
> ...
>
>> +		ret = intel_cbphy_iphy_cfg(iphy,
>> +					   intel_cbphy_pcie_en_pad_refclk);
> One line is fine here.
It is taking 81 characters, so kept in 2 lines.
>
>> +		if (ret)
>> +			return ret;
> ...
>
>> +		ret = intel_cbphy_iphy_cfg(iphy,
>> +					   intel_cbphy_pcie_dis_pad_refclk);
> Ditto.
82 characters here.
>
>> +		if (ret)
>> +			return ret;
> ...
>
>> +		return ret;
>> +	}
>> +
>> +	iphy->enable = true;
>> +	platform_set_drvdata(pdev, iphy);
>> +
>> +	return 0;
>> +}
> ...
>
>> +	if (cbphy->aggr_mode == PHY_DL_MODE) {
>> +		if (!iphy0->enable || !iphy1->enable) {
> 	if (a) {
> 		if (b) {
> 			...
> 		}
> 	}
>
> is the same as
> 	if (a && b) {
> 		...
> 	}
>
> We have it many times discussed internally.
Will fix it.
>
>> +			dev_err(cbphy->dev,
>> +				"Dual lane mode but lane0: %s, lane1: %s\n",
>> +				iphy0->enable ? "on" : "off",
>> +				iphy1->enable ? "on" : "off");
>> +			return -EINVAL;
>> +		}
>> +	}
> ...
>
>> +	ret = fwnode_property_get_reference_args(dev_fwnode(dev),
>> +						 "intel,syscfg", NULL, 1, 0,
>> +						 &ref);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	fwnode_handle_put(ref.fwnode);
> Why here?

Instructed to do:

" Caller is responsible to call fwnode_handle_put() on the returned   
args->fwnode pointer"

>
>> +	cbphy->id = ref.args[0];
>> +	cbphy->syscfg = device_node_to_regmap(ref.fwnode->dev->of_node);
> You rather need to have fwnode_to_regmap(). It's easy to add as a preparatory patch.
Sure, I will add it.
>
>> +
>> +	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "intel,hsio",
>> +						 NULL, 1, 0, &ref);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	fwnode_handle_put(ref.fwnode);
>> +	cbphy->bid = ref.args[0];
>> +	cbphy->hsiocfg = device_node_to_regmap(ref.fwnode->dev->of_node);
> Ditto.
>
>> +	if (!device_property_read_u32(dev, "intel,phy-mode", &prop)) {
> Hmm... Why to mix device_property_*() vs. fwnode_property_*() ?
device_property_* are wrapper functions to fwnode_property_*().
Calling the fwnode_property_*() ending up doing the same work of 
device_property_*().

If the best practice is to maintain symmetry, will call fwnode_property_*().

>
>> +		cbphy->phy_mode = prop;
>> +		if (cbphy->phy_mode >= PHY_MAX_MODE) {
>> +			dev_err(dev, "PHY mode: %u is invalid\n",
>> +				cbphy->phy_mode);
>> +			return -EINVAL;
>> +		}
>> +	}
> ...
>
>> +	.owner =	THIS_MODULE,
> Do we still need this?
Present in all the PHY drivers,
Please let me know if it need to be removed.

Regards,
Dilip

>
