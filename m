Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77308C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFED9206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BRT9Vi4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbgIIROX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbgIIPa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:30:27 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3B2C0611E0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 08:03:51 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u126so2629954oif.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqgUisCv6O6AIe2HSHhoMaBFAHa4ETHNWOlkQljBJ8A=;
        b=BRT9Vi4VBHt950UmvglmwImZSM4kL3ilDGd58qK07Eo89lRCG7hrMJ5v2fKeNK8UXZ
         mZLdMBMk12yoKK2uXeOkGlvQeQJvJZmzdNJ04oJpSZucuLlQMSslsP/qVgoNsYapeaEy
         3wpaj+nh0NeqwJlRpoCiPfrIGDoCd7GLIzy/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqgUisCv6O6AIe2HSHhoMaBFAHa4ETHNWOlkQljBJ8A=;
        b=glbhwlHyJYMb9lBWm1uOJWMCahW3MHRy+KePdqhj7wcm+NFPv1ZoFKfvv8U3YrFAEx
         lvpV89PsAZDiX0IruxkUuql6Z87OCCgKbGKoaB9pwoom7Xlj2fsybHUH/xs5vuWvssef
         Gb7D2eyMYhC0lUNNDPnITDljFfeeYMJ0QaY50TVnpAfcPMxqpXcuWc1DdLIhFj1N7xIW
         3JWUMxS2gY/Ub2GiEGzOMiBnV3H+Ldgtte/iXBGtKEzIJ4TpMNwayI8gBiJYrUuZYTju
         t0oJlHuHsUJpWMPu9OXvuPnMxFoSqtzIFRpXaZHRFtLGzs/DmhA5FURHpl2yMofY35Mm
         dDig==
X-Gm-Message-State: AOAM533Km89W+6BUsmuJ6WyXiTixwd9Bx4UCtWQcTHygRsYGqwVdXe19
        YC/5T0iB711rKeBrf1FBF+4COz0r3o8apylv4jLZlw==
X-Google-Smtp-Source: ABdhPJzV6KFL4kNw0JMMTwGtLRSVvE2e3kcoWpzF0VGT7IKBd/vRbzuUSWeECw2RPuAZ9KHggkot6bIzZex5xMKydis=
X-Received: by 2002:aca:5106:: with SMTP id f6mr875834oib.101.1599663828682;
 Wed, 09 Sep 2020 08:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200721042522.2403410-1-amstan@chromium.org> <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
 <20200904113822.xoyt4w5x7vwvh7cr@holly.lan> <20200907075018.GM2352366@phenom.ffwll.local>
 <20200909144537.daq2exfihhxm6bai@holly.lan>
In-Reply-To: <20200909144537.daq2exfihhxm6bai@holly.lan>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 9 Sep 2020 17:03:37 +0200
Message-ID: <CAKMK7uEK5afDHT9n0s+eDYA1Qztf9Xxibz_rZDzy5F6G9EOEVw@mail.gmail.com>
Subject: Re: [PATCH 2/3] backlight: pwm_bl: Artificially add 0% during interpolation
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Alexandru Stan <amstan@chromium.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 4:45 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Sep 07, 2020 at 09:50:18AM +0200, Daniel Vetter wrote:
> > On Fri, Sep 04, 2020 at 12:38:22PM +0100, Daniel Thompson wrote:
> > > On Mon, Jul 20, 2020 at 09:25:21PM -0700, Alexandru Stan wrote:
> > > > Some displays need the low end of the curve cropped in order to make
> > > > them happy. In that case we still want to have the 0% point, even though
> > > > anything between 0% and 5%(example) would be skipped.
> > >
> > > For backlights it is not defined that 0 means off and, to be honest, 0
> > > means off is actually rather weird for anything except transflexive
> > > or front lit reflective displays[1]. There is a problem on several
> > > systems that when the backlight slider is reduced to zero you can't
> > > see the screen properly to turn it back up. This patch looks like it
> > > would make that problem worse by hurting systems with will written
> > > device trees.
> > >
> > > There is some nasty legacy here: some backlight displays that are off
> > > at zero and that sucks because userspace doesn't know whether zero is
> > > off or lowest possible setting.
> > >
> > > Nevertheless perhaps a better way to handle this case is for 0 to map to
> > > 5% power and for the userspace to turn the backlight on/off as final
> > > step in an animated backlight fade out (and one again for a fade in).
> >
> > Afaik chromeos encodes "0 means off" somewhere in there stack. We've
> > gotten similar patches for the i915 backlight driver when we started
> > obeying the panel's lower limit in our pwm backlight driver thing that's
> > sometimes used instead of acpi.
>
> Out of interest... were they accepted?
>
> I did took a quick look at intel_panel.c and didn't see anything
> that appeared to be special casing zero but I thought I might double
> check.

I don't think so. Just figured I bring this up since it might explain
why this is coming back again from an @chromium.com address.
-Daniel

>
>
> Daniel.
>
>
> > There's also the problem that with fancy panels with protocol (dsi, edp,
> > ...) shutting of the backlight completely out of the proper power sequence
> > hangs the panel (for some panels at least), so providing a backlight off
> > that doesn't go through the drm modeset sequence isn't always possible.
> >
> > It's a bit a mess indeed :-/
> > -Daniel
> >
> > >
> > >
> > > Daniel.
> > >
> > > >
> > > > Signed-off-by: Alexandru Stan <amstan@chromium.org>
> > > > ---
> > > >
> > > >  drivers/video/backlight/pwm_bl.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > > index 5193a72305a2..b24711ddf504 100644
> > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > @@ -349,6 +349,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
> > > >                   /* Fill in the last point, since no line starts here. */
> > > >                   table[x2] = y2;
> > > >
> > > > +                 /*
> > > > +                  * If we don't start at 0 yet we're increasing, assume
> > > > +                  * the dts wanted to crop the low end of the range, so
> > > > +                  * insert a 0 to provide a display off mode.
> > > > +                  */
> > > > +                 if (table[0] > 0 && table[0] < table[num_levels - 1])
> > > > +                         table[0] = 0;
> > > > +
> > > >                   /*
> > > >                    * As we use interpolation lets remove current
> > > >                    * brightness levels table and replace for the
> > > > --
> > > > 2.27.0
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
