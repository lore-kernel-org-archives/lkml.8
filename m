Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D202C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C75F20936
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="i0P3U0FK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgDQO6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDQO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:58:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027AFC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:57:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g13so1360312wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=60VGtzwTiYwzXu9gSno8Albggq78bUOmhCjrGHuqcH0=;
        b=i0P3U0FK9NGXGLuA53xyepLNIxHPyEzf7CRFj1/kqsSEfq7usXaKYHjNKTVeO14lzm
         l+gvwwwSsSJD6qsl78aOdUwoiz9aO9r2c9l0/jlX46E2T3Gzu306zNYpvRYW7zRPR818
         hqjKDFWxbLlMW5LSLV8fkyGJLmhC7HPpcJbY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=60VGtzwTiYwzXu9gSno8Albggq78bUOmhCjrGHuqcH0=;
        b=Z+VVXZ41z4WwzqWEiLkHOxyApywxC7aPoU0egBIYcmglI3o3YPm2eevlp1vKIj7NSZ
         mntRPUY/nHVO9K+GJhvY0bhkredtApQktFtU3F6EYrRhx0RaS3KoKpwtOpgXwbx2s109
         9CTvvI+DW1u58wGNsEtaiGEFA7ENDZu5Q6lpYa3n/zFElDqQ8YLfpx7yq1PQJc2xzgbK
         aZf2wCDr7dhYcDev42az82h2B/RoKwMxGOLN/3Dg2xQ0tlWY8rESaRhw9WKszycrBbcR
         9zwQgjqvtUuT75l1tmulahwqCq9WqqpS0Gl82NUW4tl67TIK9sqMyuolojGXQFKUXiEH
         JruQ==
X-Gm-Message-State: AGi0PuZ22lD5Xd1ru3ESKu6XiHLNSi3Hzyurk6Loppc/mqdZusbNFF9L
        vo/Rny6AX5HsvxEEWzBj7jXX2g==
X-Google-Smtp-Source: APiQypLKC1eYBIJEQSftPCEpKucLkLsl9E3R3bE56ebfjr+BqL6bkLixosIGS46bokv29dR4G89U2w==
X-Received: by 2002:a5d:658e:: with SMTP id q14mr4572943wru.92.1587135478501;
        Fri, 17 Apr 2020 07:57:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h16sm35085542wrw.36.2020.04.17.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 07:57:57 -0700 (PDT)
Date:   Fri, 17 Apr 2020 16:57:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Yussuf Khalil <dev@pp3345.net>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/modes: Indicate CEA-861 CE modes to user-space
Message-ID: <20200417145755.GL3456981@phenom.ffwll.local>
Mail-Followup-To: Yussuf Khalil <dev@pp3345.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200413214024.46500-1-dev@pp3345.net>
 <20200413214024.46500-2-dev@pp3345.net>
 <20200414124132.GV3456981@phenom.ffwll.local>
 <ac01c47a3b2c2ac73368882fb90eb6ee4e07fd04.camel@pp3345.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac01c47a3b2c2ac73368882fb90eb6ee4e07fd04.camel@pp3345.net>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 03:51:36PM +0200, Yussuf Khalil wrote:
> On Tue, 2020-04-14 at 14:41 +0200, Daniel Vetter wrote:
> > On Mon, Apr 13, 2020 at 11:40:22PM +0200, Yussuf Khalil wrote:
> > > Add a new flag to mark modes that are considered a CE mode
> > > according to the
> > > CEA-861 specification. Modes without this flag are implicitly
> > > considered to
> > > be IT modes.
> > > 
> > > User-space applications may use this flag to determine possible
> > > implications of using a CE mode (e.g., limited RGB range).
> > > 
> > > There is no use for this flag inside the kernel, so we set it only
> > > when
> > > communicating a mode to user-space.
> > > 
> > > Signed-off-by: Yussuf Khalil <dev@pp3345.net>
> > 
> > Do we have userspace for this?
> > 
> > If we go with the existing quant range property you don't need new
> > userspace for the property itself. But this flag here is new uapi, so
> > needs userspace per
> > 
> > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
> > 
> > Also since this standardizes kms uapi, we need testcases per
> > 
> > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#testing-requirements-for-userspace-api
> > 
> > Cheers, Daniel
> > 
> > > ---
> > >  drivers/gpu/drm/drm_modes.c | 14 ++++++++++++++
> > >  include/uapi/drm/drm_mode.h |  2 ++
> > >  2 files changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_modes.c
> > > b/drivers/gpu/drm/drm_modes.c
> > > index d4d64518e11b..0d8a032f437d 100644
> > > --- a/drivers/gpu/drm/drm_modes.c
> > > +++ b/drivers/gpu/drm/drm_modes.c
> > > @@ -1973,6 +1973,14 @@ void drm_mode_convert_to_umode(struct
> > > drm_mode_modeinfo *out,
> > >  		break;
> > >  	}
> > >  
> > > +	if (drm_match_cea_mode(in) > 1) {
> > > +		/*
> > > +		 * All modes in CTA-861-G Table 1 are CE modes, except
> > > 640x480p
> > > +		 * (VIC 1).
> > > +		 */
> > > +		out->flags |= DRM_MODE_FLAG_CEA_861_CE_MODE;
> > > +	}
> > > +
> > >  	strncpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
> > >  	out->name[DRM_DISPLAY_MODE_LEN-1] = 0;
> > >  }
> > > @@ -2045,6 +2053,12 @@ int drm_mode_convert_umode(struct drm_device
> > > *dev,
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > +	/*
> > > +	 * The CEA-861 CE mode flag is purely informational and
> > > intended for
> > > +	 * userspace only.
> > > +	 */
> > > +	out->flags &= ~DRM_MODE_FLAG_CEA_861_CE_MODE;
> > > +
> > >  	out->status = drm_mode_validate_driver(dev, out);
> > >  	if (out->status != MODE_OK)
> > >  		return -EINVAL;
> > > diff --git a/include/uapi/drm/drm_mode.h
> > > b/include/uapi/drm/drm_mode.h
> > > index 735c8cfdaaa1..5e78b350b2e2 100644
> > > --- a/include/uapi/drm/drm_mode.h
> > > +++ b/include/uapi/drm/drm_mode.h
> > > @@ -124,6 +124,8 @@ extern "C" {
> > >  #define  DRM_MODE_FLAG_PIC_AR_256_135 \
> > >  			(DRM_MODE_PICTURE_ASPECT_256_135<<19)
> > >  
> > > +#define DRM_MODE_FLAG_CEA_861_CE_MODE (1<<23)
> > > +
> > >  #define  DRM_MODE_FLAG_ALL	(DRM_MODE_FLAG_PHSYNC |		\
> > >  				 DRM_MODE_FLAG_NHSYNC |		\
> > >  				 DRM_MODE_FLAG_PVSYNC |		\
> > > -- 
> > > 2.26.0
> > > 
> 
> Sorry, I wasn't aware DRM had these additional requirements. I do have a user-
> space implementation in mutter and gnome-control-center that makes use of the
> new property and this flag on my local machine. I'll try to propose the branch
> upstream before sending in the next revision of this patchset.
> 
> Do I understand it correctly that this will require test cases for both the
> property itself and the new flag? I'll write a patch for IGT then.

Yup. We even have some edid injection stuff so you can (for some value of
"can") test this on systems without such a monitor. That would obviously
be the gold standard for this, so that CI systems can make sure we don't
break any of this in the driver side.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
