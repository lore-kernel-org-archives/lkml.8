Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2693BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7B9206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgGUOd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:33:27 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39041 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726522AbgGUOd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:33:27 -0400
Received: (qmail 1274749 invoked by uid 1000); 21 Jul 2020 10:33:25 -0400
Date:   Tue, 21 Jul 2020 10:33:25 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: kworker/0:3+pm hogging CPU
Message-ID: <20200721143325.GB1272082@rowland.harvard.edu>
References: <20200720135857.GB1228057@rowland.harvard.edu>
 <20200720143213.GJ4074@dhcp22.suse.cz>
 <20200720151255.GE1228057@rowland.harvard.edu>
 <20200720163355.GA4061@dhcp22.suse.cz>
 <20200720173807.GJ1228057@rowland.harvard.edu>
 <20200720174530.GB4061@dhcp22.suse.cz>
 <20200720174812.GK1228057@rowland.harvard.edu>
 <20200720181605.GC4061@dhcp22.suse.cz>
 <20200720200243.GA1244989@rowland.harvard.edu>
 <20200721055917.GD4061@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721055917.GD4061@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 07:59:17AM +0200, Michal Hocko wrote:
> > Sorry, my mistake.  The module name needs to be "xhci_hcd" with an '_' 
> > character, not a '-' character -- the same as what shows up in the lsmod 
> > output.
> 
> 
> [14766.973734] xhci_hcd 0000:00:14.0: Get port status 2-1 read: 0xe000088, return 0x88
> [14766.973738] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0xe000088, return 0x88
> [14766.973742] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0xe0002a0, return 0x2a0
> [14766.973746] xhci_hcd 0000:00:14.0: Get port status 2-4 read: 0xe0002a0, return 0x2a0
> [14766.973750] xhci_hcd 0000:00:14.0: Get port status 2-5 read: 0xe0002a0, return 0x2a0
> [14766.973754] xhci_hcd 0000:00:14.0: Get port status 2-6 read: 0xe0002a0, return 0x2a0
> [14766.973759] xhci_hcd 0000:00:14.0: Get port status 2-1 read: 0xe000088, return 0x88
> [14766.973763] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0xe000088, return 0x88

According to the xHCI specification, those 02a0 values are normal and 
the 0088 values indicate the port is disabled and has an over-current 
condition.  I don't know about the e000 bits in the upper part of the 
word; according to my copy of the spec those bits should be 0.

If your machine has only two physical SuperSpeed (USB-3) ports then 
perhaps the other four ports are internally wired in a way that creates 
a permanent over-current indication.

> [14766.973771] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 0 status  = 0xe000088
> [14766.973780] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 1 status  = 0xe000088
> [14766.973789] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 2 status  = 0xe0002a0
> [14766.973798] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 3 status  = 0xe0002a0
> [14766.973807] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 4 status  = 0xe0002a0
> [14766.973816] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 5 status  = 0xe0002a0
> [14766.973830] xhci_hcd 0000:00:14.0: Bus suspend bailout, port over-current detected
> 
> Repeating again and again. The last message suggests a HW problem? But
> why does the kernel try the same thing over and over?

Because over-current is supposed to be a transient condition that goes 
away quickly.  It means there's a short circuit or something similar.

> > You could also try collect a usbmon trace from the .../2u file.  It does 
> > seem that bus 2 is where the problem occurs.
> 
> a random sample

...
> ffff888040808cc0 2551256922 S Ci:2:001:0 s a3 00 0000 0001 0004 4 <
> ffff888040808cc0 2551256925 C Ci:2:001:0 0 4 = 88000000
> ffff888040808cc0 2551256927 S Ci:2:001:0 s a3 00 0000 0002 0004 4 <
> ffff888040808cc0 2551256933 S Ci:2:001:0 s a3 00 0000 0003 0004 4 <
> ffff888040808cc0 2551256936 C Ci:2:001:0 0 4 = a0020000
> ffff888040808cc0 2551256942 C Ci:2:001:0 0 4 = a0020000
...

The usbmon output has a lot of gaps, but here we can see some of the 
port status data contains 0x0088 (four bytes little-endian) and some 
contains 0x02a0 -- the same as what the debugging log says.

So yes, this looks like a hardware design error.  Turning off 
autosuspend by writing to the sysfs power/control file is probably the 
best way to handle the problem.

Alan Stern
