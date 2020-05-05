Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40742C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1686A206D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588676442;
	bh=K7jK+93jeBiltvxYcIB2QAVepFLJ2URTxv/Kx3l60tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xQpZk5dCdrbbagWyR13bsCN/x66z7LtQXtRGjLGYtbJUmuTB596tX9kL4g84Gxtg4
	 EXl6G1/EGyFVadgqfUzmAcZed+2+6sd3vYczYUgNQo7IIqVUjnCE6xbb15k3pqYpXH
	 Om/OkHZRu3/ZuIhS+ww7bmXTyIOfBS83Nw/cgQQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgEELAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEELAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:00:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19C17206B8;
        Tue,  5 May 2020 11:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588676438;
        bh=K7jK+93jeBiltvxYcIB2QAVepFLJ2URTxv/Kx3l60tY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MqZhQ+w6PXkTW2dk3qVMo3A/1pBqhvJ1TPkzzZbg2m4O2m509ME3jLVMZzXwEw76b
         T5sxVqbnrqqsQBnnnc3YqKTg6FGJ7qWUL4Yr57tTD3kMKQDYGpzzjilfOGY7BII7GL
         QX4lrwpA4KNDKy/msBhd9jlvUM8f4payIM0B44ek=
Date:   Tue, 5 May 2020 13:00:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 3/4] usb: ehci: Add new EHCI driver for Broadcom STB
 SoC's
Message-ID: <20200505110036.GB93160@kroah.com>
References: <20200430111258.6091-1-alcooperx@gmail.com>
 <20200430111258.6091-4-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430111258.6091-4-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 07:12:57AM -0400, Al Cooper wrote:
> Add a new EHCI driver for Broadcom STB SoC's. A new EHCI driver
> was created instead of adding support to the existing ehci platform
> driver because of the code required to workaround bugs in the EHCI
> controller.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/usb/host/ehci-brcm.c | 290 +++++++++++++++++++++++++++++++++++
>  1 file changed, 290 insertions(+)
>  create mode 100644 drivers/usb/host/ehci-brcm.c

I need an ack from the EHCI maintainer to agree that this needs a whole
new driver file...

> 
> diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
> new file mode 100644
> index 000000000000..381bed5fdab0
> --- /dev/null
> +++ b/drivers/usb/host/ehci-brcm.c
> @@ -0,0 +1,290 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2020, Broadcom */
> +
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +#include <linux/iopoll.h>
> +
> +#include "ehci.h"
> +
> +#define hcd_to_ehci_priv(h) ((struct brcm_priv *)hcd_to_ehci(h)->priv)
> +
> +struct brcm_priv {
> +	struct clk *clk;
> +};
> +
> +static const char brcm_hcd_name[] = "ehci-brcm";

You don't use this anywhere?  Are you sure this didn't cause compile
warnings?

> +
> +static int (*org_hub_control)(struct usb_hcd *hcd,
> +			u16 typeReq, u16 wValue, u16 wIndex,
> +			char *buf, u16 wLength);

So you only support one device per system?  That feels bad...


> +
> +/*
> + * ehci_brcm_wait_for_sof
> + * Wait for start of next microframe, then wait extra delay microseconds
> + */
> +static inline void ehci_brcm_wait_for_sof(struct ehci_hcd *ehci, u32 delay)
> +{
> +	u32 frame_idx = ehci_readl(ehci, &ehci->regs->frame_index);
> +	u32 val;
> +	int res;
> +
> +	/* Wait for next microframe (every 125 usecs) */
> +	res = readl_relaxed_poll_timeout(&ehci->regs->frame_index, val,
> +					 val != frame_idx, 1, 130);
> +	if (res)
> +		dev_err(ehci_to_hcd(ehci)->self.controller,
> +			"Error waiting for SOF\n");
> +	udelay(delay);
> +}
> +
> +/*
> + * ehci_brcm_hub_control
> + * Intercept echi-hcd request to complete RESUME and align it to the start
> + * of the next microframe.
> + * If RESUME is complete too late in the microframe, host controller
> + * detects babble on suspended port and resets the port afterwards.
> + * This s/w workaround allows to avoid this problem.
> + * See SWLINUX-1909 for more details
> + */
> +static int ehci_brcm_hub_control(
> +	struct usb_hcd	*hcd,
> +	u16		typeReq,
> +	u16		wValue,
> +	u16		wIndex,
> +	char		*buf,
> +	u16		wLength)
> +{
> +	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
> +	int		ports = HCS_N_PORTS(ehci->hcs_params);
> +	u32 __iomem	*status_reg = &ehci->regs->port_status[
> +				(wIndex & 0xff) - 1];

Horrid line-wrapping, put this assignment below so it can be read.

And wIndex is little endian?  Or native?

> +	unsigned long flags;
> +	int retval, irq_disabled = 0;
> +
> +	/*
> +	 * RESUME is cleared when GetPortStatus() is called 20ms after start
> +	 * of RESUME
> +	 */
> +	if ((typeReq == GetPortStatus) &&
> +	    (wIndex && wIndex <= ports) &&
> +	    ehci->reset_done[wIndex-1] &&
> +	    time_after_eq(jiffies, ehci->reset_done[wIndex-1]) &&
> +	    (ehci_readl(ehci, status_reg) & PORT_RESUME)) {
> +
> +		/*
> +		 * to make sure we are not interrupted until RESUME bit
> +		 * is cleared, disable interrupts on current CPU
> +		 */
> +		ehci_dbg(ehci, "SOF alignment workaround\n");
> +		irq_disabled = 1;
> +		local_irq_save(flags);
> +		ehci_brcm_wait_for_sof(ehci, 5);
> +	}
> +	retval = (*org_hub_control)(hcd, typeReq, wValue, wIndex, buf, wLength);

But this might not be set, did you just crash?

If it is always set, then why does it need to be a function pointer at
all?

> +	if (irq_disabled)
> +		local_irq_restore(flags);
> +	return retval;
> +}
> +
> +static int ehci_brcm_reset(struct usb_hcd *hcd)
> +{
> +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> +
> +	ehci->big_endian_mmio = 1;
> +
> +	ehci->caps = (struct ehci_caps *) hcd->regs;
> +	ehci->regs = (struct ehci_regs *) (hcd->regs +

coding style, did you run this through checkpatch.pl?

> +		HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase)));
> +
> +	/* This fixes the lockup during reboot due to prior interrupts */
> +	ehci_writel(ehci, CMD_RESET, &ehci->regs->command);
> +	mdelay(10);
> +
> +	/*
> +	 * SWLINUX-1705: Avoid OUT packet underflows during high memory
> +	 *   bus usage
> +	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90
> +	 */
> +	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
> +	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
> +
> +	return ehci_setup(hcd);
> +}
> +
> +static struct hc_driver __read_mostly ehci_brcm_hc_driver;
> +
> +static const struct ehci_driver_overrides brcm_overrides __initconst = {
> +

No blank line.

> +	.reset = ehci_brcm_reset,
> +	.extra_priv_size = sizeof(struct brcm_priv),
> +};
> +
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
> +	if (irq < 0)

