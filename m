Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321EFC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0624620678
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JEyxJJHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgICIpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgICIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:45:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B080CC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 01:45:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so2207949wrn.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 01:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/8hEgczsSwA5siMShAWCRj+Fa/wWaouVqRmrq4savc=;
        b=JEyxJJHSiduf3Z20lir53f8KwZEdsX/lWxPlh0m/E79yi9SQq9SA7WUsImF68DPkQM
         b0IHTMLspzmTMB6GkKRN/v2KGeohNti5YY4toHZT//MtRFLu4vYWlhJ45glSoq1iq3PP
         dO4dT7hCYUobXhNoukuhIXto9eNKIeUTGsPzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=w/8hEgczsSwA5siMShAWCRj+Fa/wWaouVqRmrq4savc=;
        b=WbmZwQf9vk25q5znbZXWt0qv3OFJPMkC9NbVX3HcM7hyaqyYL5IWG72jh9LkFDJyc3
         PSqOU0GOFbkbeHF6VUrzJYyq686euY2XDYCgeZ0wB9b/hYfLcXl/M1gyB7Fiu7xQFWMT
         bnjNyi3o3J/GbV8e/XKfzhoCJGaCKSCMJe9Zim1skM3nU7oPXvX/6mm5p9BMvCryVRdp
         /inDIbpsbejUeY/R3ke8anwucKv/MVpEkOuk4yiiOjz1UbRHbyeppO0M6RKDcm4oLLMJ
         gBPiZPPZau7lRaTc99u//d4wfTzEN+qvRr77uV49gjNAC9+ezyrJlx0Gdzb+HIRYRKHd
         VEcw==
X-Gm-Message-State: AOAM531APAqpgWa6fYVVM6G1sLMYvoJ6Xha6/GzKgYkvVjh3TlF2zMQT
        y3l2wN3JalEF0t/PsXVjO5NnNA==
X-Google-Smtp-Source: ABdhPJx30EL7M9pGuMwPSxIVWHfLkpax1C49r8vzGrTW34Tl1cKNPRCQWUvi96dX0LLOKxnVGLLT0A==
X-Received: by 2002:adf:e74d:: with SMTP id c13mr1188595wrn.45.1599122734444;
        Thu, 03 Sep 2020 01:45:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g7sm3561732wrv.82.2020.09.03.01.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 01:45:33 -0700 (PDT)
Date:   Thu, 3 Sep 2020 10:45:31 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bernard <bernard@vivo.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [Re-send][PATCH] gpu/drm: remove drm_modeset_lock protection for
 drm_error
Message-ID: <20200903084531.GJ2352366@phenom.ffwll.local>
Mail-Followup-To: Bernard <bernard@vivo.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <ADIABQBNDXyW8X9QUmo2xaoL.1.1599052622252.Hmail.bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ADIABQBNDXyW8X9QUmo2xaoL.1.1599052622252.Hmail.bernard@vivo.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 09:17:02PM +0800, Bernard wrote:
> In function drm_atomic_helper_shutdown, maybe there is no need
> to protect DRM_ERROR log in DRM_MODESET_LOCK_ALL_BEGIN &
> DRM_MODESET_LOCK_ALL_END. This change is to make code run a bit
> fast.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

This is only run at driver unload, so really no need to optimize anything
for speed. And I think this change makes the code less symmetric, so not
really worth it imo.

Similar with the via change, drm/via is very very legacy code where the
next step will be to just outright delete it all.

Thanks anyway for submitting the patches, in other places such a change
would indeed make sense I think.
-Daniel

> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 85d163f16801..8902fd6316fc 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3100,12 +3100,10 @@ void drm_atomic_helper_shutdown(struct drm_device *dev)
>  	int ret;
>  
>  	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
> -
>  	ret = drm_atomic_helper_disable_all(dev, &ctx);
> +	DRM_MODESET_LOCK_ALL_END(ctx, ret);
>  	if (ret)
>  		DRM_ERROR("Disabling all crtc's during unload failed with %i\n", ret);
> -
> -	DRM_MODESET_LOCK_ALL_END(ctx, ret);
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_shutdown);
>  
> -- 
> 2.17.1
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
