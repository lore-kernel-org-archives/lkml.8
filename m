Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F532C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 20:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6136920732
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 20:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgC1USt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 16:18:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:13886 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgC1USt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 16:18:49 -0400
IronPort-SDR: amEyykdrmcuGDzwxLI7SVxyFpb5FEmzZUf2j9Em/Rr2HisJSf1jimTlDcVK6D2gXmomoxJkzbS
 HTncgiKjmUVw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 13:18:48 -0700
IronPort-SDR: 8G6vRZkbxY7Lejf9g5PvRI2WmjBZDd83G0KoDb42WLdqIVZBhTz7RXzqZj1IUee8ghKyGOIFf0
 APVn58glMouQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,317,1580803200"; 
   d="scan'208";a="294222256"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Mar 2020 13:18:44 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jIHuo-00Dm35-DF; Sat, 28 Mar 2020 22:18:46 +0200
Date:   Sat, 28 Mar 2020 22:18:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/4] usb: ehci: Add new EHCI driver for Broadcom STB
 SoC's
Message-ID: <20200328201846.GF1922688@smile.fi.intel.com>
References: <20200327204711.10614-1-alcooperx@gmail.com>
 <20200327204711.10614-4-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327204711.10614-4-alcooperx@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 04:47:10PM -0400, Al Cooper wrote:
> Add a new EHCI driver for Broadcom STB SoC's. A new EHCI driver
> was created instead of adding support to the existing ehci platform
> driver because of the code required to workaround bugs in the EHCI
> controller.

I'm not sure this has been tested. See below.

...

> +#include <linux/acpi.h>
> +#include <linux/of.h>

I didn;t find evidence these are needed.

...


> +	res = readl_relaxed_poll_timeout(&ehci->regs->frame_index, val,
> +					 (val != frame_idx), 1, 130);

Too many parentheses.

> +	if (res)
> +		dev_err(ehci_to_hcd(ehci)->self.controller,
> +			"Error waiting for SOF\n");

...

> +static int ehci_brcm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res_mem;
> +	struct brcm_priv *priv;
> +	struct usb_hcd *hcd;
> +	int irq;
> +	int err;
> +
> +	if (usb_disabled())
> +		return -ENODEV;
> +
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	if (err)
> +		return err;
> +

> +	irq = platform_get_irq(pdev, 0);
> +		return irq;

I'm not sure it was an intention to leave a lot of dead code below.

> +	/* Hook the hub control routine to work around a bug */

> +	if (org_hub_control == NULL)

	if (!org_hub_control) ?

> +		org_hub_control = ehci_brcm_hc_driver.hub_control;
> +	ehci_brcm_hc_driver.hub_control = ehci_brcm_hub_control;

> +	device_wakeup_enable(hcd->self.controller);
> +	device_enable_async_suspend(hcd->self.controller);
> +	platform_set_drvdata(pdev, hcd);
> +

> +	return err;

	return 0; ?

> +err_clk:
> +	clk_disable_unprepare(priv->clk);
> +err_hcd:
> +	usb_put_hcd(hcd);
> +
> +	return err;
> +}

...

> +#ifdef CONFIG_PM_SLEEP

You also can use __maybe_unused annotations.

> +static int ehci_brcm_suspend(struct device *dev)
> +{
> +	int ret;
> +	struct usb_hcd *hcd = dev_get_drvdata(dev);
> +	struct brcm_priv *priv = hcd_to_ehci_priv(hcd);
> +	bool do_wakeup = device_may_wakeup(dev);
> +

> +	ret = ehci_suspend(hcd, do_wakeup);
> +	clk_disable_unprepare(priv->clk);
> +	return ret;

So, if you fail to suspend the device, clocks will become unusable, how to recover from such case?

> +}

> +#endif /* CONFIG_PM_SLEEP */

...

> +MODULE_DESCRIPTION(BRCM_DRIVER_DESC);

Better to have it explicit.

-- 
With Best Regards,
Andy Shevchenko