"<=" right?

> +		return irq;
> +
> +	/* Hook the hub control routine to work around a bug */

What bug?  This feels wrong.

> +	if (!org_hub_control)
> +		org_hub_control = ehci_brcm_hc_driver.hub_control;
> +	ehci_brcm_hc_driver.hub_control = ehci_brcm_hub_control;
> +
> +	/* initialize hcd */
> +	hcd = usb_create_hcd(&ehci_brcm_hc_driver, dev, dev_name(dev));
> +	if (!hcd)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, hcd);
> +	priv = hcd_to_ehci_priv(hcd);
> +
> +	priv->clk = devm_clk_get_optional(dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		err = PTR_ERR(priv->clk);
> +		goto err_hcd;
> +	}
> +
> +	err = clk_prepare_enable(priv->clk);

But clk was optional, will this break?

> +	if (err)
> +		goto err_hcd;
> +
> +	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res_mem);
> +	if (IS_ERR(hcd->regs)) {
> +		err = PTR_ERR(hcd->regs);
> +		goto err_clk;
> +	}
> +	hcd->rsrc_start = res_mem->start;
> +	hcd->rsrc_len = resource_size(res_mem);
> +	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
> +	if (err)
> +		goto err_clk;
> +
> +	device_wakeup_enable(hcd->self.controller);
> +	device_enable_async_suspend(hcd->self.controller);
> +	platform_set_drvdata(pdev, hcd);

Shouldn't that be set before you register the hcd?

> +
> +	return 0;
> +
> +err_clk:
> +	clk_disable_unprepare(priv->clk);
> +err_hcd:
> +	usb_put_hcd(hcd);
> +
> +	return err;
> +}
> +
> +static int ehci_brcm_remove(struct platform_device *dev)
> +{
> +	struct usb_hcd *hcd = platform_get_drvdata(dev);
> +	struct brcm_priv *priv = hcd_to_ehci_priv(hcd);
> +
> +	usb_remove_hcd(hcd);
> +	clk_disable_unprepare(priv->clk);
> +	usb_put_hcd(hcd);
> +	return 0;
> +}
> +
> +static int __maybe_unused ehci_brcm_suspend(struct device *dev)
> +{
> +	int ret;
> +	struct usb_hcd *hcd = dev_get_drvdata(dev);
> +	struct brcm_priv *priv = hcd_to_ehci_priv(hcd);
> +	bool do_wakeup = device_may_wakeup(dev);
> +
> +	ret = ehci_suspend(hcd, do_wakeup);
> +	if (ret)
> +		return ret;
> +	clk_disable_unprepare(priv->clk);
> +	return 0;
> +}
> +
> +static int __maybe_unused ehci_brcm_resume(struct device *dev)
> +{
> +	struct usb_hcd *hcd = dev_get_drvdata(dev);
> +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> +	struct brcm_priv *priv = hcd_to_ehci_priv(hcd);
> +	int err;
> +
> +	err = clk_prepare_enable(priv->clk);
> +	if (err)
> +		return err;
> +	/*
> +	 * SWLINUX-1705: Avoid OUT packet underflows during high memory
> +	 *   bus usage
> +	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00
> +	 * @ 0x90
> +	 */
> +	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
> +	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
> +
> +	ehci_resume(hcd, false);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(ehci_brcm_pm_ops, ehci_brcm_suspend,
> +		ehci_brcm_resume);
> +
> +static const struct of_device_id brcm_ehci_of_match[] = {
> +	{ .compatible = "brcm,ehci-brcm-v2", },
> +	{ .compatible = "brcm,bcm7445-ehci", },
> +	{}
> +};
> +
> +static struct platform_driver ehci_brcm_driver = {
> +	.probe		= ehci_brcm_probe,
> +	.remove		= ehci_brcm_remove,
> +	.shutdown	= usb_hcd_platform_shutdown,
> +	.driver		= {
> +		.name	= "ehci-brcm",
> +		.pm	= &ehci_brcm_pm_ops,
> +		.of_match_table = brcm_ehci_of_match,
> +	}
> +};
> +
> +static int __init ehci_brcm_init(void)
> +{
> +	if (usb_disabled())
> +		return -ENODEV;

You check this here, so why are you also checking it in the probe
function?

thanks,

greg k-h
