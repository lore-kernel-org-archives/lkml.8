Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDE8C2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99B320719
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnPaHxp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgDFSqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:46:38 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43530 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDFSqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:46:38 -0400
Received: by mail-il1-f196.google.com with SMTP id g15so491426ilj.10;
        Mon, 06 Apr 2020 11:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVbw6U0W43QnLaQdRTE/AknHWeK3fOBeopvs+ToCJzI=;
        b=jnPaHxp3TU0EmSnZJelPcrv1dtoosfy2FiUVgCSec85jnswsIj6Xw2Ok6L+wE+T1tk
         s3JEDitWTp5wplKFZAfXu4o5jkOP+dDI7NcFN7aqSgnpNpRJ7k6OJqgZlNEfMmNYxB7v
         odfP9ubhpjpf07I6RFGD8PpqHEguoA6GlVv+xm0A5SFvNuhOIfknz+xUEt2GbkjzNWZU
         jjlLzY03XcnYS9XC0p5OjNG5TQRBLrnMfBAibZzzNI4JqWsPimLhPZWmYcI3c7MO2ucu
         ioRunN7uzIM/SL87odxaS3UUkozuHJtLI1cCBf6x/H3nBpBTH+xPOiglIqgqH71evugb
         5CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVbw6U0W43QnLaQdRTE/AknHWeK3fOBeopvs+ToCJzI=;
        b=fTyJLmR0AZEdoLFtvouzlWsrFSV3xJZZ8McMor5GwCghccnDiKw9GC3Fj1CIN9/aU9
         AaPffVF7hlshpZbzlC0ZmA9kRaYDKOKvH4sdXo6imUAs2Iey9GL4iBXd1FFlq+K1nlUZ
         qHDTwNploGzOvXRjP6OSAY/VxoKAAotLct3RL4O47FibqFROTLV+LjIzqJfEH0drEmia
         rJYXExgMoeBvTTgvn2yn0s7OXTjOCVTEzaOwSU3zUrPOMUbp1S/jN5TwDUm3j//CaD34
         1/8QwpIK96hc+2r/d+eMS0GaUxqC15We9zknX/yS/JhNt90+B2My7/gT/KK7xWOVwZ1e
         4fVQ==
X-Gm-Message-State: AGi0PuYkxBS/sjgX2M8hsB6gRFbGEowTBNQgqKI37hJ+SPh2WKlWOF/I
        hvgqFBAl6XnpZQAnukjMOLo7IBm88o6apEjCIR4=
X-Google-Smtp-Source: APiQypIMLrErILm+0n1az0w9IYwybJd3ar1vZlfPtpFymBfjMIfXrkUysYiSDbL014yKPqMnbidkLznZ9X4nxaPhbX4=
X-Received: by 2002:a92:790a:: with SMTP id u10mr770618ilc.98.1586198797446;
 Mon, 06 Apr 2020 11:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200327204711.10614-1-alcooperx@gmail.com> <20200327204711.10614-4-alcooperx@gmail.com>
 <20200328201846.GF1922688@smile.fi.intel.com>
In-Reply-To: <20200328201846.GF1922688@smile.fi.intel.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Mon, 6 Apr 2020 14:46:26 -0400
Message-ID: <CAOGqxeVkgPttD7kqANAtp1uD=aFuSqV_2sWT4ybG3m0c_2SSjA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] usb: ehci: Add new EHCI driver for Broadcom STB SoC's
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
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

On Sat, Mar 28, 2020 at 4:18 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Mar 27, 2020 at 04:47:10PM -0400, Al Cooper wrote:
> > Add a new EHCI driver for Broadcom STB SoC's. A new EHCI driver
> > was created instead of adding support to the existing ehci platform
> > driver because of the code required to workaround bugs in the EHCI
> > controller.
>
> I'm not sure this has been tested. See below.
>
> ...
>
> > +#include <linux/acpi.h>
> > +#include <linux/of.h>
>
> I didn;t find evidence these are needed.

I removed them.

>
> ...
>
>
> > +     res = readl_relaxed_poll_timeout(&ehci->regs->frame_index, val,
> > +                                      (val != frame_idx), 1, 130);
>
> Too many parentheses.
>

Fixed

> > +     if (res)
> > +             dev_err(ehci_to_hcd(ehci)->self.controller,
> > +                     "Error waiting for SOF\n");
>
> ...
>
> > +static int ehci_brcm_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct resource *res_mem;
> > +     struct brcm_priv *priv;
> > +     struct usb_hcd *hcd;
> > +     int irq;
> > +     int err;
> > +
> > +     if (usb_disabled())
> > +             return -ENODEV;
> > +
> > +     err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > +     if (err)
> > +             return err;
> > +
>
> > +     irq = platform_get_irq(pdev, 0);
> > +             return irq;
>
> I'm not sure it was an intention to leave a lot of dead code below.
>

Fixed.

> > +     /* Hook the hub control routine to work around a bug */
>
> > +     if (org_hub_control == NULL)
>
>         if (!org_hub_control) ?
>

Changed.

> > +             org_hub_control = ehci_brcm_hc_driver.hub_control;
> > +     ehci_brcm_hc_driver.hub_control = ehci_brcm_hub_control;
>
> > +     device_wakeup_enable(hcd->self.controller);
> > +     device_enable_async_suspend(hcd->self.controller);
> > +     platform_set_drvdata(pdev, hcd);
> > +
>
> > +     return err;
>
>         return 0; ?
>
Changed.


> > +err_clk:
> > +     clk_disable_unprepare(priv->clk);
> > +err_hcd:
> > +     usb_put_hcd(hcd);
> > +
> > +     return err;
> > +}
>
> ...
>
> > +#ifdef CONFIG_PM_SLEEP
>
> You also can use __maybe_unused annotations.
>

Changed.

> > +static int ehci_brcm_suspend(struct device *dev)
> > +{
> > +     int ret;
> > +     struct usb_hcd *hcd = dev_get_drvdata(dev);
> > +     struct brcm_priv *priv = hcd_to_ehci_priv(hcd);
> > +     bool do_wakeup = device_may_wakeup(dev);
> > +
>
> > +     ret = ehci_suspend(hcd, do_wakeup);
> > +     clk_disable_unprepare(priv->clk);
> > +     return ret;
>
> So, if you fail to suspend the device, clocks will become unusable, how to recover from such case?
>

Changed to handle the failure.

> > +}
>
> > +#endif /* CONFIG_PM_SLEEP */
>
> ...
>
> > +MODULE_DESCRIPTION(BRCM_DRIVER_DESC);
>
> Better to have it explicit.
>

Changed.

> --
> With Best Regards,
> Andy Shevchenko
>
>

v3 coming.
Thanks again for the review
Al
