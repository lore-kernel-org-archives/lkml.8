Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32044C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AF3204EA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IN6t6bbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgHDQjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgHDQjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:39:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B676C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 09:39:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 88so38001020wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=JuoBRwybPo1fWFUEbP61Iiw0shO0ZWJeZNUhHhFFSik=;
        b=IN6t6bbEriwy5B0+cBII5zTqrUsLuw6IiJLJi2iTwX+xkmzib/8A99wXPIkBQz4/XZ
         2tqqV+1l9ZxR1VkXrgfcVD8Og8PouW4mMGocWHGph7kYSh15Aw4CGCkO08b3P+pMmqi6
         Z/so2jerKEmn7prTPEkGDVeJraZlFBOTNAYJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=JuoBRwybPo1fWFUEbP61Iiw0shO0ZWJeZNUhHhFFSik=;
        b=byBOkEM13Ycjrdhx1rCqbhucEq4pfnQZTexjka3q/zx8CFIsFyTxLEObPVzKlEwkA3
         g1BSRLi3xPuvgePSLuWmmyVbD09W1SCCecfl9zURVsNhHTbGLCxuL82dBIQO+cehBygw
         V6sBIh2an7EMYeY6sYGV47SKnFd0KXBtc0irWLQpz/NwAwOhEuIszqC/sHYqRp0NjhgX
         OUzWCbPC2gn/Pto1pzhH/CczDepMm6i3UTL1O98iKGOaupEfPnvuocLSmv4BN/EtPVYp
         9NKXmoFu+5gQt/LD1gHIAh+dkPUcO8JGTHIEOe8jiaD4MHEDynCFm5KgfChMg3HKF5OW
         Ws5w==
X-Gm-Message-State: AOAM533+CCHCHldcqbJMlocJYMdyOaaHPoQJzoP9fpiD7K+BcYMT16Dp
        3BldYpkMhadojZbT5H1R8HzXxQ==
X-Google-Smtp-Source: ABdhPJyndQxukD3h1NEdBq4GcWX84ZlX51VAfBQMBVVX9HzgwhENu/HdYjrzvFisAeSIPiJXaAhr/Q==
X-Received: by 2002:a5d:6a4a:: with SMTP id t10mr21416131wrw.360.1596559181804;
        Tue, 04 Aug 2020 09:39:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v12sm31197854wrs.2.2020.08.04.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 09:39:41 -0700 (PDT)
Date:   Tue, 4 Aug 2020 18:39:39 +0200
From:   daniel@ffwll.ch
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Sidong Yang <realwakka@gmail.com>, twoerner@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH] drm/vkms: guarantee vblank when capturing crc
Message-ID: <20200804163939.GK6419@phenom.ffwll.local>
Mail-Followup-To: Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Sidong Yang <realwakka@gmail.com>, twoerner@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
References: <20200801184929.2eaxyoq6fm3nk4ey@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801184929.2eaxyoq6fm3nk4ey@smtp.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 01, 2020 at 03:49:29PM -0300, Melissa Wen wrote:
> VKMS needs vblank interrupts enabled to capture CRC. When vblank is
> disabled, tests like kms_cursor_crc and kms_pipe_crc_basic getting stuck
> waiting for a capture that will not occur until vkms wakes up. This
> patch ensures that vblank remains enabled as long as the CRC capture is
> needed.
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
> endless wait. In the IGT code, calling a wait_for_vblank on preparing
> for CRC capture prevented the busy-wait. But the problem persisted in
> the pipe-A-cursor-dpms and -suspend subtests.
> 
> Checking the history, the pipe-A-cursor-dpms subtest was successful
> when, in vkms_atomic_commit_tail, instead of using the flip_done op, it
> used wait_for_vblanks. Another way to prevent blocking was
> wait_one_vblank when enabling crtc. However, in both cases,
> pipe-A-cursor-suspend persisted blocking in the 2nd start of CRC
> capture, which may indicate that something got stuck in the step of CRC
> setup. Indeed, wait_one_vblank in the crc setup was able to sync things
> and free all kms_cursor_crc subtests.
> 
> Besides, other alternatives to force enabling vblanks or prevent
> disabling them such as calling drm_crtc_put_vblank or modeset_enables
> before commit_planes + offdelay = 0, also unlock all subtests
> executions. These facts together converge on the lack of vblank to
> unblock the crc capture.
> 
> Finally, considering the vkms's dependence on vblank interruptions to
> perform tasks, this patch acquires a vblank ref when setup CRC source
> and releases ref when disabling crc capture, ensuring vblanks happen to
> compute CRC.
> 
> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> Co-developed-by: Sidong Yang <realwakka@gmail.com>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> Co-developed-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>

Excellent summary of the debug story.

> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 4af2f19480f4..1161eaa383f1 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -241,6 +241,14 @@ int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name)
>  
>  	ret = vkms_crc_parse_source(src_name, &enabled);
>  
> +	/* Ensure that vblank interruptions are enabled for crc capture */
> +	/* Enabling CRC: acquire vblank ref */

This comment just explains what the code does, that's not needed. The
first comment I think can be replaced if we create a little helper
function like

void vkms_set_composer(struct vkms_output, bool enable) {
	bool old_state;

	if (enabled)
		drm_crtc_vblank_get(crtc);

	spin_lock_irq(&out->lock);
	old_enable = out->composer_enabled;
	out->composer_enabled = enabled;
	spin_unlock_irq(&out->lock);

	if (old_enabled)
		drm_crtc_vblank_put(crtc);

}

This should also help as prep for the writeback work, where we have a 2nd
user that might need to enable the composer (maybe even need to switch to
refcounting the composer state then).

> +	if (enabled)
> +		drm_crtc_vblank_get(crtc);
> +	/* Disabling CRC: release vblank ref */
> +	if (!src_name)
> +		drm_crtc_vblank_put(crtc);

I'm not sure this correctly releases the vblank reference in all cases, I
think the suggestion in the helper function pseudo code should work
better. It does mean we temporarily elevate the vblank refcount if we go
enabled -> enabled, but that's not a problem since it's refcounted.

Cheers, Daniel

> +
>  	spin_lock_irq(&out->lock);
>  	out->composer_enabled = enabled;
>  	spin_unlock_irq(&out->lock);
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
