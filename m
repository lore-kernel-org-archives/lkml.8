Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DDBC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B432063A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRibgMga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgEFUXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726906AbgEFUXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:23:14 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B31FC061A0F;
        Wed,  6 May 2020 13:23:14 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w6so3090169ilg.1;
        Wed, 06 May 2020 13:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+CEw6m8hDoAFtGiEvDNVobFauOeT930PC51p6oefV4=;
        b=tRibgMgah9qOzlRhWKn+35dygCM/PLDSbHWtsA6FoazwsNQwfnz8R/zAOUaYes9CY+
         b9hPG/qqOQ0fNcjtRJlYdz4fFuVCCESEtupdYEmvvG8b5By2887L4reM/eWpDquwV1xv
         gWWlNKm7vzpTejSkf3StUE1fIIJJGz1T8pdy3ggCt+60wDnHuHPuQ6gCC8H9gNeAclXJ
         fjqqNzKdp8PL1SXg37TcjIDZphtd8eL71onfShZC4scRBb8hg4mtbma8XBpRyTUd1WlH
         ALGWX4K0iJd25glWeoJfaXXP/ziJzU+L8hqe9OziyUfaWfrlAiSRyTtxPISQBuKx69hX
         isXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+CEw6m8hDoAFtGiEvDNVobFauOeT930PC51p6oefV4=;
        b=eiQWH5R7ahoPtjgKFyK0zeNyiSw6qlRTv3NrFL4RblDZorEqrXDpzNuepm0FpXveVt
         f/mOjxA6zC23xdIWG954jT5NLHK1T3V6v0g62HzASxihzgsUi8tp2L4MbQcGlZy9Ll3v
         Rkb251vps3Mx7oGlTQosm1dVo8nWAoa79MM5nIHSqB0EJ0/sJHqo0f9pGg3hSp8wvzwU
         g9EeyMYO2zi8FMbxkBVZMFnJAqOfK9j9u3DxmKOOHpGYJYp5ujw6hGm8jSrMA+hCD+dk
         PgSSmnMnz7awNj9vN6v3Zipkd6c/aeuOYV8JkQbfAaTqMaS9CDQ3IcB66Hf6URiUBcYK
         75Mw==
X-Gm-Message-State: AGi0PuZ2MCnS0ivpHIAvhi9dtGXfmHbdn3vNvJ68ALJ4jUEs7ysE+sJ4
        RVBsTeFYcyy5JAFm0jgROEYwJTKYyq3MzhBcvL9QG447
X-Google-Smtp-Source: APiQypJp4jsl4iShNtBUseVcG51Wa+Use+Rzw4k2czDzP+sNLK9X2upMjXGl5rFjqzLr8jRK4yxyHbm4euYJkTVMT4I=
X-Received: by 2002:a92:6c0b:: with SMTP id h11mr10007214ilc.158.1588796593560;
 Wed, 06 May 2020 13:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200430111258.6091-1-alcooperx@gmail.com> <20200430111258.6091-4-alcooperx@gmail.com>
 <20200505110036.GB93160@kroah.com>
In-Reply-To: <20200505110036.GB93160@kroah.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Wed, 6 May 2020 16:23:01 -0400
Message-ID: <CAOGqxeXboYz2OQhgJsYmH5_7qEwKeWR5AA4Ljq_iFdSX=H2fkA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] usb: ehci: Add new EHCI driver for Broadcom STB SoC's
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:00 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 30, 2020 at 07:12:57AM -0400, Al Cooper wrote:
> > Add a new EHCI driver for Broadcom STB SoC's. A new EHCI driver
> > was created instead of adding support to the existing ehci platform
> > driver because of the code required to workaround bugs in the EHCI
> > controller.
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> >  drivers/usb/host/ehci-brcm.c | 290 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 290 insertions(+)
> >  create mode 100644 drivers/usb/host/ehci-brcm.c
>
> I need an ack from the EHCI maintainer to agree that this needs a whole
> new driver file...
>
> >
> > diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
> > new file mode 100644
> > index 000000000000..381bed5fdab0
> > --- /dev/null
> > +++ b/drivers/usb/host/ehci-brcm.c
> > @@ -0,0 +1,290 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2020, Broadcom */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/err.h>
> > +#include <linux/kernel.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/usb.h>
> > +#include <linux/usb/hcd.h>
> > +#include <linux/iopoll.h>
> > +
> > +#include "ehci.h"
> > +
> > +#define hcd_to_ehci_priv(h) ((struct brcm_priv *)hcd_to_ehci(h)->priv)
> > +
> > +struct brcm_priv {
> > +     struct clk *clk;
> > +};
> > +
> > +static const char brcm_hcd_name[] = "ehci-brcm";
>
> You don't use this anywhere?  Are you sure this didn't cause compile
> warnings?

