Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02A0C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3FD2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SAi6aRue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440149AbgDNMlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730818AbgDNMlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:41:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C34C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:41:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id u13so13661463wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=EOTA3Bl8xK7jbI/7Nx56mhbuxCAqHFdnbLl81CCUHsQ=;
        b=SAi6aRueQ5Zyf7tLT2VCOAgQfNIxII4FkFQe+ghkqK3mPNmGOXJYz88+RE3XsXdRi6
         pI0oSaGVyF7xDMAM9kwkKlt7DjRomsEap9SMshCDqJXjPRJo2hwkBrrB0P9+mCDiBJ3x
         kRKLEK5KpPf4yrnR71LhJXZxP/UV/q63+DjlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EOTA3Bl8xK7jbI/7Nx56mhbuxCAqHFdnbLl81CCUHsQ=;
        b=iQhN46iAk1jlQ50ZUsGKWIKxmNjEIe7o8/ppYAC42c9y0KAFpVAhR66fqqkhOOGzyS
         CFm9whs0kGv1JSdqEO/0cyK0sZXmopJ7R3/H+JN89Rg51xNcRNCb+IPz1lX5Kq7fl2/K
         ol0srAxrIASlT7aT4EyrMGTzyYm7rbox6EzMMKaocdiS10swnyKio60yVOjPlu9gbbY2
         dBwUHpzECkmnnqJUCb9N30ITGeAqH2wgPP1qZprzYZIBwOYz9cxcy1xUCp+OiU0q+eWN
         gJ7VX5/6D9s+CcV4tmxrtxPTnY9+AqLsymPnts7GNVow0eVnddOX0FH2/X/K+YL00Y6c
         szpA==
X-Gm-Message-State: AGi0PubaPtbEyNq8wVOI2xJWoKUKzzn5MfYPJxmojiXF5zSY2j4pbpR4
        fM607R7YCFLX1TW4LmFVj6GNiA==
X-Google-Smtp-Source: APiQypLKGFmCSvctczx8VqjOVo8EhZPFdvd9ehQw9JMKKTphUeYZwccZm2MYcJ+RgiNCMDJUQcRwEQ==
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr23416418wrj.165.1586868095238;
        Tue, 14 Apr 2020 05:41:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v21sm18064169wmj.8.2020.04.14.05.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 05:41:34 -0700 (PDT)
Date:   Tue, 14 Apr 2020 14:41:32 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Yussuf Khalil <dev@pp3345.net>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/modes: Indicate CEA-861 CE modes to user-space
Message-ID: <20200414124132.GV3456981@phenom.ffwll.local>
Mail-Followup-To: Yussuf Khalil <dev@pp3345.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200413214024.46500-1-dev@pp3345.net>
 <20200413214024.46500-2-dev@pp3345.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413214024.46500-2-dev@pp3345.net>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 11:40:22PM +0200, Yussuf Khalil wrote:
> Add a new flag to mark modes that are considered a CE mode according to the
> CEA-861 specification. Modes without this flag are implicitly considered to
> be IT modes.
> 
> User-space applications may use this flag to determine possible
> implications of using a CE mode (e.g., limited RGB range).
> 
> There is no use for this flag inside the kernel, so we set it only when
> communicating a mode to user-space.
> 
> Signed-off-by: Yussuf Khalil <dev@pp3345.net>

Do we have userspace for this?

If we go with the existing quant range property you don't need new
userspace for the property itself. But this flag here is new uapi, so
needs userspace per

https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements

Also since this standardizes kms uapi, we need testcases per

https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#testing-requirements-for-userspace-api

Cheers, Daniel

> ---
>  drivers/gpu/drm/drm_modes.c | 14 ++++++++++++++
>  include/uapi/drm/drm_mode.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index d4d64518e11b..0d8a032f437d 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -1973,6 +1973,14 @@ void drm_mode_convert_to_umode(struct drm_mode_modeinfo *out,
>  		break;
>  	}
>  
> +	if (drm_match_cea_mode(in) > 1) {
> +		/*
> +		 * All modes in CTA-861-G Table 1 are CE modes, except 640x480p
> +		 * (VIC 1).
> +		 */
> +		out->flags |= DRM_MODE_FLAG_CEA_861_CE_MODE;
> +	}
> +
>  	strncpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
>  	out->name[DRM_DISPLAY_MODE_LEN-1] = 0;
>  }
> @@ -2045,6 +2053,12 @@ int drm_mode_convert_umode(struct drm_device *dev,
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * The CEA-861 CE mode flag is purely informational and intended for
> +	 * userspace only.
> +	 */
> +	out->flags &= ~DRM_MODE_FLAG_CEA_861_CE_MODE;
> +
>  	out->status = drm_mode_validate_driver(dev, out);
>  	if (out->status != MODE_OK)
>  		return -EINVAL;
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 735c8cfdaaa1..5e78b350b2e2 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -124,6 +124,8 @@ extern "C" {
>  #define  DRM_MODE_FLAG_PIC_AR_256_135 \
>  			(DRM_MODE_PICTURE_ASPECT_256_135<<19)
>  
> +#define DRM_MODE_FLAG_CEA_861_CE_MODE (1<<23)
> +
>  #define  DRM_MODE_FLAG_ALL	(DRM_MODE_FLAG_PHSYNC |		\
>  				 DRM_MODE_FLAG_NHSYNC |		\
>  				 DRM_MODE_FLAG_PVSYNC |		\
> -- 
> 2.26.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
