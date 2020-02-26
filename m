Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1E4C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FFA2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgBZDfW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:35:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33295 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgBZDfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 22:35:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so2027341edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 19:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UXofy6EkwfdL30O9+SzmICCU7Qa0hak4F21CzXTG5yo=;
        b=BI1nSrWF+/FFZ8+JmAkwrTwZ8uTUsT8k+xakqDm1vdUr9g4Ie6I4hDaKKnlZCNpDA9
         VUmUjog7h0R4Hq4xpMXupUP75nYeP4S2qMNngmoAE3gjWTQnNWh/7lf8pKwwctAIKclc
         Y/GuhSKlOk0f4Odr5CSZwNSzHXaGPdu6QYtjf520lqWkdz8yMT8QmMJp9lr4VAE0QvWt
         Zu2ttEU3wScy1HXqytXc4bgEihS+AgQytPmE6Hv+K/nn65pexYnD8+8jtP56QLoiXM5B
         xQ/JaWGxEVBl0OrNihdVu4h4r5339oBoKCUYgbWwVNeXKS7+oJ9J7rGx4wAfegZfPttk
         T74w==
X-Gm-Message-State: APjAAAUNa0WF/gb7IB9t+Bcls6N3MkcvBsNneY/t3RH1WmIzLPSS3xde
        afwUBECc00CSVGiQxT61QYUnZcrKPFU=
X-Google-Smtp-Source: APXvYqx4+2ePU5zGnoq/1CYaKRmOjBBiEnB4X0GTffeXg9sDRzZBLtI9rw1h3LVcUXcSLr20RFSYQw==
X-Received: by 2002:a50:d0d2:: with SMTP id g18mr413334edf.37.1582687801348;
        Tue, 25 Feb 2020 19:30:01 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id e22sm24448edq.75.2020.02.25.19.30.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 19:30:01 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id c84so1410129wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 19:30:00 -0800 (PST)
X-Received: by 2002:a05:600c:10d2:: with SMTP id l18mr2582096wmd.122.1582687800441;
 Tue, 25 Feb 2020 19:30:00 -0800 (PST)
MIME-Version: 1.0
References: <20200224173901.174016-1-jernej.skrabec@siol.net>
 <20200225083448.6upblnctjjrbarje@gilmour.lan> <CAGb2v64g7Q4e+ic08pA7tbamgToOjyYzuzqP0bpqBZjRuRUrPA@mail.gmail.com>
 <12462592.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <12462592.uLZWGnKmhe@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 26 Feb 2020 11:29:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v65=a3p1xrz3RuT7w9p+KqRbYMVqf7_GajEQHOpQnTAqnA@mail.gmail.com>
Message-ID: <CAGb2v65=a3p1xrz3RuT7w9p+KqRbYMVqf7_GajEQHOpQnTAqnA@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/sun4i: de2: Don't return de2_fmt_info struct
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime@cerno.tech>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 2:50 AM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>
> Hi!
>
> Dne torek, 25. februar 2020 ob 09:52:18 CET je Chen-Yu Tsai napisal(a):
> > On Tue, Feb 25, 2020 at 4:35 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > Hi,
> > >
> > > On Mon, Feb 24, 2020 at 06:39:00PM +0100, Jernej Skrabec wrote:
> > > > Now that de2_fmt_info contains only DRM <-> HW format mapping, it
> > > > doesn't make sense to return pointer to structure when searching by DRM
> > > > format. Rework that to return only HW format instead.
> > > >
> > > > This doesn't make any functional change.
> > > >
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > ---
> > > >
> > > >  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 15 +++++++++++----
> > > >  drivers/gpu/drm/sun4i/sun8i_mixer.h    |  7 +------
> > > >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 10 +++++-----
> > > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 12 ++++++------
> > > >  4 files changed, 23 insertions(+), 21 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index e078ec96de2d..56cc037fd312
> > > > 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > @@ -27,6 +27,11 @@
> > > >
> > > >  #include "sun8i_vi_layer.h"
> > > >  #include "sunxi_engine.h"
> > > >
> > > > +struct de2_fmt_info {
> > > > +     u32     drm_fmt;
> > > > +     u32     de2_fmt;
> > > > +};
> > > > +
> > > >
> > > >  static const struct de2_fmt_info de2_formats[] = {
> > > >
> > > >       {
> > > >
> > > >               .drm_fmt = DRM_FORMAT_ARGB8888,
> > > >
> > > > @@ -230,15 +235,17 @@ static const struct de2_fmt_info de2_formats[] = {
> > > >
> > > >       },
> > > >
> > > >  };
> > > >
> > > > -const struct de2_fmt_info *sun8i_mixer_format_info(u32 format)
> > > > +int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw_format)
> > > >
> > > >  {
> > > >
> > > >       unsigned int i;
> > > >
> > > >       for (i = 0; i < ARRAY_SIZE(de2_formats); ++i)
> > > >
> > > > -             if (de2_formats[i].drm_fmt == format)
> > > > -                     return &de2_formats[i];
> > > > +             if (de2_formats[i].drm_fmt == format) {
> > > > +                     *hw_format = de2_formats[i].de2_fmt;
> > > > +                     return 0;
> > > > +             }
> > > >
> > > > -     return NULL;
> > > > +     return -EINVAL;
> > > >
> > > >  }
> > >
> > > I'm not too sure about that one. It breaks the consistency with the
> > > other functions, and I don't really see a particular benefit to it?
> >
>
> I don't have strong opinion about this patch. It can be dropped.
>
> > I guess we could just define an "invalid" value, and have the function
> > return that if can't find a match? I'm guessing 0x0 is valid, so maybe
> > 0xffffffff or 0xdeadbeef ?
> >
> > That would keep consistency with everything else all the while
> > removing the level of indirection you wanted to.
>
> I modeled this after
> static int sun4i_backend_drm_format_to_layer(u32 format, u32 *mode);
> from sun4i_backend.c.
>
> What consistency do you have in mind?

Directly returning values (or error codes) instead of passing in a pointer
for data to be returned. I assumed that was what Maxime was referring to.

ChenYu

> >
> > ChenYu
> >
> > > The rest of the series is
> > > Acked-by: Maxime Ripard <mripard@kernel.org>
>
> Thanks!
>
> Best regards,
> Jernej
>
> > >
> > > Maxime
>
>
>
>
