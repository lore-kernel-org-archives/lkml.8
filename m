Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2589C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A2420842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgCBLTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:19:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:13541 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgCBLTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:19:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 03:19:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,506,1574150400"; 
   d="scan'208";a="239608115"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 02 Mar 2020 03:19:00 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1j8j6E-0067EA-03; Mon, 02 Mar 2020 13:19:02 +0200
Date:   Mon, 2 Mar 2020 13:19:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
Subject: Re: [PATCH v4 3/3] phy: intel: Add driver support for ComboPhy
Message-ID: <20200302111901.GT1224808@smile.fi.intel.com>
References: <cover.1583127977.git.eswara.kota@linux.intel.com>
 <4e55050985ef0ab567415625f5d14ab1c9b33994.1583127977.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e55050985ef0ab567415625f5d14ab1c9b33994.1583127977.git.eswara.kota@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 04:43:25PM +0800, Dilip Kota wrote:
> ComboPhy subsystem provides PHYs for various
> controllers like PCIe, SATA and EMAC.

Thanks for an update, my (few minor) comments below.

...

> +enum intel_phy_mode {
> +	PHY_PCIE_MODE = 0,
> +	PHY_XPCS_MODE,

> +	PHY_SATA_MODE

From here it's not visible that above is the only possible values.
Maybe in the future you will have another mode.
So, I suggest to leave comma here...

> +};

> +enum intel_combo_mode {
> +	PCIE0_PCIE1_MODE = 0,
> +	PCIE_DL_MODE,
> +	RXAUI_MODE,
> +	XPCS0_XPCS1_MODE,

> +	SATA0_SATA1_MODE

...and here...

> +};
> +
> +enum aggregated_mode {
> +	PHY_SL_MODE,

> +	PHY_DL_MODE

...and here.

> +};

...

> +static int intel_cbphy_iphy_cfg(struct intel_cbphy_iphy *iphy,
> +				int (*phy_cfg)(struct intel_cbphy_iphy *))
> +{
> +	struct intel_combo_phy *cbphy = iphy->parent;
> +	struct intel_cbphy_iphy *sphy;
> +	int ret;
> +
> +	ret = phy_cfg(iphy);
> +	if (ret)
> +		return ret;
> +
> +	if (cbphy->aggr_mode != PHY_DL_MODE)
> +		return 0;
> +

> +	sphy = &cbphy->iphy[PHY_1];

Do you really need temporary variable here?

> +
> +	return phy_cfg(sphy);
> +}

...

> +	if (!cbphy->init_cnt) {

	if (init_cnt)
		return 0;

?

> +		clk_disable_unprepare(cbphy->core_clk);
> +		intel_cbphy_rst_assert(cbphy);
> +	}
> +
> +	return 0;

-- 
With Best Regards,
Andy Shevchenko


