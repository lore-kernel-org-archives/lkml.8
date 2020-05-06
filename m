Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D78C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767DC2076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRId+sPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgEFS7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgEFS7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:59:23 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC93FC061A0F;
        Wed,  6 May 2020 11:59:22 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t12so1210797ile.9;
        Wed, 06 May 2020 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lpYq+th169UEJTBFHfr6994K42fMCM/CE3wPoNMf8w=;
        b=rRId+sPJ5iOYmr5Y2pDwfZnKD38JSFpf65opPROixp6cmEWzguPot8tGC5dtJ4Xx34
         HbTQy1oPtncmsCLm5FgLcvpq5OJCscpscNBYzcjwz0ny6yLUK2j3zxsFn+ec8OoIwU76
         17+TRfQtfNL2pdGXjQZ8wsfXnZUIW8l4y4wNIX3xaVSHsR4x3U4SW0W/MrsqOyOUoBHb
         gitHxwplv/4ZSmhFWK1sc+gMSIYgb0+qnJXfhJCKeJIg8//H/zEmHeoG7DRBMicU8leN
         WnpM2dqcR2Sg1nAsvyfdSc3a9ovnGy4jedPaOJHcwhBYZDqrKi9t6wcuoM916vymGV/K
         dDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lpYq+th169UEJTBFHfr6994K42fMCM/CE3wPoNMf8w=;
        b=UVzlQxGHz1Z881fopMOz6ASY0rG3vT31Kv0bIhBUv0/Lic3UHwQR9a56UHi+68ZhQr
         dxmVJHfHaoE6opFCm8PR8C5wi/nqbP3Q79AY4QBOWsv6IS6a9YWV2YWBcALqzXtdg0gb
         CGckMdXsvcGuiWDBftwdVTrCHYXBUgqs1ophSPSJsQmVg0u7hu7k1rNC+WqOviijNHBt
         FmoMzG5aRVAJnSQm1twU1++pnGDYgA18mE3dABxhZ5ISeXFcQ9OThwmPMy60vKHpIgpI
         rOe8O9xoXDu2X5hdAU4vOtSyF6ghPzsKS81mVgm1cjEC/G0KucDwrtdbkHYYAEpXebYS
         /u1Q==
X-Gm-Message-State: AGi0PuZAj4yXwnakrv9lThuY0nSRMJjde49k4Sn4dABRqaMjDlpKqJs/
        vJOU9N791oG2hY1F+xS9XYrxkfW7cRG7yLsJ6Js=
X-Google-Smtp-Source: APiQypKhL3iLzzChz2Mlk2v1yEhGVvpmo/vYIu427ZTa6j0CjVwvW5wMIIjpDcBU/aiEoPEN5IPjfHjJHpooxBxwlhM=
X-Received: by 2002:a92:d286:: with SMTP id p6mr10006224ilp.98.1588791562140;
 Wed, 06 May 2020 11:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200430111258.6091-1-alcooperx@gmail.com> <20200430111258.6091-5-alcooperx@gmail.com>
 <20200505105413.GA93160@kroah.com>
In-Reply-To: <20200505105413.GA93160@kroah.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Wed, 6 May 2020 14:59:10 -0400
Message-ID: <CAOGqxeUJsYmQS8N3yvb8U76J-afFa9qKiu+S0=SK1OYmu+qYeQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] usb: host: Add ability to build new Broadcom STB
 USB drivers
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