I'll remove it. I'm not getting a warning because it's a "static
const" which doesn't give unused warnings.

>
> > +
> > +static int (*org_hub_control)(struct usb_hcd *hcd,
> > +                     u16 typeReq, u16 wValue, u16 wIndex,
> > +                     char *buf, u16 wLength);
>
> So you only support one device per system?  That feels bad...

When this driver was originally written, the ehci_hub_control()
function was a static function in ehci-hub.c and couldn't be called
directly. Instead, the function pointer was taken out of  "struct
hc_driver" and since it couldn't change for multiple devices, only one
pointer was needed. The ehci_hub_control function is now global so it
can be called directly and this can be removed. It's nice to get rid
of this hack, thanks.

>
>
> > +
> > +/*
> > + * ehci_brcm_wait_for_sof
> > + * Wait for start of next microframe, then wait extra delay microseconds
> > + */
> > +static inline void ehci_brcm_wait_for_sof(struct ehci_hcd *ehci, u32 delay)
> > +{
> > +     u32 frame_idx = ehci_readl(ehci, &ehci->regs->frame_index);
> > +     u32 val;
> > +     int res;
> > +
> > +     /* Wait for next microframe (every 125 usecs) */
> > +     res = readl_relaxed_poll_timeout(&ehci->regs->frame_index, val,
> > +                                      val != frame_idx, 1, 130);
> > +     if (res)
> > +             dev_err(ehci_to_hcd(ehci)->self.controller,
> > +                     "Error waiting for SOF\n");
> > +     udelay(delay);
> > +}
> > +
> > +/*
> > + * ehci_brcm_hub_control
> > + * Intercept echi-hcd request to complete RESUME and align it to the start
> > + * of the next microframe.
> > + * If RESUME is complete too late in the microframe, host controller
> > + * detects babble on suspended port and resets the port afterwards.
> > + * This s/w workaround allows to avoid this problem.
> > + * See SWLINUX-1909 for more details
> > + */
> > +static int ehci_brcm_hub_control(
> > +     struct usb_hcd  *hcd,
> > +     u16             typeReq,
> > +     u16             wValue,
> > +     u16             wIndex,
> > +     char            *buf,
> > +     u16             wLength)
> > +{
> > +     struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> > +     int             ports = HCS_N_PORTS(ehci->hcs_params);
> > +     u32 __iomem     *status_reg = &ehci->regs->port_status[
> > +                             (wIndex & 0xff) - 1];
>
> Horrid line-wrapping, put this assignment below so it can be read.
>
> And wIndex is little endian?  Or native?

native

>
> > +     unsigned long flags;
> > +     int retval, irq_disabled = 0;
> > +
> > +     /*
> > +      * RESUME is cleared when GetPortStatus() is called 20ms after start
> > +      * of RESUME
> > +      */
> > +     if ((typeReq == GetPortStatus) &&
> > +         (wIndex && wIndex <= ports) &&
> > +         ehci->reset_done[wIndex-1] &&
> > +         time_after_eq(jiffies, ehci->reset_done[wIndex-1]) &&
> > +         (ehci_readl(ehci, status_reg) & PORT_RESUME)) {
> > +
> > +             /*
> > +              * to make sure we are not interrupted until RESUME bit
> > +              * is cleared, disable interrupts on current CPU
> > +              */
> > +             ehci_dbg(ehci, "SOF alignment workaround\n");
> > +             irq_disabled = 1;
> > +             local_irq_save(flags);
> > +             ehci_brcm_wait_for_sof(ehci, 5);
> > +     }
> > +     retval = (*org_hub_control)(hcd, typeReq, wValue, wIndex, buf, wLength);
>
> But this might not be set, did you just crash?
>
> If it is always set, then why does it need to be a function pointer at
> all?

Explained above (and removed).

>
> > +     if (irq_disabled)
> > +             local_irq_restore(flags);
> > +     return retval;
> > +}
> > +
> > +static int ehci_brcm_reset(struct usb_hcd *hcd)
> > +{
> > +     struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> > +
> > +     ehci->big_endian_mmio = 1;
> > +
> > +     ehci->caps = (struct ehci_caps *) hcd->regs;
> > +     ehci->regs = (struct ehci_regs *) (hcd->regs +
>
> coding style, did you run this through checkpatch.pl?

Checkpatch did not complain, but I'll clean it up.

>
> > +             HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase)));
> > +
> > +     /* This fixes the lockup during reboot due to prior interrupts */
> > +     ehci_writel(ehci, CMD_RESET, &ehci->regs->command);
> > +     mdelay(10);
> > +
> > +     /*
> > +      * SWLINUX-1705: Avoid OUT packet underflows during high memory
> > +      *   bus usage
> > +      * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90
> > +      */
> > +     ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
> > +     ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
> > +
> > +     return ehci_setup(hcd);
> > +}
> > +
> > +static struct hc_driver __read_mostly ehci_brcm_hc_driver;
> > +
> > +static const struct ehci_driver_overrides brcm_overrides __initconst = {
> > +
>
> No blank line.

Fixed.

>
> > +     .reset = ehci_brcm_reset,
> > +     .extra_priv_size = sizeof(struct brcm_priv),
> > +};
> > +
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
> > +     irq = platform_get_irq(pdev, 0);
> > +     if (irq < 0)
>
> "<=" right?

