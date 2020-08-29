Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91088C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B556207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgH2QBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:01:13 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34087 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728463AbgH2P7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:59:50 -0400
Received: (qmail 499484 invoked by uid 1000); 29 Aug 2020 11:59:49 -0400
Date:   Sat, 29 Aug 2020 11:59:49 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dirk Kostrewa <dirk.kostrewa@mailbox.org>
Subject: Re: kworker/0:3+pm hogging CPU
Message-ID: <20200829155949.GA499295@rowland.harvard.edu>
References: <20200720151255.GE1228057@rowland.harvard.edu>
 <20200720163355.GA4061@dhcp22.suse.cz>
 <20200720173807.GJ1228057@rowland.harvard.edu>
 <20200720174530.GB4061@dhcp22.suse.cz>
 <20200720174812.GK1228057@rowland.harvard.edu>
 <20200720181605.GC4061@dhcp22.suse.cz>
 <20200720200243.GA1244989@rowland.harvard.edu>
 <20200721055917.GD4061@dhcp22.suse.cz>
 <20200721143325.GB1272082@rowland.harvard.edu>
 <20200829095003.GA2446485@eldamar.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829095003.GA2446485@eldamar.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 11:50:03AM +0200, Salvatore Bonaccorso wrote:
> Hi Alan,
> 
> I'm following up on this thread because a user in Debian (Dirk, Cc'ed)
> as well encountered the same/similar issue:
> 
> On Tue, Jul 21, 2020 at 10:33:25AM -0400, Alan Stern wrote:
> > On Tue, Jul 21, 2020 at 07:59:17AM +0200, Michal Hocko wrote:
> > > > Sorry, my mistake.  The module name needs to be "xhci_hcd" with an '_' 
> > > > character, not a '-' character -- the same as what shows up in the lsmod 
> > > > output.
> > > 
> > > 
> > > [14766.973734] xhci_hcd 0000:00:14.0: Get port status 2-1 read: 0xe000088, return 0x88
> > > [14766.973738] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0xe000088, return 0x88
> > > [14766.973742] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0xe0002a0, return 0x2a0
> > > [14766.973746] xhci_hcd 0000:00:14.0: Get port status 2-4 read: 0xe0002a0, return 0x2a0
> > > [14766.973750] xhci_hcd 0000:00:14.0: Get port status 2-5 read: 0xe0002a0, return 0x2a0
> > > [14766.973754] xhci_hcd 0000:00:14.0: Get port status 2-6 read: 0xe0002a0, return 0x2a0
> > > [14766.973759] xhci_hcd 0000:00:14.0: Get port status 2-1 read: 0xe000088, return 0x88
> > > [14766.973763] xhci_hcd 0000:00:14.0: Get port status 2-2 read: 0xe000088, return 0x88
> > 
> > According to the xHCI specification, those 02a0 values are normal and 
> > the 0088 values indicate the port is disabled and has an over-current 
> > condition.  I don't know about the e000 bits in the upper part of the 
> > word; according to my copy of the spec those bits should be 0.
> > 
> > If your machine has only two physical SuperSpeed (USB-3) ports then 
> > perhaps the other four ports are internally wired in a way that creates 
> > a permanent over-current indication.
> > 
> > > [14766.973771] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 0 status  = 0xe000088
> > > [14766.973780] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 1 status  = 0xe000088
> > > [14766.973789] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 2 status  = 0xe0002a0
> > > [14766.973798] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 3 status  = 0xe0002a0
> > > [14766.973807] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 4 status  = 0xe0002a0
> > > [14766.973816] xhci_hcd 0000:00:14.0: set port remote wake mask, actual port 5 status  = 0xe0002a0
> > > [14766.973830] xhci_hcd 0000:00:14.0: Bus suspend bailout, port over-current detected
> > > 
> > > Repeating again and again. The last message suggests a HW problem? But
> > > why does the kernel try the same thing over and over?
> > 
> > Because over-current is supposed to be a transient condition that goes 
> > away quickly.  It means there's a short circuit or something similar.
> 
> Dirk exprienced the same issue aand enabled dynamic debugging showed
> similar pattern. His dmesg excerpt is attached.
> 
> The Debian report is at https://bugs.debian.org/966703
> 
> What could be tracked down is that the issue is uncovered since
> e9fb08d617bf ("xhci: prevent bus suspend if a roothub port detected a
> over-current condition") which was applied in 5.7-rc3 and backported
> to several stable releases (v5.6.8, v5.4.36 and v4.19.119).
> 
> Dirk found additionally:
> 
> > I just found out, that if none of the two USB ports is connected, there
> > are two kworker processes with permanently high CPU load, if one USB
> > port is connected and the other not, there is one such kworker process,
> > and if both USB ports are connected, there is no kworker process with
> > high CPU load.
> > I think, this supports your suspicion that these kworker processes are
> > connected with the overcurrent condition for both USB ports that I also
> > see in the dmesg output.
> 
> Reverting the above commit covers the problem again. But I'm not
> exprienced enough here to claim if this is a HW issue or if the Kernel
> should handle the situation otherwise. Is there anything else Dirk can
> provide?

It is undoubtedly a hardware issue.  The dmesg extract shows that ports 
1-10, 1-11, and 2-5 (which is probably the same port as one of the 
others) have overcurrent conditions; I'm guessing that these are the 
ports which have external connections.

What were the devices Dirk plugged in that got rid of the kworker 
processes?  In particular, were they USB-2 or USB-3?  (The dmesg log for 
when the devices were first attached can answer these questions.)

As far as I know, there is no way for the kernel to work around this 
problem.  Preventing the controller from going into runtime suspend is 
probably the best solution.

Perhaps Mathias (the xhci-hcd maintainer) will have more suggestions.

Alan Stern
