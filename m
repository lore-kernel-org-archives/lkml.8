Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4948C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A699B22BF5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbgGTUCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:02:44 -0400
Received: from netrider.rowland.org ([192.131.102.5]:53175 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729358AbgGTUCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:02:44 -0400
Received: (qmail 1245347 invoked by uid 1000); 20 Jul 2020 16:02:43 -0400
Date:   Mon, 20 Jul 2020 16:02:43 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: kworker/0:3+pm hogging CPU
Message-ID: <20200720200243.GA1244989@rowland.harvard.edu>
References: <20200720083956.GA4074@dhcp22.suse.cz>
 <20200720135857.GB1228057@rowland.harvard.edu>
 <20200720143213.GJ4074@dhcp22.suse.cz>
 <20200720151255.GE1228057@rowland.harvard.edu>
 <20200720163355.GA4061@dhcp22.suse.cz>
 <20200720173807.GJ1228057@rowland.harvard.edu>
 <20200720174530.GB4061@dhcp22.suse.cz>
 <20200720174812.GK1228057@rowland.harvard.edu>
 <20200720181605.GC4061@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720181605.GC4061@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 08:16:05PM +0200, Michal Hocko wrote:
> On Mon 20-07-20 13:48:12, Alan Stern wrote:
> > On Mon, Jul 20, 2020 at 07:45:30PM +0200, Michal Hocko wrote:
> > > On Mon 20-07-20 13:38:07, Alan Stern wrote:
> > > > On Mon, Jul 20, 2020 at 06:33:55PM +0200, Michal Hocko wrote:
> > > > > On Mon 20-07-20 11:12:55, Alan Stern wrote:
> > > > > [...]
> > > > > > 	sudo echo 'module usbcore =p' >/debug/dynamic_debug/control
> > > > > > 
> > > > > > Then wait long enough for some interesting messages to appear in the 
> > > > > > kernel log (it should only take a few seconds if the worker thread is as 
> > > > > > busy as you say) and collect the output from the dmesg command.
> > > > > > 
> > > > > > To turn dynamic debugging back off when you're finished, use the same 
> > > > > > command with "=p" changed to "-p".
> > > > > 
> > > > > [   95.395815] hub 2-0:1.0: state 7 ports 6 chg 0006 evt 0000
> > > > > [   95.395824] usb usb2-port1: status 0088, change 0000, 5.0 Gb/s
> > > > > [   95.395838] usb usb2-port2: status 0088, change 0000, 5.0 Gb/s
> > > > > [   95.396016] hub 2-0:1.0: hub_suspend
> > > > > [   95.396023] usb usb2: bus auto-suspend, wakeup 1
> > > > > [   95.396029] usb usb2: bus suspend fail, err -16
> > > > 
> > > > Okay, that's the problem.  You may get more specific information about 
> > > > the suspend failure if you turn on dynamic debugging for the xhci-hcd 
> > > > module (same command as above but with xhci-hcd instead of usbcore).
> > > 
> > > Would that help to pinpoint the problem down?
> > 
> > It might.  I can't say for sure without seeing the output.
> 
> echo 'module xhci-hcd =p' >/sys/kernel/debug/dynamic_debug/control
> 
> doesn't yield to any output. I have tried both with and without usbcore
> debug output enabled. In the former there is no new output and for the
> later I get the same I have posted earlier.

Sorry, my mistake.  The module name needs to be "xhci_hcd" with an '_' 
character, not a '-' character -- the same as what shows up in the lsmod 
output.

You could also try collect a usbmon trace from the .../2u file.  It does 
seem that bus 2 is where the problem occurs.

Alan Stern
