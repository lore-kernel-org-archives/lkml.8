Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649FAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439E220657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vl9mmuiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbgERSUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbgERRxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:53:30 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B08EC05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:53:30 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c12so5404917lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=auxOAvLWtf1pZZSyVWFPai0DZNGDmQxFTyydphVNHvc=;
        b=Vl9mmuiC7+19REd6VDHNPar684dLArGlRGMkQn5oqgGISgDn9rA9Lik+VFA810mJKY
         Z/lqU/1LmGYWo/ob8AYxr4Q2/sNWezCyNM2TzOQag9de1dtWzYYjvtcqYLaj5UZ/eRSs
         j8hcnYEluwCIYYQEZhNVvSaQXUVwZaW1vekivhtGXj6agpH6us2lt2eVka42V2tC3FBb
         anttD+3GT6y2WprpvsdRhnf8iEsWgi9AJN5Lcv6UsJMZ0dJcUwz0KICOSnVe+AkXm4jK
         rk7WxHuCvOQsbVbuTW9D42lNo27aBJenp/CL1EDodgfeQDkV7DKsAI6jISrExqk+E3OT
         iqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=auxOAvLWtf1pZZSyVWFPai0DZNGDmQxFTyydphVNHvc=;
        b=W8iJ7XF2xmSsYazWcCs6/qClZLDZLNNa2jddTAeJNzRkwKPLDvfQweG4a47/7mzrtH
         k2Hwak17cTjkr85gaWeHxn1HYZLWALxVcL88OgTPAmPdm7/j+d0gvvDS98kx7jsZ3cIp
         Jea3RIC7l6IDeJwtzRPHZZLRoycnkwYGMDwq0bHwmYNmS69zbXnO4YKQs25w2EaCYMZM
         7GKGAJhunDR9TkFQ2dgz5xHvok5sZFnICkQBr93alrV0ZvFTeX4hYk7q/q02o8I7M8aO
         vAEo70mSNWJ18JgBec5X4IXwaVxYHVUB+TdIoRgmxdzXBzKfuxb6YBL9Zg5jm7287lyk
         OfVA==
X-Gm-Message-State: AOAM531DvlBULBV2cVYHsogAGpHBlKeYA8cHCu5qG1Tk3RIpLJ9Vuido
        QKspxvz7+LAnW0h+T5ta3ZUVpAPNJ46lxvuGGAV0OA==
X-Google-Smtp-Source: ABdhPJzv50aTNUNlvFS55s6qXm4/Sd4s/08q5esk2oruVv0ektYpkAo/7FrkfziK8Eed36WkBnmqcTgcwCr6rqNC7Eg=
X-Received: by 2002:a19:48c9:: with SMTP id v192mr8337329lfa.20.1589824408382;
 Mon, 18 May 2020 10:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200506060025.1535960-1-vkoul@kernel.org> <20200506060025.1535960-4-vkoul@kernel.org>
In-Reply-To: <20200506060025.1535960-4-vkoul@kernel.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 18 May 2020 19:53:17 +0200
Message-ID: <CADYN=9JLeWHODRWDEcTE_6iZ3TX-E4yyx3OwqzK-H-ytLAmQUg@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] usb: xhci: Add support for Renesas controller
 with memory
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        John Stultz <john.stultz@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        =?UTF-8?Q?Andreas_B=C3=B6hler?= <dev@aboehler.at>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 at 08:01, Vinod Koul <vkoul@kernel.org> wrote:
>
> Some rensas controller like uPD720201 and uPD720202 need firmware to be
> loaded. Add these devices in pci table and invoke renesas firmware loader
> functions to check and load the firmware into device memory when
> required.
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Hi, I got a build error when I built an arm64 allmodconfig kernel.

building obj-arm64-next-20200518

aarch64-linux-gnu-ld: drivers/usb/host/xhci-pci.o: in function
`xhci_pci_remove':
/srv/src/kernel/next/obj-arm64-next-20200518/../drivers/usb/host/xhci-pci.c:411:
undefined reference to `renesas_xhci_pci_exit'
aarch64-linux-gnu-ld:
/srv/src/kernel/next/obj-arm64-next-20200518/../drivers/usb/host/xhci-pci.c:411:(.text+0xd8):
relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
`renesas_xhci_pci_exit'
aarch64-linux-gnu-ld: drivers/usb/host/xhci-pci.o: in function `xhci_pci_probe':
/srv/src/kernel/next/obj-arm64-next-20200518/../drivers/usb/host/xhci-pci.c:345:
undefined reference to `renesas_xhci_check_request_fw'
aarch64-linux-gnu-ld:
/srv/src/kernel/next/obj-arm64-next-20200518/../drivers/usb/host/xhci-pci.c:345:(.text+0x2298):
relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
`renesas_xhci_check_request_fw'
make[1]: *** [/srv/src/kernel/next/Makefile:1126: vmlinux] Error 1
make[1]: Target 'Image' not remade because of errors.
make: *** [Makefile:185: __sub-make] Error 2
make: Target 'Image' not remade because of errors.

