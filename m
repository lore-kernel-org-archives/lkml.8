Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8357C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71C620658
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtXdJiPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHMPB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgHMPBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:01:18 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FD6C061383;
        Thu, 13 Aug 2020 08:01:14 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id 77so5791736ilc.5;
        Thu, 13 Aug 2020 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VeYAUU/EPHxpKZxQpzyBoUPcmpVwrp5iSAGglmALi44=;
        b=rtXdJiPqDxZtanJ1zr6YZmaoHeaquOSdJCL8ts20MymHJqMSztPqABANtHwHVRR/V8
         EWMHvwwDCLq0rCF6gP4Sje84MOhiILz3X1/7t2+jv3xgdBfN3Fp2+75ZAAyi7E6NFyCu
         BNAgJ+5iXltwYd8NlVSML2WMuwgQVTrHp07gURFfhyuYUYoNhLMV5/N7N95JWeIZfDQ8
         vMavNI6TqxhPi+jfcCt2fp6FE65O8RuzI3BC3GMvY33YQ/IeIXTXc9MlyYZ+Ipc/VU+W
         6+2eI0kJzhE/8HxwQYlwMt1Pw+6ekltMECah+PZTMDAWulz7DFHvHLjEVHivKGBDqLD8
         O2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VeYAUU/EPHxpKZxQpzyBoUPcmpVwrp5iSAGglmALi44=;
        b=mLg0988LJKeTwFhpCiezl9yHsRX2ZfPQHFCUrLKsX5EYIWViFzD/Yy6hsiZdKkzG5s
         r46l6Kl6GqdVeYrVZE0cWsyY1w09PBzR7nh7RHpiKW0Fsvf6ly3A5UBKRLFH730gNV8f
         WFRTrzr6fz7YC2PoqvaCgeWjneq3AsBx+hCpNoGpI/2iCP6Nz6jDRZyOCOnftKOfK1ul
         7b92a5hK1ec8PdygJHS1Y7O6lA3AEGLjyhRDbXxvj1WOeBo/3OSXNF/aI9ImJpzyulnT
         uK06LB87JT/BaHXiPI2zzMDlvIp+WOPzbSmkPB0vPszBIbadeDxIQwbugkzOIfYdFHNM
         YykA==
X-Gm-Message-State: AOAM531j2nWpqk1KrAz6YDXzSiXBrvgokBnegXPK5AI1jK0jujwKu2Wq
        SpPAxRPpuJNjM0xzEguLapzYqZeHtcJJwNwJ8lM=
X-Google-Smtp-Source: ABdhPJx8Hq7WaVsxSID5/i4yhVP3HCwyPRJ0hLC/Ef4A3U5uAIdFrrglKppOTu0TMEXk4mprOThz2voH2++4iPFcYB8=
X-Received: by 2002:a92:7f04:: with SMTP id a4mr5103943ild.10.1597330873980;
 Thu, 13 Aug 2020 08:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200812202018.49046-1-alcooperx@gmail.com> <20200812202018.49046-4-alcooperx@gmail.com>
 <20200813054052.GB1353152@kroah.com>
In-Reply-To: <20200813054052.GB1353152@kroah.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Thu, 13 Aug 2020 11:01:02 -0400
Message-ID: <CAOGqxeVQ_h83dYOypQXD24q55eYwUWK=uW75mFUrVRjSJFgF2w@mail.gmail.com>
Subject: Re: [PATCH 3/3] usb: Add Kconfig and Makefile changes to build brcmstb-usb-pinmap
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Al Cooper <al.cooper@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        USB list <linux-usb@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 1:40 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 12, 2020 at 04:20:18PM -0400, Al Cooper wrote:
> > From: Al Cooper <al.cooper@broadcom.com>
> >
> > Add Kconfig and Makefile changes to build brcmstb-usb-pinmap and
> > update MAINTAINERS for the new driver.
>
> This can be part of the previous patch, or at least the Kconfig and
> Makefile changes should be there so that we build the code when we add
> it.

I'll combine the 2 patches.

>
> > refs #SWLINUX-5537
>
> What is this?

This will be removed.

>
> >
> > Signed-off-by: Al Cooper <al.cooper@broadcom.com>
> > ---
> >  MAINTAINERS               | 8 ++++++++
> >  drivers/usb/host/Kconfig  | 4 ++++
> >  drivers/usb/host/Makefile | 1 +
> >  3 files changed, 13 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f0569cf304ca..3a44ac61899b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3527,6 +3527,14 @@ S:     Maintained
> >  F:   Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> >  F:   drivers/usb/host/ehci-brcm.*
> >
> > +BROADCOM BRCMSTB USB PIN MAP DRIVER
> > +M:   Al Cooper <alcooperx@gmail.com>
> > +L:   linux-usb@vger.kernel.org
> > +L:   bcm-kernel-feedback-list@broadcom.com
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> > +F:   drivers/usb/host/brcmstb-usb-pinmap.c
> > +
> >  BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
> >  M:   Al Cooper <alcooperx@gmail.com>
> >  L:   linux-kernel@vger.kernel.org
> > diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> > index 1cb3004ea7b2..9c285053bb0c 100644
> > --- a/drivers/usb/host/Kconfig
> > +++ b/drivers/usb/host/Kconfig
> > @@ -109,12 +109,16 @@ endif # USB_XHCI_HCD
> >  config USB_EHCI_BRCMSTB
> >         tristate
> >
> > +config BRCM_USB_PINMAP
> > +       tristate
> > +
> >  config USB_BRCMSTB
> >       tristate "Broadcom STB USB support"
> >       depends on (ARCH_BRCMSTB && PHY_BRCM_USB) || COMPILE_TEST
> >       select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
> >       select USB_EHCI_BRCMSTB if USB_EHCI_HCD
> >       select USB_XHCI_PLATFORM if USB_XHCI_HCD
> > +     select BRCM_USB_PINMAP
> >       help
> >         Enables support for XHCI, EHCI and OHCI host controllers
> >         found in Broadcom STB SoC's.
> > diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> > index bc731332fed9..0e63ef94790d 100644
> > --- a/drivers/usb/host/Makefile
> > +++ b/drivers/usb/host/Makefile
> > @@ -90,3 +90,4 @@ obj-$(CONFIG_USB_HCD_BCMA)  += bcma-hcd.o
> >  obj-$(CONFIG_USB_HCD_SSB)    += ssb-hcd.o
> >  obj-$(CONFIG_USB_FOTG210_HCD)        += fotg210-hcd.o
> >  obj-$(CONFIG_USB_MAX3421_HCD)        += max3421-hcd.o
> > +obj-$(CONFIG_BRCM_USB_PINMAP)        += brcmstb-usb-pinmap.o
>
> Shouldn't this driver be in usb/misc/ with other drivers like this?  Why
> host?

That does seem like a better choice, I'll move it.

>
> Wait, why is this a separate driver at all?  Why not just build it into
> the USB_BRCMSTB driver?

Of the 20 or so chips supported by the BRCMSTB USB drivers, only one
currently has this functionality so it seems better to have this code
in it's own driver so it can be enabled in device-tree for just this
chip. I also wanted to leave this in it's own driver because in the
future the same hardware functionality may be added for some eMMC
signals.

Thanks
Al

>
> thanks,
>
> greg k-h
