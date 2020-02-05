Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E88CC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D625218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="pBDIT5N2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgBEL5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:57:04 -0500
Received: from dougal.metanate.com ([90.155.101.14]:20693 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727833AbgBEL5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:Content-Type:References:In-Reply-To:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
         bh=QIyjQ/REztIDNpy2jOk34jtYI7tAwWjPcGdUhfZavRk=; b=pBDIT5N2UMu5EENFL3Aj9/v5X
        KoYRuZfpCHcB/lOGydqgH2wb5j8sp5sj2Iz0OYjvCJDaGy+N/daqjvBAyiF3NV4iyAshxRFWxtb1x
        KYZrLnYYs+sXgrTq84bVhdhC+TQ57T1lFIT4U5o9k4BpmJA0H7J6z/Tne8QDpD3G1nXiKRh7pqqJa
        I7snvwoFf7Ng9W4pp7Ds9ZmoJ0YYZRCBoL4BjhRYOzGounUE597/nep5+sR+ywPHQOotgQazkPzR4
        EKrGpge5oHOPXmIbSHgTpekIykjzih2JCjwtjz/ObFgxhjjKgT+834Eb2x7bqV31ven21LXUMWTWd
        3j0ESHxQg==;
Received: from dougal.metanate.com ([192.168.88.1] helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1izJIe-0006L1-Td; Wed, 05 Feb 2020 11:56:56 +0000
Date:   Wed, 5 Feb 2020 11:56:56 +0000
From:   John Keeping <john@metanate.com>
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Implement set_selfpowered()
Message-ID: <20200205115656.3c698385.john@metanate.com>
In-Reply-To: <34b74e48-a3ea-f68f-540e-121ae98afb31@synopsys.com>
References: <20200204152933.2216615-1-john@metanate.com>
        <34b74e48-a3ea-f68f-540e-121ae98afb31@synopsys.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

On Wed, 5 Feb 2020 07:59:48 +0000
Minas Harutyunyan <Minas.Harutyunyan@synopsys.com> wrote:

> On 2/4/2020 7:29 PM, John Keeping wrote:
> > dwc2 always reports as self-powered in response to a device status
> > request.  Implement the set_selfpowered() operations so that the gadget
> > can report as bus-powered when appropriate.
> > 
> > This is modelled on the dwc3 implementation.
> > 
> > Signed-off-by: John Keeping <john@metanate.com>  
> 
> Good catch. Just one concern. Your patch partially fix my patch this is 
> why I think you need to add Fixes tag otherwise it can create merge 
> conflict if your patch will be merged to next earlier than my.

I don't think this is actually a fix for your patch, it's a separate fix
which happens to touch the same code.

Since dwc2 has never supported the set_selfpowered() operation, I'm not
really sure if this counts as a bugfix or a feature.

I'm happy to re-send with a fixes tag if you think it's necessary, but I
don't think it's accurate in this case - your patch did not introduce a
bug here :-)


Regards,
John

> > ---
> >   drivers/usb/dwc2/gadget.c | 24 +++++++++++++++++++++++-
> >   1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> > index 2717f4401b97..76c0a5242175 100644
> > --- a/drivers/usb/dwc2/gadget.c
> > +++ b/drivers/usb/dwc2/gadget.c
> > @@ -1646,7 +1646,8 @@ static int dwc2_hsotg_process_req_status(struct dwc2_hsotg *hsotg,
> >   
> >   	switch (ctrl->bRequestType & USB_RECIP_MASK) {
> >   	case USB_RECIP_DEVICE:
> > -		status = 1 << USB_DEVICE_SELF_POWERED;
> > +		status = hsotg->gadget.is_selfpowered <<
> > +			 USB_DEVICE_SELF_POWERED;
> >   		status |= hsotg->remote_wakeup_allowed <<
> >   			  USB_DEVICE_REMOTE_WAKEUP;
> >   		reply = cpu_to_le16(status);
> > @@ -4530,6 +4531,26 @@ static int dwc2_hsotg_gadget_getframe(struct usb_gadget *gadget)
> >   	return dwc2_hsotg_read_frameno(to_hsotg(gadget));
> >   }
> >   
> > +/**
> > + * dwc2_hsotg_set_selfpowered - set if device is self/bus powered
> > + * @gadget: The usb gadget state
> > + * @is_selfpowered: Whether the device is self-powered
> > + *
> > + * Set if the device is self or bus powered.
> > + */
> > +static int dwc2_hsotg_set_selfpowered(struct usb_gadget *gadget,
> > +				      int is_selfpowered)
> > +{
> > +	struct dwc2_hsotg *hsotg = to_hsotg(gadget);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&hsotg->lock, flags);
> > +	gadget->is_selfpowered = !!is_selfpowered;
> > +	spin_unlock_irqrestore(&hsotg->lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> >   /**
> >    * dwc2_hsotg_pullup - connect/disconnect the USB PHY
> >    * @gadget: The usb gadget state
> > @@ -4621,6 +4642,7 @@ static int dwc2_hsotg_vbus_draw(struct usb_gadget *gadget, unsigned int mA)
> >   
> >   static const struct usb_gadget_ops dwc2_hsotg_gadget_ops = {
> >   	.get_frame	= dwc2_hsotg_gadget_getframe,
> > +	.set_selfpowered	= dwc2_hsotg_set_selfpowered,
> >   	.udc_start		= dwc2_hsotg_udc_start,
> >   	.udc_stop		= dwc2_hsotg_udc_stop,
> >   	.pullup                 = dwc2_hsotg_pullup,
> >   

