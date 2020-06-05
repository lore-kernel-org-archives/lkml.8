Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8656C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A512075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="V5npm3uY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgFEJxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgFEJxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:53:17 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D201C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 02:53:16 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id g3so8907350ilq.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=monHGGTUzGlIMbzMGDloNi/6krZ+xGxUI2rFPNJjxTY=;
        b=V5npm3uYtWnPdZRtIjCSGN4UzEKRD+kpzLNoDt/2wNMZS+pA1BykjEHGnh5FU+V+dH
         37562hI81mQk3yHDBNNdX0gtWzOMVOEia5ZQBSj+i7hkmz/mVR5zXQWcNBHc1JUu0QA3
         JQttBF10iGKSAxh5+9G+rBzecWEXustZu9sNiTZdxsMIoXmuC4ZTRQpE7ISWXLb0AOos
         OAoW/n2HjGw59BsuTVimY9spxFYa6hdTH4pR7v+y2mBUl2Vu9DklQZHowPKTZppx0r0L
         1JKjhzazMZC5aH5ERCP0HbxOCtVkc6l+pZnOOqtH0TNrHOoPndH4qYOqB5pVxaGU3msK
         KPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=monHGGTUzGlIMbzMGDloNi/6krZ+xGxUI2rFPNJjxTY=;
        b=Hv2XmVnB6ZfXvMTEDPOqGDiMGXEQdZy57IRXJ7vRMc1Ea/A5TC1dHvK9jGoMiQJihA
         QKXSKRROadXM/uuXF+I2QAf/JxJq0PHrruAMjlJIJDSJO4RqO/LCxJp+OzZ3+Xu5/BgB
         paYg/PmVaJYEnBcLziBZBSJ4c9qZi2oeCD/HGreSBGknSwzwsCBOvO9gcCJWEMRw2GVC
         s5YSKWg956c562wEdBEpL5XGAddN4/4hO96mzuxNHPPbZeZHjOhq9cxXyVX64hVsH//2
         QZRcQxLs9MDHJX15X1/HkvRcTpsj2U1ynj7LCBQ52WGGzPoXBvpNPqwG75/LnuCKT0yc
         fltw==
X-Gm-Message-State: AOAM531H5QmwtAqIw+kGCQxiFZhItmw2GlEN3py5U06ymVQlpcXWw4Kh
        BPsTUw/LZYyLhzubEPF6gplidUfUUsGBL3rAB88T340m6Wk=
X-Google-Smtp-Source: ABdhPJwx2Nz2JkEdMTbkVEC6JMT2EVTx3YpWl7aoDh3PV+ttAcyMw/OpxBWaFU4vhs4p46N6KJQUAUEDTYujrzaQpuU=
X-Received: by 2002:a92:dd04:: with SMTP id n4mr7420168ilm.220.1591350795826;
 Fri, 05 Jun 2020 02:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200516064507.19058-1-warthog618@gmail.com> <CAMpxmJUbC4qmUGM0Z-6hXsYPRSpEpNM7iXgc7XbMcf_epi0Lig@mail.gmail.com>
 <20200604160006.GA5730@sol>
In-Reply-To: <20200604160006.GA5730@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 5 Jun 2020 11:53:05 +0200
Message-ID: <CAMRc=MfS1sCTU3vs5Gq_6+Ubt_89HX34mqabtpGbAASo+SfzSw@mail.gmail.com>
Subject: Re: [RFC PATCH] gpio: uapi: v2 proposal
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 4 cze 2020 o 18:00 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a)=
:
>

[snip!]

> > > +
> > > +enum gpioline_edge {
> > > +       GPIOLINE_EDGE_NONE              =3D 0,
> > > +       GPIOLINE_EDGE_RISING            =3D 1,
> > > +       GPIOLINE_EDGE_FALLING           =3D 2,
> > > +       GPIOLINE_EDGE_BOTH              =3D 3,
> > > +};
> >
> > I would skip the names of the enum types if we're not reusing them anyw=
here.
> >
>
> I thought it was useful to name them even if it was just to be able to
> reference them in the documentation for relevant fields, such as that in
> struct gpioline_config below, rather than having to either list all
> possible values or a GPIOLINE_EDGE_* glob.
>
> And I'm currently using enum gpioline_edge in my edge detector
> implementation - is that sufficient?
>

The documentation argument is more convincing. :)

> > > +
> > > +/* Line flags - V2 */
> > > +#define GPIOLINE_FLAG_V2_KERNEL                (1UL << 0) /* Line us=
ed by the kernel */
> >
> > In v1 this flag is also set if the line is used by user-space. Maybe a
> > simple GPIOLINE_FLAG_V2_USED would be better?
> >
>
> Agreed - the _KERNEL name is confusing.
> In my latest draft I've already renamed it GPIOLINE_FLAG_V2_BUSY,
> as EBUSY is what the ioctl returns when you try to request such a line.
> Does that work for you?
> I was also considering _IN_USE, and was using _UNAVAILABLE for a while.
>

BUSY sounds less precise to me than USED or IN_USE of which both are
fine (with a preference for the former).

[snip!]

> > > +
> > > +/**
> > > + * struct gpioline_values - Values of GPIO lines
> > > + * @values: when getting the state of lines this contains the curren=
t
> > > + * state of a line, when setting the state of lines these should con=
tain
> > > + * the desired target state
> > > + */
> > > +struct gpioline_values {
> > > +       __u8 values[GPIOLINES_MAX];
> >
> > Same here for bitfield. And maybe reuse this structure in
> > gpioline_config for default values?
> >
>
> Can do.  What makes me reticent is the extra level of indirection
> and the stuttering that would cause when referencing them.
> e.g. config.default_values.values
> So not sure the gain is worth the pain.
>

I'd say yes - consolidation and reuse of data structures is always
good and normally they are going to be wrapped in some kind of
low-level user-space library anyway.

> And I've renamed "default_values" to just "values" in my latest draft
> which doesn't help with the stuttering.
>

Why though? Aren't these always default values for output?

[snip!]

> > > +
> > > +/**
> > > + * struct gpioline_event - The actual event being pushed to userspac=
e
> > > + * @timestamp: best estimate of time of event occurrence, in nanosec=
onds
> > > + * @id: event identifier with value from enum gpioline_event_id
> > > + * @offset: the offset of the line that triggered the event
> > > + * @padding: reserved for future use
> > > + */
> > > +struct gpioline_event {
> > > +       __u64 timestamp;
> >
> > I'd specify in the comment the type of clock used for the timestamp.
> >
>
> Agreed - as this one will be guaranteed to be CLOCK_MONOTONIC.
>
> I'm also kicking around the idea of adding sequence numbers to events,
> one per line and one per handle, so userspace can more easily detect
> mis-ordering or buffer overflows.  Does that make any sense?
>

Hmm, now that you mention it - and in the light of the recent post by
Ryan Lovelett about polling precision - I think it makes sense to have
this. Especially since it's very easy to add.

> And would it be useful for userspace to be able to influence the size of
> the event buffer (currently fixed at 16 events per line)?
>

Good question. I would prefer to not overdo it though. The event
request would need to contain the desired kfifo size and we'd only
allow to set it on request, right?

[snip!]

Bartosz
