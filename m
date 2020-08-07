Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E953CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F99821744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JQwvG7SK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHGJKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgHGJKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:10:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0A9C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 02:10:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f1so1002168wro.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 02:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=yIduASxOSE1is+l6ba3Ib+q/uSjP1gWsCSN6YMU1MGM=;
        b=JQwvG7SK70jkxfMfT30/3cNZrD0PDGXLYYzyABgNj0q59whRkvEyofQ6QxfiRLcKn6
         nO/Klfw7scX4KxlZij3JbF8aLOT94AYvbbF9BQq/2dIQsWwnJLd4is1d2M0gDhQOEYdy
         CXn5QDUOLpAVJvt/ZTysbRcCVI8yutvfQQ/00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=yIduASxOSE1is+l6ba3Ib+q/uSjP1gWsCSN6YMU1MGM=;
        b=p1QZG9xBpDDSH9mhvXmkMYmaTVPblwbF6rsY4/dtZdWOR8tUDhfZ36DSx7ousJST2R
         vq/Ta/5weHHPyjVvH9/kC3qS39qIFJTTOhmQA8TsaG9n7oLKyb1GugHfhpb/r3Hcro22
         +VyiTm3TrXL1VCHLf2POLXaWASJ6J+qWR2nVfAedhAeFJdMochZL6UNIrnui1NX7cu6o
         0Y7nIsMoILOxXp1uaUURoJLAhUn701VBrDdVUC6OM7MR+s8T8Dk9e0TErNXHEiL32M59
         8NXrj2rrxFq9hBggBo+k5UCqyzd8XBjg1wHCGMfwv3RMMN4A6axQ0DSn0ELkoa5UbhE4
         YIZw==
X-Gm-Message-State: AOAM532PqvVaCAbAr5gmAfNROz36THdELFoUp8fiMgU2XgJhH9WzftaF
        lF7LnHeO6gMzfPdyH16YEqV38A==
X-Google-Smtp-Source: ABdhPJw8ep9/pbXF2Su/zlcXhSRw0Tiq7c3D4P/Ith2AwJI316p7Uapmu81omHOlAmZusLXqij3mSg==
X-Received: by 2002:a5d:6a41:: with SMTP id t1mr10202625wrw.388.1596791446966;
        Fri, 07 Aug 2020 02:10:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c15sm9291026wme.23.2020.08.07.02.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:10:46 -0700 (PDT)
Date:   Fri, 7 Aug 2020 11:10:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Sidong Yang <realwakka@gmail.com>, twoerner@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2] drm/vkms: guarantee vblank when capturing crc
Message-ID: <20200807091044.GB2352366@phenom.ffwll.local>
Mail-Followup-To: Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Sidong Yang <realwakka@gmail.com>, twoerner@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
References: <20200806111705.xebopzucxr3367z4@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806111705.xebopzucxr3367z4@smtp.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 08:17:05AM -0300, Melissa Wen wrote:
> VKMS needs vblank interrupts enabled to capture CRC. When vblank is
> disabled, tests like kms_cursor_crc and kms_pipe_crc_basic getting stuck
> waiting for a capture that will not occur until vkms wakes up. This patch
> adds a helper to set composer and ensure that vblank remains enabled as
> long as the CRC capture is needed.
> 
> It clears the execution of the following kms_cursor_crc subtests:
> 1. pipe-A-cursor-[size,alpha-opaque, NxN-(on-screen, off-screen, sliding,
> random, fast-moving])] - successful when running individually.
> 2. pipe-A-cursor-dpms passes again
> 3. pipe-A-cursor-suspend also passes
> 
> The issue was initially tracked in the sequential execution of IGT
> kms_cursor_crc subtest: when running the test sequence or one of its
> subtests twice, the odd execs complete and the pairs get stuck in an
> endless wait. In the IGT code, calling a wait_for_vblank on preparing for
> CRC capture prevented the busy-wait. But the problem persisted in the
> pipe-A-cursor-dpms and -suspend subtests.
> 
> Checking the history, the pipe-A-cursor-dpms subtest was successful when,
> in vkms_atomic_commit_tail, instead of using the flip_done op, it used
> wait_for_vblanks. Another way to prevent blocking was wait_one_vblank when
> enabling crtc. However, in both cases, pipe-A-cursor-suspend persisted
> blocking in the 2nd start of CRC capture, which may indicate that
> something got stuck in the step of CRC setup. Indeed, wait_one_vblank in
> the crc setup was able to sync things and free all kms_cursor_crc
> subtests. Besides, other alternatives to force enabling vblanks or prevent
> disabling them such as calling drm_crtc_put_vblank or modeset_enables
> before commit_planes + offdelay = 0, also unlock all subtests executions.
> 
> Finally, due to vkms's dependence on vblank interruptions to perform
> tasks, this patch uses refcount to ensure that vblanks happen when
> enabling composer and while crc capture is needed.

For next time around, please include a patch changelog here so people know
what was changed, and why. E.g.

v2:
- extract a vkms_set_composer helper
- fix vblank refcounting for the disabling case

> 
> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> Co-developed-by: Sidong Yang <realwakka@gmail.com>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> Co-developed-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Daniel Vetter <daniel@ffwll.ch>

Nah that's a bit too much credit for me, I'll get the r-b tag. You &
Sidong figured this story out, so I'd use Co-debugged-by: Sidong here for
credits.

> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 20 +++++++++++++++++---
>  drivers/gpu/drm/vkms/vkms_drv.h      |  1 +
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index b8b060354667..e2ac2b9759bf 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -233,6 +233,22 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *src_name,
>  	return 0;
>  }
>  
> +void vkms_set_composer(struct vkms_output *out, bool enabled)

Since this isn't yet used outside of this file I'd just make this static.
Writeback connector support can then add the prototype in the header. With
that

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Please include that tag for revision 3.

Cheers, Daniel

> +{
> +	bool old_enabled;
> +
> +	if (enabled)
> +		drm_crtc_vblank_get(&out->crtc);
> +
> +	spin_lock_irq(&out->lock);
> +	old_enabled = out->composer_enabled;
> +	out->composer_enabled = enabled;
> +	spin_unlock_irq(&out->lock);
> +
> +	if (old_enabled)
> +		drm_crtc_vblank_put(&out->crtc);
> +}
> +
>  int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name)
>  {
>  	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
> @@ -241,9 +257,7 @@ int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name)
>  
>  	ret = vkms_crc_parse_source(src_name, &enabled);
>  
> -	spin_lock_irq(&out->lock);
> -	out->composer_enabled = enabled;
> -	spin_unlock_irq(&out->lock);
> +	vkms_set_composer(out, enabled);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index f4036bb0b9a8..2cc86d08bd4e 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -142,6 +142,7 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
>  			   size_t *values_cnt);
>  
>  /* Composer Support */
> +void vkms_set_composer(struct vkms_output *output, bool enabled);
>  void vkms_composer_worker(struct work_struct *work);
>  
>  #endif /* _VKMS_DRV_H_ */
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
