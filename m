Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE1AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADE12074B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QGa30Zxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbgIHRw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731626AbgIHQNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:13:44 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3813C0617A4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:13:00 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EF77339;
        Tue,  8 Sep 2020 14:07:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1599566866;
        bh=gVQ6vV1AXzJOgjJLHm9N/dNNMo5x6er9J7+iF8u+AkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGa30ZxmFOr8fkWU2OJpI/toSpG6N4iUhztpdHqegiOWw5o0Y4gQ0PfCRvN8uHsWi
         P6a2E3nLv3IjzpbAfep3BTCZivEbImsehfIgwob+5ckDFvUMf7nv9nKRkiWfmUuynp
         YePkjknL80Di8J06EJlpqK5ZMTdw6XEDGiVIQTF0=
Date:   Tue, 8 Sep 2020 15:07:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Stefan Agner <stefan@agner.ch>, jsarha@ti.com, marex@denx.de,
        airlied@linux.ie, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: mxsfb: check framebuffer pitch
Message-ID: <20200908120719.GD6047@pendragon.ideasonboard.com>
References: <20200907160343.124405-1-stefan@agner.ch>
 <20200907161712.GF6047@pendragon.ideasonboard.com>
 <20200907181855.GE2352366@phenom.ffwll.local>
 <86615b4b1551d4a6f1cfcc13b38e616c@agner.ch>
 <dc5a16d0-4d2a-366a-7716-29dd8db1a12a@ti.com>
 <20200908084855.GH2352366@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908084855.GH2352366@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:48:55AM +0200, Daniel Vetter wrote:
> On Tue, Sep 08, 2020 at 11:18:25AM +0300, Tomi Valkeinen wrote:
> > On 08/09/2020 10:55, Stefan Agner wrote:
> > > On 2020-09-07 20:18, Daniel Vetter wrote:
> > >> On Mon, Sep 07, 2020 at 07:17:12PM +0300, Laurent Pinchart wrote:
> > >>> Hi Stefan,
> > >>>
> > >>> Thank you for the patch.
> > >>>
> > >>> On Mon, Sep 07, 2020 at 06:03:43PM +0200, Stefan Agner wrote:
> > >>>> The lcdif IP does not support a framebuffer pitch (stride) other than
> > >>>> the CRTC width. Check for equality and reject the state otherwise.
> > >>>>
> > >>>> This prevents a distorted picture when using 640x800 and running the
> > >>>> Mesa graphics stack. Mesa tires to use a cache aligned stride, which
> > >>>
> > >>> s/tires/tries/
> > >>>
> > >>>> leads at that particular resolution to width != stride. Currently
> > >>>> Mesa has no fallback behavior, but rejecting this configuration allows
> > >>>> userspace to handle the issue correctly.
> > >>>
> > >>> I'm increasingly impressed by how featureful this IP core is :-)
> > >>>
> > >>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> > >>>> ---
> > >>>>  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 22 ++++++++++++++++++----
> > >>>>  1 file changed, 18 insertions(+), 4 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> > >>>> index b721b8b262ce..79aa14027f91 100644
> > >>>> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> > >>>> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> > >>>> @@ -403,14 +403,28 @@ static int mxsfb_plane_atomic_check(struct drm_plane *plane,
> > >>>>  {
> > >>>>  	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(plane->dev);
> > >>>>  	struct drm_crtc_state *crtc_state;
> > >>>> +	unsigned int pitch;
> > >>>> +	int ret;
> > >>>>
> > >>>>  	crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
> > >>>>  						   &mxsfb->crtc);
> > >>>>
> > >>>> -	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> > >>>> -						   DRM_PLANE_HELPER_NO_SCALING,
> > >>>> -						   DRM_PLANE_HELPER_NO_SCALING,
> > >>>> -						   false, true);
> > >>>> +	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> > >>>> +						  DRM_PLANE_HELPER_NO_SCALING,
> > >>>> +						  DRM_PLANE_HELPER_NO_SCALING,
> > >>>> +						  false, true);
> > >>>> +	if (ret || !plane_state->visible)
> > >>>
> > >>> Would it be more explict to check for !plane_state->fb ? Otherwise I'll
> > >>> have to verify that !fb always implies !visible :-)
> > >>>
> > >>>> +		return ret;
> > >>>> +
> > >>>> +	pitch = crtc_state->mode.hdisplay *
> > >>>> +		plane_state->fb->format->cpp[0];
> > >>>
> > >>> This holds on a single line.
> > >>>
> > >>>> +	if (plane_state->fb->pitches[0] != pitch) {
> > >>>> +		dev_err(plane->dev->dev,
> > >>>> +			"Invalid pitch: fb and crtc widths must be the same");
> > >>>
> > >>> I'd turn this into a dev_dbg(), printing error messages to the kernel
> > >>> log in response to user-triggered conditions is a bit too verbose and
> > >>> could flood the log.
> > >>>
> > >>> Wouldn't it be best to catch this issue when creating the framebuffer ?
> > >>
> > >> Yeah this should be verified at addfb time. We try to validate as early as
> > >> possible.
> > > 
> > > Sounds sensible. From what I can tell fb_create is the proper callback
> > > to implement this at addfb time. Will give this a try.
> > > 
> > > FWIW, I got the idea from drivers/gpu/drm/tilcdc/tilcdc_plane.c. Maybe
> > > should be moved to addfb there too?
> > 
> > But you don't know the crtc width when creating the framebuffer.
> 
> Hm right this is a different check. What we could check in fb_create for
> both is that the logical fb size matches exactly the pitch. That's not
> sufficient criteria, but it will at least catch some of them already.
> 
> But yeah we'd need both here.

Correct. At addfb time we can check the pitch, and at atomic check time
we should check that the plane spans the whole CRTC.

-- 
Regards,

Laurent Pinchart
