Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8F0C33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2061D2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgAMJSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:18:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35040 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgAMJSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:18:49 -0500
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iqvrz-0001WQ-7F
        for linux-kernel@vger.kernel.org; Mon, 13 Jan 2020 09:18:47 +0000
Received: by mail-oi1-f198.google.com with SMTP id n196so2889143oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 01:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hVWGhfiQZEAjtDdU0ey/pBEgv+qGBYAi8H1g/HjIfXk=;
        b=pdjX+VbMLRxKPzQ8g3P3QZmh2N+g5bRFqdA79BEAb0jMfgrt+V8rxPpgDzaFwY3qai
         hH8Appnq9Lvh4VtrFtB6501I/CRSZEy+z4p6g6YS3Hc6gVoooK3yZTEu+HkIk9R8otx8
         nZ/12CXjLotN6IIPx81demsrH7B/vKmATR2Xj40pEfJnY+bT7WXxYmRvsRUR9vMUWwkG
         E60nfTkPOxkDq/slhF+Pa2dy4OoRpaLI7usHEu0KHHw1aEGnxvJQAZh2tsA6FQvz9oYb
         lQlHg8lUq7vEINOdJdKdwa9wjdB1Si+UzrKyKaBbv5S3Gc76rU1uORFhkU8hAL0q55XM
         KRLg==
X-Gm-Message-State: APjAAAWBS66ie+dxU7NGBzDYzWDlQqqJjgay1zmlqXPTNL1wkDpC8/p9
        oU5m/3XwVeqRGilimWbTs1/rF7PLzyJns1T+ksCX2FN+JYHhqKVA/1c7EgaoSyB2/EExW/K+hky
        GywvjpPhq1pjMZQn/VHEheI6aw71AfVb9jX0zSXTT54RjOC39jVmYraQsqA==
X-Received: by 2002:a05:6830:12ce:: with SMTP id a14mr11808703otq.366.1578907126131;
        Mon, 13 Jan 2020 01:18:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHcsYX3u2oPHuVVNKlv+I1KyPkmjPZkt7whVKHbvjKr3vQC7KtZcLpX7DCMKdHUX2mzwfWJGxbpX+gPQzMzDw=
X-Received: by 2002:a05:6830:12ce:: with SMTP id a14mr11808693otq.366.1578907125847;
 Mon, 13 Jan 2020 01:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20200103084008.3579-1-kai.heng.feng@canonical.com>
 <20200103084008.3579-2-kai.heng.feng@canonical.com> <17701887-a249-eade-eecb-541df6c2c704@linux.intel.com>
In-Reply-To: <17701887-a249-eade-eecb-541df6c2c704@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 13 Jan 2020 17:18:31 +0800
Message-ID: <CAAd53p56oXDsPBKqZA_HJbtajWNBQz_LfK-fpOiuxoTrn3WU5w@mail.gmail.com>
Subject: Re: [PATCH 2/3] xhci: Wait until link state trainsits to U0 after
 setting USB_SS_PORT_LS_U0
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

On Fri, Jan 10, 2020 at 11:27 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 3.1.2020 10.40, Kai-Heng Feng wrote:
> > Like U3 case, xHCI spec doesn't specify the upper bound of U0 transition
> > time. The 20ms is not enough for some devices.
> >
> > Intead of polling PLS or PLC, we can facilitate the port change event to
> > know that the link transits to U0 is completed.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >   drivers/usb/host/xhci-hub.c  | 8 +++++++-
> >   drivers/usb/host/xhci-mem.c  | 1 +
> >   drivers/usb/host/xhci-ring.c | 1 +
> >   drivers/usb/host/xhci.h      | 1 +
> >   4 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> > index 2b2e9d004dbf..07886a1bce62 100644
> > --- a/drivers/usb/host/xhci-hub.c
> > +++ b/drivers/usb/host/xhci-hub.c
> > @@ -1310,11 +1310,17 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
> >                                       spin_lock_irqsave(&xhci->lock, flags);
> >                               }
> >                       }
> > +                     if (link_state == USB_SS_PORT_LS_U0)
> > +                             reinit_completion(&ports[wIndex]->link_state_changed);
>
> All the other suspend and resume related port flags/completions are
> in struct xhci_bus_state. See for example rexit_done[].
> Not sure that is a better place but at least it would be consistent.
>
> Could actually make sense to move more of them to the xhci_port structure,
> but perhaps in some later suspend/resume rework patch.

