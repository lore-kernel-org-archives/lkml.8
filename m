Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F12C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C34D20735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Cnt9unex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCQRCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:02:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36872 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQRCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:02:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id a141so72389wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fba/U9otc2Taw+dP1ayFE6PdkE156208ze8hBWbP5a0=;
        b=Cnt9unexUh7DiO8/+NFCYWS6n4xihEaetGa9wprZioX0B5ztpZhNHZa1z+2KRnvfWc
         WowDv3qSzyU+n5zlmaxOryg9osqcQL8P6I1u7bpW2c1aOrs+kq5fUBlulwSd/TX2Cf7Y
         GE1nPLfhIjXMkIp+5+Wgpw/iv+wn0WIGofvNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Fba/U9otc2Taw+dP1ayFE6PdkE156208ze8hBWbP5a0=;
        b=PokCWv0rdahjs20/j3nSAsxs+4b/RRcWspqzaAgJveUbRs7+Rm9+tr53B5Di/RK6eu
         Q+7aM89XqYYWueqEjNm2cRQNdYidxN4NRmGx7EhEl2hAJhPOuSX+F+JUQE5w52aml6Qd
         IL4i2cVvHdhIFst/ly3bgWA5fQz9OB8h4/yfAgMpdPcTy6DcawIM1Nz5Pkrsb4ErZx7G
         8WcQVCy0m5aG+lHH+1XGyTVS9roSZX1z89YtLTl7+9ei08dj9RhfYgy5kz8tv8y8t2rc
         fIVY6mNwAe1djeC3WuynKo9z8Y9qRvlNIlPF/slI1ZuYRCld04OgDeUE7ZJu3XW1UhIM
         hw+A==
X-Gm-Message-State: ANhLgQ2hp7HDJEhnSWXEk8fxZdmAajRypicc9fpbBLY+cJnPRN8RoH/a
        yvA99YniJx/g93RCHI1cipE6bg==
X-Google-Smtp-Source: ADFU+vtWZkm5YFA2wKbGqBsADcieSlIQinWEBnhNpwFvx09DRAxMcKI1mmVSAsGI36f/KlGOMFUewQ==
X-Received: by 2002:a7b:c3ca:: with SMTP id t10mr231733wmj.69.1584464566676;
        Tue, 17 Mar 2020 10:02:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n14sm63632wmi.19.2020.03.17.10.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 10:02:45 -0700 (PDT)
Date:   Tue, 17 Mar 2020 18:02:43 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/lease: fix potential race in fill_object_idr
Message-ID: <20200317170243.GR2363188@phenom.ffwll.local>
Mail-Followup-To: Qiujun Huang <hqjagain@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1584343103-13896-1-git-send-email-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584343103-13896-1-git-send-email-hqjagain@gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 03:18:23PM +0800, Qiujun Huang wrote:
> We should hold idr_mutex for idr_alloc.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>

I've not seen the first version of this anywhere in my inbox, not sure
where that got lost.

Anyway, this seems like a false positive - I'm assuming this was caught
with KCSAN. The commit message really should mention that.

fill_object_idr creates the idr, which yes is only access later on under
the idr_mutex. But here it's not yet visible to any other thread, and
hence lockless access is safe and correct.

No idea what the KCSAN complains about safe access like this best practice
is.
-Daniel

> ---
>  drivers/gpu/drm/drm_lease.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> index b481caf..427ee21 100644
> --- a/drivers/gpu/drm/drm_lease.c
> +++ b/drivers/gpu/drm/drm_lease.c
> @@ -418,6 +418,7 @@ static int fill_object_idr(struct drm_device *dev,
>  		goto out_free_objects;
>  	}
>  
> +	mutex_lock(&dev->mode_config.idr_mutex);
>  	/* add their IDs to the lease request - taking into account
>  	   universal planes */
>  	for (o = 0; o < object_count; o++) {
> @@ -437,7 +438,7 @@ static int fill_object_idr(struct drm_device *dev,
>  		if (ret < 0) {
>  			DRM_DEBUG_LEASE("Object %d cannot be inserted into leases (%d)\n",
>  					object_id, ret);
> -			goto out_free_objects;
> +			goto out_unlock;
>  		}
>  		if (obj->type == DRM_MODE_OBJECT_CRTC && !universal_planes) {
>  			struct drm_crtc *crtc = obj_to_crtc(obj);
> @@ -445,20 +446,22 @@ static int fill_object_idr(struct drm_device *dev,
>  			if (ret < 0) {
>  				DRM_DEBUG_LEASE("Object primary plane %d cannot be inserted into leases (%d)\n",
>  						object_id, ret);
> -				goto out_free_objects;
> +				goto out_unlock;
>  			}
>  			if (crtc->cursor) {
>  				ret = idr_alloc(leases, &drm_lease_idr_object, crtc->cursor->base.id, crtc->cursor->base.id + 1, GFP_KERNEL);
>  				if (ret < 0) {
>  					DRM_DEBUG_LEASE("Object cursor plane %d cannot be inserted into leases (%d)\n",
>  							object_id, ret);
> -					goto out_free_objects;
> +					goto out_unlock;
>  				}
>  			}
>  		}
>  	}
>  
>  	ret = 0;
> +out_unlock:
> +	mutex_unlock(&dev->mode_config.idr_mutex);
>  out_free_objects:
>  	for (o = 0; o < object_count; o++) {
>  		if (objects[o])
> -- 
> 1.8.3.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
