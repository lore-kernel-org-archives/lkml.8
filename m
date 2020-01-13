Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47512C33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DD5206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgAMJKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:10:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34768 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgAMJKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:10:17 -0500
Received: from mail-oi1-f200.google.com ([209.85.167.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iqvji-0000pc-LQ
        for linux-kernel@vger.kernel.org; Mon, 13 Jan 2020 09:10:14 +0000
Received: by mail-oi1-f200.google.com with SMTP id u125so2880433oia.20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 01:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEdQLRNNr60Uq1X2SB+y192Ftk0ynyhp3ZNDXSiOKAQ=;
        b=ZDuUtxXP8lCfFmmKbHgRHfnbN1ufYkqKPzLomRLXV3ddQ4mcuLFIWqAfgSmTY/x8UF
         +fk+Dl9PF3Uh52mfnv8uUiBHrQWWJFLVZeh671dAlwSZP4l+Q0aMHW80FdnJZVMt3p2e
         OSuWdDG7Otlx9GCzBeaiCaxzR0zD+b8JQaeEHUGYTlpxU9Aihiq6J6uDDp6+gGvZDLs5
         Y/kgJ7dKaHwfLl3+wPTdlkFmTthPigr1HUjlYQvKxTrdJLa4W9ThcDdEa+pozOjdWNJc
         cl/1q28bju4LsXKhKDHGf0OgDko74N+hX2CUr6RFBOBhxCSqTdcOqRSneawc/VarsO3c
         ms8w==
X-Gm-Message-State: APjAAAVKywk5wTEZbGO4GXxgIbNC+HDDDN4qW2qipNCKkNO3USe518hB
        9Tl8JnVDkQ2Egi9OWADpu1/a3qnEKGyfZOK1NEDJo9s6K7wXy2X0Ev9TTHLtIqrLOFUgPs2xovU
        ubaiU5TIdhzufgGnm3k8CElXBH/v7pqhFG69sjik1qQRqVXV1gQIqAnlAkQ==
X-Received: by 2002:a05:6830:2116:: with SMTP id i22mr12892759otc.0.1578906613629;
        Mon, 13 Jan 2020 01:10:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzbkSKjuRTgR1fq86s85YJnJMUaFmgpHoY0wic8O0U5gnrpy6eHqN8bmmjRA09V5O4NRND1ZioaeJVWGm5KziM=
X-Received: by 2002:a05:6830:2116:: with SMTP id i22mr12892740otc.0.1578906613363;
 Mon, 13 Jan 2020 01:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20200103084008.3579-1-kai.heng.feng@canonical.com> <607e395f-21ce-3c9f-eff7-2fa6aaa74595@linux.intel.com>
In-Reply-To: <607e395f-21ce-3c9f-eff7-2fa6aaa74595@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 13 Jan 2020 17:10:02 +0800
Message-ID: <CAAd53p5a2RFpZuHGvuNO_9kgv4dGhHCYU0jeq44FtKJv0Ky8uA@mail.gmail.com>
Subject: Re: [PATCH 1/3] xhci: Ensure link state is U3 after setting USB_SS_PORT_LS_U3
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        AceLan Kao <acelan.kao@canonical.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 5:33 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 3.1.2020 10.40, Kai-Heng Feng wrote:
> > The xHCI spec doesn't specify the upper bound of U3 transition time. For
> > some devices 20ms is not enough, so we need to make sure the link state
> > is in U3 before further actions.
>
> Looking at the USB 3.2 spec (7.2.4.2 Link Power management and Flow) it seems
> most timers related to U3 entry are a lot less than a millisecond (4-16us)
> If port is in U1/U2,  Ux_EXIT_TIMER is 6ms which seems to be the longest timeout.
>
> If we anyway are polling for the U3 state we could shorten the initial 20ms sleep
> down to 10ms. I think many devices, especially if they are already in U0
> could manage this.

Ok.

>
> are >
> > I've tried to use U3 Entry Capability by setting U3 Entry Enable in
> > config register, however the port change event for U3 transition
> > interrupts the system suspend process.
> >
> > For now let's use the less ideal method by polling PLS.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >   drivers/usb/host/xhci-hub.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> > index 7a3a29e5e9d2..2b2e9d004dbf 100644
> > --- a/drivers/usb/host/xhci-hub.c
> > +++ b/drivers/usb/host/xhci-hub.c
> > @@ -1228,6 +1228,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
> >                       break;
> >               case USB_PORT_FEAT_LINK_STATE:
> >                       temp = readl(ports[wIndex]->addr);
> > +                     xhci_dbg(xhci, "before setting link state, actual port %d-%d status = 0x%0x\n", hcd->self.busnum, wIndex + 1, temp);
>
> xhci_set_link_state() already shows similar debugging,

Ok, will remove it.

>
> >                       /* Disable port */
> >                       if (link_state == USB_SS_PORT_LS_SS_DISABLED) {
> >                               xhci_dbg(xhci, "Disable port %d\n", wIndex);
> > @@ -1316,9 +1317,17 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
> >                       msleep(20); /* wait device to enter */
> >                       spin_lock_irqsave(&xhci->lock, flags);
> >
> > -                     temp = readl(ports[wIndex]->addr);
> > -                     if (link_state == USB_SS_PORT_LS_U3)
> > +                     if (link_state == USB_SS_PORT_LS_U3) {
> > +                             retval = xhci_handshake(ports[wIndex]->addr, PORT_PLS_MASK, XDEV_U3, 80 * 1000);
> > +                             if (retval)
> > +                                     xhci_dbg(xhci, "polling XDEV_U3 on port %d-%d timeout\n", hcd->self.busnum, wIndex + 1);
>
> In worst case we are busylooping for 80ms here, keeping the cpu busy.
> It should be ok to sleep here, so how about just reading the register
> every 10ms max 10 times, sleeping in between.

Ok. Is the polling safe outside of spin_lock_irqsave()?

Kai-Heng

>
> -Mathias
