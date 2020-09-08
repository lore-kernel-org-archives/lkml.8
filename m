Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DBEC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D5D215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hvxn9skr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgIHItF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729813AbgIHIs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:48:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A9DC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:48:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so18210371wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=vTwZpb2SRbHS6TVjDRxWxiFRdUx1UorL5y3KysCor9o=;
        b=hvxn9skrMRRr0q95ExVeGBXDKL50YXqPxTkDw/op5wnsECwbMgTPjRembThpSe3EYK
         HAdhN+caBKBO/UMSUpqVSK6hrPlnx0e9fN4VMOPkmrB5/nj3AI8Gdf5cdpkPoAgCJhGX
         wLDN/wIwneGsAHwiuvEdIk/6G5aE0Y4MBD780=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=vTwZpb2SRbHS6TVjDRxWxiFRdUx1UorL5y3KysCor9o=;
        b=TQcAf6ur5ADRRsB+uX7awmxFdte4bBV4JwyGHaDSGV/ywU5IVIq6UD+F3GJa3OMEf3
         YJJrYomA/LNDIjpD8wCbwACc9HHnvZ+kLfIAkpH+merMmA+tU3reeKLSLQ9nhvufbZmN
         2s4U4L3iGF+X6eDjYwxsoECRTh2jzN1/vFZ422qQr/p+oXhETbDHUx9V18I75BS2j/BT
         GILvEjVyNI+JB3ZJQaArOqy+1rSvWOZGAdtjoJddY0HDK9iSoRY40ZXndHgwzpsOp6TK
         V3PQ+kkaaZbleUCkmz3+VmVQ6HBxc60d7WwLZT4I8Z7+y3u3EFXqEVT6/U5dovk32t0Z
         bYEA==
X-Gm-Message-State: AOAM532tPfsQ+w8/Z1M4SSTVatvONuP5nwoZJm3cMWL9cC6r+j/fA7oN
        mNfiQtsme0IIEtxB5QAM4LYY4Q==
X-Google-Smtp-Source: ABdhPJyChK39vZ43On41Fya27UnXYFaJZY862924QCXz3b7+wz4vQQztCQcIMrRa95whcLZtQ6e+NQ==
X-Received: by 2002:adf:9125:: with SMTP id j34mr28207058wrj.157.1599554937849;
        Tue, 08 Sep 2020 01:48:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id r14sm33235979wrn.56.2020.09.08.01.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:48:57 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:48:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsarha@ti.com, marex@denx.de, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: mxsfb: check framebuffer pitch
Message-ID: <20200908084855.GH2352366@phenom.ffwll.local>
Mail-Followup-To: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Stefan Agner <stefan@agner.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>, jsarha@ti.com,
        marex@denx.de, airlied@linux.ie, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200907160343.124405-1-stefan@agner.ch>
 <20200907161712.GF6047@pendragon.ideasonboard.com>
 <20200907181855.GE2352366@phenom.ffwll.local>
 <86615b4b1551d4a6f1cfcc13b38e616c@agner.ch>
 <dc5a16d0-4d2a-366a-7716-29dd8db1a12a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc5a16d0-4d2a-366a-7716-29dd8db1a12a@ti.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 11:18:25AM +0300, Tomi Valkeinen wrote:
> Hi,
> 
> On 08/09/2020 10:55, Stefan Agner wrote:
> > On 2020-09-07 20:18, Daniel Vetter wrote:
> >> On Mon, Sep 07, 2020 at 07:17:12PM +0300, Laurent Pinchart wrote:
> >>> Hi Stefan,
> >>>
> >>> Thank you for the patch.
> >>>
> >>> On Mon, Sep 07, 2020 at 06:03:43PM +0200, Stefan Agner wrote:
> >>>> The lcdif IP does not support a framebuffer pitch (stride) other than
> >>>> the CRTC width. Check for equality and reject the state otherwise.
> >>>>
> >>>> This prevents a distorted picture when using 640x800 and running the
> >>>> Mesa graphics stack. Mesa tires to use a cache aligned stride, which
> >>>
> >>> s/tires/tries/
> >>>
> >>>> leads at that particular resolution to width != stride. Currently
> >>>> Mesa has no fallback behavior, but rejecting this configuration allows
> >>>> userspace to handle the issue correctly.
> >>>
> >>> I'm increasingly impressed by how featureful this IP core is :-)
> >>>
> >>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >>>> ---
> >>>>  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 22 ++++++++++++++++++----
> >>>>  1 file changed, 18 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> >>>> index b721b8b262ce..79aa14027f91 100644
> >>>> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> >>>> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> >>>> @@ -403,14 +403,28 @@ static int mxsfb_plane_atomic_check(struct drm_plane *plane,
> >>>>  {
> >>>>  	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(plane->dev);
> >>>>  	struct drm_crtc_state *crtc_state;
> >>>> +	unsigned int pitch;
> >>>> +	int ret;
> >>>>
> >>>>  	crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
> >>>>  						   &mxsfb->crtc);
> >>>>
> >>>> -	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> >>>> -						   DRM_PLANE_HELPER_NO_SCALING,
> >>>> -						   DRM_PLANE_HELPER_NO_SCALING,
> >>>> -						   false, true);
> >>>> +	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> >>>> +						  DRM_PLANE_HELPER_NO_SCALING,
> >>>> +						  DRM_PLANE_HELPER_NO_SCALING,
> >>>> +						  false, true);
> >>>> +	if (ret || !plane_state->visible)
> >>>
> >>> Would it be more explict to check for !plane_state->fb ? Otherwise I'll
> >>> have to verify that !fb always implies !visible :-)
> >>>
> >>>> +		return ret;
> >>>> +
> >>>> +	pitch = crtc_state->mode.hdisplay *
> >>>> +		plane_state->fb->format->cpp[0];
> >>>
> >>> This holds on a single line.
> >>>
> >>>> +	if (plane_state->fb->pitches[0] != pitch) {
> >>>> +		dev_err(plane->dev->dev,
> >>>> +			"Invalid pitch: fb and crtc widths must be the same");
> >>>
> >>> I'd turn this into a dev_dbg(), printing error messages to the kernel
> >>> log in response to user-triggered conditions is a bit too verbose and
> >>> could flood the log.
> >>>
> >>> Wouldn't it be best to catch this issue when creating the framebuffer ?
> >>
> >> Yeah this should be verified at addfb time. We try to validate as early as
> >> possible.
> >> -Daniel
> >>
> > 
> > Sounds sensible. From what I can tell fb_create is the proper callback
> > to implement this at addfb time. Will give this a try.
> > 
> > FWIW, I got the idea from drivers/gpu/drm/tilcdc/tilcdc_plane.c. Maybe
> > should be moved to addfb there too?
> 
> But you don't know the crtc width when creating the framebuffer.

Hm right this is a different check. What we could check in fb_create for
both is that the logical fb size matches exactly the pitch. That's not
sufficient criteria, but it will at least catch some of them already.

But yeah we'd need both here.
-Daniel

> 
>  Tomi
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
