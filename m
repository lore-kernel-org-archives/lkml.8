Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E5BC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD8321744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgBYSuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:50:10 -0500
Received: from mailoutvs19.siol.net ([185.57.226.210]:53515 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730634AbgBYSuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:50:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 98BFF524A96;
        Tue, 25 Feb 2020 19:50:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OIDBOTbewRWl; Tue, 25 Feb 2020 19:50:06 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 2F4BF524A94;
        Tue, 25 Feb 2020 19:50:06 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 93601524A8B;
        Tue, 25 Feb 2020 19:50:03 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime@cerno.tech>, Chen-Yu Tsai <wens@csie.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] drm/sun4i: de2: Don't return de2_fmt_info struct
Date:   Tue, 25 Feb 2020 19:50:03 +0100
Message-ID: <12462592.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <CAGb2v64g7Q4e+ic08pA7tbamgToOjyYzuzqP0bpqBZjRuRUrPA@mail.gmail.com>
References: <20200224173901.174016-1-jernej.skrabec@siol.net> <20200225083448.6upblnctjjrbarje@gilmour.lan> <CAGb2v64g7Q4e+ic08pA7tbamgToOjyYzuzqP0bpqBZjRuRUrPA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne torek, 25. februar 2020 ob 09:52:18 CET je Chen-Yu Tsai napisal(a):
> On Tue, Feb 25, 2020 at 4:35 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > Hi,
> > 
> > On Mon, Feb 24, 2020 at 06:39:00PM +0100, Jernej Skrabec wrote:
> > > Now that de2_fmt_info contains only DRM <-> HW format mapping, it
> > > doesn't make sense to return pointer to structure when searching by DRM
> > > format. Rework that to return only HW format instead.
> > > 
> > > This doesn't make any functional change.
> > > 
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > > 
> > >  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 15 +++++++++++----
> > >  drivers/gpu/drm/sun4i/sun8i_mixer.h    |  7 +------
> > >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 10 +++++-----
> > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 12 ++++++------
> > >  4 files changed, 23 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index e078ec96de2d..56cc037fd312
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > @@ -27,6 +27,11 @@
> > > 
> > >  #include "sun8i_vi_layer.h"
> > >  #include "sunxi_engine.h"
> > > 
> > > +struct de2_fmt_info {
> > > +     u32     drm_fmt;
> > > +     u32     de2_fmt;
> > > +};
> > > +
> > > 
> > >  static const struct de2_fmt_info de2_formats[] = {
> > >  
> > >       {
> > >       
> > >               .drm_fmt = DRM_FORMAT_ARGB8888,
> > > 
> > > @@ -230,15 +235,17 @@ static const struct de2_fmt_info de2_formats[] = {
> > > 
> > >       },
> > >  
> > >  };
> > > 
> > > -const struct de2_fmt_info *sun8i_mixer_format_info(u32 format)
> > > +int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw_format)
> > > 
> > >  {
> > >  
> > >       unsigned int i;
> > >       
> > >       for (i = 0; i < ARRAY_SIZE(de2_formats); ++i)
> > > 
> > > -             if (de2_formats[i].drm_fmt == format)
> > > -                     return &de2_formats[i];
> > > +             if (de2_formats[i].drm_fmt == format) {
> > > +                     *hw_format = de2_formats[i].de2_fmt;
> > > +                     return 0;
> > > +             }
> > > 
> > > -     return NULL;
> > > +     return -EINVAL;
> > > 
> > >  }
> > 
> > I'm not too sure about that one. It breaks the consistency with the
> > other functions, and I don't really see a particular benefit to it?
> 

I don't have strong opinion about this patch. It can be dropped.

> I guess we could just define an "invalid" value, and have the function
> return that if can't find a match? I'm guessing 0x0 is valid, so maybe
> 0xffffffff or 0xdeadbeef ?
> 
> That would keep consistency with everything else all the while
> removing the level of indirection you wanted to.

I modeled this after 
static int sun4i_backend_drm_format_to_layer(u32 format, u32 *mode);
from sun4i_backend.c.

What consistency do you have in mind?

> 
> ChenYu
> 
> > The rest of the series is
> > Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!

Best regards,
Jernej

> > 
> > Maxime




