Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC5EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7269720732
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hZpY+ABA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgIGSTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbgIGSS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:18:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC5DC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 11:18:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so2333768wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 11:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=nmGHPNrS/6S0SVPN+UDSLWRiyfZpZ44FO0zwUXQGhPk=;
        b=hZpY+ABAxUzZiiEnMcGY2zsoByRD7Qyn3GVNt7pMeFqg40sUBrUExQ3IX3NAtZYDed
         vpuuoHVdh32ifvExwzoruB17FLiBxcLLWvh6JivS+6V7GpKxu17XBwxDmiAFVWBo3oke
         VeYhIhUZA5q3aMC5BRIP+qKUUioViLMCnNc3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nmGHPNrS/6S0SVPN+UDSLWRiyfZpZ44FO0zwUXQGhPk=;
        b=fDzjYknO0EibMGbM+Ip39tOqLG8OJKAhTFEOxB/XUe8kKpb6BfsX+BFcgku66Hjb99
         d59du7b6lA2vXJhdqOZaXSbiPUq/vb+hBLs+OV+u7NA+ot+8i0h+CdOjik5MCe8QxUY5
         A0bb6LRxR4rFJsOvIOnQjLvNAjtsZLM+eAehkHie8oYtruz+U1WgfVW7IMUiq2QR/7Ty
         vOizBwNCMoMNCVAqLOkNWPEjvIQu1XHUlD3LoDZrBe6GMUVFANxKvrPgsMS1V74bJmPb
         U9TrilrYfym40x0oftUDKaC+VzoF/r8Foj/Y3kC7j2I1mCLN/nG0g6H+1L7yuNImEnHh
         JdTQ==
X-Gm-Message-State: AOAM5309JAvRouRo8P5Ovh2yDC9NSQHGtX0Ax7LeoHtSxqujEfKWVCV2
        qGhR6qCcG6NxyZIXFhJnSsN5aw==
X-Google-Smtp-Source: ABdhPJx/Jk99iRJFxTsv1nNiWHcEwaGPbYeF2e2q7j3F1PqjKZLVLTc9yfm/TiCX2Ye++izPL+H2oQ==
X-Received: by 2002:a1c:6187:: with SMTP id v129mr528032wmb.35.1599502737762;
        Mon, 07 Sep 2020 11:18:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v6sm29503897wrt.90.2020.09.07.11.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 11:18:56 -0700 (PDT)
Date:   Mon, 7 Sep 2020 20:18:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Stefan Agner <stefan@agner.ch>, marex@denx.de, airlied@linux.ie,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: mxsfb: check framebuffer pitch
Message-ID: <20200907181855.GE2352366@phenom.ffwll.local>
Mail-Followup-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stefan Agner <stefan@agner.ch>, marex@denx.de, airlied@linux.ie,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200907160343.124405-1-stefan@agner.ch>
 <20200907161712.GF6047@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907161712.GF6047@pendragon.ideasonboard.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 07:17:12PM +0300, Laurent Pinchart wrote:
> Hi Stefan,
> 
> Thank you for the patch.
> 
> On Mon, Sep 07, 2020 at 06:03:43PM +0200, Stefan Agner wrote:
> > The lcdif IP does not support a framebuffer pitch (stride) other than
> > the CRTC width. Check for equality and reject the state otherwise.
> > 
> > This prevents a distorted picture when using 640x800 and running the
> > Mesa graphics stack. Mesa tires to use a cache aligned stride, which
> 
> s/tires/tries/
> 
> > leads at that particular resolution to width != stride. Currently
> > Mesa has no fallback behavior, but rejecting this configuration allows
> > userspace to handle the issue correctly.
> 
> I'm increasingly impressed by how featureful this IP core is :-)
> 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> >  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> > index b721b8b262ce..79aa14027f91 100644
> > --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> > +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> > @@ -403,14 +403,28 @@ static int mxsfb_plane_atomic_check(struct drm_plane *plane,
> >  {
> >  	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(plane->dev);
> >  	struct drm_crtc_state *crtc_state;
> > +	unsigned int pitch;
> > +	int ret;
> >  
> >  	crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
> >  						   &mxsfb->crtc);
> >  
> > -	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> > -						   DRM_PLANE_HELPER_NO_SCALING,
> > -						   DRM_PLANE_HELPER_NO_SCALING,
> > -						   false, true);
> > +	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> > +						  DRM_PLANE_HELPER_NO_SCALING,
> > +						  DRM_PLANE_HELPER_NO_SCALING,
> > +						  false, true);
> > +	if (ret || !plane_state->visible)
> 
> Would it be more explict to check for !plane_state->fb ? Otherwise I'll
> have to verify that !fb always implies !visible :-)
> 
> > +		return ret;
> > +
> > +	pitch = crtc_state->mode.hdisplay *
> > +		plane_state->fb->format->cpp[0];
> 
> This holds on a single line.
> 
> > +	if (plane_state->fb->pitches[0] != pitch) {
> > +		dev_err(plane->dev->dev,
> > +			"Invalid pitch: fb and crtc widths must be the same");
> 
> I'd turn this into a dev_dbg(), printing error messages to the kernel
> log in response to user-triggered conditions is a bit too verbose and
> could flood the log.
> 
> Wouldn't it be best to catch this issue when creating the framebuffer ?

Yeah this should be verified at addfb time. We try to validate as early as
possible.
-Daniel

> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> >  }
> >  
> >  static void mxsfb_plane_primary_atomic_update(struct drm_plane *plane,
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
