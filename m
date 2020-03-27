Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9BEC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7BE2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eb2Ch3P3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgC0U1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:27:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33290 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgC0U1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:27:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id 22so11190093otf.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 13:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4TJK76BpSA9YI3cPtqJdIcnUuqOCgqs6v2serY2DbQ=;
        b=eb2Ch3P3hXfvuPO/NtXJdTY5EusAbCGvDa1iuIphw8sV6QM1Jm/ZXkV0u+5g4eIYRX
         O5tePhHcpDl/L8pHvBCqCkqWF61z6Np5o74RD9D9mb87qqwiBc73tQjy4rfU/0PU65M0
         E/CPRV1KKMV3jXBZMRDAHcrml/PEKjo/ud7/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4TJK76BpSA9YI3cPtqJdIcnUuqOCgqs6v2serY2DbQ=;
        b=aJSsbtlvre59zYu1PLksIBiYZT6v5rf2U4vuKMia/dkJXnkSSX6Fqe8xgrn2ZnrwLi
         mGxTQUmdBAv0Pl1o6OCHay0EvX7gttVVVwVeYSCWxO51Vb9a1uPp2cU+lWwwdmJuOphs
         3I1RacP34QJTDooIGvupTtw1rZPMcAXUJchIHh5YKhWCbi6Wm/LD+a/7LofOpxE+1RkY
         +bIZ9AD+cYh2yXv254j/icTrru3iMgRuBUmnKIN+VDhLCKkJy7819K+Ss1t41WMXnalP
         ixordep2BShmiNeCreilJWbaBf+SRIqjlZ95ciOVRJvBnzAZjTC6usADCPrVM0atYaBZ
         0hHw==
X-Gm-Message-State: ANhLgQ1/ZCZ1fWYS/hNQSLarbdDYFGG18mP6XsDLjw8KKqAe0XVvm1D4
        Y/N/O5Z3PJ6AZyya+Yi2MgJvxBuLzgGxTNzrBaPI
X-Google-Smtp-Source: ADFU+vvWncgDuK7mqPalJMSuDUt36PZ7gzoGFMnanqWxRPIm3BvZ3agS44LW94H1HiN69BpTa9f9pXQyPI8ZhInKLEI=
X-Received: by 2002:a9d:1a3:: with SMTP id e32mr422856ote.206.1585340856370;
 Fri, 27 Mar 2020 13:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200313141545.31943-1-alcooperx@gmail.com> <20200313141545.31943-4-alcooperx@gmail.com>
 <20200313150850.GV1922688@smile.fi.intel.com>
In-Reply-To: <20200313150850.GV1922688@smile.fi.intel.com>
From:   Al Cooper <al.cooper@broadcom.com>
Date:   Fri, 27 Mar 2020 16:27:25 -0400
Message-ID: <CAGh=XAA-4b38ViF+7ibM+imUQ+RsaZT=gH9MNAL0ZfccsPc=EQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] usb: ehci: Add new EHCI driver for Broadcom STB SoC's
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

I've addressed all you suggestions.
Thanks.

On Fri, Mar 13, 2020 at 11:08 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Mar 13, 2020 at 10:15:44AM -0400, Al Cooper wrote:
> > Add a new EHCI driver for Broadcom STB SoC's. A new EHCI driver
> > was created instead of adding support to the existing ehci platform
> > driver because of the code required to workaround bugs in the EHCI
> > controller.
>
> I'm not sure this is the best approach, but I leave it to maintainers.
>
> By the way, can you list what exactly the difference to the (generic)
> ehci driver?
>
> ...
>
> > +#include <linux/acpi.h>
> > +#include <linux/clk.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/err.h>
> > +#include <linux/kernel.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
>
> ...
>
> > +/* ehci_brcm_wait_for_sof
> > + * Wait for start of next microframe, then wait extra delay microseconds
> > + */
>
> Style is inconsistent even inside this file.
>
> > +static inline void ehci_brcm_wait_for_sof(struct ehci_hcd *ehci, u32 delay)
> > +{
> > +     int frame_idx = ehci_readl(ehci, &ehci->regs->frame_index);
>
> This is not needed if you use do {} while approach.
>
> > +
>
> > +     while (frame_idx == ehci_readl(ehci, &ehci->regs->frame_index))
> > +             ;
>
> Busy loop without even power management taking into consideration?
>
> Infinite loop?
>
> > +     udelay(delay);
> > +}
>
> ...
>
> > +static const struct ehci_driver_overrides brcm_overrides __initconst = {
> > +
>
> > +     .reset =        ehci_brcm_reset,
>
> Indentation issue.
>
> > +     .extra_priv_size = sizeof(struct brcm_priv),
> > +};
>
> ...
>
> > +static int ehci_brcm_probe(struct platform_device *pdev)
> > +{
>
> > +     irq = platform_get_irq(pdev, 0);
> > +     if (irq < 0) {
>
> > +             dev_err(&pdev->dev, "no irq provided");
>
> Duplicate with core message.
>
> > +             return irq;
> > +     }
>
> > +     /* initialize hcd */
> > +     hcd = usb_create_hcd(&ehci_brcm_hc_driver,
> > +                     &pdev->dev, dev_name(&pdev->dev));
>
> At least this one will look much better (and fit one line) when you introduce
>
>         struct device *dev = &pdev->dev;
>
> in the definition block above.
>
> > +     if (!hcd)
> > +             return -ENOMEM;
>
> > +     return err;
> > +}
>
> ...
>
> > +static struct platform_driver ehci_brcm_driver = {
> > +     .probe          = ehci_brcm_probe,
> > +     .remove         = ehci_brcm_remove,
> > +     .shutdown       = usb_hcd_platform_shutdown,
> > +     .driver         = {
>
> > +             .owner  = THIS_MODULE,
>
> Do we need this?
>
> > +             .name   = "ehci-brcm",
> > +             .pm     = &ehci_brcm_pm_ops,
> > +             .of_match_table = brcm_ehci_of_match,
> > +     }
> > +};
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
