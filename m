Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDBDC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804C6207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599496255;
	bh=+hBkQu9s4/gMzHCxciSjjnQi2QtLKwBklfRKGdDcWQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KhjYlbbOjRFnk5X+7pVmRij6VxFPK5dzgQeYtOvi8pecKAAW5cJWEHPAFIhJiAzsG
	 In42CXAWr4QxTGkrMNgB1LHyK+XBI0ZlRvzafbnfS5ruW+RP0qEzedHgj9JypQe61J
	 b3SyyNkYpyZeZs9m0VH2H2Xtx7l9keQbOMjWBPxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgIGQaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729842AbgIGOZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:25:29 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F2292064B;
        Mon,  7 Sep 2020 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599488180;
        bh=+hBkQu9s4/gMzHCxciSjjnQi2QtLKwBklfRKGdDcWQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ubElOFB8q/iIS1SIkvwxPAzakDy+zGpi/JPWEGV+l+oSadsydiBT5sTCirXySPLqt
         uFcwgKNn3JXhKu8BvcomGRstBQE9qN2SN/qJLdtwM9id25z1Lv/0d/Bbt72IA2dTay
         GkXCdq92evvVCma8kdDninKnSyiW/ZPpouX25gls=
Date:   Mon, 7 Sep 2020 16:16:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Eli Billauer <eli.billauer@gmail.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Alexander Tsoy <alexander@tsoy.me>,
        "Geoffrey D. Bennett" <g@b4.vu>, Jussi Laako <jussi@sonarnerd.net>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Dmitry Panchenko <dmitry@d-systems.ee>,
        Chris Wulff <crwulff@gmail.com>,
        Jesus Ramos <jesus-ramos@live.com>
Subject: Re: [PATCH 01/10] USB: move snd_usb_pipe_sanity_check into the USB
 core
Message-ID: <20200907141634.GA3733019@kroah.com>
References: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
 <20200902110115.1994491-2-gregkh@linuxfoundation.org>
 <20200903004553.GA642955@rowland.harvard.edu>
 <20200903073230.GA162335@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903073230.GA162335@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 09:32:30AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 02, 2020 at 08:45:53PM -0400, Alan Stern wrote:
> > On Wed, Sep 02, 2020 at 01:01:03PM +0200, Greg Kroah-Hartman wrote:
> > > snd_usb_pipe_sanity_check() is a great function, so let's move it into
> > > the USB core so that other parts of the kernel, including the USB core,
> > > can call it.
> > > 
> > > Name it usb_pipe_type_check() to match the existing
> > > usb_urb_ep_type_check() call, which now uses this function.
> > > 
> > > Cc: Jaroslav Kysela <perex@perex.cz>
> > > Cc: Takashi Iwai <tiwai@suse.com>
> > > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > > Cc: Eli Billauer <eli.billauer@gmail.com>
> > > Cc: Emiliano Ingrassia <ingrassia@epigenesys.com>
> > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > Cc: Alexander Tsoy <alexander@tsoy.me>
> > > Cc: "Geoffrey D. Bennett" <g@b4.vu>
> > > Cc: Jussi Laako <jussi@sonarnerd.net>
> > > Cc: Nick Kossifidis <mickflemm@gmail.com>
> > > Cc: Dmitry Panchenko <dmitry@d-systems.ee>
> > > Cc: Chris Wulff <crwulff@gmail.com>
> > > Cc: Jesus Ramos <jesus-ramos@live.com>
> > > Cc: linux-usb@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: alsa-devel@alsa-project.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > 
> > > diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> > > index 27e83e55a590..45bc2914c1ba 100644
> > > --- a/drivers/usb/core/urb.c
> > > +++ b/drivers/usb/core/urb.c
> > > @@ -192,24 +192,39 @@ static const int pipetypes[4] = {
> > >  };
> > >  
> > >  /**
> > > - * usb_urb_ep_type_check - sanity check of endpoint in the given urb
> > > - * @urb: urb to be checked
> > > + * usb_pipe_type_check - sanity check of a specific pipe for a usb device
> > > + * @dev: struct usb_device to be checked
> > > + * @pipe: pipe to check
> > >   *
> > >   * This performs a light-weight sanity check for the endpoint in the
> > > - * given urb.  It returns 0 if the urb contains a valid endpoint, otherwise
> > > - * a negative error code.
> > > + * given usb device.  It returns 0 if the pipe is a valid for the specific usb
> > -----------------------------------------------------^
> > Typo.
> 
> Oops, will fix, thanks.
> 
> 
> > 
> > > + * device, otherwise a negative error code.
> > >   */
> > > -int usb_urb_ep_type_check(const struct urb *urb)
> > > +int usb_pipe_type_check(struct usb_device *dev, unsigned int pipe)
> > >  {
> > >  	const struct usb_host_endpoint *ep;
> > >  
> > > -	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
> > > +	ep = usb_pipe_endpoint(dev, pipe);
> > >  	if (!ep)
> > >  		return -EINVAL;
> > > -	if (usb_pipetype(urb->pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
> > > +	if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
> > >  		return -EINVAL;
> > >  	return 0;
> > >  }
> > > +EXPORT_SYMBOL_GPL(usb_pipe_type_check);
> > > +
> > > +/**
> > > + * usb_urb_ep_type_check - sanity check of endpoint in the given urb
> > > + * @urb: urb to be checked
> > > + *
> > > + * This performs a light-weight sanity check for the endpoint in the
> > > + * given urb.  It returns 0 if the urb contains a valid endpoint, otherwise
> > > + * a negative error code.
> > > + */
> > > +int usb_urb_ep_type_check(const struct urb *urb)
> > > +{
> > > +	return usb_pipe_type_check(urb->dev, urb->pipe);
> > > +}
> > >  EXPORT_SYMBOL_GPL(usb_urb_ep_type_check);
> > 
> > Since this routine is used in only one place in the entire kernel, you 
> > might as well inline the code there and get rid of the function 
> > entirely.
> 
> Good idea, will do.

No, wait, the USB sound drivers call it a lot, so it needs to stick
around for now until we clean that up.

thanks,

greg k-h