On Tue, May 5, 2020 at 6:54 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 30, 2020 at 07:12:58AM -0400, Al Cooper wrote:
> > Add the build system changes needed to get the Broadcom STB XHCI,
> > EHCI and OHCI functionality working. The OHCI support does not
> > require anything unique to Broadcom so the standard ohci-platform
> > driver is being used. The link order for XHCI was changed in the
> > Makefile because of the way STB XHCI, EHCI and OHCI controllers
> > share a port which requires that the XHCI driver be initialized
> > first. Also update MAINTAINERS.
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > ---
> >  MAINTAINERS               |  8 ++++++++
> >  drivers/usb/host/Kconfig  | 16 ++++++++++++++++
> >  drivers/usb/host/Makefile | 16 ++++++++++------
> >  3 files changed, 34 insertions(+), 6 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 26f281d9f32a..6147ed78d212 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3481,6 +3481,14 @@ S:     Supported
> >  F:   Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
> >  F:   drivers/i2c/busses/i2c-brcmstb.c
> >
> > +BROADCOM BRCMSTB USB EHCI DRIVER
> > +M:   Al Cooper <alcooperx@gmail.com>
> > +L:   linux-usb@vger.kernel.org
> > +L:   bcm-kernel-feedback-list@broadcom.com
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> > +F:   drivers/usb/host/ehci-brcm.*
> > +
> >  BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
> >  M:   Al Cooper <alcooperx@gmail.com>
> >  L:   linux-kernel@vger.kernel.org
> > diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> > index 55bdfdf11e4c..7d58fd66e412 100644
> > --- a/drivers/usb/host/Kconfig
> > +++ b/drivers/usb/host/Kconfig
> > @@ -97,6 +97,22 @@ config USB_XHCI_TEGRA
> >
> >  endif # USB_XHCI_HCD
> >
> > +config USB_EHCI_BRCMSTB
> > +       tristate
> > +
> > +config USB_BRCMSTB
> > +     tristate "Broadcom STB USB support"
> > +     depends on (ARCH_BRCMSTB && PHY_BRCM_USB) || COMPILE_TEST
> > +     select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
> > +     select USB_EHCI_BRCMSTB if USB_EHCI_HCD
> > +     select USB_XHCI_PLATFORM if USB_XHCI_HCD
> > +     help
> > +       Say Y to enable support for XHCI, EHCI and OHCI host controllers
> > +       found in Broadcom STB SoC's.
> > +
> > +       Disabling this will keep the controllers and corresponding
> > +       PHYs powered down.
>
> Whhat are the module names?

I'll add the module names.

>
> And why 2 config options here?

I'd like the option to build an XHCI only system by not enabling
USB_EHCI_HCD and USB_OHCI_HCD.

>
> > +
> >  config USB_EHCI_HCD
> >       tristate "EHCI HCD (USB 2.0) support"
> >       depends on HAS_DMA && HAS_IOMEM
> > diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> > index b191361257cc..85fa6ace552a 100644
> > --- a/drivers/usb/host/Makefile
> > +++ b/drivers/usb/host/Makefile
> > @@ -37,6 +37,15 @@ endif
> >
> >  obj-$(CONFIG_USB_PCI)        += pci-quirks.o
> >
> > +# NOTE: BRCMSTB systems require that xhci driver be linked before the
> > +# ehci/ohci drivers.
>
> Why?  Please do this as a separate change before your makefile changes.

Okay

>
> And what else will this break?  We have relied on this link order for a
> very long time, changing it could cause issues...
>
> I don't see how your driver needs this, please explain in great detail.

For this explaination, I'm going to call our EHCI and OHCI controllers EOHCI.
We have some SoC's that have an XHCI controller and an EOHCI
controller on the same  port, where the XHCI controller handles the
3.0 devices and the EOHCI handles the <= 2.0 devices. If the EOHCI
controller comes up before the XHCI controller, any 3.0 devices
installed on the port will be seen as a 2.0 device. Once the 3.0
controller comes up, most 3.0 USB devices will switch to 3.0, but this
seems to cause problems on some USB devices.
In the past, this wasn't a problem because we had custom XHCI, EHCI
and OHCI drivers that I could order any way necessary. Now that the
standard platform XHCI and OHCI drivers are being used this becomes a
problem.

Thanks for the review
Al

>
> thanks,
>
> greg k-h
