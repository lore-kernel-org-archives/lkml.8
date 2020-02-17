Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D87C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9158E2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581935769;
	bh=60viLGKf79jXAYXHImdhwgxFlEuSkAt+HsIyxhV25lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V3Uk8el2s50DNt2C1qQHyJ720NsolDw6FqWwOonlXpOogKY7i5auoHLl8BWiZ9m1X
	 TQo7onihiNh4O00cvQsqLHKb2G0aYCMdKB3hB0XISJrhUi1eTLbu9f2rMc8TYXmSkn
	 fubFzUhMLFwvUHL00BvP2F1jRUFyBiAUEBMxF/+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgBQKgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:36:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbgBQKgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:36:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB2D420725;
        Mon, 17 Feb 2020 10:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581935767;
        bh=60viLGKf79jXAYXHImdhwgxFlEuSkAt+HsIyxhV25lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYlTq6hflCJzX6XFC6jLt7AvBAgZw/8p1du/CYSw/mqOuHrhFtercBxM1Wi6zCe5m
         eQI8yyOD/oy5vnxuSOpYCuQ2gZNaYbD8fLHnV+lyHYSiZAhWLuWghe8Avhpb7BWE6G
         3J5NZqs8bYpPR2a2GT0Hj/sZExxyxFG6CYA/ACYo=
Date:   Mon, 17 Feb 2020 11:36:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, oneukum@suse.com,
        phil@raspberrypi.com, tim.gover@raspberrypi.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] usb: xhci-pci: Raspberry Pi FW loader for VIA VL805
Message-ID: <20200217103605.GA93732@kroah.com>
References: <20200217100701.19949-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217100701.19949-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:07:00AM +0100, Nicolas Saenz Julienne wrote:
> On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> loaded directly from an EEPROM or, if not present, by the SoC's
> VideCore.  Inform VideCore that VL805 was just reset, or defer xhci's
> probe if not yet joinable trough the mailbox interface.
> 
> Based on Tim Gover's downstream implementation.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/usb/host/xhci-pci.c                | 50 ++++++++++++++++++++++
>  include/soc/bcm2835/raspberrypi-firmware.h |  2 +-
>  2 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 4917c5b033fa..eadace4a9339 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -13,6 +13,8 @@
>  #include <linux/module.h>
>  #include <linux/acpi.h>
>  
> +#include <soc/bcm2835/raspberrypi-firmware.h>

That feels really wrong :(

> +
>  #include "xhci.h"
>  #include "xhci-trace.h"
>  
> @@ -308,6 +310,44 @@ static int xhci_pci_setup(struct usb_hcd *hcd)
>  	return xhci_pci_reinit(xhci, pdev);
>  }
>  
> +/*
> + * On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> + * loaded directly from an EEPROM or, if not present, by the SoC's VideCore.
> + * Inform VideCore that VL805 was just reset, or defer xhci's probe if not yet
> + * joinable trough the mailbox interface.
> + */
> +static int raspberrypi_load_vl805_fw(struct pci_dev *pdev)
> +{
> +#ifdef CONFIG_RASPBERRYPI_FIRMWARE

Can you just put #ifdefs in a .h file instead please?

> +	struct device_node *fw_np;
> +	struct rpi_firmware *fw;
> +	u32 dev_addr;
> +	int ret;
> +
> +	fw_np = of_find_compatible_node(NULL, NULL,
> +					"raspberrypi,bcm2835-firmware");
> +	if (!fw_np)
> +		return 0;

So for non-rpi systems, this will work just fine, no need to #ifdef out
the whole function, right?


> +
> +	fw = rpi_firmware_get(fw_np);
> +	of_node_put(fw_np);
> +	if (!fw)
> +		return -EPROBE_DEFER;
> +
> +	dev_addr = pdev->bus->number << 20 | PCI_SLOT(pdev->devfn) << 15 |
> +		   PCI_FUNC(pdev->devfn) << 12;
> +
> +	ret = rpi_firmware_property(fw, RPI_FIRMWARE_NOTIFY_XHCI_RESET,
> +				    &dev_addr, sizeof(dev_addr));
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(&pdev->dev, "loaded Raspberry Pi's VL805 firmware\n");
> +
> +#endif
> +	return 0;
> +}

Why not put this whole function in some rpi-platform code?

> +
>  /*
>   * We need to register our own PCI probe function (instead of the USB core's
>   * function) in order to create a second roothub under xHCI.
> @@ -321,6 +361,16 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  
>  	driver = (struct hc_driver *)id->driver_data;
>  
> +	if (dev->vendor == PCI_VENDOR_ID_VIA && dev->device == 0x3483) {
> +		retval = raspberrypi_load_vl805_fw(dev);
> +		if (retval) {
> +			if (retval != -EPROBE_DEFER)
> +				dev_err(&dev->dev,
> +					"Failed to load VL805's firmware");

Shouldn't the function print an error if there is one?

thanks,

greg k-h
