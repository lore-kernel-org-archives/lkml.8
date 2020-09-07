Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20553C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D760E20732
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gI316Jq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgIGSRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgIGSRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:17:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336BEC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 11:17:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so16653303wrx.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=QAr1+0ipkVpkx5YO9BIZ97gdBS2//wH3zq/vWYPLIrs=;
        b=gI316Jq405Je2kwl9Dqk5oa+2uA8CtINsqRrQuzjeGDqNKqWJDnhaYrBjv04KRh5+r
         xzDWk/7Jj7r5+ew40cblbmARBwPs/aiUBtea76zjl1e5UEXCJJvLaq/grvlq7zijQiwW
         r8bHEPmG1AIVOklW4efeRnB9Ft1R9JZAinI2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=QAr1+0ipkVpkx5YO9BIZ97gdBS2//wH3zq/vWYPLIrs=;
        b=Ac72dijI588Cx2Ya/Q6jUAysKbPN1FviB0pwjxOPpwBu/X33bvaYMy5IhZAjUHVy0r
         rcuB+55cBy011sCpWW9baP9C8J6yg/Q6d5EpiN6JMcV9G6lhgJuFYSvUBhNl71HfeSjH
         dHGx0YVIAsWgSQ5CSwQVLUn6yD9zCS9KmExASpKensX+LAAay6FOcOYbmrBHGYJsaXN7
         PJmNT0WUR7ba0e24scF++32OBSQMH8fblkF9BnjyOWZf1CcPs6C3XsRCwq9wZ1+Zv6gb
         Y9IIHO49FU0S/oWTffJUjJ3+IL5iElTUfjozWuv027lwRzEQO3eNZ7sXsBU51FGxrAAH
         nSJg==
X-Gm-Message-State: AOAM533Qxco94yeK/bqs7cFwHIav2wzF6wrY6xfPHh8j25MlN5cZWRgt
        jBXyWRF2SMe0EZMLGW6rpz7+dA==
X-Google-Smtp-Source: ABdhPJwuITBLa7qo+WjXsX4qXTW2jiGBgHyMLzP5pTEfDes/HppbxX0Ga3nG3TPBjexQB4gCUQb0tQ==
X-Received: by 2002:adf:fa0c:: with SMTP id m12mr22363209wrr.406.1599502625885;
        Mon, 07 Sep 2020 11:17:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c145sm26200523wmd.7.2020.09.07.11.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 11:17:05 -0700 (PDT)
Date:   Mon, 7 Sep 2020 20:17:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] gpu/drm: cleanup coding style a bit
Message-ID: <20200907181703.GD2352366@phenom.ffwll.local>
Mail-Followup-To: Bernard Zhao <bernard@vivo.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20200907123129.27905-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907123129.27905-1-bernard@vivo.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 05:31:29AM -0700, Bernard Zhao wrote:
> Remove first assignment to info which is meaningless.
> Put the width and higth check first.
> This change is to make the code a bit readable.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Looks reasonable, thanks for your patch. Applied to drm-misc-next for
5.10.
-Daniel

> ---
>  drivers/gpu/drm/drm_framebuffer.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index df656366a530..2f5b0c2bb0fe 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -176,8 +176,7 @@ static int framebuffer_check(struct drm_device *dev,
>  	int i;
>  
>  	/* check if the format is supported at all */
> -	info = __drm_format_info(r->pixel_format);
> -	if (!info) {
> +	if (!__drm_format_info(r->pixel_format)) {
>  		struct drm_format_name_buf format_name;
>  
>  		DRM_DEBUG_KMS("bad framebuffer format %s\n",
> @@ -186,9 +185,6 @@ static int framebuffer_check(struct drm_device *dev,
>  		return -EINVAL;
>  	}
>  
> -	/* now let the driver pick its own format info */
> -	info = drm_get_format_info(dev, r);
> -
>  	if (r->width == 0) {
>  		DRM_DEBUG_KMS("bad framebuffer width %u\n", r->width);
>  		return -EINVAL;
> @@ -199,6 +195,9 @@ static int framebuffer_check(struct drm_device *dev,
>  		return -EINVAL;
>  	}
>  
> +	/* now let the driver pick its own format info */
> +	info = drm_get_format_info(dev, r);
> +
>  	for (i = 0; i < info->num_planes; i++) {
>  		unsigned int width = fb_plane_width(r->width, info, i);
>  		unsigned int height = fb_plane_height(r->height, info, i);
> -- 
> 2.28.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
