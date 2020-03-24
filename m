Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1017C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C404520775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgCXRWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:22:40 -0400
Received: from foss.arm.com ([217.140.110.172]:38646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbgCXRWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:22:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05CD51FB;
        Tue, 24 Mar 2020 10:22:40 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C3133F71F;
        Tue, 24 Mar 2020 10:22:39 -0700 (PDT)
Date:   Tue, 24 Mar 2020 17:22:36 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Oliver Neukum <oneukum@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Message-ID: <20200324172235.bsxea6qb3id6bhb3@e107158-lin>
References: <20200324140609.gqvjgxdbcm5ndhvo@e107158-lin>
 <Pine.LNX.4.44L0.2003241137440.16735-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2003241137440.16735-100000@netrider.rowland.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24/20 11:56, Alan Stern wrote:
> On Tue, 24 Mar 2020, Qais Yousef wrote:
> 
> > On 03/24/20 09:52, Alan Stern wrote:
> > > On Tue, 24 Mar 2020, Qais Yousef wrote:
> > > 
> > > > On 03/24/20 14:20, Oliver Neukum wrote:
> > > > > Am Dienstag, den 24.03.2020, 10:46 +0000 schrieb Qais Yousef:
> > > > > > 
> > > > > > I should have stuck to what I know then. I misread the documentation. Hopefully
> > > > > > the attached looks better. I don't see the new debug you added emitted.
> > > > > 
> > > > > That is odd. Please try
> > > > > 
> > > > > echo "module usbcore +mfp" > /sys/kernel/debug/dynamic_debug/control
> > > > > 
> > > > > with the attached improved patch.
> > > > 
> > > > Hmm still no luck
> > > > 
> > > > 
> > > > # history
> > > >    0 echo "module usbcore +mfp" > /sys/kernel/debug/dynamic_debug/control
> > > >    1 swapoff -a
> > > >    2 echo suspend > /sys/power/disk
> > > >    3 echo disk > /sys/power/state
> > > >    4 dmesg > usb.dmesg
> > > 
> > > What happens if you omit step 1 (the swapoff)?
> > 
> > It seems to hibernate (suspend) successfully. If I omit that step I must setup
> > a wakealarm to trigger the wakeup, but that's it.
> 
> You don't have any other wakeup sources?  Like a power button?

Not sure if it's hooked correctly as a wakeup source. But as UK is now getting
lockedown, I don't think I'll be seeing the board for a while and serial
console is my only friend :-)

I can hard reboot remotely reliably though.

> 
> > I attached the dmesg; I didn't reboot the system in between.
> > 
> > 
> > # history
> >    0 echo "module usbcore +mfp" > /sys/kernel/debug/dynamic_debug/control
> >    1 swapoff -a
> >    2 echo suspend > /sys/power/disk
> >    3 echo disk > /sys/power/state
> >    4 dmesg > usb.dmesg
> >    5 history
> >    6 grep URB /sys/kernel/debug/dynamic_debug/control
> >    7 grep "URB allocated" /sys/kernel/debug/dynamic_debug/control
> >    8 swapon -a
> >    9 echo +60 > /sys/class/rtc/rtc0/wakealarm
> >   10 echo disk > /sys/power/state
> >   11 dmesg > usb.dmesg
> 
> This certainly reinforces the initial impression that the cause of the
> warnings is a bug in the platform code.  You should ask the appropriate
> maintainer.

The device-tree compatible node returns "generic-ohci".
drivers/usb/host/ohci-platform.c returns you as the maintainer :-)

> 
> However, an equally troubling question is why the usb2 bus never got 
> suspended in the first place.  To solve that, you may need to enable 
> dynamic debugging in the Power Management core (i.e., "file
> drivers/base/power/* +p").

Thanks Alan. I'll run with extra debug and send back.

Cheers

--
Qais Yousef
