Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4B7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03E12076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgCXP4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:56:09 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39253 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727133AbgCXP4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:56:09 -0400
Received: (qmail 22461 invoked by uid 500); 24 Mar 2020 11:56:08 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Mar 2020 11:56:08 -0400
Date:   Tue, 24 Mar 2020 11:56:08 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Qais Yousef <qais.yousef@arm.com>
cc:     Oliver Neukum <oneukum@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <20200324140609.gqvjgxdbcm5ndhvo@e107158-lin>
Message-ID: <Pine.LNX.4.44L0.2003241137440.16735-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Qais Yousef wrote:

> On 03/24/20 09:52, Alan Stern wrote:
> > On Tue, 24 Mar 2020, Qais Yousef wrote:
> > 
> > > On 03/24/20 14:20, Oliver Neukum wrote:
> > > > Am Dienstag, den 24.03.2020, 10:46 +0000 schrieb Qais Yousef:
> > > > > 
> > > > > I should have stuck to what I know then. I misread the documentation. Hopefully
> > > > > the attached looks better. I don't see the new debug you added emitted.
> > > > 
> > > > That is odd. Please try
> > > > 
> > > > echo "module usbcore +mfp" > /sys/kernel/debug/dynamic_debug/control
> > > > 
> > > > with the attached improved patch.
> > > 
> > > Hmm still no luck
> > > 
> > > 
> > > # history
> > >    0 echo "module usbcore +mfp" > /sys/kernel/debug/dynamic_debug/control
> > >    1 swapoff -a
> > >    2 echo suspend > /sys/power/disk
> > >    3 echo disk > /sys/power/state
> > >    4 dmesg > usb.dmesg
> > 
> > What happens if you omit step 1 (the swapoff)?
> 
> It seems to hibernate (suspend) successfully. If I omit that step I must setup
> a wakealarm to trigger the wakeup, but that's it.

You don't have any other wakeup sources?  Like a power button?

> I attached the dmesg; I didn't reboot the system in between.
> 
> 
> # history
>    0 echo "module usbcore +mfp" > /sys/kernel/debug/dynamic_debug/control
>    1 swapoff -a
>    2 echo suspend > /sys/power/disk
>    3 echo disk > /sys/power/state
>    4 dmesg > usb.dmesg
>    5 history
>    6 grep URB /sys/kernel/debug/dynamic_debug/control
>    7 grep "URB allocated" /sys/kernel/debug/dynamic_debug/control
>    8 swapon -a
>    9 echo +60 > /sys/class/rtc/rtc0/wakealarm
>   10 echo disk > /sys/power/state
>   11 dmesg > usb.dmesg

This certainly reinforces the initial impression that the cause of the
warnings is a bug in the platform code.  You should ask the appropriate
maintainer.

However, an equally troubling question is why the usb2 bus never got 
suspended in the first place.  To solve that, you may need to enable 
dynamic debugging in the Power Management core (i.e., "file
drivers/base/power/* +p").

Alan Stern

