Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748C6C54FCF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5072073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgCXNrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:47:43 -0400
Received: from netrider.rowland.org ([192.131.102.5]:55753 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728220AbgCXNrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:47:42 -0400
Received: (qmail 8027 invoked by uid 500); 24 Mar 2020 09:47:40 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Mar 2020 09:47:40 -0400
Date:   Tue, 24 Mar 2020 09:47:40 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Qais Yousef <qais.yousef@arm.com>
cc:     Oliver Neukum <oneukum@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <20200324104610.pqdtaocg6qctlnqv@e107158-lin>
Message-ID: <Pine.LNX.4.44L0.2003240937410.4640-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Qais Yousef wrote:

> I should have stuck to what I know then. I misread the documentation. Hopefully
> the attached looks better. I don't see the new debug you added emitted.

These lines:

[  158.113836] ohci_hcd:ohci_resume: ohci-platform 7ffb0000.ohci: powerup ports
[  158.139682] usbcore:hcd_bus_resume: usb usb2: usb resume
[  158.139715] ohci_hcd:ohci_rh_resume: ohci-platform 7ffb0000.ohci: resume root hub
...
[  158.219604] usbcore:hub_resume: hub 2-0:1.0: hub_resume
[  158.220482] usb usb2: runtime PM trying to activate child device usb2 but parent (7ffb0000.ohci) is not active

suggest there is a bug in the platform code.  The 7ffb0000.ohci 
platform device should already be resumed and active at this point.

Following that, this is suspicious:

[  158.482995] PM: Cannot find swap device, try swapon -a
[  158.488379] PM: Cannot get swap writer

Since there was never any device attached to the OHCI controller, this
error is not connected to the previous one.  In fact, the swap device
was plugged into the EHCI controller; it was 1-1.1.  But the log
doesn't contain anything about that device being suspended, resumed, or
disconnected.  What happened to it?

[  159.064094] OOM killer enabled.
[  159.067351] Restarting tasks ... 
[  159.068831] usbcore:hub_event: hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0000
[  159.079921] usbcore:hub_event: hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0000
[  159.079959] usbcore:hub_event: hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
[  159.090776] done.
[  159.097076] usbcore:hub_resume: hub 2-0:1.0: hub_resume
[  159.102961] ------------[ cut here ]------------
[  159.107805] URB (____ptrval____) submitted while active

And why was usb2 resumed twice in a row with intervening suspend?

Alan Stern

