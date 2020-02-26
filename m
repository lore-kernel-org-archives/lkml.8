Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE324C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E0921D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBZOls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:41:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:15113 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgBZOls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:41:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 06:41:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="350403644"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2020 06:41:45 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1j6xsh-004wzF-3T; Wed, 26 Feb 2020 16:41:47 +0200
Date:   Wed, 26 Feb 2020 16:41:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
Subject: Re: [PATCH v3 3/3] phy: intel: Add driver support for Combophy
Message-ID: <20200226144147.GQ10400@smile.fi.intel.com>
References: <cover.1582709320.git.eswara.kota@linux.intel.com>
 <48dbbe705a1f22fb9e088827ca0be149e8fbcd85.1582709320.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48dbbe705a1f22fb9e088827ca0be149e8fbcd85.1582709320.git.eswara.kota@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 06:09:53PM +0800, Dilip Kota wrote:
> Combophy subsystem provides PHYs for various
> controllers like PCIe, SATA and EMAC.

Thanks for an update, my comments below.

...

> +config PHY_INTEL_COMBO
> +	bool "Intel Combo PHY driver"

> +	depends on OF && HAS_IOMEM && (X86 || COMPILE_TEST)

I guess it would be better to have like this:

	depends on X86 || COMPILE_TEST
	depends on OF && HAS_IOMEM

But do you still have a dependency to OF?

> +	select MFD_SYSCON
> +	select GENERIC_PHY
> +	select REGMAP

...

> + * Copyright (C) 2019 Intel Corporation.

2019-2020

...

> +static const unsigned long intel_iphy_clk_rates[] = {
> +	CLK_100MHZ, CLK_156_25MHZ, CLK_100MHZ

It's good to have comma at the end since this might potentially be extended in
the future.

> +};
> +
> +enum {
> +	PHY_0,
> +	PHY_1,

> +	PHY_MAX_NUM,

But here we don't need it since it's a terminator line.
Ditto for the rest of enumerators with a terminator / max entry.

> +};

...

> +/*
> + * Clock register bitfields to enable clocks
> + * for ComboPhy according to the mode

For multi-line comments use proper English punctuation.

> + */

...

> +static int intel_cbphy_pcie_refclk_cfg(struct intel_cbphy_iphy *iphy, bool set)
> +{
> +	struct intel_combo_phy *cbphy = iphy->parent;
> +	u32 mask = BIT(cbphy->id * 2 + iphy->id);

> +	const u32 pad_dis_cfg_off = 0x174;

This has to be defined in the top.

> +	u32 val;
> +
> +	/* Register: 0 is enable, 1 is disable */
> +	val = set ? 0 : mask;
> +
> +	return regmap_update_bits(cbphy->syscfg, pad_dis_cfg_off, mask, val);
> +}

...

> +	ret = phy_cfg(sphy);
> +
> +	return ret;

	return phy_cfg();

...

> +	/*
> +	 * No way to identify gen1/2/3/4 for mppla and mpplb, just delay
> +	 * for stable plla(gen1/gen2) or pllb(gen3/gen4)
> +	 */

Use proper abbreviation rules, i.e. capitalize appropriately. (I think at least
PLL is quite common way to do it, the rest depends to the documentation / your
intentions).


...

> +	ret = reset_control_assert(iphy->app_rst);
> +	if (ret) {
> +		dev_err(dev, "PHY(%u:%u) core assert failed!\n",
> +			COMBO_PHY_ID(iphy), PHY_ID(iphy));
> +		return ret;
> +	}
> +
> +	ret = intel_cbphy_iphy_enable(iphy, false);
> +	if (ret) {
> +		dev_err(dev, "Failed disabling Phy core\n");

Phy -> PHY for sake of the consistency

> +		return ret;
> +	}

...

> +	/* Wait RX adaptation to finish */
> +	ret = readl_poll_timeout(cr_base + CR_ADDR(PCS_XF_RX_ADAPT_ACK, id),
> +				 val, val & RX_ADAPT_ACK_BIT, 10, 5000);
> +	if (ret)
> +		dev_err(dev, "RX Adaptation failed!\n");
> +	else

> +		dev_info(dev, "RX Adaptation success!\n");

