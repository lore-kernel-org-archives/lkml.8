Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FFEC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AAC20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgCWPzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:55:02 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59865 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727267AbgCWPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:55:00 -0400
Received: (qmail 27965 invoked by uid 500); 23 Mar 2020 11:54:59 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Mar 2020 11:54:59 -0400
Date:   Mon, 23 Mar 2020 11:54:59 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Oliver Neukum <oneukum@suse.de>
cc:     Qais Yousef <qais.yousef@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <1584977769.27949.18.camel@suse.de>
Message-ID: <Pine.LNX.4.44L0.2003231151390.24254-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Mar 2020, Oliver Neukum wrote:

> Am Montag, den 23.03.2020, 14:38 +0000 schrieb Qais Yousef:
> > Hi
> > 
> > I've hit the following lockdep warning when I trigger hibernate on arm64
> > platform (Juno-r2)
> > 
> > 
> > 	echo suspend > /sys/power/disk
> > 	echo disk > /sys/power/state
> > 
> > I only had a usb flash drive attached to it. Let me know if you need more info.
> 
> Hi,
> 
> that is not a lockdep issue, but the hub driver is not properly killing
> its URB presumably. Yet, the driver looks correct to me. Please use
> the additional patch and activate dynamic debugging for usbcore.

Was the USB flash drive being used as a swap device for holding the 
hibernation image?  That's not likely to work very well.  At least, I 
doubt that it has been tested very much.

This diagnostic was suggested by the runtime PM error that occurred 
when the system was trying to store the hibernation image.  That's 
probably when the hub driver's URB got restarted.

Alan Stern