The example in the comment above platform_get_irq in platform.c says
"if (irq < 0)"

>
> > +             return irq;
> > +
> > +     /* Hook the hub control routine to work around a bug */
>
> What bug?  This feels wrong.

The bug is explained in a comment above the ehci_brcm_hub_control()
routine as follows:
/*
 * ehci_brcm_hub_control
 * Intercept echi-hcd request to complete RESUME and align it to the start
 * of the next microframe.
 * If RESUME is complete too late in the microframe, host controller
 * detects babble on suspended port and resets the port afterwards.
 * This s/w workaround allows to avoid this problem.
 * See SWLINUX-1909 for more details
 */
I'll remove the internal bug tracking reference from the comment.

>
> > +     if (!org_hub_control)
> > +             org_hub_control = ehci_brcm_hc_driver.hub_control;
> > +     ehci_brcm_hc_driver.hub_control = ehci_brcm_hub_control;
> > +
> > +     /* initialize hcd */
> > +     hcd = usb_create_hcd(&ehci_brcm_hc_driver, dev, dev_name(dev));
> > +     if (!hcd)
> > +             return -ENOMEM;
> > +
> > +     platform_set_drvdata(pdev, hcd);
> > +     priv = hcd_to_ehci_priv(hcd);
> > +
> > +     priv->clk = devm_clk_get_optional(dev, NULL);
> > +     if (IS_ERR(priv->clk)) {
> > +             err = PTR_ERR(priv->clk);
> > +             goto err_hcd;
> > +     }
> > +
> > +     err = clk_prepare_enable(priv->clk);
>
> But clk was optional, will this break?

devm_clk_get_optional() will set clk to NULL if it's not found and all
the clk_... routines handle a NULL clk by just returning.

>
> > +     if (err)
> > +             goto err_hcd;
> > +
> > +     hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res_mem);
> > +     if (IS_ERR(hcd->regs)) {
> > +             err = PTR_ERR(hcd->regs);
> > +             goto err_clk;
> > +     }
> > +     hcd->rsrc_start = res_mem->start;
> > +     hcd->rsrc_len = resource_size(res_mem);
> > +     err = usb_add_hcd(hcd, irq, IRQF_SHARED);
> > +     if (err)
> > +             goto err_clk;
> > +
> > +     device_wakeup_enable(hcd->self.controller);
> > +     device_enable_async_suspend(hcd->self.controller);
> > +     platform_set_drvdata(pdev, hcd);
>
> Shouldn't that be set before you register the hcd?

