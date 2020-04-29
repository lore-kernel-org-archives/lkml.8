Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B0DC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B90D20775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgD2I5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:57:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:46002 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2I5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:57:12 -0400
IronPort-SDR: isBu9Z1pGPDlCmRj/kuPdOzWYOyBuDk+1JcX28bxHaC77vSYm987N694nerLyiy/lWSh/WSuJG
 m/7OylOibm8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 01:57:12 -0700
IronPort-SDR: G4/d0UbJqdjex9NZ6XaktL1Z/yKFjmRFbM2as3Tz/2G6uUXxKSC069rzY+LenK12JSxhW/Cwv9
 wGjUWjT7kvVg==
X-IronPort-AV: E=Sophos;i="5.73,331,1583222400"; 
   d="scan'208";a="432490237"
Received: from jwerner6-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.46.246])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 01:57:08 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Michal Orzel <michalorzel.eng@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org,
        Michal Orzel <michalorzel.eng@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Replace drm_modeset_lock/unlock_all with DRM_MODESET_LOCK_ALL_* helpers
In-Reply-To: <1588093804-30446-1-git-send-email-michalorzel.eng@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1588093804-30446-1-git-send-email-michalorzel.eng@gmail.com>
Date:   Wed, 29 Apr 2020 11:57:05 +0300
Message-ID: <875zdiacv2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020, Michal Orzel <michalorzel.eng@gmail.com> wrote:
> As suggested by the TODO list for the kernel DRM subsystem, replace
> the deprecated functions that take/drop modeset locks with new helpers.
>
> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
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

I cry a little every time I look at the DRM_MODESET_LOCK_ALL_BEGIN and
DRM_MODESET_LOCK_ALL_END macros. :(

Currently only six users... but there are ~60 calls to
drm_modeset_lock_all{,_ctx} that I presume are to be replaced. I wonder
if this will come back and haunt us.

BR,
Jani.


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

-- 
Jani Nikula, Intel Open Source Graphics Center
