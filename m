Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002C7C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D834D20707
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIACbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:31:18 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54251 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725993AbgIACbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:31:18 -0400
Received: (qmail 572242 invoked by uid 1000); 31 Aug 2020 22:31:17 -0400
Date:   Mon, 31 Aug 2020 22:31:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     gregkh@linuxfoundation.org, erkka.talvitie@vincit.fi,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC RESEND PATCH 0/1] USB EHCI: repeated resets on full and low
 speed devices
Message-ID: <20200901023117.GD571008@rowland.harvard.edu>
References: <cover.1598887346.git.khalid@gonehiking.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1598887346.git.khalid@gonehiking.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 10:23:30AM -0600, Khalid Aziz wrote:
> [Resending since I screwed up linux-usb mailing list address in
> cut-n-paste in original email]
> 
> 
> I recently replaced the motherboard on my desktop with an MSI B450-A
> Pro Max motherboard. Since then my keybaords, mouse and tablet have
> become very unreliable. I see messages like this over and over in
> dmesg:
> 
> ug 23 00:01:49 rhapsody kernel: [198769.314732] usb 1-2.4: reset full-speed USB
>  device number 27 using ehci-pci
> Aug 23 00:01:49 rhapsody kernel: [198769.562234] usb 1-2.1: reset full-speed USB
>  device number 28 using ehci-pci
> Aug 23 00:01:52 rhapsody kernel: [198772.570704] usb 1-2.1: reset full-speed USB
>  device number 28 using ehci-pci
> Aug 23 00:02:02 rhapsody kernel: [198782.526669] usb 1-2.4: reset full-speed USB
>  device number 27 using ehci-pci
> Aug 23 00:02:03 rhapsody kernel: [198782.714660] usb 1-2.1: reset full-speed USB
>  device number 28 using ehci-pci
> Aug 23 00:02:04 rhapsody kernel: [198784.210171] usb 1-2.3: reset low-speed USB device number 26 using ehci-pci
> Aug 23 00:02:06 rhapsody kernel: [198786.110181] usb 1-2.4: reset full-speed USB device number 27 using ehci-pci
> Aug 23 00:02:08 rhapsody kernel: [198787.726158] usb 1-2.4: reset full-speed USB device number 27 using ehci-pci
> Aug 23 00:02:10 rhapsody kernel: [198790.126628] usb 1-2.1: reset full-speed USB device number 28 using ehci-pci
> Aug 23 00:02:10 rhapsody kernel: [198790.314141] usb 1-2.4: reset full-speed USB device number 27 using ehci-pci
> Aug 23 00:02:12 rhapsody kernel: [198792.518765] usb 1-2.4: reset full-speed USB device number 27 using ehci-pci
> 
> The devices I am using are:
> 
> - Logitech K360 wireless keyboard
> - Wired Lenovo USB keyboard
> - Wired Lenovo USB mouse
> - Wired Wacom Intuos tablet
> 
> After a reset, the wireless keyboard simply stops working. Rest of
> the devices keep seeing intermittent failure.
> 
> I tried various combinations of hubs and USB controllers to see what
> works. MSI B450-A motherboard has USB 3.0 and USB 3.1 controllers. I
> added a USB 2.0 PCI card as well for this test:
> 
> 03:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset USB 3.1 XHCI Controller (rev 01)
> 29:01.0 USB controller: NEC Corporation OHCI USB Controller (rev 43)
> 29:01.1 USB controller: NEC Corporation OHCI USB Controller (rev 43)
> 29:01.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 04)
> 2c:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller
> 
> I have a bus powered USB 3.0 hub, a bus powered USB 2.0 hub and a
> self powered USB 2.0 hub built into my monitor.
> 
> I have connected my devices directly into the ports on motherboard
> and PCI card as well as into external hub. Here are the results I
> saw when devices wee plugged into various combination of ports:
> 
> 1. USB 3.0/3.1 controller - does NOT work
> 2. USB 2.0 controller - WORKS
> 3. USB 3.0/3.1 controller -> Self powered USB 2.0 hub in monitor - does
>    NOT work
> 4. USB 3.0/3.1 controller -> bus powered USB 3.0 hub - does NOT work
> 5. USB 3.0/3.1 controller -> Bus powered USB 2.0 hub - WORKS
> 7. USB 2.0 controller -> Bus powered USB 3.0 hub - does NOT work
> 8. USB 2.0 controller -> Bus powered 2.0 hub - Does not work

