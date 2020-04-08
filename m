Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E4AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF692075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVl7GPAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgDHTAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:00:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44476 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgDHTAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:00:19 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so1190645iok.11;
        Wed, 08 Apr 2020 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UDOGux9OnwcLCVvDL8z/SzrW7VhDkSyO73EN0gWoFZo=;
        b=UVl7GPAKW++tURxy6THgSLiuvtOk21CT1Xt8akTipbQcraT3551XJQHeDQ2+LXClzO
         Ty/KEXudk26DqFo9enLwrfsCWTG8cM0VqDVsAHRBsYJFynBCwTcadbuhx7c1NUJVUghh
         LadzkTAtBe/9+39KKLoJrQtfxAt9/IcFfWN5vvm64p1Zn8YsDuCa5edne5kk+NNQL1rE
         6Z8A+hlQrFNucfDP+upSPTPKnygFJZWAOlrryiA2233asov6nBrDc5lAmLW845kAapAd
         k9z4U6AIQpTa+AHxDaFY+XvF64LihFmQ++uHe6GVfCIh9cs+0XtvV1tcBr/0qsXRPWMO
         E5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UDOGux9OnwcLCVvDL8z/SzrW7VhDkSyO73EN0gWoFZo=;
        b=oe3Ix6CKn79mSNToBvNUNdR6aWdzmbrO4Ap4FkGe2Whsd91VFTluszKSH3Vy7n7WDt
         RAb4qOlHQYt4+jWpAPp+ScgNGNLHfZgAJpVeIogEmHJDmdGTwfIjdf0Ll+nVcTEBO/Wa
         n6un7E5chNb+l7opa1ws6ka+ZiTpk15MMSMJelMTvaPp4Y3HOCAfsWggQS5mwQIPaN/j
         eL3CJ6pHylLPpQ9+gCcdDlHo7FL9KKo66LiLvpgGsZsLOkA/KF2sEbQIzjMOS1qg6PTL
         2bIV8BTw6K3u2U4TiotwQaZwysJ8qIMohVXpgSl4UBIqbM4fAAyi3FbasjL2wL0Yba2t
         L2Lg==
X-Gm-Message-State: AGi0PuafJopnhktKXEsoLjje7gb3HV9MdqijNEIYNtStZteudeSkDr5O
        EA1hQk7QeH/ZAAQJG5zfH6gU99H8Ul2g83H2BMA=
X-Google-Smtp-Source: APiQypLJjj8ZBg6Mt5DZq9kqoXz/BVCXrfODGbWgtNmw50cx1Z6OgxhRqhXjMW201TFjaKkCtUeg1WgTmVbYFzaIpwU=
X-Received: by 2002:a6b:5116:: with SMTP id f22mr8425922iob.15.1586372417265;
 Wed, 08 Apr 2020 12:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200408181406.40389-1-alcooperx@gmail.com> <20200408182557.GR3676135@smile.fi.intel.com>
In-Reply-To: <20200408182557.GR3676135@smile.fi.intel.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Wed, 8 Apr 2020 15:00:05 -0400
Message-ID: <CAOGqxeVZpT2Li86kJSgw7D9hv76Knw8-aTAmq+T03nFf5Q1a4g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 2:25 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 08, 2020 at 02:14:02PM -0400, Al Cooper wrote:
> > v3 - Addressed all of Andy Shevchenko's review comments for
> >      ehci-brcm.c.
> >    - Fixed the brcm,bcm7445-ehci.yaml dt-bindings document,
> >      dt_binding_check now passes.
> >    - Added the XHCI functionality to xhci-plat.c instead of creating
> >      new brcmstb files, as suggested by Mathias Nyman.
>
> It's nice, but have you heard what Mathias asked / proposed?

I thought that was what I did.

Al

...


>
> > v2 - Addressed Andy Shevchenko's review comments.
> >    - Fixed dt_binding_check error pointed out by Rob Herring.
> >    - Removed pr_info message in ehci_brcm_init as suggested by
> >      Greg Kroah-Hartman.
> >
> > This adds support for the XHCI, EHCI and OHCI host controllers found
> > in Broadcom STB SoC's. These drivers depend on getting access to the
> > new Broadcom STB USB PHY driver through a device-tree phandle and
> > will fail if the driver is not available.
> >
> > Al Cooper (4):
> >   dt-bindings: Add Broadcom STB USB support
> >   usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
> >   usb: ehci: Add new EHCI driver for Broadcom STB SoC's
> >   usb: host: Add ability to build new Broadcom STB USB drivers
> >
> >  .../bindings/usb/brcm,bcm7445-ehci.yaml       |  60 ++++
> >  .../devicetree/bindings/usb/usb-xhci.txt      |   1 +
> >  MAINTAINERS                                   |   8 +
> >  drivers/usb/host/Kconfig                      |  16 +
> >  drivers/usb/host/Makefile                     |  16 +-
> >  drivers/usb/host/ehci-brcm.c                  | 286 ++++++++++++++++++
> >  drivers/usb/host/xhci-plat.c                  |  10 +
> >  7 files changed, 391 insertions(+), 6 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> >  create mode 100644 drivers/usb/host/ehci-brcm.c
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
