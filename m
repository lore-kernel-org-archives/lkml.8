Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780CFC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 14:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1682070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 14:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgDZOcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 10:32:00 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49747 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725876AbgDZOb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 10:31:59 -0400
Received: (qmail 16225 invoked by uid 500); 26 Apr 2020 10:31:58 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Apr 2020 10:31:58 -0400
Date:   Sun, 26 Apr 2020 10:31:58 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
cc:     gregkh@linuxfoundation.org, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mausb-host-devel@displaylink.com>
Subject: Re: [PATCH v5 5/8] usb: mausb_host: Introduce PAL processing
In-Reply-To: <48e45671-1f07-c994-8083-04199822c818@displaylink.com>
Message-ID: <Pine.LNX.4.44L0.2004261025550.15458-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Apr 2020, Vladimir Stankovic wrote:

> On 26.4.20. 02:32, Alan Stern wrote:
> > On Sat, 25 Apr 2020 vladimir.stankovic@displaylink.com wrote:
> > 
> >> Protocol adaptation layer (PAL) implementation has been added to
> >> introduce MA-USB structures and logic.
> >>
> >> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
> > 
> > ...
> > 
> >> +	/*
> >> +	 * Masking URB_SHORT_NOT_OK flag as SCSI driver is adding it where it
> >> +	 * should not, so it is breaking the USB drive on the linux
> >> +	 */
> >> +	urb->transfer_flags &= ~URB_SHORT_NOT_OK;
> > 
> > Removing the SHORT_NOT_OK flag is _not_ a valid thing to do.  It will 
> > cause drivers to malfunction.
> > 
> > Can you please explain this comment?
> > 
> > 	What SCSI driver?
> > 
> > 	When is the flag being added?
> > 
> > 	How does it break USB drives?
> > 
> > 	Why haven't you already reported this problem to the 
> > 	appropriate maintainers?
> > 
> > Alan Stern
> > 
> 
> Hi,
> 
> Issue that removal of SHORT_NOT_OK flag addressed is linked to particular
> set of Kingston USB 3.0 flash drives (super speed) - other USB flash drives
> haven't had this flag set. Without this "fix", those Kingston flash drives
> are not being enumerated properly.

Please explain in detail how the enumeration of these Kingston flash
drives fails.  Or if such an explanation has already been posted,
please provide a link to it.

> This particular line was added in the early stage of development, during
> enumeration process implementation. The reason why it remained in the code
> since is because we haven't noticed any side-effects, even with various
> USB devices being attached to remote MA-USB device, including flash drives,
> cameras, wireless mice, etc.

Come to think of it, the SHORT_NOT_OK flag is mainly used with HCDs
that don't have scatter-gather support.  Since your mausb driver does
support scatter-gather, you most likely won't encounter any problems 
unless you go looking for them specifically.

> The problem has been reported, and is actively being investigated.

Where was the problem reported (URL to a mailing list archive)?  Who is
investigating it?

> As soon as it gets addressed properly (w/o global negation of the flag),
> a new patch will be pushed.

Thank you.

Alan Stern

