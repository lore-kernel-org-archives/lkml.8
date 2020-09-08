Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4177EC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 871C920578
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SxjZumxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbgIHTnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbgIHPwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:52:47 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DCDC061386
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:29:14 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a65so14653055otc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvP5wxO99gZBW1/GgVybgs8x6Qa2e+TG1rM2skLb3n8=;
        b=SxjZumxDfk+p1Z5e+pGMFDZSyQBZfaolz6fGUKsKeOL5tEPmnxx/fKBJk8atljXnpf
         dS43UY5yxUeXlCPx9mrR1XFnfE1V6Jl3iTWzX5V3gztH23ltRxBz4zutOgsRUmVZr240
         Tx3/Yfh09teKN/ZiNjXoOI19gw7Tr0Elfr1E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvP5wxO99gZBW1/GgVybgs8x6Qa2e+TG1rM2skLb3n8=;
        b=I8+X4xFyCCUMEkmC0t3lrMfsML5mW5TrC2g3y/OaV4MkPbGRjaok2M2MhIpKStaSrQ
         1u4yAHfaT+cOZgn2UzeWvZv9KJooTRCubl/tPsRf3+r4Cnscn1JVeYUqXza3ba3rkANk
         EaWhf4AUORebZj/GgYUpErRf0utiHgnMFSxXzdgPMYB+aHpuz+8rMcMnKmboF5npRpFg
         GKTVStPgAcNt7qQ7P+4iNClOLrAhBBsw4RaltPjFA4Idwt2BZrNB32eZFVBgsi6ZkUeF
         HVRglLoWv3HZqU6jYZmXg3rRjaygdCxO+WIaGfYukkS6HFy7/GxJxXMsXYY1aXBK8Kvw
         Ss8Q==
X-Gm-Message-State: AOAM530+/8cBL82SMzyUJ5f1kLWor9FVkgG8Ht8/n3eGccPQ56PEvcUc
        Ug61dq5Y1+IfIe8JPuUqxS/gSDNEh38nbWZ4htntRw==
X-Google-Smtp-Source: ABdhPJzs6u28yl8m0FEDALY8EGEEtDD4tiR4lB4sUBvtJacgGsCVh3L1QDdQXz7Rd84ZJfvPSp4ZQmYYzVgq3xis49E=
X-Received: by 2002:a9d:4b99:: with SMTP id k25mr12321360otf.281.1599568153380;
 Tue, 08 Sep 2020 05:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200907160343.124405-1-stefan@agner.ch> <20200907161712.GF6047@pendragon.ideasonboard.com>
 <20200907181855.GE2352366@phenom.ffwll.local> <86615b4b1551d4a6f1cfcc13b38e616c@agner.ch>
 <dc5a16d0-4d2a-366a-7716-29dd8db1a12a@ti.com> <20200908084855.GH2352366@phenom.ffwll.local>
 <bed1ef4f988626962317519cb7d8928e@agner.ch>
In-Reply-To: <bed1ef4f988626962317519cb7d8928e@agner.ch>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 8 Sep 2020 14:29:02 +0200
Message-ID: <CAKMK7uG2NgN1fGFTDnP=0Yow4B051pHhYWw-Uu-cZT3t0UPKWg@mail.gmail.com>
Subject: Re: [PATCH] drm: mxsfb: check framebuffer pitch
To:     Stefan Agner <stefan@agner.ch>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jyri Sarha <jsarha@ti.com>, Marek Vasut <marex@denx.de>,
        Dave Airlie <airlied@linux.ie>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 2:07 PM Stefan Agner <stefan@agner.ch> wrote:
