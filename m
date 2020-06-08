Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DD2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653F1206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgFHKHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:07:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:57304 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729264AbgFHKHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:07:54 -0400
IronPort-SDR: 3nxrl/gQ0tS6XoX6ZlslvSj68Zx01CKmMaiqpfRbvem7zRZZRPe6sax0+FP8d3+yMhfegxXokV
 5+e33prtmzZA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 03:07:54 -0700
IronPort-SDR: 5+7mES5COj9KJp8BgF2WCLGOmjUk53k4O90NWFP63bw+uIJk21msuAnnqH1epYgov0wl8MA8je
 QnkXj4F0mPHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="274169342"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2020 03:07:51 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jiEh8-00BeJO-TK; Mon, 08 Jun 2020 13:07:54 +0300
Date:   Mon, 8 Jun 2020 13:07:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com
Subject: Re: [PATCH v3 2/2] phy: intel: Add Keem Bay eMMC PHY support
Message-ID: <20200608100754.GD2428291@smile.fi.intel.com>
References: <20200608081501.29558-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200608081501.29558-3-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608081501.29558-3-wan.ahmad.zainie.wan.mohamad@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 04:15:01PM +0800, Wan Ahmad Zainie wrote:
> Add support for eMMC PHY on Intel Keem Bay SoC.

I think I commented on something already.

...

> +	if (ret) {
> +		dev_err(&phy->dev, "dllrdy failed, ret=%d\n", ret);

> +		return ret;
> +	}
> +
> +	return 0;

return ret;

...

> +	if (IS_ERR(priv->emmcclk)) {
> +		dev_err(&phy->dev, "ERROR: getting emmcclk\n");

> +		return PTR_ERR(priv->emmcclk);
> +	}
> +
> +	return 0;

return PTR_ERR_OR_ZERO(...);

...

> +	priv->syscfg = devm_regmap_init_mmio(dev, base,
> +					     &keembay_regmap_config);

One line.

-- 
With Best Regards,
Andy Shevchenko


