Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBB3C3F2D4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEBB246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QLC+z2Xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgB1XkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:40:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37796 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgB1XkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:40:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id a141so5162789wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=HPQ0vMjcYBqlg394dEQ/4gsJnXVnnOWOWAqm+ggMU98=;
        b=QLC+z2XfmDUoHotHgxdo22k3WQ516q+eTmA2xrFluquOvHy0d4Sd6g73yUVfYZ5fFR
         NO7D5YH3pAAqVFLcKS1iF1sbJvfU5pLf2MiGieaWJnVDO/cti25b05belwneJSun35uk
         602/rga6hTxrKRBu1psZf9zGwPquy0oltIeV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=HPQ0vMjcYBqlg394dEQ/4gsJnXVnnOWOWAqm+ggMU98=;
        b=otQp+3fMdOC5W41VWcm9UwQqHaaL81YUDWMNF8i2yF6+Y4rrg6WoxgyPaLwGSM7UBV
         SPTpRv521ZeSxZPyB37uombWC5FPrKtDgiscwhc0yEtCOHnXIZCu9+waIaBfMM/+sLZS
         duHgrOccG0agr2fD7YnXbALzCTlSt/jaVpECxmZl3dRcsz/gw+1+ZLd2NCVO1bdn5U3Y
         E55JOFVRnWe+ofheT/IvTePxN3/VRarRusYvADb4KkZUqHd5UtUfwfOrHORViN7AZ0b2
         6PshmyYoFlyULp95xOcIU3970kVhZjBUK0OT51lZdE9x/lFJiDSz0NlWcJPp5ZmOgj9i
         kaig==
X-Gm-Message-State: APjAAAW1V5O3Xe6S5dX7u7LYnvaP/X8FuN4N1ObCLckr71j7mZtoHZjI
        xKhfqhSirr7l69Auy//zZFakkg==
X-Google-Smtp-Source: APXvYqyO0iFrnGt7nWTY7vEtpiJdxw3S7UzoWgSGTzWNRpRcJrW749cnTPe1nXba5aAXJO42ot+jEQ==
X-Received: by 2002:a1c:7ec5:: with SMTP id z188mr6730603wmc.52.1582933220720;
        Fri, 28 Feb 2020 15:40:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t124sm4699111wmg.13.2020.02.28.15.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:40:19 -0800 (PST)
Date:   Sat, 29 Feb 2020 00:40:17 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm: prevent a harmless integer overflow in
 drm_legacy_sg_alloc()
Message-ID: <20200228234017.GB2363188@phenom.ffwll.local>
Mail-Followup-To: Dan Carpenter <dan.carpenter@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200228092321.axulddmkxrujkmas@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228092321.axulddmkxrujkmas@kili.mountain>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 12:23:21PM +0300, Dan Carpenter wrote:
> There is an integer overflow when we round up to PAGE_SIZE, but it's
> harmless because we never re-use "request->size" for anything meaningful.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This code predates git.

Also not compiled without CONFIG_DRM_LEGACY, which we tell everyone is to
enable the root holes in drm :-)

Thanks for your patch, queued in drm-misc-next.
-Daniel

> 
>  drivers/gpu/drm/drm_scatter.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
> index d5c386154246..ca520028b2cb 100644
> --- a/drivers/gpu/drm/drm_scatter.c
> +++ b/drivers/gpu/drm/drm_scatter.c
> @@ -99,6 +99,9 @@ int drm_legacy_sg_alloc(struct drm_device *dev, void *data,
>  	if (!drm_core_check_feature(dev, DRIVER_SG))
>  		return -EOPNOTSUPP;
>  
> +	if (request->size > SIZE_MAX - PAGE_SIZE)
> +		return -EINVAL;
> +
>  	if (dev->sg)
>  		return -EINVAL;
>  
> -- 
> 2.11.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
