Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B6DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C822072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCMPI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:08:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:11038 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgCMPIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:08:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 08:08:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="322815286"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 13 Mar 2020 08:08:48 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jClve-009I1a-FG; Fri, 13 Mar 2020 17:08:50 +0200
Date:   Fri, 13 Mar 2020 17:08:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/4] usb: ehci: Add new EHCI driver for Broadcom STB SoC's
Message-ID: <20200313150850.GV1922688@smile.fi.intel.com>
References: <20200313141545.31943-1-alcooperx@gmail.com>
 <20200313141545.31943-4-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313141545.31943-4-alcooperx@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 10:15:44AM -0400, Al Cooper wrote:
> Add a new EHCI driver for Broadcom STB SoC's. A new EHCI driver
> was created instead of adding support to the existing ehci platform
> driver because of the code required to workaround bugs in the EHCI
> controller.

I'm not sure this is the best approach, but I leave it to maintainers.

By the way, can you list what exactly the difference to the (generic)
ehci driver?

...

> +#include <linux/acpi.h>
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>

...

> +/* ehci_brcm_wait_for_sof
> + * Wait for start of next microframe, then wait extra delay microseconds
> + */

Style is inconsistent even inside this file.

> +static inline void ehci_brcm_wait_for_sof(struct ehci_hcd *ehci, u32 delay)
> +{
> +	int frame_idx = ehci_readl(ehci, &ehci->regs->frame_index);

This is not needed if you use do {} while approach.

> +

> +	while (frame_idx == ehci_readl(ehci, &ehci->regs->frame_index))
> +		;

Busy loop without even power management taking into consideration?

Infinite loop?

> +	udelay(delay);
> +}

...

> +static const struct ehci_driver_overrides brcm_overrides __initconst = {
> +

> +	.reset =	ehci_brcm_reset,

Indentation issue.

> +	.extra_priv_size = sizeof(struct brcm_priv),
> +};

...

> +static int ehci_brcm_probe(struct platform_device *pdev)
> +{

> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {

> +		dev_err(&pdev->dev, "no irq provided");

Duplicate with core message.

> +		return irq;
> +	}

> +	/* initialize hcd */
> +	hcd = usb_create_hcd(&ehci_brcm_hc_driver,
> +			&pdev->dev, dev_name(&pdev->dev));

At least this one will look much better (and fit one line) when you introduce

	struct device *dev = &pdev->dev;

in the definition block above.

> +	if (!hcd)
> +		return -ENOMEM;

> +	return err;
> +}

...

> +static struct platform_driver ehci_brcm_driver = {
> +	.probe		= ehci_brcm_probe,
> +	.remove		= ehci_brcm_remove,
> +	.shutdown	= usb_hcd_platform_shutdown,
> +	.driver		= {

> +		.owner	= THIS_MODULE,

Do we need this?

> +		.name	= "ehci-brcm",
> +		.pm	= &ehci_brcm_pm_ops,
> +		.of_match_table = brcm_ehci_of_match,
> +	}
> +};

-- 
With Best Regards,
Andy Shevchenko


