Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BDEC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE102469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgB0Qly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:41:54 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51945 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgB0Qlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:41:53 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1j7MEM-0005Cg-1u; Thu, 27 Feb 2020 17:41:46 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1j7MEI-0005z9-Df; Thu, 27 Feb 2020 17:41:42 +0100
Date:   Thu, 27 Feb 2020 17:41:42 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        harry.pan@intel.com, nobuta.keiya@fujitsu.com, malat@debian.org,
        kai.heng.feng@canonical.com, chiasheng.lee@intel.com,
        andreyknvl@google.com, heinzelmann.david@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, kbuild test robot <lkp@intel.com>
Subject: Re: [RFC PATCH v2] USB: hub: fix port suspend/resume
Message-ID: <20200227164142.dsnbrxtk747tnvma@pengutronix.de>
References: <20200227135631.13983-1-m.felsch@pengutronix.de>
 <Pine.LNX.4.44L0.2002271100000.1730-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002271100000.1730-100000@iolanthe.rowland.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:25:52 up 104 days,  7:44, 121 users,  load average: 0.09, 0.08,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-27 11:18, Alan Stern wrote:
> On Thu, 27 Feb 2020, Marco Felsch wrote:
> 
> > At the momemnt the usb-port driver has only runime_pm hooks.
> > Suspending the port and turn off the VBUS supply should be triggered by
> > the hub device suspend callback usb_port_suspend() which calls the
> 
> Strictly speaking it's just a routine, not a callback.  That is, it 
> doesn't get invoked through a function pointer.

Damn, you right it gets called from the generic_suspend callback.

> > pm_runtime_put_sync() if all pre-conditions are meet. This mechanism
> > don't work correctly due to the global PM behaviour, for more information
> > see [1]. According [1] I added the suspend/resume callbacks for the port
> > device to fix this.
> > 
> > [1] https://www.spinics.net/lists/linux-usb/msg190537.html
> 
> Please put at least a short description of the problem here; don't 
> force people to go look up some random web page just to find out what's 
> really going on.

Okay, I will do that.

> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > Hi,
> > 
> > this v2 contains the fixes
> > 
> > Reported-by: kbuild test robot <lkp@intel.com>
> 
> Everything below the "---" line, except the patch itself, gets ignored.  
> You need to move this Reported-by: up higher.

I know, I put it here because the patch isn't part of the kernel. IMHO a

Signed-off-by:
Reported-by: 

looks a bit strange.

> > Regards,
> >   Marco
> > 
> > Changes:
> > - init retval to zero
> > - keep CONFIG_PM due to do_remote_wakeup availability
> > - adapt commit message
> > 
> >  drivers/usb/core/hub.c  | 13 -------------
> >  drivers/usb/core/port.c | 35 ++++++++++++++++++++++++++++++-----
> >  2 files changed, 30 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 3405b146edc9..c294484e478d 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -3323,10 +3323,6 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
> >  		usb_set_device_state(udev, USB_STATE_SUSPENDED);
> >  	}
> >  
> > -	if (status == 0 && !udev->do_remote_wakeup && udev->persist_enabled
> > -			&& test_and_clear_bit(port1, hub->child_usage_bits))
> > -		pm_runtime_put_sync(&port_dev->dev);
> > -
> >  	usb_mark_last_busy(hub->hdev);
> >  
> >  	usb_unlock_port(port_dev);
> > @@ -3514,15 +3510,6 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
> >  	int		status;
> >  	u16		portchange, portstatus;
> >  
> > -	if (!test_and_set_bit(port1, hub->child_usage_bits)) {
> > -		status = pm_runtime_get_sync(&port_dev->dev);
> > -		if (status < 0) {
> > -			dev_dbg(&udev->dev, "can't resume usb port, status %d\n",
> > -					status);
> > -			return status;
> > -		}
> > -	}
> > -
> 
> Why do you get rid of these two sections of code?  Won't that cause
> runtime PM to stop working properly?

Both runtime_pm calls are part of the suspend/resume logic so this code
isn't called during runtime PM. As far as I understood it correctly the
purpose of those section was to trigger port poweroff if the device
supports it upon a system-suspend. Therefore I came up with my question:
https://www.spinics.net/lists/linux-usb/msg190537.html.

> >  	usb_lock_port(port_dev);
> >  
> >  	/* Skip the initial Clear-Suspend step for a remote wakeup */
> > diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> > index bbbb35fa639f..13f130b67efe 100644
> > --- a/drivers/usb/core/port.c
> > +++ b/drivers/usb/core/port.c
> > @@ -283,7 +283,34 @@ static int usb_port_runtime_suspend(struct device *dev)
> >  
> >  	return retval;
> >  }
> > -#endif
> > +
> > +static int __maybe_unused _usb_port_suspend(struct device *dev)
> 
> Don't say _maybe_unused.  Instead, protect these two routines with 
> #ifdef CONFIG_PM_SLEEP.  That way they won't be compiled on systems 
> that can't use them.

Okay, as you like. I find the __maybe_unused better than #ifdefs.

> Also, try to find better names.  Maybe usb_port_sleep and 
> usb_port_wake, or usb_port_system_suspend and usb_port_system_resume.

IMHO usb_port_suspend/resume should be the best ;)

> > +{
> > +	struct usb_port *port_dev = to_usb_port(dev);
> > +	struct usb_device *udev = port_dev->child;
> > +	int retval = 0;
> > +
> > +	if (!udev->do_remote_wakeup && udev->persist_enabled)
> > +		retval = usb_port_runtime_suspend(dev);
> > +
> > +	/* Do not force the user to enable the power-off feature */
> > +	if (retval && retval != -EAGAIN)
> > +		return retval;
> > +
> > +	return 0;
> 
> IMO it would be a lot more understandable if you wrote
> 
> 	if (retval == -EAGAIN)
> 		retval = 0;

As you like.

> Also, the relation between this code and the preceding comment is not
> obvious.  The comment should say something more like: If the
> PM_QOS_FLAG setting prevents us from powering off the port, it's not an
> error.

Okay I will change that.

Regards,
  Marco

> Alan Stern
> 
> > +}
> > +
> > +static int __maybe_unused _usb_port_resume(struct device *dev)
> > +{
> > +	struct usb_port *port_dev = to_usb_port(dev);
> > +	struct usb_device *udev = port_dev->child;
> > +
> > +	if (!udev->do_remote_wakeup && udev->persist_enabled)
> > +		return usb_port_runtime_resume(dev);
> > +
> > +	return 0;
> > +}
> > +#endif /* CONFIG_PM */
> >  
> >  static void usb_port_shutdown(struct device *dev)
> >  {
> > @@ -294,10 +321,8 @@ static void usb_port_shutdown(struct device *dev)
> >  }
> >  
> >  static const struct dev_pm_ops usb_port_pm_ops = {
> > -#ifdef CONFIG_PM
> > -	.runtime_suspend =	usb_port_runtime_suspend,
> > -	.runtime_resume =	usb_port_runtime_resume,
> > -#endif
> > +	SET_SYSTEM_SLEEP_PM_OPS(_usb_port_suspend, _usb_port_resume)
> > +	SET_RUNTIME_PM_OPS(usb_port_runtime_suspend, usb_port_runtime_resume, NULL)
> >  };
> >  
> >  struct device_type usb_port_device_type = {
> > 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
