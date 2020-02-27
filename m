Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E18C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8C324691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgB0T3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:29:35 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:37258 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729687AbgB0T3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:29:35 -0500
Received: (qmail 1906 invoked by uid 2102); 27 Feb 2020 14:29:34 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2020 14:29:34 -0500
Date:   Thu, 27 Feb 2020 14:29:34 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Marco Felsch <m.felsch@pengutronix.de>
cc:     gregkh@linuxfoundation.org, <Thinh.Nguyen@synopsys.com>,
        <harry.pan@intel.com>, <nobuta.keiya@fujitsu.com>,
        <malat@debian.org>, <kai.heng.feng@canonical.com>,
        <chiasheng.lee@intel.com>, <andreyknvl@google.com>,
        <heinzelmann.david@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [RFC PATCH v2] USB: hub: fix port suspend/resume
In-Reply-To: <20200227164142.dsnbrxtk747tnvma@pengutronix.de>
Message-ID: <Pine.LNX.4.44L0.2002271353300.1307-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020, Marco Felsch wrote:

> On 20-02-27 11:18, Alan Stern wrote:

> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > > Hi,
> > > 
> > > this v2 contains the fixes
> > > 
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > Everything below the "---" line, except the patch itself, gets ignored.  
> > You need to move this Reported-by: up higher.
> 
> I know, I put it here because the patch isn't part of the kernel. IMHO a
> 
> Signed-off-by:
> Reported-by: 
> 
> looks a bit strange.

Not at all.  That sort of thing occurs all the time; just look at a few 
commits in the kernel or patches on the mailing lists.  Especially ones 
that are bug fixes.

> > > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > > index 3405b146edc9..c294484e478d 100644
> > > --- a/drivers/usb/core/hub.c
> > > +++ b/drivers/usb/core/hub.c
> > > @@ -3323,10 +3323,6 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
> > >  		usb_set_device_state(udev, USB_STATE_SUSPENDED);
> > >  	}
> > >  
> > > -	if (status == 0 && !udev->do_remote_wakeup && udev->persist_enabled
> > > -			&& test_and_clear_bit(port1, hub->child_usage_bits))
> > > -		pm_runtime_put_sync(&port_dev->dev);
> > > -
> > >  	usb_mark_last_busy(hub->hdev);
> > >  
> > >  	usb_unlock_port(port_dev);
> > > @@ -3514,15 +3510,6 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
> > >  	int		status;
> > >  	u16		portchange, portstatus;
> > >  
> > > -	if (!test_and_set_bit(port1, hub->child_usage_bits)) {
> > > -		status = pm_runtime_get_sync(&port_dev->dev);
> > > -		if (status < 0) {
> > > -			dev_dbg(&udev->dev, "can't resume usb port, status %d\n",
> > > -					status);
> > > -			return status;
> > > -		}
> > > -	}
> > > -
> > 
> > Why do you get rid of these two sections of code?  Won't that cause
> > runtime PM to stop working properly?
> 
> Both runtime_pm calls are part of the suspend/resume logic so this code
> isn't called during runtime PM.

I'm not quite sure what you mean by that.  In any case, it would be 
completely wrong to think that usb_port_suspend isn't involved in 
runtime PM.

In fact, usb_port_suspend is _more_ important for runtime suspend than
for system sleep.  The reason is simple: If you want to put a USB
device into runtime suspend, you have to tell its upstream hub's port
to enable the suspend feature (i.e., call usb_port_suspend).  But if
you want to put an entire bus of USB devices to sleep for a system
suspend, all you have to do is tell the host controller to stop sending
packets; the ports don't need any notification.

(Actually the situation is more complicated for USB 3.  But you get the 
idea.)

> As far as I understood it correctly the
> purpose of those section was to trigger port poweroff if the device
> supports it upon a system-suspend.

No, the purpose of the sections you removed is to trigger port poweroff
when the device goes into any type of suspend, either system or
runtime.  Of course, as you discovered, during system sleep the code
doesn't actually turn off the port power -- that's a bug.  But during
runtime PM it does.

> Therefore I came up with my question:
> https://www.spinics.net/lists/linux-usb/msg190537.html.

> > Also, try to find better names.  Maybe usb_port_sleep and 
> > usb_port_wake, or usb_port_system_suspend and usb_port_system_resume.
> 
> IMHO usb_port_suspend/resume should be the best ;)

Okay, so long as they are static and won't conflict with the functions 
in hub.c.

Alan Stern

PS: There's one more thing you need to know -- I completely forgot 
about it until just now.  During system sleep, we have to make sure 
that the child device gets suspended _before_ and resumed _after_ the 
port.  If it happened the other way, we'd be in trouble.

(The proper ordering would be automatic if the child USB device was
registered under the port device, but for historical reasons it isn't;
it gets registered directly under the parent hub.)

This means you'll have to call device_pm_wait_for_dev() at the 
appropriate places in the suspend and resume pathways.