The error messages in your log extract all refer to ehci-pci, which is 
the driver for a USB-2 controller.  They are completely unrelated to any 
problems you may be having with USB-3 controllers.

> I narrowed the failure down to following lines (this code was added
> in 5.5 with commit 64cc3f12d1c7 "USB: EHCI: Do not return -EPIPE
> when hub is disconnected"):
> 
> drivers/usb/host/ehci-q.c:
> 
>  217                 } else if ((token & QTD_STS_MMF) &&
>  218                                         (QTD_PID(token) == PID_CODE_IN)) {
>  219                         status = -EPROTO;
>  220                 /* CERR nonzero + halt --> stall */
> 
> At the time of failure, when we reach this conditional, token is
> either 0x80408d46 or 0x408d46 which means following bits are set:
> 
> QTD_STS_STS, QTD_STS_MMF, QTD_STS_HALT, QTD_IOC, QTD_TOGGLE
> 
> and 
> 
>         QTD_PID = 1
>         QTD_CERR = 3
>         QTD_LENGTH = 0x40 (64)
> 
> This causes  the branch "(token & QTD_STS_MMF) && (QTD_PID(token) ==
> PID_CODE_IN" to be taken and qtd_copy_status() returns EPROTO. This
> return value in qh_completions() results in ehci_clear_tt_buffer()
> being called:
> 
> drivers/usb/host/ehci-q.c:
>  472                         /* As part of low/full-speed endpoint-halt processi     ng
>  473                          * we must clear the TT buffer (11.17.5).
>  474                          */
>  475                         if (unlikely(last_status != -EINPROGRESS &&
>  476                                         last_status != -EREMOTEIO)) {
>  477                                 /* The TT's in some hubs malfunction when t     hey
>  478                                  * receive this request following a STALL (     they
>  479                                  * stop sending isochronous packets).  Sinc     e a
>  480                                  * STALL can't leave the TT buffer in a bus     y
>  481                                  * state (if you believe Figures 11-48 - 11     -51
>  482                                  * in the USB 2.0 spec), we won't clear the      TT
>  483                                  * buffer in this case.  Strictly speaking      this
>  484                                  * is a violation of the spec.
>  485                                  */
>  486                                 if (last_status != -EPIPE)
>  487                                         ehci_clear_tt_buffer(ehci, qh, urb,
>  488                                                         token);
>  489                         }
> 
> It seems like clearing TT buffers in this case is resulting in hub
> hanging. A USB reset gets it going again until we repeat the cycle
> over again. The comment in this code says "The TT's in some hubs
> malfunction when they receive this request following a STALL (they
> stop sending isochronous packets)". That may be what is happening.

What makes you think that?  Do you have any evidence that the hub is 
receiving a STALL?  Indeed, the commit you referenced above specifically 
mentions that when MMF is set and the PID code is IN then it is not a 
STALL.

> Removing the code that returns EPROTO for such case solves the
> problem on my machine (as in the RFC patch)

It certainly can't solve the problem for any USB-3 connections, because 
the patch doesn't touch any of the USB-3 driver code.

>  but that probably is not
> the right solution. I do not understand USB protocol well enough to
> propose a better solution. Does anyone have a better idea?

Can you collect a usbmon trace showing an example of this problem?

One possibility is to introduce a special quirk for the NEC uPD72010x 
EHCI controller.  But we should hold off on that until we know exactly 
what is happening.

Alan Stern