Sounds more likely like dev_dbg().

...

> +static int intel_cbphy_iphy_dt_parse(struct intel_combo_phy *cbphy,

dt -> fwnode
Ditto for other similar function names.

> +				     struct fwnode_handle *fwnode, int idx)
> +{

> +	dev = get_dev_from_fwnode(fwnode);

I don't see where you drop reference count to the struct device object.

> +}

...

> +	if (!iphy0->enable && !iphy1->enable) {

	if (!(iphy0->enable || iphy1->enable)) {

?

> +		dev_err(cbphy->dev, "CBPHY%u both PHY disabled!\n", cbphy->id);

> +		return -EINVAL;

-ENODEV ?

> +	}
> +
> +	if (cbphy->aggr_mode == PHY_DL_MODE &&
> +	    (!iphy0->enable || !iphy1->enable)) {

	if (cbphy->aggr_mode == PHY_DL_MODE && !(iphy0->enable && iphy1->enable)) {

?

> +		dev_err(cbphy->dev,
> +			"Dual lane mode but lane0: %s, lane1: %s\n",
> +			iphy0->enable ? "on" : "off",
> +			iphy1->enable ? "on" : "off");
> +		return -EINVAL;
> +	}

...

> +	struct fwnode_reference_args ref;
> +	struct device *dev = cbphy->dev;
> +	struct fwnode_handle *fwnode;
> +	struct platform_device *pdev;
> +	int i, ret;
> +	u32 prop;

I guess the following would be better:

	struct device *dev = cbphy->dev;
	struct platform_device *pdev = to_platform_device(dev);
	struct fwnode_handle *fwnode = dev_fwnode(dev);
	struct fwnode_reference_args ref;
	int i, ret;
	u32 prop;

> +	pdev = to_platform_device(dev);

See above.

> +	fwnode = dev_fwnode(dev);

See above.

> +	ret = fwnode_property_read_u32_array(fwnode, "intel,phy-mode", &prop, 1);
> +	if (ret)
> +		return ret;
> +
> +	if (prop >= PHY_MAX_MODE) {
> +		dev_err(dev, "Invalid phy mode: %u\n", prop);
> +		return -EINVAL;
> +	}
> +
> +	cbphy->phy_mode = prop;

I don't see why you need temporary variable at all?


...

> +	i = 0;
> +	fwnode_for_each_available_child_node(dev_fwnode(dev), fwnode) {

> +		if (i >= PHY_MAX_NUM) {
> +			fwnode_handle_put(fwnode);
> +			dev_err(dev, "Error: DT child number larger than %d\n",
> +				PHY_MAX_NUM);
> +			return -EINVAL;
> +		}

Logically this part is better to put after i++; line...

> +		ret = intel_cbphy_iphy_dt_parse(cbphy, fwnode, i);
> +		if (ret) {
> +			fwnode_handle_put(fwnode);
> +			return ret;
> +		}
> +

> +		i++;

...here.

> +	}
> +
> +	return intel_cbphy_dt_sanity_check(cbphy);
> +}

...

> +	.init =		intel_cbphy_init,
> +	.exit =		intel_cbphy_exit,
> +	.calibrate =	intel_cbphy_calibrate,
> +	.owner =	THIS_MODULE,

Usual way is to format by =, i.e.

	.init		= intel_cbphy_init,
	.exit		= intel_cbphy_exit,
	.calibrate	= intel_cbphy_calibrate,
	.owner		= THIS_MODULE,

...

> +	for (i = 0; i < PHY_MAX_NUM; i++) {
> +		iphy = &cbphy->iphy[i];

> +		if (iphy->enable) {

		if (!iphy->enable)
			continue;

?

> +			ret = intel_cbphy_iphy_create(iphy);
> +			if (ret)
> +				return ret;
> +		}
> +	}

...

> +	platform_set_drvdata(pdev, cbphy);

I guess it makes sense a bit later to do...

> +	ret = intel_cbphy_dt_parse(cbphy);
> +	if (ret)
> +		return ret;

...here?

> +
> +	return intel_cbphy_create(cbphy);

-- 
With Best Regards,
Andy Shevchenko


