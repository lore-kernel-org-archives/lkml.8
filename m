Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46791C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6C720714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CSvH/Ub1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgC0UXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:23:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37434 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgC0UXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:23:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id g23so11165404otq.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 13:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFz97eXpjJf+7mUd4dNZdWEqJgglvlf1biCOfhwlvrw=;
        b=CSvH/Ub1dezjRaHvNDRiXZX7jQJCKDFX+dMYut7M8RhokpljrMAVooMj1bo9SqDIb3
         1ZaKfbVP4po180gn4uml+oUsHpx5MgITAEltFGisMTpSBUEnbhaUhi3JkPzSbjDauj6K
         a+B+xGyeeYUdP+yk/txqFyw8E1pPKBrG4ME9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFz97eXpjJf+7mUd4dNZdWEqJgglvlf1biCOfhwlvrw=;
        b=gU815Hm6Tea3hkyyA935zOpJSf9v5jfGw6BYaksLguVguv6qfAndZnS+X1TFl9In4+
         oZbwZoeWDCRTPhdi7gcVrkBKoyI+PLljAG/fad1284W2/Vi0zfpuKxDBPpMtCuWaGqPd
         6W53gAktPChNBj0JQBAH5DbS48B4HZEkO8dtfkgVAv85xHBFVrbyCMRIoRiExHYiScZJ
         QayuRDdPfoz2x7ztVJktinE0L7uhV7qfFwSF74Mi4vdy9rIaP3mTgWQQch6q61ikIzPe
         tVO76FX7q9JqvyQoD5ooNf7zKMOUCtnwH3a8RJeCIs5+mpQ6AHWZIWcYuJO+/+l2coAR
         5UWA==
X-Gm-Message-State: ANhLgQ2vpTlTm2PPX8bFJrnZGjLQCoX9GkOTzgbI6GUEbDlpNz9BK9jJ
        AH1kRiSx9FKIffAAmzHx475NVR9AhJinSDhm2mwO
X-Google-Smtp-Source: ADFU+vvIa69JmP/eHtaUxuKh+BObIiRLVegX94oveThM6CY52unkByyBKrxVNAURHYXSfVWiT369OFTMKFjSimrf3G0=
X-Received: by 2002:a05:6830:19ee:: with SMTP id t14mr375774ott.287.1585340583924;
 Fri, 27 Mar 2020 13:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200313141545.31943-1-alcooperx@gmail.com> <20200313161836.GX1922688@smile.fi.intel.com>
In-Reply-To: <20200313161836.GX1922688@smile.fi.intel.com>
From:   Al Cooper <al.cooper@broadcom.com>
Date:   Fri, 27 Mar 2020 16:22:52 -0400
Message-ID: <CAGh=XAD63AhGRqvvNKfm2=0-bsZZdhtXcMDavR75BNzUd7UiOQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
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

On Fri, Mar 13, 2020 at 12:18 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Mar 13, 2020 at 10:15:41AM -0400, Al Cooper wrote:
> > This adds support for the XHCI, EHCI and OHCI host controllers found
> > in Broadcom STB SoC's. These drivers depend on getting access to the
> > new Broadcom STB USB PHY driver through a device-tree phandle and
> > will fail if the driver is not available.
>
> Hint to the future:
>
>         scripts/get_maintainer.pl --git --git-min-percent=67 ...

Thanks, I'll use that in the future.

>
> >
> > Al Cooper (4):
> >   dt-bindings: Add Broadcom STB USB support
> >   usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
> >   usb: ehci: Add new EHCI driver for Broadcom STB SoC's
> >   usb: host: Add ability to build new Broadcom STB USB drivers
> >
> >  .../bindings/usb/brcm,bcm7445-ehci.yaml       |  60 ++++
> >  .../devicetree/bindings/usb/usb-xhci.txt      |   1 +
> >  MAINTAINERS                                   |   9 +
> >  drivers/usb/host/Kconfig                      |  20 ++
> >  drivers/usb/host/Makefile                     |  20 +-
> >  drivers/usb/host/ehci-brcm.c                  | 288 ++++++++++++++++++
> >  drivers/usb/host/xhci-brcm.c                  |  16 +
> >  drivers/usb/host/xhci-brcm.h                  |  16 +
> >  drivers/usb/host/xhci-plat.c                  |  11 +
> >  9 files changed, 435 insertions(+), 6 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> >  create mode 100644 drivers/usb/host/ehci-brcm.c
> >  create mode 100644 drivers/usb/host/xhci-brcm.c
> >  create mode 100644 drivers/usb/host/xhci-brcm.h
> >
> > --
> > 2.17.1
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
