Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201FCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E963120656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597297256;
	bh=bQZJ0csaHLc3qhSl2N9bDL/Th0k3IbfW8GP+TvkeLZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dNvPoOgYCr1X2pES2nKITpQ1APCWeKxMzCBhqIXVGMQRxHDvbFatgIonZirF15aE2
	 fUFpTS/KmuHMny4SctOjMwh2IiEV6Izb/1zosBQQRjNEwpSfSzp1xb6vX8UEbI7ocN
	 9FVx3lONfW3iF9gAN8qZETNH8Yt6I4btGKpJ3waI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMFkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:40:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgHMFkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:40:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BF7D20639;
        Thu, 13 Aug 2020 05:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597297254;
        bh=bQZJ0csaHLc3qhSl2N9bDL/Th0k3IbfW8GP+TvkeLZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hUSp26TN0+hTBL4DvZdAHU5esUKHk4ITr7+3w3yRFw9xYlGbHsd+ezWa3042ogmUv
         ZYIAkMK4F967W2t2M767YWQRhS3m4Ot4F0KywCwBiv8X2T0D8QDEmKtpmDGfN6EOPm
         eC1+4cDs9k6dH4LbxS5aLOZhLhLFU9a2V2ozcX8E=
Date:   Thu, 13 Aug 2020 07:40:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Al Cooper <al.cooper@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] usb: Add Kconfig and Makefile changes to build
 brcmstb-usb-pinmap
Message-ID: <20200813054052.GB1353152@kroah.com>
References: <20200812202018.49046-1-alcooperx@gmail.com>
 <20200812202018.49046-4-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812202018.49046-4-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 04:20:18PM -0400, Al Cooper wrote:
> From: Al Cooper <al.cooper@broadcom.com>
> 
> Add Kconfig and Makefile changes to build brcmstb-usb-pinmap and
> update MAINTAINERS for the new driver.

This can be part of the previous patch, or at least the Kconfig and
Makefile changes should be there so that we build the code when we add
it.

> refs #SWLINUX-5537

What is this?

> 
> Signed-off-by: Al Cooper <al.cooper@broadcom.com>
> ---
>  MAINTAINERS               | 8 ++++++++
>  drivers/usb/host/Kconfig  | 4 ++++
>  drivers/usb/host/Makefile | 1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0569cf304ca..3a44ac61899b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3527,6 +3527,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
>  F:	drivers/usb/host/ehci-brcm.*
>  
> +BROADCOM BRCMSTB USB PIN MAP DRIVER
> +M:	Al Cooper <alcooperx@gmail.com>
> +L:	linux-usb@vger.kernel.org
> +L:	bcm-kernel-feedback-list@broadcom.com
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> +F:	drivers/usb/host/brcmstb-usb-pinmap.c
> +
>  BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
>  M:	Al Cooper <alcooperx@gmail.com>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 1cb3004ea7b2..9c285053bb0c 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -109,12 +109,16 @@ endif # USB_XHCI_HCD
>  config USB_EHCI_BRCMSTB
>         tristate
>  
> +config BRCM_USB_PINMAP
> +       tristate
> +
>  config USB_BRCMSTB
>  	tristate "Broadcom STB USB support"
>  	depends on (ARCH_BRCMSTB && PHY_BRCM_USB) || COMPILE_TEST
>  	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
>  	select USB_EHCI_BRCMSTB if USB_EHCI_HCD
>  	select USB_XHCI_PLATFORM if USB_XHCI_HCD
> +	select BRCM_USB_PINMAP
>  	help
>  	  Enables support for XHCI, EHCI and OHCI host controllers
>  	  found in Broadcom STB SoC's.
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index bc731332fed9..0e63ef94790d 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -90,3 +90,4 @@ obj-$(CONFIG_USB_HCD_BCMA)	+= bcma-hcd.o
>  obj-$(CONFIG_USB_HCD_SSB)	+= ssb-hcd.o
>  obj-$(CONFIG_USB_FOTG210_HCD)	+= fotg210-hcd.o
>  obj-$(CONFIG_USB_MAX3421_HCD)	+= max3421-hcd.o
> +obj-$(CONFIG_BRCM_USB_PINMAP)	+= brcmstb-usb-pinmap.o

Shouldn't this driver be in usb/misc/ with other drivers like this?  Why
host?

Wait, why is this a separate driver at all?  Why not just build it into
the USB_BRCMSTB driver?

thanks,

greg k-h
