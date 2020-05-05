Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F085AC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF92D206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588676057;
	bh=aYqWgxDw5IsJh6TJ8GhppNLJSzt9m3CkVmWJNtjyYj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b86k5of+NYszmadIRHYjb6O+IH4qydlZGc3WbOy08AGbHbxAUscGIvpnoIYtoNBWD
	 EutJE5WI5yXBnj8vbEhe4kWhuiODqFVgKqyXdPAKFbu64nsu3Pkt5a/jvfbSDifncJ
	 PaRGBZfB0YlngWQDOT8dp40Sl4iIWjGot4u5lLIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgEEKyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 06:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:32888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgEEKyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:54:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E576206A5;
        Tue,  5 May 2020 10:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588676055;
        bh=aYqWgxDw5IsJh6TJ8GhppNLJSzt9m3CkVmWJNtjyYj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LpmkD4yhNInpl3QPz4dnWFWoBI7wCZMXWIvaH63Gwj8Vd34Tie9w/eI4kSh8mjYbE
         LeTJqsKggf6KCS+1jISsWYewd38EAWNn4FLJgBxIroiVP84QhAhoKfYqUD4hwPmjVT
         qGzrNppK+vT1bNanDUIMgUL9GVb4R8244qIbVIiM=
Date:   Tue, 5 May 2020 12:54:13 +0200
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
Subject: Re: [PATCH v6 4/4] usb: host: Add ability to build new Broadcom STB
 USB drivers
Message-ID: <20200505105413.GA93160@kroah.com>
References: <20200430111258.6091-1-alcooperx@gmail.com>
 <20200430111258.6091-5-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430111258.6091-5-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 07:12:58AM -0400, Al Cooper wrote:
> Add the build system changes needed to get the Broadcom STB XHCI,
> EHCI and OHCI functionality working. The OHCI support does not
> require anything unique to Broadcom so the standard ohci-platform
> driver is being used. The link order for XHCI was changed in the
> Makefile because of the way STB XHCI, EHCI and OHCI controllers
> share a port which requires that the XHCI driver be initialized
> first. Also update MAINTAINERS.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  MAINTAINERS               |  8 ++++++++
>  drivers/usb/host/Kconfig  | 16 ++++++++++++++++
>  drivers/usb/host/Makefile | 16 ++++++++++------
>  3 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 26f281d9f32a..6147ed78d212 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3481,6 +3481,14 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
>  F:	drivers/i2c/busses/i2c-brcmstb.c
>  
> +BROADCOM BRCMSTB USB EHCI DRIVER
> +M:	Al Cooper <alcooperx@gmail.com>
> +L:	linux-usb@vger.kernel.org
> +L:	bcm-kernel-feedback-list@broadcom.com
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> +F:	drivers/usb/host/ehci-brcm.*
> +
>  BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
>  M:	Al Cooper <alcooperx@gmail.com>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 55bdfdf11e4c..7d58fd66e412 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -97,6 +97,22 @@ config USB_XHCI_TEGRA
>  
>  endif # USB_XHCI_HCD
>  
> +config USB_EHCI_BRCMSTB
> +       tristate
> +
> +config USB_BRCMSTB
> +	tristate "Broadcom STB USB support"
> +	depends on (ARCH_BRCMSTB && PHY_BRCM_USB) || COMPILE_TEST
> +	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
> +	select USB_EHCI_BRCMSTB if USB_EHCI_HCD
> +	select USB_XHCI_PLATFORM if USB_XHCI_HCD
> +	help
> +	  Say Y to enable support for XHCI, EHCI and OHCI host controllers
> +	  found in Broadcom STB SoC's.
> +
> +	  Disabling this will keep the controllers and corresponding
> +	  PHYs powered down.

Whhat are the module names?

And why 2 config options here?

> +
>  config USB_EHCI_HCD
>  	tristate "EHCI HCD (USB 2.0) support"
>  	depends on HAS_DMA && HAS_IOMEM
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index b191361257cc..85fa6ace552a 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -37,6 +37,15 @@ endif
>  
>  obj-$(CONFIG_USB_PCI)	+= pci-quirks.o
>  
> +# NOTE: BRCMSTB systems require that xhci driver be linked before the
> +# ehci/ohci drivers.

Why?  Please do this as a separate change before your makefile changes.

And what else will this break?  We have relied on this link order for a
very long time, changing it could cause issues...

I don't see how your driver needs this, please explain in great detail.

thanks,

greg k-h
