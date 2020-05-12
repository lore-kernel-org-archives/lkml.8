Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9264DC2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70478206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LYPD0EML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbgELTTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 15:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELTTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:19:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A18DC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:19:12 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so6814677pfw.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NTFtvW9Z7pWHfvK8fawdp7hae6YucW8EOFMduRCV3ZM=;
        b=LYPD0EMLPWcRjpoJJOSPnayGtY5iiroLZNWvWRoFNMwZYTCjp3oUawMMewKUSMtG2R
         qrJwi+t0+gZluRbMON0FXIrSa4BUQ5AkeJJsxZB0RUk9Rc+2dkcgbVfb+VeiB9ZCSReA
         ZORFY2HVTm2u28VVFhRJaICAG5yw+BEhib++U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NTFtvW9Z7pWHfvK8fawdp7hae6YucW8EOFMduRCV3ZM=;
        b=Wk5WTVVQmkqLGEiAfv/iNacxXPSos9AFkON+X0SxYwTcVj91ebimiQDXAzkOpmWlA6
         Fsz0IUSs7t6hkLt4FR70Ndyo1u7YpDi/FaDlwTolLOpDKpvlW+vd/eR8yKEkCgNZiFnb
         THtJ4Bt49LNCgr6GbYv5wMm4xwALJmrxyhHmCzLIUYBCpLQlkABKbFySbHw4qwJq3W5C
         QTP41ULhoGwRNWMpkh0a9c0RNE7fU10TIOBuqF2VtZvYWNELggDKsupj2hsPH8dCNr98
         DbEX704d81NFk2fGtd8HenROAdoe5f0H1zICQaq/iJBkL3R6rLETzBqoumeZL8JpqWYs
         Wh8A==
X-Gm-Message-State: AGi0PuaQvx4In9lDZpa5f2wIJt+wqtKFsYsQZuftTXhNyDfUpBpy0P+i
        72Ft65fudmiya/2krmWTyCMB2Q==
X-Google-Smtp-Source: APiQypJYSPGb/vm2e7JVL672lR8HWUaeJEC0T9D2V0BWqJ254UQ5es/Lp06OSWAnhHJEse3mY7fuWw==
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr21792580pfb.130.1589311151493;
        Tue, 12 May 2020 12:19:11 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id s15sm1532655pgv.5.2020.05.12.12.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 12:19:10 -0700 (PDT)
Date:   Tue, 12 May 2020 12:19:10 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: typec: mux: intel_pmc_mux: Support for static
 SBU/HSL orientation
Message-ID: <20200512191910.GD136540@google.com>
References: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
 <20200507150900.12102-3-heikki.krogerus@linux.intel.com>
 <20200507224041.GA247416@google.com>
 <20200508111840.GG645261@kuha.fi.intel.com>
 <20200511133202.GA2085641@kuha.fi.intel.com>
 <20200511175719.GA136540@google.com>
 <20200512142251.GD2085641@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512142251.GD2085641@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Tue, May 12, 2020 at 05:22:51PM +0300, Heikki Krogerus wrote:
> Hi Prashant,
> 
> On Mon, May 11, 2020 at 10:57:19AM -0700, Prashant Malani wrote:
> > Hi Heikki,
> > 
> > Thanks a lot for looking into this. Kindly see my response inline:
> > 
> > On Mon, May 11, 2020 at 04:32:02PM +0300, Heikki Krogerus wrote:
> > > On Fri, May 08, 2020 at 02:18:44PM +0300, Heikki Krogerus wrote:
> > > > Hi Prashant,
> > > > 
> > > > On Thu, May 07, 2020 at 03:40:41PM -0700, Prashant Malani wrote:
> > > > > > +static int sbu_orientation(struct pmc_usb_port *port)
> > > > > > +{
> > > > > > +	if (port->sbu_orientation)
> > > > > > +		return port->sbu_orientation - 1;
> > > > > > +
> > > > > > +	return port->orientation - 1;
> > > > > > +}
> > > > > > +
> > > > > > +static int hsl_orientation(struct pmc_usb_port *port)
> > > > > > +{
> > > > > > +	if (port->hsl_orientation)
> > > > > > +		return port->hsl_orientation - 1;
> > > > > > +
> > > > > > +	return port->orientation - 1;
> > > > > > +}
> > > > > > +
> > > > > >  static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
> > > > > >  {
> > > > > >  	u8 response[4];
> > > > > > @@ -151,8 +170,9 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
> > > > > >  
> > > > > >  	req.mode_data = (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
> > > > > >  	req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
> > > > > > -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> > > > > > -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
> > > > > > +
> > > > > > +	req.mode_data |= sbu_orientation(port) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> > > > > 
> > > > > I'm curious to know what would happen when sbu-orientation == "normal".
> > > > > That means |port->sbu_orientation| == 1.
> > > > > 
> > > > > It sounds like what should happen is the AUX_SHIFT orientation
> > > > > setting should follow what |port->orientation| is, but here it
> > > > > looks like it will always be set to |port->sbu_orientation - 1|, i.e 0,
> > > > > even if port->orientation == TYPEC_ORIENTATION_REVERSE, i.e 2, meaning
> > > > > it should be set to 1 ?
> > > > 
> > > > I'll double check this, and get back to you..
> > > 
> > > This is not exactly an answer to your question, but it seems that
> > > those bits are only valid if "Alternate-Direct" message is used.
> > > Currently the driver does not support that message.
> > Could you kindly provide some detail on when "Alternate-Direct" would be
> > preferred to the current method?
> 
> Alternate Mode Direct request is supposed to be used if an alternate
> mode is entered directly from disconnected state.

Ack.
> 
> > Also, is there anything on the PMC side which is preventing the use of
> > "Alternate-Direct" messages? It seems like the state transition diagram
> > there would be simpler, although I'm likely missing significant details
> > here.
> 
> So we actually should use the "direct" request if we are in
> disconnected state to enter alt modes if I understood correctly. But
> otherwise we should use the normal Alternate Mode request and not the
> Alternate Mode "direct" request. And I'm afraid I don't know why.

SG.
> 
> > > I think the correct thing to do now is to remove the two lines from
> > > the driver where those bits (ORI-HSL and ORI-Aux) are set.
> > I see. How would orientation then be handled in a retimer configuration
> > where AUX/SBU is flipped by the retimer itself?
> 
> Note that if we send a separate "connection" request first, then we
> already tell the HSL and SBU orientation as part of the payload of
> that request. That is why there is no need to tell about the HSL and
> SBU orientation with the normal Alternate Mode Request.
> 
> So we have already handled the HSL and SBU orientation by the time
> this function is called.

Thanks for the explanation. I assume the HSL and SBU bit setting lines
will be removed from pmc_usb_mux_tbt() too?

Best regards,
> 
> 
> thanks,
> 
> -- 
> heikki
