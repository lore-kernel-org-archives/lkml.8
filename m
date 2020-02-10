Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD71C3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C312070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJVLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:11:12 -0500
Received: from netrider.rowland.org ([192.131.102.5]:36421 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727056AbgBJVLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:11:11 -0500
Received: (qmail 15433 invoked by uid 500); 10 Feb 2020 16:11:10 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Feb 2020 16:11:10 -0500
Date:   Mon, 10 Feb 2020 16:11:10 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        syzbot <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>,
        <andreyknvl@google.com>, <ingrassia@epigenesys.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] usb: core: urb: change a dev_WARN() to dev_err() for
 syzbot
In-Reply-To: <20200210190419.GC1058087@kroah.com>
Message-ID: <Pine.LNX.4.44L0.2002101609090.13988-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020, Greg KH wrote:

> On Fri, Jan 31, 2020 at 08:06:52AM +0300, Dan Carpenter wrote:
> > We changed this from dev_err() to dev_WARN() in commit 0cb54a3e47cb
> > ("USB: debugging code shouldn't alter control flow").
> > 
> > The difference between dev_WARN() and dev_err() is that dev_WARN()
> > prints a stack trace and if you have panic on OOPS enabled then it leads
> > to a panic.  The dev_err() function just prints the error message.
> > 
> > Back in the day we didn't have usb emulators fuzz testing the kernel
> > so dev_WARN() didn't cause a problem for anyone, but these days the
> > dev_WARN() interferes with syzbot so let's change this to a dev_err().
> > 
> > Reported-by: syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > 
> >  drivers/usb/core/urb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> > index da923ec17612..0980c1d2253d 100644
> > --- a/drivers/usb/core/urb.c
> > +++ b/drivers/usb/core/urb.c
> > @@ -475,7 +475,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
> >  
> >  	/* Check that the pipe's type matches the endpoint's type */
> >  	if (usb_urb_ep_type_check(urb))
> > -		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
> > +		dev_err(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
> >  			usb_pipetype(urb->pipe), pipetypes[xfertype]);
> 
> Like others said, we should have the stack trace here.  So can you
> change this to dev_warn() and a stacktrace?

In fact we want both a stack trace and a syzbot notification, because 
this particular error indicates a bug in a kernel driver.  Therefore 
dev_WARN is appropriate.

Alan Stern

> thanks,
> 
> greg k-h

