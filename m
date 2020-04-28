Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69034C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485D2206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H6SSYjBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgD1PPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728129AbgD1PPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:15:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1E9C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:15:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so3210045wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yn8M6g86OIpdWY0eWe5/lYcoIX+3NTjGSgF/ptBwm/o=;
        b=H6SSYjBwPWWXBB+0KzyoILouyMyDgGP9+FYTr8CMUDXP6C1qvRnD3rAzz7JrynNNb2
         zfQFn2TUJd4H5r/y8X4bJ2P2CdDKq6CuWHM9nLjY7XNYAzBfTAfXyD0D+k1Z2kL80FB8
         VCe6GNM5SqtLRv79fcmUAT4YRYKzewnb+mnKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Yn8M6g86OIpdWY0eWe5/lYcoIX+3NTjGSgF/ptBwm/o=;
        b=YwqFxTi2rMEpohe7EqVUCKzo8Dhca69Mh+FzlfmGFsUOM01LrCqmyhLPkieAYOeLXe
         p0aJTH6KN4lJzKec6cOkOuDIfDoEdx4Z9Y9Nk0hZqEGGi2T9GsJkJZLAFizNoef8LjWJ
         UeFZZGLksYX1FYM4sTwIUdvxGw618T9dhlxNylUXL2L1NeLMvy/pm5smDlUYK99CFY7G
         bMIt10GbtI4MxrrQSF1ak5zq/8dO2v//yfySCaBIjrhq76eZPH2OFQ5ir+JHAsnC66eW
         HjBouoELGt1qdD4Fghm9Accas0a4C+QunHLVnm6Xnl/IvJpdTjksU+9Q5RMIqhm19C85
         E5gw==
X-Gm-Message-State: AGi0PubWtzchKaFjnHsjGdIqyPZejIntg5uFrGxgPMJz73u7JMcZd79O
        B/4c5Uz3G56rb2ajtxoCdLM/wRY1CHY=
X-Google-Smtp-Source: APiQypLan+NIXwt1O7aY8prkzguSWZNpvGFzg72miI7QE6xRrwrxztj6bOJextickiVknRj1I2zyYA==
X-Received: by 2002:a7b:c104:: with SMTP id w4mr5112868wmi.8.1588086941313;
        Tue, 28 Apr 2020 08:15:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id s12sm3531003wmc.7.2020.04.28.08.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 08:15:40 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:15:38 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Michal Orzel <michalorzel.eng@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Replace drm_modeset_lock/unlock_all with
 DRM_MODESET_LOCK_ALL_* helpers
Message-ID: <20200428151538.GV3456981@phenom.ffwll.local>
Mail-Followup-To: Michal Orzel <michalorzel.eng@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1587895282-2808-1-git-send-email-michalorzel.eng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587895282-2808-1-git-send-email-michalorzel.eng@gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 12:01:22PM +0200, Michal Orzel wrote:
> As suggested by the TODO list for the kernel DRM subsystem, replace
> the deprecated functions that take/drop modeset locks with new helpers.
> 
> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>

Hm can you pls resubmit with intel-gfx mailing list cc'ed? There's a CI
bot there for checking stuff. Patch looks good, thanks a lot for doing
this.

Thanks, Daniel
> ---
>  drivers/gpu/drm/drm_mode_object.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> index 35c2719..901b078 100644
> --- a/drivers/gpu/drm/drm_mode_object.c
> +++ b/drivers/gpu/drm/drm_mode_object.c
> @@ -402,12 +402,13 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
>  {
>  	struct drm_mode_obj_get_properties *arg = data;
>  	struct drm_mode_object *obj;
> +	struct drm_modeset_acquire_ctx ctx;
>  	int ret = 0;
>  
>  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
>  		return -EOPNOTSUPP;
>  
> -	drm_modeset_lock_all(dev);
> +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
>  
>  	obj = drm_mode_object_find(dev, file_priv, arg->obj_id, arg->obj_type);
>  	if (!obj) {
> @@ -427,7 +428,7 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
>  out_unref:
>  	drm_mode_object_put(obj);
>  out:
> -	drm_modeset_unlock_all(dev);
> +	DRM_MODESET_LOCK_ALL_END(ctx, ret);
>  	return ret;
>  }
>  
> @@ -449,12 +450,13 @@ static int set_property_legacy(struct drm_mode_object *obj,
>  {
>  	struct drm_device *dev = prop->dev;
>  	struct drm_mode_object *ref;
> +	struct drm_modeset_acquire_ctx ctx;
>  	int ret = -EINVAL;
>  
>  	if (!drm_property_change_valid_get(prop, prop_value, &ref))
>  		return -EINVAL;
>  
> -	drm_modeset_lock_all(dev);
> +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
>  	switch (obj->type) {
>  	case DRM_MODE_OBJECT_CONNECTOR:
>  		ret = drm_connector_set_obj_prop(obj, prop, prop_value);
> @@ -468,7 +470,7 @@ static int set_property_legacy(struct drm_mode_object *obj,
>  		break;
>  	}
>  	drm_property_change_valid_put(prop, ref);
> -	drm_modeset_unlock_all(dev);
> +	DRM_MODESET_LOCK_ALL_END(ctx, ret);
>  
>  	return ret;
>  }
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
