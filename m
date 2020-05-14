Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BEEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE322065C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nSO+tCI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgENUvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbgENUvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:51:45 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E599AC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:51:44 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id l3so10365qvo.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CEO5MKxsOiGcoZ39AsHbecY6ymOt3yQ4dCldSFUPnR4=;
        b=nSO+tCI9Zh7sRx+j/A6zP12qApAJl7YPoucFFniaPNg63f6d/RJbqGvHBbbdz3qR4q
         wxQNpJ4ZIOCIIsp5ABxFrQkrZWd4iUPjVGPhYw01jxSLQ8Ncs4KZRqZPhr4wZIQxc+9r
         kRHo62eCYWEsQ51YWnuWSvkk/F9oX8bUbIsU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEO5MKxsOiGcoZ39AsHbecY6ymOt3yQ4dCldSFUPnR4=;
        b=beUBlaXdenBLxDi9IodZETTm+8D1iGzHCb8CISELtc5SwhLXt9iG8eGEPA/zTW3psL
         DY4ml0hX5JRTjmnKk+ncgBGR4l9H9r/3pt5ojz6PnNUYx17OKP7iBUwbSYXkxnsICNqS
         b1klZMkPN206edcU/91NG8X4P+mYu+3DxoKPuy/d2AGNyOSgdpT1O+R+JkYt1jqOqhMO
         UcX8ltJAPOuGVggbCBflIshVLkhRzIo+KNkoQETVjTW8ZRE5tJcnvVEfj0EbfZXDVtiD
         HYI2icmIFKOV2Nlyazy7l5WkT/peBfw9tADN7CuMBBvXp40ZxABM5UHNsK6s/OJH85o4
         j5Tw==
X-Gm-Message-State: AOAM533FlkqQo55x/QQcHmARFpaUFkWnyttBLj4VDcgW7DgscxGt3Xef
        S9D9UEDZEuvIVhIxwNNysQJlkgCRmRETS5P1RrduMA==
X-Google-Smtp-Source: ABdhPJwZIDQ0iffdn72gpulU1LnB9Bmp5RlA17+pbGPp6hkz8/U1ki4Yh9hvEH+g3T7fP+yL9FS3YYKm8La8/jz7ldA=
X-Received: by 2002:a0c:e304:: with SMTP id s4mr303192qvl.133.1589489502504;
 Thu, 14 May 2020 13:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
 <20200507150900.12102-3-heikki.krogerus@linux.intel.com> <20200507224041.GA247416@google.com>
 <20200508111840.GG645261@kuha.fi.intel.com> <20200511133202.GA2085641@kuha.fi.intel.com>
 <20200511175719.GA136540@google.com> <20200512142251.GD2085641@kuha.fi.intel.com>
 <20200512191910.GD136540@google.com>
In-Reply-To: <20200512191910.GD136540@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 14 May 2020 13:51:32 -0700
Message-ID: <CACeCKad4BebiBJS_wO=FdWVWypgOD822Dir7HeRBf0uXUuJusA@mail.gmail.com>
Subject: Re: [PATCH 2/4] usb: typec: mux: intel_pmc_mux: Support for static
 SBU/HSL orientation
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Tue, May 12, 2020 at 12:19 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Heikki,
>
> On Tue, May 12, 2020 at 05:22:51PM +0300, Heikki Krogerus wrote:
> > Hi Prashant,
> >
> > On Mon, May 11, 2020 at 10:57:19AM -0700, Prashant Malani wrote:
> > > Hi Heikki,
> > >
> > > Thanks a lot for looking into this. Kindly see my response inline:
> > >
> > > On Mon, May 11, 2020 at 04:32:02PM +0300, Heikki Krogerus wrote:
> > > > On Fri, May 08, 2020 at 02:18:44PM +0300, Heikki Krogerus wrote:
> > > > > Hi Prashant,
> > > > >
> > > > > On Thu, May 07, 2020 at 03:40:41PM -0700, Prashant Malani wrote:
> > > > > > > +static int sbu_orientation(struct pmc_usb_port *port)
> > > > > > > +{
> > > > > > > +   if (port->sbu_orientation)
> > > > > > > +           return port->sbu_orientation - 1;
> > > > > > > +
> > > > > > > +   return port->orientation - 1;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int hsl_orientation(struct pmc_usb_port *port)
> > > > > > > +{
> > > > > > > +   if (port->hsl_orientation)
> > > > > > > +           return port->hsl_orientation - 1;
> > > > > > > +
> > > > > > > +   return port->orientation - 1;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
> > > > > > >  {
> > > > > > >     u8 response[4];
> > > > > > > @@ -151,8 +170,9 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
> > > > > > >
> > > > > > >     req.mode_data = (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
> > > > > > >     req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
> > > > > > > -   req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> > > > > > > -   req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
> > > > > > > +
> > > > > > > +   req.mode_data |= sbu_orientation(port) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> > > > > >
> > > > > > I'm curious to know what would happen when sbu-orientation == "normal".
> > > > > > That means |port->sbu_orientation| == 1.
> > > > > >
> > > > > > It sounds like what should happen is the AUX_SHIFT orientation
> > > > > > setting should follow what |port->orientation| is, but here it
> > > > > > looks like it will always be set to |port->sbu_orientation - 1|, i.e 0,
> > > > > > even if port->orientation == TYPEC_ORIENTATION_REVERSE, i.e 2, meaning
> > > > > > it should be set to 1 ?
> > > > >
> > > > > I'll double check this, and get back to you..
> > > >
> > > > This is not exactly an answer to your question, but it seems that
> > > > those bits are only valid if "Alternate-Direct" message is used.
> > > > Currently the driver does not support that message.
> > > Could you kindly provide some detail on when "Alternate-Direct" would be
> > > preferred to the current method?
> >
> > Alternate Mode Direct request is supposed to be used if an alternate
> > mode is entered directly from disconnected state.
>
> Ack.
> >
> > > Also, is there anything on the PMC side which is preventing the use of
> > > "Alternate-Direct" messages? It seems like the state transition diagram
> > > there would be simpler, although I'm likely missing significant details
> > > here.
> >
> > So we actually should use the "direct" request if we are in
> > disconnected state to enter alt modes if I understood correctly. But
> > otherwise we should use the normal Alternate Mode request and not the
> > Alternate Mode "direct" request. And I'm afraid I don't know why.
>
> SG.
> >
> > > > I think the correct thing to do now is to remove the two lines from
> > > > the driver where those bits (ORI-HSL and ORI-Aux) are set.
> > > I see. How would orientation then be handled in a retimer configuration
> > > where AUX/SBU is flipped by the retimer itself?
> >
> > Note that if we send a separate "connection" request first, then we
> > already tell the HSL and SBU orientation as part of the payload of
> > that request. That is why there is no need to tell about the HSL and
> > SBU orientation with the normal Alternate Mode Request.
> >
> > So we have already handled the HSL and SBU orientation by the time
> > this function is called.
>
> Thanks for the explanation. I assume the HSL and SBU bit setting lines
> will be removed from pmc_usb_mux_tbt() too?
>
I just realized, the issue I initially pointed out would apply to the
connect message too, i.e I'm not sure if "normal" orientation setting
handles the case where port orientation is reversed correctly.
Overall, I am not sure that re-using the typec_orientations[] string
list is the best option for this use-case.
we're looking for "normal" (i.e follows port->orientation) and "fixed"
(i.e is always the same orientation, regardless of what
port->orientation is), so it is perhaps better to just define a new
array just for this driver.

> Best regards,
> >
> >
> > thanks,
> >
> > --
> > heikki
