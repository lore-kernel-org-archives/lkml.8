Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24682C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041682068F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgBTK5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:57:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:50598 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbgBTK5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:57:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 02:57:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,464,1574150400"; 
   d="scan'208";a="224826205"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 20 Feb 2020 02:57:20 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1j4jWE-003VkL-Fe; Thu, 20 Feb 2020 12:57:22 +0200
Date:   Thu, 20 Feb 2020 12:57:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
Subject: Re: [PATCH v2 2/2] phy: intel: Add driver support for Combophy
Message-ID: <20200220105722.GB10400@smile.fi.intel.com>
References: <208fcb9660abd560aeab077442d158d84a3dddee.1582021248.git.eswara.kota@linux.intel.com>
 <b49e2f94631da003fb4b1409adc42fb81f77877b.1582021248.git.eswara.kota@linux.intel.com>
 <20200219101435.GM10400@smile.fi.intel.com>
 <3c73c805-55a6-dcc0-4cd4-dd452f1d002d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c73c805-55a6-dcc0-4cd4-dd452f1d002d@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 05:58:41PM +0800, Dilip Kota wrote:
> On 2/19/2020 6:14 PM, Andy Shevchenko wrote:
> > On Wed, Feb 19, 2020 at 11:31:30AM +0800, Dilip Kota wrote:

...

> > 	return regmap_update_bits(..., mask, val);
> > 
> > ?
> Still it is taking more than 80 characters with mask, need to be in 2 lines
> 
> return regmap_update_bits(...,
>                                                      mask, val);

It's up to maintainer, I was talking about use of temporary variable for mask.

> > > +static int intel_cbphy_pcie_refclk_cfg(struct intel_cbphy_iphy *iphy, bool set)
> > > +{
> > > +	struct intel_combo_phy *cbphy = iphy->parent;
> > > +	const u32 pad_dis_cfg_off = 0x174;
> > > +	u32 val, bitn;
> > > +
> > > +	bitn = cbphy->id * 2 + iphy->id;
> > > +
> > > +	/* Register: 0 is enable, 1 is disable */
> > > +	val = set ? 0 : BIT(bitn);
> > > +
> > > +	return regmap_update_bits(cbphy->syscfg, pad_dis_cfg_off, BIT(bitn),
> > > +				 val);
> > Ditto.
> Here it can with go in single line with mask,

Here I meant all changes from previous function, yes, temporary variable mask
in particular.

> > > +}

...

> > > +	case PHY_PCIE_MODE:
> > > +		cb_mode = (aggr == PHY_DL_MODE) ?
> > > +			  PCIE_DL_MODE : PCIE0_PCIE1_MODE;
> > I think one line is okay here.

> its taking 82 characters.

Up to maintainer, but I consider the two lines approach is worse to read.

> > > +		break;

...

> > > +		ret = intel_cbphy_iphy_cfg(iphy,
> > > +					   intel_cbphy_pcie_en_pad_refclk);
> > One line is fine here.
> It is taking 81 characters, so kept in 2 lines.

Ditto.

> > > +		if (ret)
> > > +			return ret;

...

> > > +		ret = intel_cbphy_iphy_cfg(iphy,
> > > +					   intel_cbphy_pcie_dis_pad_refclk);
> > Ditto.
> 82 characters here.

Ditto.

> > > +		if (ret)
> > > +			return ret;

...

> > > +	ret = fwnode_property_get_reference_args(dev_fwnode(dev),
> > > +						 "intel,syscfg", NULL, 1, 0,
> > > +						 &ref);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	fwnode_handle_put(ref.fwnode);
> > Why here?
> 
> Instructed to do:
> 
> " Caller is responsible to call fwnode_handle_put() on the returned  
> args->fwnode pointer"

Right...

> > > +	cbphy->id = ref.args[0];
> > > +	cbphy->syscfg = device_node_to_regmap(ref.fwnode->dev->of_node);

...and here you called unreferenced one. Is it okay?
If it's still being referenced, that is fine, but otherwise it may gone already.


> > > +	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "intel,hsio",
> > > +						 NULL, 1, 0, &ref);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	fwnode_handle_put(ref.fwnode);
> > > +	cbphy->bid = ref.args[0];
> > > +	cbphy->hsiocfg = device_node_to_regmap(ref.fwnode->dev->of_node);
> > Ditto.
> > 
> > > +	if (!device_property_read_u32(dev, "intel,phy-mode", &prop)) {
> > Hmm... Why to mix device_property_*() vs. fwnode_property_*() ?
> device_property_* are wrapper functions to fwnode_property_*().
> Calling the fwnode_property_*() ending up doing the same work of
> device_property_*().
> 
> If the best practice is to maintain symmetry, will call fwnode_property_*().

The best practice to keep consistency as much as possible.
If you call two similar APIs in one scope, it's not okay.

-- 
With Best Regards,
Andy Shevchenko


