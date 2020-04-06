Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDEFC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3180248A5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyEqc4DE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgDFP2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:28:35 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40973 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgDFP2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:28:35 -0400
Received: by mail-il1-f193.google.com with SMTP id t6so15032256ilj.8;
        Mon, 06 Apr 2020 08:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyNfGvI8xlMgP9IkvrRBBzNVq6mwzYQ+gOI9+q9PIZQ=;
        b=XyEqc4DEG4j+uXqNvcxJtqMwYAYSq95od8zlYpQAY4Wv681ocQbqoVFQPBhxMB1x6N
         7ApumgbAAYZPs0QiH56GvQi5I8k9jg72GrEhPPasNhuAdb/KRQ3ZF1C4H6KPLcUpmSse
         O2QKWEr+slWvJtNesxo3I7RJS1sN/yj2A4cd4smqDgqzdZojGZmBfFrU1ycbK7MSTCio
         ps1UtzwdVdq+BF296sjMSmmDa2CoEi8bydIWP/PO26VH92UORToKwptF3J6JwBeSmmKs
         nnaWJDd68DPcnoMSHQp1roRq+rHgKckHwA+/48W03SOlXjuV9GkQlNMDFxKh8/RdnrBJ
         P7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyNfGvI8xlMgP9IkvrRBBzNVq6mwzYQ+gOI9+q9PIZQ=;
        b=T8nPG6bBVBFBWPk+/V5lrdpkudGHkDCa15D0K8mcfENo7UGfAJwZSnoZlEChh8Rc1K
         3sxGBTxFDTYc0oEXQum9XQBh7M80+QykRRKUawDtwcL3/7LQxM7h0qVHu8yrrhwsYxa1
         IX6xIAC5hhLqn2XGiwBBbtkyFuI9vXxO/RuCHCDt8wXdHNq9M/AvmGZe3Cqm/rq/nS6w
         7C3AI+aVNfZvBsY4eTbBNUG7dJJ7DhIPaWlWLpgoWgRRyEbEp3TdLmU9emX3XDbN+LBX
         QIU8C2hjyAPO2h7Avslva8kNmHhVOWOp9vUD3R03Ll1MY4Bxi3benYA4kqrQh3gNTfwI
         MR+Q==
X-Gm-Message-State: AGi0Puay61epJeNeCSBTGGnXufE9iG8aY5RFjBhxXXBXgan3bWa8oVgz
        RpT7ys+Vc97OmF8mvuQQBy4BJJgQ5QMI3R0tLLg=
X-Google-Smtp-Source: APiQypJsFoDu9wRagMbFLsqaDNyD3lWs8SOgxKH9XPsxIiJzM8zrYy4VQ6AjUgkurPjCS4dpUliemIlh7GcvvfSL/cs=
X-Received: by 2002:a92:c90d:: with SMTP id t13mr21476197ilp.10.1586186912593;
 Mon, 06 Apr 2020 08:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200327204711.10614-1-alcooperx@gmail.com> <20200327204711.10614-3-alcooperx@gmail.com>
 <1585535724.28859.18.camel@mhfsdcap03>
In-Reply-To: <1585535724.28859.18.camel@mhfsdcap03>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Mon, 6 Apr 2020 11:28:20 -0400
Message-ID: <CAOGqxeXvhYqGNgoMDAObz5vTA0zxWOW9HT3as206tvG9SFBbDQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 10:35 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Hi,
...
> > +     }, {
> > +             .compatible = "brcm,xhci-brcm-v2",
> > +             .data = &xhci_plat_brcm,
> This one is not described in dt-binding.

This is an obsolete name, but was left in the driver for backward
compatibility with some older boards that still have this in their
device tree.

> > +     }, {
> > +             .compatible = "brcm,bcm7445-xhci",
> > +             .data = &xhci_plat_brcm,
> bcm7445 is a SoC name ?
> the quirk only happens on this one? or on all SoCs with Broadcom xHIC
> IP?

bcm7445 is the first SoC with this style controller and all subsequent
SoCs contain this compatible entry and also have the quirk.

>
> >       },
> >       {},
> >  };

