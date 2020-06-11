Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89813C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E53E2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgFKIM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:12:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:37101 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgFKIM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:12:56 -0400
IronPort-SDR: EzcRdxcBb3j0v8WYfR/dZrEcwkFUjz/RZ2B2/PQ+7B7LyY/GgZH37/ngRSVdozuUTruPrQWbGk
 0E2fKPKv8Ovw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 01:12:55 -0700
IronPort-SDR: WU+un76Q4SR2mxZ2hVUP87EHbCpgbHM1YQB+V4UZ7GoQ4Vh+DrugYRjRXu5t7nLe/bA4nQyNHE
 fvEzdvppBlXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="447838730"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 11 Jun 2020 01:12:52 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jjIKU-00CJMC-OH; Thu, 11 Jun 2020 11:12:54 +0300
Date:   Thu, 11 Jun 2020 11:12:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, balbi@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com
Subject: Re: [PATCH v2 2/2] usb: phy: Add USB3 PHY support for Intel LGM SoC
Message-ID: <20200611081254.GR2428291@smile.fi.intel.com>
References: <20200611021246.3250-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200611021246.3250-3-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611021246.3250-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 10:12:46AM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add support for USB PHY on Intel LGM SoC.

...

> +static int get_flipped(struct tca_apb *ta, bool *flipped)
> +{
> +	union extcon_property_value property;
> +	int ret;
> +
> +	ret = extcon_get_property(ta->phy.edev, EXTCON_USB_HOST,
> +				  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
> +	if (ret) {
> +		dev_err(ta->phy.dev, "no polarity property from extcon\n");

> +		return false;

return ret;

> +	}
> +
> +	*flipped = property.intval;
> +

> +	return *flipped;

return 0;

> +}

...I suppose it should be as above.

...

> +	ret = readl_poll_timeout(ctrl1, val, val & SRAM_INIT_DONE,
> +				 10, 10 * 1000);

On one line easier to read.

> +	if (ret) {
> +		dev_err(ta->phy.dev, "SRAM init failed, 0x%x\n", val);
> +		return ret;
> +	}

...

> +static int phy_set_vbus(struct usb_phy *phy, int on)
> +{
> +	struct tca_apb *ta = container_of(phy, struct tca_apb, phy);

> +	int ret = 0;

Assignment is redundant.

> +
> +	if (on) {
> +		ret = regulator_enable(ta->vbus);
> +		if (ret)
> +			dev_err(ta->phy.dev, "regulator not enabled\n");
> +	} else {
> +		ret = regulator_disable(ta->vbus);
> +		if (ret)
> +			dev_err(ta->phy.dev, "regulator not disabled\n");
> +	}
> +
> +	return ret;
> +}

...

> +	ret = get_flipped(ta, &flipped);
> +	if (!ret)
> +		dev_err(ta->phy.dev, "no polarity property from extcon\n");

This should be fixed accordingly.

...

> +		dev_info(ta->phy.dev, "connected%s\n",
> +			 flipped ? " flipped" : "");

One line.

-- 
With Best Regards,
Andy Shevchenko


