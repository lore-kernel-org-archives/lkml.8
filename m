Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F76C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFC92074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgCXTWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:22:25 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46377 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725900AbgCXTWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:22:25 -0400
Received: (qmail 12890 invoked by uid 500); 24 Mar 2020 15:22:24 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Mar 2020 15:22:24 -0400
Date:   Tue, 24 Mar 2020 15:22:24 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Qais Yousef <qais.yousef@arm.com>
cc:     Oliver Neukum <oneukum@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <20200324172235.bsxea6qb3id6bhb3@e107158-lin>
Message-ID: <Pine.LNX.4.44L0.2003241445210.8484-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Qais Yousef wrote:

> On 03/24/20 11:56, Alan Stern wrote:

> > This certainly reinforces the initial impression that the cause of the
> > warnings is a bug in the platform code.  You should ask the appropriate
> > maintainer.
> 
> The device-tree compatible node returns "generic-ohci".
> drivers/usb/host/ohci-platform.c returns you as the maintainer :-)

I'm the maintainer of the driver for the device.  But the device
structure itself (the one named 7ffb0000.ohci) gets created by 
device-tree -- that's what I was referring to.

Here's the first error message:

usb usb2: runtime PM trying to activate child device usb2 but parent (7ffb0000.ohci) is not active

The runtime PM status of 7ffb0000.ohci is set in ohci_platform_probe(),
which does:

        pm_runtime_set_active(&dev->dev);

The runtime PM status can change, and there aren't any debugging 
statements in ohci_platform_suspend() or ohci_platform_resume() (or 
ohci_suspend()/ohci_resume() in ohci-hcd.c, for that matter).  Maybe 
you can add some so we can see if anything strange is going on.

Any maybe you can find out exactly where that error message is coming 
from by calling dump_stack() immediately after the dev_err() line 
(approximately line 1198 in drivers/base/power/runtime.c).

(Also, you might want to turn off rcutorture.  It adds a lot of 
messages to the system log that are irrelevant for our purposes.)

Alan Stern