Since usb_add_hcd(hcd,...) takes the hcd pointer and not a device
pointer it shouldn't require platform_set_drvdata() to be called
first.
Looking at the code made me notice that platform_set_drvdata() is also
called at the beginning of the function and it's not needed twice so
I'll remove this second call. This driver used the ehci and ohci
platform drivers as a starting point and they also do this call twice
in probe.

>
> > +
> > +     return 0;
> > +
> > +err_clk:
> > +     clk_disable_unprepare(priv->clk);
> > +err_hcd:
> > +     usb_put_hcd(hcd);
> > +
> > +     return err;
> > +}
> > +
> > +static int ehci_brcm_remove(struct platform_device *dev)
> > +{
> > +     struct usb_hcd *hcd = platform_get_drvdata(dev);
> > +     struct brcm_priv *priv = hcd_to_ehci_priv(hcd);
> > +
> > +     usb_remove_hcd(hcd);
> > +     clk_disable_unprepare(priv->clk);
> > +     usb_put_hcd(hcd);
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused ehci_brcm_suspend(struct device *dev)
> > +{
> > +     int ret;
> > +     struct usb_hcd *hcd = dev_get_drvdata(dev);
> > +     struct brcm_priv *priv = hcd_to_ehci_priv(hcd);
> > +     bool do_wakeup = device_may_wakeup(dev);
> > +
> > +     ret = ehci_suspend(hcd, do_wakeup);
> > +     if (ret)
> > +             return ret;
> > +     clk_disable_unprepare(priv->clk);
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused ehci_brcm_resume(struct device *dev)
> > +{
> > +     struct usb_hcd *hcd = dev_get_drvdata(dev);
> > +     struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> > +     struct brcm_priv *priv = hcd_to_ehci_priv(hcd);
> > +     int err;
> > +
> > +     err = clk_prepare_enable(priv->clk);
> > +     if (err)
> > +             return err;
> > +     /*
> > +      * SWLINUX-1705: Avoid OUT packet underflows during high memory
> > +      *   bus usage
> > +      * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00
> > +      * @ 0x90
> > +      */
> > +     ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
> > +     ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
> > +
> > +     ehci_resume(hcd, false);
> > +
> > +     pm_runtime_disable(dev);
> > +     pm_runtime_set_active(dev);
> > +     pm_runtime_enable(dev);
> > +
> > +     return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(ehci_brcm_pm_ops, ehci_brcm_suspend,
> > +             ehci_brcm_resume);
> > +
> > +static const struct of_device_id brcm_ehci_of_match[] = {
> > +     { .compatible = "brcm,ehci-brcm-v2", },
> > +     { .compatible = "brcm,bcm7445-ehci", },
> > +     {}
> > +};
> > +
> > +static struct platform_driver ehci_brcm_driver = {
> > +     .probe          = ehci_brcm_probe,
> > +     .remove         = ehci_brcm_remove,
> > +     .shutdown       = usb_hcd_platform_shutdown,
> > +     .driver         = {
> > +             .name   = "ehci-brcm",
> > +             .pm     = &ehci_brcm_pm_ops,
> > +             .of_match_table = brcm_ehci_of_match,
> > +     }
> > +};
> > +
> > +static int __init ehci_brcm_init(void)
> > +{
> > +     if (usb_disabled())
> > +             return -ENODEV;
>
> You check this here, so why are you also checking it in the probe
> function?

Good point. I'll remove the one in probe. This was another thing that
came from the ehci and ohci platform drivers.  About a third of the
drivers in this directory do this, probably because they started with
the platform drivers. Do you think it's worth me submitting a patch to
clean this up at some point?

>
> thanks,
>
> greg k-h

I'll wait for your response before sending a V7.
Thanks for the review.
Al
