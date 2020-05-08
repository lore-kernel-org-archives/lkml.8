Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2608C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C260421582
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W1zZ1SHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgEHLg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726690AbgEHLgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:36:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB07BC05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 04:36:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r14so820430pfg.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xG/oTmVNvsSrVAKyKn0GG7fP0wz/voKoWWtsagHKWks=;
        b=W1zZ1SHmI2Ggfi1Ayr4ozVYtK2iuT8r+74rAm5ZyvFqZalCMq2gcmRIvtkUzqyS+mj
         PaNmE2v+/aR1B8wUfixjzKlek1GOHGl+mvLQsQpJR1WpwH+9lzdA9IO/BJHK0qYLH9q6
         QxOQmJYFsuiIyR/FrfTlGrZANhUfvzr3R4QSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xG/oTmVNvsSrVAKyKn0GG7fP0wz/voKoWWtsagHKWks=;
        b=Yy1S7SWxA5czjhNBiHFC8tjDTPIOU109DBBzk8DtzlDAgh/GvwfOjAtd2AR4tnORhm
         OVDp2QWnNdd+nm/uNPTk/gjptyeYrMC1FeH7yYC/0cjBgs8LgTqq8HDjdDaH3xir4otF
         NgcBH5nCgDMxPzYJ7c9TMQuPhHAQfxPt+jOnNFCMy+ue3HPz1X4Lg392iPTv9iGKZoKA
         pre19WMFgPLZCfitOUXWlxHh9QaC1qn07o1FjOuXNAiwq6J/rnmqpj8ADHY4inI0ZCxq
         j4AvYGCX01gU62TIJLl2re5Euu5prbDGneZXM/ltdyguYMm1SCzenzXv2NC87NoRG3nB
         2sUA==
X-Gm-Message-State: AGi0PuZrjebrZKxXXVvDzwrMIkibCBoY78YJHERv4sYzT3/6OidA0hRD
        HJAt6euwXHTyHVlpJQDNvNJBHQ==
X-Google-Smtp-Source: APiQypKT5Nd6sPhxivcyI6fARenFffjc+L0JYcg8jsLniC9BOmw17JjLzozG6egmA6aCO4DoBH6IVg==
X-Received: by 2002:a62:76c3:: with SMTP id r186mr2454835pfc.190.1588937814083;
        Fri, 08 May 2020 04:36:54 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id a12sm1615001pfr.28.2020.05.08.04.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 04:36:53 -0700 (PDT)
Date:   Fri, 8 May 2020 04:36:52 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: typec: mux: intel_pmc_mux: Support for static
 SBU/HSL orientation
Message-ID: <20200508113652.GA34001@google.com>
References: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
 <20200507150900.12102-3-heikki.krogerus@linux.intel.com>
 <20200507224041.GA247416@google.com>
 <20200508111840.GG645261@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508111840.GG645261@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 02:18:40PM +0300, Heikki Krogerus wrote:
> Hi Prashant,
> 
> On Thu, May 07, 2020 at 03:40:41PM -0700, Prashant Malani wrote:
> > > +static int sbu_orientation(struct pmc_usb_port *port)
> > > +{
> > > +	if (port->sbu_orientation)
> > > +		return port->sbu_orientation - 1;
> > > +
> > > +	return port->orientation - 1;
> > > +}
> > > +
> > > +static int hsl_orientation(struct pmc_usb_port *port)
> > > +{
> > > +	if (port->hsl_orientation)
> > > +		return port->hsl_orientation - 1;
> > > +
> > > +	return port->orientation - 1;
> > > +}
> > > +
> > >  static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
> > >  {
> > >  	u8 response[4];
> > > @@ -151,8 +170,9 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
> > >  
> > >  	req.mode_data = (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
> > >  	req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
> > > -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> > > -	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
> > > +
> > > +	req.mode_data |= sbu_orientation(port) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
> > 
> > I'm curious to know what would happen when sbu-orientation == "normal".
> > That means |port->sbu_orientation| == 1.
> > 
> > It sounds like what should happen is the AUX_SHIFT orientation
> > setting should follow what |port->orientation| is, but here it
> > looks like it will always be set to |port->sbu_orientation - 1|, i.e 0,
> > even if port->orientation == TYPEC_ORIENTATION_REVERSE, i.e 2, meaning
> > it should be set to 1 ?
> 
> I'll double check this, and get back to you..
> 
> Thanks a lot for reviewing this. If you guys have time, then please
> check also that the documentation I'm proposing in patch 3/4 for this
> driver has everything explained clearly enough, and nothing is missing.
> 
Sure thing, we'll take a look.

Best,

-Prashant
> Br,
> 
> -- 
> heikki