Thanks
Al

On Sun, Mar 29, 2020 at 10:35 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Hi,
> On Fri, 2020-03-27 at 16:47 -0400, Al Cooper wrote:
> > Add support for Broadcom STB SoC's to the xhci platform driver
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > ---
> >  drivers/usb/host/xhci-brcm.c | 16 ++++++++++++++++
> >  drivers/usb/host/xhci-brcm.h | 16 ++++++++++++++++
> >  drivers/usb/host/xhci-plat.c | 11 +++++++++++
> >  3 files changed, 43 insertions(+)
> >  create mode 100644 drivers/usb/host/xhci-brcm.c
> >  create mode 100644 drivers/usb/host/xhci-brcm.h
> >
> > diff --git a/drivers/usb/host/xhci-brcm.c b/drivers/usb/host/xhci-brcm.c
> > new file mode 100644
> > index 000000000000..bf8c0bfd1780
> > --- /dev/null
> > +++ b/drivers/usb/host/xhci-brcm.c
> > @@ -0,0 +1,16 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2018, Broadcom */
> > +
> > +#include <linux/usb.h>
> > +#include <linux/usb/hcd.h>
> > +
> > +#include "xhci.h"
> > +
> > +int xhci_plat_brcm_init_quirk(struct usb_hcd *hcd)
> > +{
> > +     struct xhci_hcd *xhci = hcd_to_xhci(hcd);
> > +
> > +     xhci->quirks |= XHCI_RESET_ON_RESUME;
> > +     return 0;
> > +}
> > +
> > diff --git a/drivers/usb/host/xhci-brcm.h b/drivers/usb/host/xhci-brcm.h
> > new file mode 100644
> > index 000000000000..e64800fae4d5
> > --- /dev/null
> > +++ b/drivers/usb/host/xhci-brcm.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) 2018, Broadcom */
> > +
> > +#ifndef _XHCI_BRCM_H
> > +#define _XHCI_BRCM_H
> > +
> > +#if IS_ENABLED(CONFIG_USB_XHCI_BRCM)
> > +int xhci_plat_brcm_init_quirk(struct usb_hcd *hcd);
> > +#else
> > +static inline int xhci_plat_brcm_init_quirk(struct usb_hcd *hcd)
> > +{
> > +     return 0;
> > +}
> > +#endif
> > +#endif /* _XHCI_BRCM_H */
> > +
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > index 315b4552693c..3e90a1207803 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -22,6 +22,7 @@
> >
> >  #include "xhci.h"
> >  #include "xhci-plat.h"
> > +#include "xhci-brcm.h"
> >  #include "xhci-mvebu.h"
> >  #include "xhci-rcar.h"
> >
> > @@ -112,6 +113,10 @@ static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
> >       SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V3)
> >  };
> >
> > +static const struct xhci_plat_priv xhci_plat_brcm = {
> > +     .init_quirk = xhci_plat_brcm_init_quirk,
> > +};
> > +
> >  static const struct of_device_id usb_xhci_of_match[] = {
> >       {
> >               .compatible = "generic-xhci",
> > @@ -147,6 +152,12 @@ static const struct of_device_id usb_xhci_of_match[] = {
> >       }, {
> >               .compatible = "renesas,rcar-gen3-xhci",
> >               .data = &xhci_plat_renesas_rcar_gen3,
> > +     }, {
> > +             .compatible = "brcm,xhci-brcm-v2",
> > +             .data = &xhci_plat_brcm,
> This one is not described in dt-binding.
> > +     }, {
> > +             .compatible = "brcm,bcm7445-xhci",
> > +             .data = &xhci_plat_brcm,
> bcm7445 is a SoC name ?
> the quirk only happens on this one? or on all SoCs with Broadcom xHIC
> IP?
>
> >       },
> >       {},
> >  };
>
