Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EABC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 20:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563DE2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 20:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgDZU4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 16:56:43 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36453 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726177AbgDZU4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 16:56:43 -0400
Received: (qmail 2181 invoked by uid 500); 26 Apr 2020 16:56:41 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Apr 2020 16:56:41 -0400
Date:   Sun, 26 Apr 2020 16:56:41 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
cc:     gregkh@linuxfoundation.org, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mausb-host-devel@displaylink.com>
Subject: Re: [External] Re: [PATCH v5 5/8] usb: mausb_host: Introduce PAL
 processing
In-Reply-To: <871dcf46-19f8-f152-99c0-8185832ed109@displaylink.com>
Message-ID: <Pine.LNX.4.44L0.2004261655390.1962-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Apr 2020, Vladimir Stankovic wrote:

> On 26.4.20. 16:31, Alan Stern wrote:
> > On Sun, 26 Apr 2020, Vladimir Stankovic wrote:
> > 
> >> On 26.4.20. 02:32, Alan Stern wrote:
> >>> On Sat, 25 Apr 2020 vladimir.stankovic@displaylink.com wrote:
> >>>
> >>>> Protocol adaptation layer (PAL) implementation has been added to
> >>>> introduce MA-USB structures and logic.
> >>>>
> >>>> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
> >>>
> >>> ...
> >>>
> >>>> +	/*
> >>>> +	 * Masking URB_SHORT_NOT_OK flag as SCSI driver is adding it where it
> >>>> +	 * should not, so it is breaking the USB drive on the linux
> >>>> +	 */
> >>>> +	urb->transfer_flags &= ~URB_SHORT_NOT_OK;
> >>>
> >>> Removing the SHORT_NOT_OK flag is _not_ a valid thing to do.  It will 
> >>> cause drivers to malfunction.
> >>>
> >>> Can you please explain this comment?
> >>>
> >>> 	What SCSI driver?
> >>>
> >>> 	When is the flag being added?
> >>>
> >>> 	How does it break USB drives?
> >>>
> >>> 	Why haven't you already reported this problem to the 
> >>> 	appropriate maintainers?
> >>>
> >>> Alan Stern
> >>>
> >>
> >> Hi,
> >>
> >> Issue that removal of SHORT_NOT_OK flag addressed is linked to particular
> >> set of Kingston USB 3.0 flash drives (super speed) - other USB flash drives
> >> haven't had this flag set. Without this "fix", those Kingston flash drives
> >> are not being enumerated properly.
> > 
> > Please explain in detail how the enumeration of these Kingston flash
> > drives fails.  Or if such an explanation has already been posted,
> > please provide a link to it.
> 
> Will reproduce the issue once again (w/o the fix) and run through the events.
> Issue has been noticed during early development, and addressed right away.
> > 
> >> This particular line was added in the early stage of development, during
> >> enumeration process implementation. The reason why it remained in the code
> >> since is because we haven't noticed any side-effects, even with various
> >> USB devices being attached to remote MA-USB device, including flash drives,
> >> cameras, wireless mice, etc.
> > 
> > Come to think of it, the SHORT_NOT_OK flag is mainly used with HCDs
> > that don't have scatter-gather support.  Since your mausb driver does
> > support scatter-gather, you most likely won't encounter any problems 
> > unless you go looking for them specifically.
> > 
> >> The problem has been reported, and is actively being investigated.
> > 
> > Where was the problem reported (URL to a mailing list archive)?  Who is
> > investigating it?
> 
> Ticket has been submitted to DisplayLink's internal issue-tracking system
> and is being investigated by mausb-host-devel team.

Okay.  What SCSI driver does the comment refer to?  Is it something 
internal to DisplayLink or is it part of the regular Linux kernel?

Alan Stern

