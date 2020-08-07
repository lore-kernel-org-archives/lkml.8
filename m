Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AABDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05AED221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="L751dIlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgHGNKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgHGNKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:10:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DDBC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 06:10:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a5so1628018wrm.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 06:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=h/9NLZ4ReA+HnaQVY6McKcG5jzY2nrGCSkB9IBxfWTk=;
        b=L751dIlgU27AYm2WGwfGweb8D0uvZR0rzfBZfvm5T1K7Tx2mDct5RcUgWLMjcXRCNG
         tDPSWr01eY0/HIpmUGdOygtzTm7gakHH5C0DHtsZIbDfxSofwaIJbihrxTV6xGEwXvy1
         my1Ws0TjqSRnIzGH1L7Ua8XDjiA07YBpegYHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=h/9NLZ4ReA+HnaQVY6McKcG5jzY2nrGCSkB9IBxfWTk=;
        b=UgSYtbnKcV1pWJXsV9SIZPuXnqgzOrRph1e18ui8M2LrpdGNorL6YZUvZL9u4jlywj
         anH15OcdPN6DGa6fbl00TMiZFlwvBjDSnCqYfAHwxybDWBK51f9PZLgZ7Xu8qEg0V1Cz
         NzayjjkKdK9gowPsP5IupJ4uERr7u3PRGLI3O+rU0/zxFc8NlIiQM4Vc1Nc2U6f9VRVh
         PphqIf8kndMAhPg88frHJL2mxeh2AN71QqbDDdU1SukOX9dDIKsXODpKSEFhCfAuuleu
         W3OMnNHpMaFD/RdqgO+Zf1jTYgPEeezXlTpCDAXdU2IiDi2nPDekvgYHOtOS2vE7mgCl
         gJ2Q==
X-Gm-Message-State: AOAM530dqzF/ecskeEgCG1WL9y8vG6OEQEfkteW0YVUm5Nac9vpXh3+Q
        ZZWZhQKRENvDDoC2HIecUT+QcA==
X-Google-Smtp-Source: ABdhPJzRC3u1EBaYAkd2FdtfLOXeNU8Du4KwE6MIjBntk/q16CUg6W1Gjnc0iKsJubIdyof6+6wssA==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr12124520wrs.297.1596805799195;
        Fri, 07 Aug 2020 06:09:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d7sm10840945wra.29.2020.08.07.06.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 06:09:58 -0700 (PDT)
Date:   Fri, 7 Aug 2020 15:09:56 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, 1882851@bugs.launchpad.net,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: fix unblank
Message-ID: <20200807130956.GE2352366@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, 1882851@bugs.launchpad.net,
        David Airlie <airlied@linux.ie>, Chia-I Wu <olvaffe@gmail.com>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200807105429.24208-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807105429.24208-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 12:54:29PM +0200, Gerd Hoffmann wrote:
> When going through a disable/enable cycle without changing the
> framebuffer the optimization added by commit 3954ff10e06e ("drm/virtio:
> skip set_scanout if framebuffer didn't change") causes the screen stay
> blank.  Add a bool to force an update to fix that.
> 
> Cc: 1882851@bugs.launchpad.net
> Fixes: 3954ff10e06e ("drm/virtio: skip set_scanout if framebuffer didn't change")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h     | 1 +
>  drivers/gpu/drm/virtio/virtgpu_display.c | 1 +
>  drivers/gpu/drm/virtio/virtgpu_plane.c   | 4 +++-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 9ff9f4ac0522..7b0c319f23c9 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -138,6 +138,7 @@ struct virtio_gpu_output {
>  	int cur_x;
>  	int cur_y;
>  	bool enabled;
> +	bool need_update;
>  };
>  #define drm_crtc_to_virtio_gpu_output(x) \
>  	container_of(x, struct virtio_gpu_output, crtc)
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index cc7fd957a307..378be5956b30 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -100,6 +100,7 @@ static void virtio_gpu_crtc_atomic_enable(struct drm_crtc *crtc,
>  	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
>  
>  	output->enabled = true;
> +	output->need_update = true;
>  }
>  
>  static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index 52d24179bcec..5948031a9ce8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -163,7 +163,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>  	    plane->state->src_w != old_state->src_w ||
>  	    plane->state->src_h != old_state->src_h ||
>  	    plane->state->src_x != old_state->src_x ||
> -	    plane->state->src_y != old_state->src_y) {
> +	    plane->state->src_y != old_state->src_y ||
> +	    output->need_update) {

Uh instead of hand-rolling what's essentially a drm_crtc_needs_modeset
check, why not use that one? atomic helpers try to keep the usual suspects
for state transitions already handy, to avoid every driver rolling their
own. Or do I miss something here?
-Daniel


>  		DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
>  			  bo->hw_res_handle,
>  			  plane->state->crtc_w, plane->state->crtc_h,
> @@ -178,6 +179,7 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>  					   plane->state->src_h >> 16,
>  					   plane->state->src_x >> 16,
>  					   plane->state->src_y >> 16);
> +		output->need_update = false;
>  	}
>  
>  	virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
> -- 
> 2.18.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