When I reverted this patch from todays next tag next-20200518 I
managed to build.


Cheers,
Anders

> ---
>  drivers/usb/host/xhci-pci.c | 35 ++++++++++++++++++++++++++++++++++-
>  drivers/usb/host/xhci.h     |  1 +
>  2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index b6c2f5c530e3..ef513c2fb843 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -15,6 +15,7 @@
>
>  #include "xhci.h"
>  #include "xhci-trace.h"
> +#include "xhci-pci.h"
>
>  #define SSIC_PORT_NUM          2
>  #define SSIC_PORT_CFG2         0x880c
> @@ -87,7 +88,16 @@ static int xhci_pci_reinit(struct xhci_hcd *xhci, struct pci_dev *pdev)
>
>  static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  {
> -       struct pci_dev          *pdev = to_pci_dev(dev);
> +       struct pci_dev                  *pdev = to_pci_dev(dev);
> +       struct xhci_driver_data         *driver_data;
> +       const struct pci_device_id      *id;
> +
> +       id = pci_match_id(pdev->driver->id_table, pdev);
> +
> +       if (id && id->driver_data) {
> +               driver_data = (struct xhci_driver_data *)id->driver_data;
> +               xhci->quirks |= driver_data->quirks;
> +       }
>
>         /* Look for vendor-specific quirks */
>         if (pdev->vendor == PCI_VENDOR_ID_FRESCO_LOGIC &&
> @@ -328,6 +338,14 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>         int retval;
>         struct xhci_hcd *xhci;
>         struct usb_hcd *hcd;
> +       struct xhci_driver_data *driver_data;
> +
> +       driver_data = (struct xhci_driver_data *)id->driver_data;
> +       if (driver_data && driver_data->quirks & XHCI_RENESAS_FW_QUIRK) {
> +               retval = renesas_xhci_check_request_fw(dev, id);
> +               if (retval)
> +                       return retval;
> +       }
>
>         /* Prevent runtime suspending between USB-2 and USB-3 initialization */
>         pm_runtime_get_noresume(&dev->dev);
> @@ -389,6 +407,9 @@ static void xhci_pci_remove(struct pci_dev *dev)
>         struct xhci_hcd *xhci;
>
>         xhci = hcd_to_xhci(pci_get_drvdata(dev));
> +       if (xhci->quirks & XHCI_RENESAS_FW_QUIRK)
> +               renesas_xhci_pci_exit(dev);
> +
>         xhci->xhc_state |= XHCI_STATE_REMOVING;
>
>         if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
> @@ -540,14 +561,26 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
>
>  /*-------------------------------------------------------------------------*/
>
> +static const struct xhci_driver_data reneses_data = {
> +       .quirks  = XHCI_RENESAS_FW_QUIRK,
> +       .firmware = "renesas_usb_fw.mem",
> +};
> +
>  /* PCI driver selection metadata; PCI hotplugging uses this */
>  static const struct pci_device_id pci_ids[] = {
> +       { PCI_DEVICE(0x1912, 0x0014),
> +               .driver_data =  (unsigned long)&reneses_data,
> +       },
> +       { PCI_DEVICE(0x1912, 0x0015),
> +               .driver_data =  (unsigned long)&reneses_data,
> +       },
>         /* handle any USB 3.0 xHCI controller */
>         { PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_USB_XHCI, ~0),
>         },
>         { /* end: all zeroes */ }
>  };
>  MODULE_DEVICE_TABLE(pci, pci_ids);
> +MODULE_FIRMWARE("renesas_usb_fw.mem");
>
>  /* pci driver glue; this is a "new style" PCI driver module */
>  static struct pci_driver xhci_pci_driver = {
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 3289bb516201..4047363c7423 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1873,6 +1873,7 @@ struct xhci_hcd {
>  #define XHCI_DEFAULT_PM_RUNTIME_ALLOW  BIT_ULL(33)
>  #define XHCI_RESET_PLL_ON_DISCONNECT   BIT_ULL(34)
>  #define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
> +#define XHCI_RENESAS_FW_QUIRK  BIT_ULL(36)
>
>         unsigned int            num_active_eps;
>         unsigned int            limit_active_eps;
> --
> 2.25.4
>
