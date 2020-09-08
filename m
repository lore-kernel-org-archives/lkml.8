Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F519C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A30A2177B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ogDS3j32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgIHH4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgIHH4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:56:04 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A59C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 00:56:03 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 6C7F05C3BD6;
        Tue,  8 Sep 2020 09:55:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1599551754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X93b1AlSU972vWQ+6u3RASECywrcJyvf5qdmfnyVL4w=;
        b=ogDS3j32qzhAEWYD8aPKZv+4w3RpValDrIyQrHshuslfD6MDcg9MPmIRUUh2OtU7fCHbFK
        EIpPWEjiIndN/LdULkEuLVHQkixEMH+9ZKoV6vVO070Yf8a4I4VNB17HuBGxHwNVHZSnGo
        r+KS56k3cpSQ3cMYeW/HsajATy6Dhjo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Sep 2020 09:55:53 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsarha@ti.com, tomi.valkeinen@ti.com
Cc:     marex@denx.de, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: mxsfb: check framebuffer pitch
In-Reply-To: <20200907181855.GE2352366@phenom.ffwll.local>
References: <20200907160343.124405-1-stefan@agner.ch>
 <20200907161712.GF6047@pendragon.ideasonboard.com>
 <20200907181855.GE2352366@phenom.ffwll.local>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <86615b4b1551d4a6f1cfcc13b38e616c@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-07 20:18, Daniel Vetter wrote:
> On Mon, Sep 07, 2020 at 07:17:12PM +0300, Laurent Pinchart wrote:
>> Hi Stefan,
>>
>> Thank you for the patch.
>>
>> On Mon, Sep 07, 2020 at 06:03:43PM +0200, Stefan Agner wrote:
>> > The lcdif IP does not support a framebuffer pitch (stride) other than
>> > the CRTC width. Check for equality and reject the state otherwise.
>> >
>> > This prevents a distorted picture when using 640x800 and running the
>> > Mesa graphics stack. Mesa tires to use a cache aligned stride, which
>>
>> s/tires/tries/
>>
>> > leads at that particular resolution to width != stride. Currently
>> > Mesa has no fallback behavior, but rejecting this configuration allows
>> > userspace to handle the issue correctly.
>>
>> I'm increasingly impressed by how featureful this IP core is :-)
>>
>> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>> > ---
>> >  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 22 ++++++++++++++++++----
>> >  1 file changed, 18 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
>> > index b721b8b262ce..79aa14027f91 100644
>> > --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
>> > +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
>> > @@ -403,14 +403,28 @@ static int mxsfb_plane_atomic_check(struct drm_plane *plane,
>> >  {
>> >  	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(plane->dev);
>> >  	struct drm_crtc_state *crtc_state;
>> > +	unsigned int pitch;
>> > +	int ret;
>> >
>> >  	crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
>> >  						   &mxsfb->crtc);
>> >
>> > -	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
>> > -						   DRM_PLANE_HELPER_NO_SCALING,
>> > -						   DRM_PLANE_HELPER_NO_SCALING,
>> > -						   false, true);
>> > +	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
>> > +						  DRM_PLANE_HELPER_NO_SCALING,
>> > +						  DRM_PLANE_HELPER_NO_SCALING,
>> > +						  false, true);
>> > +	if (ret || !plane_state->visible)
>>
>> Would it be more explict to check for !plane_state->fb ? Otherwise I'll
>> have to verify that !fb always implies !visible :-)
>>
>> > +		return ret;
>> > +
>> > +	pitch = crtc_state->mode.hdisplay *
>> > +		plane_state->fb->format->cpp[0];
>>
>> This holds on a single line.
>>
>> > +	if (plane_state->fb->pitches[0] != pitch) {
>> > +		dev_err(plane->dev->dev,
>> > +			"Invalid pitch: fb and crtc widths must be the same");
>>
>> I'd turn this into a dev_dbg(), printing error messages to the kernel
>> log in response to user-triggered conditions is a bit too verbose and
>> could flood the log.
>>
>> Wouldn't it be best to catch this issue when creating the framebuffer ?
> 
> Yeah this should be verified at addfb time. We try to validate as early as
> possible.
> -Daniel
> 

Sounds sensible. From what I can tell fb_create is the proper callback
to implement this at addfb time. Will give this a try.

FWIW, I got the idea from drivers/gpu/drm/tilcdc/tilcdc_plane.c. Maybe
should be moved to addfb there too?

[added Jyri/Tomi]

--
Stefan

>>
>> > +		return -EINVAL;
>> > +	}
>> > +
>> > +	return 0;
>> >  }
>> >
>> >  static void mxsfb_plane_primary_atomic_update(struct drm_plane *plane,
>>
>> --
>> Regards,
>>
>> Laurent Pinchart
