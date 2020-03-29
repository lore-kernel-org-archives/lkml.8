Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10043C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D692B20732
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTmZm4tA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgC2Ji7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 05:38:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41338 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgC2Ji7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 05:38:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id a24so194572pfc.8;
        Sun, 29 Mar 2020 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1FjUt0FY4qG4swr3glwUOGPZovJqvh5BcKDS4lGNLW4=;
        b=JTmZm4tANjipQr6DLS3RinvGorU5jef6avNVRWTXMGMOHc5zWJD8xRNxFdvfYAU4My
         dEKmoB/HJdqNKyrKgkKhGvUtY2NYkWNMrIpeZcIPjbvpkgSoKP+IlQUNP6CyEu+b4qGT
         l+YPnkDIixPJwYLwiuhYT1u38s37mYmi54uDWkT7EzzbeLUFYD5j78Upnr/2DGP4+d6m
         fXVTjObFPYSWpVc+/5VbiQy/dyhcRHQTNROPixtBi5Cc7g9PWtN2eezd9eFyd2k8FEjg
         w49fddJ9HlCac53/1mK3H20pfoGxPXiO70i0BlYo5w+3HCm3cV8SOG5GXIG7hlLiOHcB
         hA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1FjUt0FY4qG4swr3glwUOGPZovJqvh5BcKDS4lGNLW4=;
        b=Ta+fMBXBVVHCiMwkQNmuuJFGEplmsOrKixl7Jyd2QPcMFy8L/C+ACS45H2CVs5eBmt
         Chn2DC719xnITo/ye/d6D6+e2i1Tpn8wSBs56pXCxKX6jlrUP41hiwYqWxfiJg6laGSq
         EwaOx4VHxj5TFJklYzxUKuFhVahds783espD5zUEFgUgfLoQFRcKWl/c54rbp40G+IJE
         rWnKiAYjyYZDjbAT5GGPdIMVCe/VHCZHzM1X/f9wfPmVC7j2ZIv6xlV4Da1SYWEcPtpM
         tKqr1HJ2EsFQrvNQhoa1KIFHv/Crqbd5IWRA5XROlymLb2Tw4PauvSoDF4mGvOCPRHgP
         Nlgg==
X-Gm-Message-State: ANhLgQ2QB3Ie5zxK1aP1wPiWl9LNZNRrT3tGWt15Xb/OmgzAAq+O5H+P
        ha9m+JzmmorSZewVPGulMMQ=
X-Google-Smtp-Source: ADFU+vsho0XarlgM5qxPPJLJ7yrus56xN6a1QzWk0breFr82zriHlE38k99Mh8f7T/KzyYmocphc7Q==
X-Received: by 2002:a62:160b:: with SMTP id 11mr8149948pfw.189.1585474737395;
        Sun, 29 Mar 2020 02:38:57 -0700 (PDT)
Received: from ManjaroKDE ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id y29sm7265920pge.22.2020.03.29.02.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 02:38:56 -0700 (PDT)
Message-ID: <2fccf96c3754e6319797a10856e438e023f734a7.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: fbtft: Replace udelay with
 preferred usleep_range
From:   John Wyatt <jbwyatt4@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 29 Mar 2020 02:38:51 -0700
In-Reply-To: <alpine.DEB.2.21.2003291127230.2990@hadrien>
References: <20200329092204.770405-1-jbwyatt4@gmail.com>
         <alpine.DEB.2.21.2003291127230.2990@hadrien>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-29 at 11:28 +0200, Julia Lawall wrote:
> 
> On Sun, 29 Mar 2020, John B. Wyatt IV wrote:
> 
> > Fix style issue with usleep_range being reported as preferred over
> > udelay.
> > 
> > Issue reported by checkpatch.
> > 
> > Please review.
> > 
> > As written in Documentation/timers/timers-howto.rst udelay is the
> > generally preferred API. hrtimers, as noted in the docs, may be too
> > expensive for this short timer.
> > 
> > Are the docs out of date, or, is this a checkpatch issue?
> > 
> > Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> > ---
> >  drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c
> > b/drivers/staging/fbtft/fb_agm1264k-fl.c
> > index eeeeec97ad27..019c8cce6bab 100644
> > --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> > +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> > @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
> >  	dev_dbg(par->info->device, "%s()\n", __func__);
> > 
> >  	gpiod_set_value(par->gpio.reset, 0);
> > -	udelay(20);
> > +	usleep_range(20, 20);
> 
> usleep_range should have a range, eg usleep_range(50, 100);.  But it
> is
> hard to know a priori what the range should be.  So it is probably
> better
> to leave the code alone.

Understood.

With the question I wrote in the commit message:

"As written in Documentation/timers/timers-howto.rst udelay is the
generally preferred API. hrtimers, as noted in the docs, may be too
expensive for this short timer.

Are the docs out of date, or, is this a checkpatch issue?"

Is usleep_range too expensive for this operation?

Why does checkpatch favor usleep_range while the docs favor udelay?

> 
> julia
> 
> >  	gpiod_set_value(par->gpio.reset, 1);
> >  	mdelay(120);
> >  }
> > --
> > 2.25.1
> > 
> > --
> > You received this message because you are subscribed to the Google
> > Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it,
> > send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit 
> > https://groups.google.com/d/msgid/outreachy-kernel/20200329092204.770405-1-jbwyatt4%40gmail.com
> > .
> > 

