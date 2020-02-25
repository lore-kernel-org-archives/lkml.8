Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73105C35DFC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4322176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgBYIwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:52:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35587 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbgBYIwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:52:33 -0500
Received: by mail-ed1-f68.google.com with SMTP id c7so15337184edu.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 00:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+2A/gft6LrFZSl1mPAmF46n0w4UjXc0APhIZ+UJahU=;
        b=oreHJxzIZydfZL6I+5uKj1kz+zdaoVMTqlNjKcn+0SjV47QKvWnd8sCBdX9PFOi/9N
         IUJHX2g6HS0waNAoWdC79goixo49PWDZ1ChcOyIAIrkuXOXRIbewmzXezbW37/OaxCXk
         CTVkcqEAPtZ46io29os8JwJkROJhRkc4Xpysm/ZkkzUM8HP750x2VObyltibPMJotm0+
         S7nDU9xo1xa/7M1cMkyNT6w/Iu4cTvxj06CzOHA1OFgDK8SMgPv2AvOmicfE2b9shoyf
         GN8WuSzzs1HG1IuHl09XyVfiIFf3tI6u74ENyMqMGeFC9LO927dq6jO4XE8VEv0ReM9x
         eFSQ==
X-Gm-Message-State: APjAAAVbdJyYWa796xqPn5AMjfaR9WNAFxqOKq8Pk/DMId4Qsa2lzo20
        PkoebYkMpiMUAsTyx4jOHSbsyvjl7Hc=
X-Google-Smtp-Source: APXvYqzlOAgz7b3/+BZMCjVszAI+KWZKXb/9cJ+seRJFLK+8jP79nDhNvgrY8EtvcO1HhsqQmSeqDQ==
X-Received: by 2002:a17:906:344d:: with SMTP id d13mr51906876ejb.306.1582620751365;
        Tue, 25 Feb 2020 00:52:31 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id q3sm904259eju.88.2020.02.25.00.52.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 00:52:31 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id z15so5344026wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 00:52:30 -0800 (PST)
X-Received: by 2002:a5d:604a:: with SMTP id j10mr5439322wrt.181.1582620750522;
 Tue, 25 Feb 2020 00:52:30 -0800 (PST)
MIME-Version: 1.0
References: <20200224173901.174016-1-jernej.skrabec@siol.net>
 <20200224173901.174016-7-jernej.skrabec@siol.net> <20200225083448.6upblnctjjrbarje@gilmour.lan>
In-Reply-To: <20200225083448.6upblnctjjrbarje@gilmour.lan>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 25 Feb 2020 16:52:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v64g7Q4e+ic08pA7tbamgToOjyYzuzqP0bpqBZjRuRUrPA@mail.gmail.com>
Message-ID: <CAGb2v64g7Q4e+ic08pA7tbamgToOjyYzuzqP0bpqBZjRuRUrPA@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/sun4i: de2: Don't return de2_fmt_info struct
To:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 4:35 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Mon, Feb 24, 2020 at 06:39:00PM +0100, Jernej Skrabec wrote:
> > Now that de2_fmt_info contains only DRM <-> HW format mapping, it
> > doesn't make sense to return pointer to structure when searching by DRM
> > format. Rework that to return only HW format instead.
> >
> > This doesn't make any functional change.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> >  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 15 +++++++++++----
> >  drivers/gpu/drm/sun4i/sun8i_mixer.h    |  7 +------
> >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 10 +++++-----
> >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 12 ++++++------
> >  4 files changed, 23 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > index e078ec96de2d..56cc037fd312 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > @@ -27,6 +27,11 @@
> >  #include "sun8i_vi_layer.h"
> >  #include "sunxi_engine.h"
> >
> > +struct de2_fmt_info {
> > +     u32     drm_fmt;
> > +     u32     de2_fmt;
> > +};
> > +
> >  static const struct de2_fmt_info de2_formats[] = {
> >       {
> >               .drm_fmt = DRM_FORMAT_ARGB8888,
> > @@ -230,15 +235,17 @@ static const struct de2_fmt_info de2_formats[] = {
> >       },
> >  };
> >
> > -const struct de2_fmt_info *sun8i_mixer_format_info(u32 format)
> > +int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw_format)
> >  {
> >       unsigned int i;
> >
> >       for (i = 0; i < ARRAY_SIZE(de2_formats); ++i)
> > -             if (de2_formats[i].drm_fmt == format)
> > -                     return &de2_formats[i];
> > +             if (de2_formats[i].drm_fmt == format) {
> > +                     *hw_format = de2_formats[i].de2_fmt;
> > +                     return 0;
> > +             }
> >
> > -     return NULL;
> > +     return -EINVAL;
> >  }
>
> I'm not too sure about that one. It breaks the consistency with the
> other functions, and I don't really see a particular benefit to it?

I guess we could just define an "invalid" value, and have the function
return that if can't find a match? I'm guessing 0x0 is valid, so maybe
0xffffffff or 0xdeadbeef ?

That would keep consistency with everything else all the while
removing the level of indirection you wanted to.

ChenYu


> The rest of the series is
> Acked-by: Maxime Ripard <mripard@kernel.org>
>
> Maxime