Ok. Should I keep this part of the patch as is? Or move it to
xhci_bus_state and probably move it back to xhci_port in later rework
patch?

> >
> >                       xhci_set_link_state(xhci, ports[wIndex], link_state);
> >
> >                       spin_unlock_irqrestore(&xhci->lock, flags);
> > -                     msleep(20); /* wait device to enter */
> > +                     if (link_state == USB_SS_PORT_LS_U0) {
> > +                             if (!wait_for_completion_timeout(&ports[wIndex]->link_state_changed, msecs_to_jiffies(100)))
> > +                                     xhci_dbg(xhci, "missing U0 port change event for port %d-%d\n", hcd->self.busnum, wIndex + 1);
>
> We might be waiting for completion here in unnecessary.
> No completion is called if port is already in U0, either set by
> xhci_bus_resume(), or we race with a device initiated resume.

Is there a way to know if device initiated resume is inplace?

>
> Maybe read the current port link state first, and don't do anything if it's
> already in U0, or fail if it's in a state where we can't resume to U0.

What happens if device initiated resume happens right after we query the PLS?

>
> > +                     } else
> > +                             msleep(20); /* wait device to enter */
> >                       spin_lock_irqsave(&xhci->lock, flags);
>
> Code might also be cleaner if we have separate if() statements for U0 and U3 link
> states, and skip the generic xhci_set_link_state()
>
> USB 3.2 specs only support PORT_LINK_STATE request feature selectors for
> U0, U1, U2, U3, SS.Disabled, Rx.Detect and Compliance mode.
> Out of these xhci driver already handles the SS.Disabled, Rx.detect and Compliance in
> separate if statements, and xHC hardware can't force a U1 or U2 state by writing
> the PLS field of the PORTSC register, so the xhci_set_link_state() here
> is only useful for U0 and U3.
>
> So maybe something like this:
>
> if (link_state == U0)
>    if (active_link_state == U0)
>      break
>    else if (active_link_state != a proper link state)
>      return error
>    xhci_set_link_state(U0)
>    wait_for_completion_timeout()
>    break;
>
> if (link_state == U3)
>    xhci_stop_device(slot_id)
>    xhci_set_link_state(U3)
>    for (max 10 tries) {
>      msleep_range(~10ms)
>      if (readl(PORTSC(PLS) == U3)
>        break
>    }
>    break

Ok, will rework the next patch in this direction.

Kai-Heng

> >
> >                       if (link_state == USB_SS_PORT_LS_U3) {
> > diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> > index 3b1388fa2f36..c760a28e3556 100644
> > --- a/drivers/usb/host/xhci-mem.c
> > +++ b/drivers/usb/host/xhci-mem.c
> > @@ -2268,6 +2268,7 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
> >               xhci->hw_ports[i].addr = &xhci->op_regs->port_status_base +
> >                       NUM_PORT_REGS * i;
> >               xhci->hw_ports[i].hw_portnum = i;
> > +             init_completion(&xhci->hw_ports[i].link_state_changed);
> >       }
> >
> >       xhci->rh_bw = kcalloc_node(num_ports, sizeof(*xhci->rh_bw), flags,
> > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> > index d23f7408c81f..44d91a53bf07 100644
> > --- a/drivers/usb/host/xhci-ring.c
> > +++ b/drivers/usb/host/xhci-ring.c
> > @@ -1677,6 +1677,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
> >            (portsc & PORT_PLS_MASK) == XDEV_U1 ||
> >            (portsc & PORT_PLS_MASK) == XDEV_U2)) {
> >               xhci_dbg(xhci, "resume SS port %d finished\n", port_id);
> > +             complete(&port->link_state_changed);
>
> Completion will only be called if there was a port link change (PLC bit set)
> and link is in U0/U1/U2. Completion will also be called for device
> initiated resume even when no one is waiting for it. (probably harmless)
>
> -Mathias
