Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2370208B3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgFLNSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:18:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:9961 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgFLNSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:18:23 -0400
IronPort-SDR: Xl4wIJOotmnv+mePScFlOIvmkV/tpRdiaG1iXKyvcON0B0VUBWK48aSg14iuAzOEmnQnyJx2yx
 hGRRbyiCYbFw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 06:18:23 -0700
IronPort-SDR: qbMMbC3vf1k45oMKqRqK8eRrYVgDJdMebeYGvLUSX5uo04mv8WSH1rUkKUqF6zrOAMAuZZuVnc
 5iGrelD9ButQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,503,1583222400"; 
   d="scan'208";a="307297849"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2020 06:18:20 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jjjZe-00CZEa-Pq; Fri, 12 Jun 2020 16:18:22 +0300
Date:   Fri, 12 Jun 2020 16:18:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, balbi@kernel.org, robh@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
Subject: Re: [PATCH v3 2/2] usb: phy: Add USB3 PHY support for Intel LGM SoC
Message-ID: <20200612131822.GG2428291@smile.fi.intel.com>
References: <20200612025941.5484-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200612025941.5484-3-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612025941.5484-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 10:59:41AM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add support for USB PHY on Intel LGM SoC.

Thank you for an update, looks pretty much good, my comments below.

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

(1)

> +		return ret;
> +	}
> +
> +	*flipped = property.intval;
> +
> +	return ret;
> +}

...

> +	ret = get_flipped(ta, &flipped);
> +	if (ret)
> +		dev_err(ta->phy.dev, "no polarity property from extcon\n");

You already has a message in (1). You should decide which one to leave.

But note, if it's a fatal error, you have to return here, otherwise, if you
decide to leave message here, it should be not on error level.

> +	connected = extcon_get_state(ta->phy.edev, EXTCON_USB_HOST);
> +	if (connected == ta->connected)
> +		return;
> +
> +	ta->connected = connected;
> +	if (connected) {
> +		val = TCPC_VALID | FIELD_PREP(TCPC_MUX_CTL, MUX_USB);
> +		if (flipped)
> +			val |= TCPC_FLIPPED;
> +		dev_info(ta->phy.dev, "connected%s\n", flipped ? " flipped" : "");
> +	} else {
> +		val = TCPC_DISCONN;
> +		dev_info(ta->phy.dev, "disconnected\n");
> +	}
> +
> +	writel(val, ta->phy.io_priv + TCPC_OFFSET);
> +

> +	if (ta->phy.set_vbus(&ta->phy, connected))
> +		dev_err(ta->phy.dev, "failed to set VBUS\n");

Please, split it to
	ret = ...;
	if (ret)

> +}

...

> +static int vbus_notifier(struct notifier_block *nb,
> +			 unsigned long event, void *ptr)

Consider to put it on one line (you can also shrink the names of unused
parameters.

> +{
> +	return NOTIFY_DONE;
> +}

-- 
With Best Regards,
Andy Shevchenko


