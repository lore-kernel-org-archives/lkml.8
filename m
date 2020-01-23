Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B574DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C9421D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAWPuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:50:06 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:54888 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726231AbgAWPuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:50:06 -0500
Received: (qmail 2710 invoked by uid 2102); 23 Jan 2020 10:50:05 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jan 2020 10:50:05 -0500
Date:   Thu, 23 Jan 2020 10:50:05 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Zimmerman <pauldzim@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [REGRESSION][BISECTED] 5.5-rc suspend/resume failure caused by
 patch a4f55d8b8c14 ("usb: hub: Check device descriptor before resusciation")
In-Reply-To: <20200122165454.757aaa25@EliteBook>
Message-ID: <Pine.LNX.4.44L0.2001231035250.1518-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020, Paul Zimmerman wrote:

> > Still, since there was no real connection change at the port, there's
> > no reason to call hub_port_connect_change() here.  Let's see if the
> > patch below fixes your problem.
> > 
> > Alan Stern
> > 
> > 
> > 
> > Index: usb-devel/drivers/usb/core/hub.c
> > ===================================================================
> > --- usb-devel.orig/drivers/usb/core/hub.c
> > +++ usb-devel/drivers/usb/core/hub.c
> > @@ -1216,11 +1216,6 @@ static void hub_activate(struct usb_hub
> >  #ifdef CONFIG_PM
> >  			udev->reset_resume = 1;
> >  #endif
> > -			/* Don't set the change_bits when the device
> > -			 * was powered off.
> > -			 */
> > -			if (test_bit(port1, hub->power_bits))
> > -				set_bit(port1, hub->change_bits);
> >  
> >  		} else {
> >  			/* The power session is gone; tell hub_wq */
> > 
> 
> I can confirm this fixes the issue for me, I did a couple dozen
> suspend/resume cycles without seeing a failure.
> 
> I see the code you removed was added by Lan Tianyu in commit
> ad493e5e5805 ("usb: add usb port auto power off mechanism"). I

No, not really.  The set_bit() call was added by me in a much earlier
commit (8808f00c7adf, merged in 2008).  Lan Tianyu merely added the
"if" test, so that set_bit() doesn't always get called.  Now with this
change, set_bit() never gets called.

> wonder if your patch would break that? I don't know what that is
> or how to test it.

While some code review by people who are familiar with this material 
wouldn't hurt, I don't think you need to worry about any additional 
testing.

> In any case:
> Tested-by: Paul Zimmerman <pauldzim@gmail.com>

Thank you.  I'll submit the patch soon.

Alan Stern