>
> On 2020-09-08 10:48, Daniel Vetter wrote:
> > On Tue, Sep 08, 2020 at 11:18:25AM +0300, Tomi Valkeinen wrote:
> >> Hi,
> >>
> >> On 08/09/2020 10:55, Stefan Agner wrote:
> >> > On 2020-09-07 20:18, Daniel Vetter wrote:
> >> >> On Mon, Sep 07, 2020 at 07:17:12PM +0300, Laurent Pinchart wrote:
> >> >>> Hi Stefan,
> >> >>>
> >> >>> Thank you for the patch.
> >> >>>
> >> >>> On Mon, Sep 07, 2020 at 06:03:43PM +0200, Stefan Agner wrote:
> >> >>>> The lcdif IP does not support a framebuffer pitch (stride) other than
> >> >>>> the CRTC width. Check for equality and reject the state otherwise.
> >> >>>>
> >> >>>> This prevents a distorted picture when using 640x800 and running the
> >> >>>> Mesa graphics stack. Mesa tires to use a cache aligned stride, which
> >> >>>
> >> >>> s/tires/tries/
> >> >>>
> >> >>>> leads at that particular resolution to width != stride. Currently
> >> >>>> Mesa has no fallback behavior, but rejecting this configuration allows
> >> >>>> userspace to handle the issue correctly.
> >> >>>
> >> >>> I'm increasingly impressed by how featureful this IP core is :-)
> >> >>>
> >> >>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> >>>> ---
> >> >>>>  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 22 ++++++++++++++++++----
> >> >>>>  1 file changed, 18 insertions(+), 4 deletions(-)
> >> >>>>
> >> >>>> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> >> >>>> index b721b8b262ce..79aa14027f91 100644
> >> >>>> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> >> >>>> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> >> >>>> @@ -403,14 +403,28 @@ static int mxsfb_plane_atomic_check(struct drm_plane *plane,
> >> >>>>  {
> >> >>>>         struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(plane->dev);
> >> >>>>         struct drm_crtc_state *crtc_state;
> >> >>>> +       unsigned int pitch;
> >> >>>> +       int ret;
> >> >>>>
> >> >>>>         crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
> >> >>>>                                                    &mxsfb->crtc);
> >> >>>>
> >> >>>> -       return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> >> >>>> -                                                  DRM_PLANE_HELPER_NO_SCALING,
> >> >>>> -                                                  DRM_PLANE_HELPER_NO_SCALING,
> >> >>>> -                                                  false, true);
> >> >>>> +       ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> >> >>>> +                                                 DRM_PLANE_HELPER_NO_SCALING,
> >> >>>> +                                                 DRM_PLANE_HELPER_NO_SCALING,
> >> >>>> +                                                 false, true);
> >> >>>> +       if (ret || !plane_state->visible)
> >> >>>
> >> >>> Would it be more explict to check for !plane_state->fb ? Otherwise I'll
> >> >>> have to verify that !fb always implies !visible :-)
> >> >>>
> >> >>>> +               return ret;
> >> >>>> +
> >> >>>> +       pitch = crtc_state->mode.hdisplay *
> >> >>>> +               plane_state->fb->format->cpp[0];
> >> >>>
> >> >>> This holds on a single line.
> >> >>>
> >> >>>> +       if (plane_state->fb->pitches[0] != pitch) {
> >> >>>> +               dev_err(plane->dev->dev,
> >> >>>> +                       "Invalid pitch: fb and crtc widths must be the same");
> >> >>>
> >> >>> I'd turn this into a dev_dbg(), printing error messages to the kernel
> >> >>> log in response to user-triggered conditions is a bit too verbose and
> >> >>> could flood the log.
> >> >>>
> >> >>> Wouldn't it be best to catch this issue when creating the framebuffer ?
> >> >>
> >> >> Yeah this should be verified at addfb time. We try to validate as early as
> >> >> possible.
> >> >> -Daniel
> >> >>
> >> >
> >> > Sounds sensible. From what I can tell fb_create is the proper callback
> >> > to implement this at addfb time. Will give this a try.
> >> >
> >> > FWIW, I got the idea from drivers/gpu/drm/tilcdc/tilcdc_plane.c. Maybe
> >> > should be moved to addfb there too?
> >>
> >> But you don't know the crtc width when creating the framebuffer.
> >
> > Hm right this is a different check. What we could check in fb_create for
> > both is that the logical fb size matches exactly the pitch. That's not
> > sufficient criteria, but it will at least catch some of them already.
> >
> > But yeah we'd need both here.
>
> After validating width of framebuffer against pitch, the only thing we
> need to check here is that the width matches. From what I can tell,
> least for mxsfb, this should be covered by
> drm_atomic_helper_check_plane_state's can_position parameter set to
> false.

This only checks against the src rectangle of the crtc state, there's
nothing forcing that the size of the fb matches the src rectangle
exactly. I guess we could maybe add that as another parameter for hw
like yours or tilcdc. Naming is a bit tricky, maybe
require_matching_fb or src_must_match_fb or something like that.

> So I think in my case I can get away by only checking the framebuffer.

You still need both I think.
-Daniel

>
> --
> Stefan
>
>
> > -Daniel
> >
> >>
> >>  Tomi
> >>
> >> --
> >> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> >> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
