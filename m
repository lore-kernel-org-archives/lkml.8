Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C665C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09F72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581371408;
	bh=owHQZja7WYcROTLPbbAABiKavRBsJY96RmXIGENBBaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Si7JsonBCFTGz6tdacrim/betKxscuerSqbc8XM40HWhk2Gxrt5aO5Kn0u45WJtmy
	 0yadWmG1LLgX679d6TQ9H92ZQH3DvJNQDd6GFcK+mb2oLWwRQcI4o5jKmb0X+m8tEP
	 aHDXNeUwK4XIsvDUdZBCwv0MjLkvKhiXS4IKWoYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJVuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgBJVuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:50:07 -0500
Received: from localhost (unknown [104.132.1.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6056020733;
        Mon, 10 Feb 2020 21:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581371407;
        bh=owHQZja7WYcROTLPbbAABiKavRBsJY96RmXIGENBBaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B7Wac62SNF21DMh+x9ak6ktlFN0yWHiJbqfEd4lRpQgU7LZltpBDjLigWkJLrOfba
         NII3D0tMB61y5IN8DmC2otgWr2kRwfm7SR8CJhHq1MUiNWy9qTIRtSRANsLVWGuwgC
         c2RMttje9d/oaf94qCQAbhcXJNFODd9KUXbMlbw8=
Date:   Mon, 10 Feb 2020 13:50:06 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        syzbot <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>,
        andreyknvl@google.com, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] usb: core: urb: change a dev_WARN() to dev_err() for
 syzbot
Message-ID: <20200210215006.GA1628323@kroah.com>
References: <20200210190419.GC1058087@kroah.com>
 <Pine.LNX.4.44L0.2002101609090.13988-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002101609090.13988-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:11:10PM -0500, Alan Stern wrote:
> On Mon, 10 Feb 2020, Greg KH wrote:
> 
> > On Fri, Jan 31, 2020 at 08:06:52AM +0300, Dan Carpenter wrote:
> > > We changed this from dev_err() to dev_WARN() in commit 0cb54a3e47cb
> > > ("USB: debugging code shouldn't alter control flow").
> > > 
> > > The difference between dev_WARN() and dev_err() is that dev_WARN()
> > > prints a stack trace and if you have panic on OOPS enabled then it leads
> > > to a panic.  The dev_err() function just prints the error message.
> > > 
> > > Back in the day we didn't have usb emulators fuzz testing the kernel
> > > so dev_WARN() didn't cause a problem for anyone, but these days the
> > > dev_WARN() interferes with syzbot so let's change this to a dev_err().
> > > 
> > > Reported-by: syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > > 
> > >  drivers/usb/core/urb.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> > > index da923ec17612..0980c1d2253d 100644
> > > --- a/drivers/usb/core/urb.c
> > > +++ b/drivers/usb/core/urb.c
> > > @@ -475,7 +475,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
> > >  
> > >  	/* Check that the pipe's type matches the endpoint's type */
> > >  	if (usb_urb_ep_type_check(urb))
> > > -		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
> > > +		dev_err(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
> > >  			usb_pipetype(urb->pipe), pipetypes[xfertype]);
> > 
> > Like others said, we should have the stack trace here.  So can you
> > change this to dev_warn() and a stacktrace?
> 
> In fact we want both a stack trace and a syzbot notification, because 
> this particular error indicates a bug in a kernel driver.  Therefore 
> dev_WARN is appropriate.

Ok, nevermind, you are right we should fix up the driver if that
happens.

greg k-h
