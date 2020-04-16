Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E1C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6092E206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pp3345.net header.i=@pp3345.net header.b="LPvAOFTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgDPPGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:06:31 -0400
Received: from saul.pp3345.net ([163.172.111.124]:53468 "EHLO saul.pp3345.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392443AbgDPNwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:52:12 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: dev@pp3345.net)
        by saul.pp3345.net (Postcow) with ESMTPSA id 90B299A4642;
        Thu, 16 Apr 2020 15:51:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pp3345.net; s=saul;
        t=1587045100; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:autocrypt;
        bh=p72sMrzpjiFBe093N4lGaIhYqi5PDODmXWZRAmXL3do=;
        b=LPvAOFTHvmx2f6lB1iTk8U8tLB6dV9w5XwqI7PJuJaYAwrda2p7+AiHFfT3/PhQQzDYjDP
        oPxW4oVvEGSuJ0qS6/XkwSD/o7Z8N+mjBfqQbkCc2YRcHuY0A5D7BxZyjynC2WdSyKBt2n
        fBpqBRrq94kWjSoEoG9Q3NqfI8iG400Dd9g2Egy2dvd36Yih+uTDewxdd4AQWXuZxA2Emo
        //TVSphDSFvYpJmaxFI/giDgAoSBjvgeUA3pq9MF4bek4K2uzIdxlnMPiLdSL+XNRrVXGR
        VR0LhnxS6k24xrcs/h68mw/rC2ZYj9P66mQfOmcPHX6CakBpfSHwpXAnT6AkEA==
Message-ID: <ac01c47a3b2c2ac73368882fb90eb6ee4e07fd04.camel@pp3345.net>
Subject: Re: [PATCH 1/5] drm/modes: Indicate CEA-861 CE modes to user-space
From:   Yussuf Khalil <dev@pp3345.net>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Apr 2020 15:51:36 +0200
In-Reply-To: <20200414124132.GV3456981@phenom.ffwll.local>
References: <20200413214024.46500-1-dev@pp3345.net>
         <20200413214024.46500-2-dev@pp3345.net>
         <20200414124132.GV3456981@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-14 at 14:41 +0200, Daniel Vetter wrote:
> On Mon, Apr 13, 2020 at 11:40:22PM +0200, Yussuf Khalil wrote:
> > Add a new flag to mark modes that are considered a CE mode
> > according to the
> > CEA-861 specification. Modes without this flag are implicitly
> > considered to
> > be IT modes.
> > 
> > User-space applications may use this flag to determine possible
> > implications of using a CE mode (e.g., limited RGB range).
> > 
> > There is no use for this flag inside the kernel, so we set it only
> > when
> > communicating a mode to user-space.
> > 
> > Signed-off-by: Yussuf Khalil <dev@pp3345.net>
> 
> Do we have userspace for this?
> 
> If we go with the existing quant range property you don't need new
> userspace for the property itself. But this flag here is new uapi, so
> needs userspace per
> 
> https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
> 
> Also since this standardizes kms uapi, we need testcases per
> 
> https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#testing-requirements-for-userspace-api
> 
> Cheers, Daniel
> 
> > ---
> >  drivers/gpu/drm/drm_modes.c | 14 ++++++++++++++
> >  include/uapi/drm/drm_mode.h |  2 ++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_modes.c
> > b/drivers/gpu/drm/drm_modes.c
> > index d4d64518e11b..0d8a032f437d 100644
> > --- a/drivers/gpu/drm/drm_modes.c
> > +++ b/drivers/gpu/drm/drm_modes.c
> > @@ -1973,6 +1973,14 @@ void drm_mode_convert_to_umode(struct
> > drm_mode_modeinfo *out,
> >  		break;
> >  	}
> >  
> > +	if (drm_match_cea_mode(in) > 1) {
> > +		/*
> > +		 * All modes in CTA-861-G Table 1 are CE modes, except
> > 640x480p
> > +		 * (VIC 1).
> > +		 */
> > +		out->flags |= DRM_MODE_FLAG_CEA_861_CE_MODE;
> > +	}
> > +
> >  	strncpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
> >  	out->name[DRM_DISPLAY_MODE_LEN-1] = 0;
> >  }
> > @@ -2045,6 +2053,12 @@ int drm_mode_convert_umode(struct drm_device
> > *dev,
> >  		return -EINVAL;
> >  	}
> >  
> > +	/*
> > +	 * The CEA-861 CE mode flag is purely informational and
> > intended for
> > +	 * userspace only.
> > +	 */
> > +	out->flags &= ~DRM_MODE_FLAG_CEA_861_CE_MODE;
> > +
> >  	out->status = drm_mode_validate_driver(dev, out);
> >  	if (out->status != MODE_OK)
> >  		return -EINVAL;
> > diff --git a/include/uapi/drm/drm_mode.h
> > b/include/uapi/drm/drm_mode.h
> > index 735c8cfdaaa1..5e78b350b2e2 100644
> > --- a/include/uapi/drm/drm_mode.h
> > +++ b/include/uapi/drm/drm_mode.h
> > @@ -124,6 +124,8 @@ extern "C" {
> >  #define  DRM_MODE_FLAG_PIC_AR_256_135 \
> >  			(DRM_MODE_PICTURE_ASPECT_256_135<<19)
> >  
> > +#define DRM_MODE_FLAG_CEA_861_CE_MODE (1<<23)
> > +
> >  #define  DRM_MODE_FLAG_ALL	(DRM_MODE_FLAG_PHSYNC |		\
> >  				 DRM_MODE_FLAG_NHSYNC |		\
> >  				 DRM_MODE_FLAG_PVSYNC |		\
> > -- 
> > 2.26.0
> > 

Sorry, I wasn't aware DRM had these additional requirements. I do have a user-
space implementation in mutter and gnome-control-center that makes use of the
new property and this flag on my local machine. I'll try to propose the branch
upstream before sending in the next revision of this patchset.

Do I understand it correctly that this will require test cases for both the
property itself and the new flag? I'll write a patch for IGT then.

Regards
Yussuf

