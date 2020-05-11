Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A32C54E8F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74134206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XYsodEli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgEKR5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727051AbgEKR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:57:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94A0C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:57:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so4242593plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/4VPW/3YLXwoqcjHvmu+U93vY1XvtT8ILR97l+aBRHM=;
        b=XYsodElimbqFJLNFnU/6UJl3lwNcwYu/y1MR1mjVNPFY94eInf7JUE6nLmVgUkHowr
         4zSTdezoG0smW1qmL27QUdfb65KUD5AuCFfMJHnfOwzRVwH5uwUY2BPnP2uILCu+GQY0
         PICJ13i5ZMC1iPneXD+vBuFAGy2Rk3JBqX/2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/4VPW/3YLXwoqcjHvmu+U93vY1XvtT8ILR97l+aBRHM=;
        b=B+6ZFTk+ICzFGCGFYseW05KOb4FRnayaPBGjL5u3jNL34DIj/U4ol+xPOEjRscMXgx
         /H9Nzo0cTBtIgpOce+U4rCdGl84y7wf52rzcPjRsCXJlEIEzWp0GuktsndMgGGL6/9Zo
         LsgqtXOBQe+Z9EIvWIpG2Bcl41mefLbFtb2xJ7Z0Hje83AcVmgcwTRgdmMi3dxN6FOSh
         du1sdkccDDphHgAb1AhL+PGxvdmrLbOFieMtgTc+mXOiU2czJl4p0DKcAF3nod2jWo/m
         yG2AQB65uZv+YvjOpjvl+yoNnY2wt64ALDsiPZL46+PzPTlzWZC4D1POQqf8uZ/IqsGC
         cCQA==
X-Gm-Message-State: AGi0PuYs2Rw1tjzu3713ST1zXAiKlDs1YPcM613MSrPVgUTYioNtc3XZ
        ibRf4xIVcTMqqdm3TolwWFlycKPCXoQ=
X-Google-Smtp-Source: APiQypKPWCdtCZVF1JVQ+N/i5CTxy1YZ2uxgAQ2wkunQWyauVm+9tyh+T7jrBtoR7DjFIZl3sskrPw==
X-Received: by 2002:a17:90a:1b67:: with SMTP id q94mr23611499pjq.84.1589219841106;
        Mon, 11 May 2020 10:57:21 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id z190sm9750203pfz.84.2020.05.11.10.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 10:57:20 -0700 (PDT)
Date:   Mon, 11 May 2020 10:57:19 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: typec: mux: intel_pmc_mux: Support for static
 SBU/HSL orientation
Message-ID: <20200511175719.GA136540@google.com>
References: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
 <20200507150900.12102-3-heikki.krogerus@linux.intel.com>
 <20200507224041.GA247416@google.com>
 <20200508111840.GG645261@kuha.fi.intel.com>
 <20200511133202.GA2085641@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511133202.GA2085641@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Thanks a lot for looking into this. Kindly see my response inline:

On Mon, May 11, 2020 at 04:32:02PM +0300, Heikki Krogerus wrote:
> On Fri, May 08, 2020 at 02:18:44PM +0300, Heikki Krogerus wrote:
> > Hi Prashant,
> > 
> > On Thu, May 07, 2020 at 03:40:41PM -0700, Prashant Malani wrote:
> > > > +static int sbu_orientation(struct pmc_usb_port *port)
> > > > +{
> > > > +	if (port->sbu_orientation)
> > > > +		return port->sbu_orientation - 1;
> > > > +
> > > > +	return port->orientation - 1;
> > > > +}
> > > > +
> > > > +static int hsl_orientation(struct pmc_usb_port *port)
> > > > +{
> > > > +	if (port->hsl_orientation)
> > > > +		return port->hsl_orientation - 1;
> > > > +
> > > > +	return port->orientation - 1;
> > > > +}
> > > > +
> > > >  static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
> > > >  {
> > > >  	u8 response[4];
> > > > @@ -151,8 +170,9 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
> > > >  
> > > >  	req.mode_data = (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
> > > >  	req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
> > > > -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> > > > -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
> > > > +
> > > > +	req.mode_data |= sbu_orientation(port) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> > > 
> > > I'm curious to know what would happen when sbu-orientation == "normal".
> > > That means |port->sbu_orientation| == 1.
> > > 
> > > It sounds like what should happen is the AUX_SHIFT orientation
> > > setting should follow what |port->orientation| is, but here it
> > > looks like it will always be set to |port->sbu_orientation - 1|, i.e 0,
> > > even if port->orientation == TYPEC_ORIENTATION_REVERSE, i.e 2, meaning
> > > it should be set to 1 ?
> > 
> > I'll double check this, and get back to you..
> 
> This is not exactly an answer to your question, but it seems that
> those bits are only valid if "Alternate-Direct" message is used.
> Currently the driver does not support that message.
Could you kindly provide some detail on when "Alternate-Direct" would be
preferred to the current method?
Also, is there anything on the PMC side which is preventing the use of
"Alternate-Direct" messages? It seems like the state transition diagram
there would be simpler, although I'm likely missing significant details
here.

> 
> I think the correct thing to do now is to remove the two lines from
> the driver where those bits (ORI-HSL and ORI-Aux) are set.
I see. How would orientation then be handled in a retimer configuration
where AUX/SBU is flipped by the retimer itself?

Best regards,

-Prashant
> 
> Let me know if that's OK, and I'll update the series.
> 
> thanks,
> 
> -- 
> heikki
