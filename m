Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8F0C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5AF2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598253886;
	bh=2lv/37B9nrEMgkuh4/fhttxPoZfvqCbCNNw9Zi6mWjQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=r7kB0b5arX4pcdxO02dZPJ+E4Tsv5apUn6B8/WX7g5nvLBWfAwsoPUNlxF3TtvFAl
	 iZDeY+727Q2ZgTbmEM3PzwPfx8V1qqxLss5N6KMr5aE4/6U1Yc6nQD6MnHmF6I+bK5
	 PZFHMwqjlOGa+7/xxW21RHWPPS302SWMW3ACrV1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHXHYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:24:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37477 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgHXHYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:24:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id i26so7112782edv.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 00:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JQhe2TwsvYSS5W+dXPyOis7nazcu/3wqiq9MuxZoClE=;
        b=lN5tDO4HenNX1aJVgUE1A1Fn83H20KEnSktSX1BzBiDr62ftITwwG1MDCEjTWwjjQM
         vVWFHm6YtGqF9bQfYP1KlBsZsWIbdkA9Zfsu4daH4ev68fHEAeWPoVDpIIJMEGjTQ1cL
         uGUTnFwsNH/R3aDY3tx6IItvzJKFwowqgfEFlFRBwSGvx7InaHVy72VH72xrRA5Z82SJ
         pZyuZqtik01rfTRXFXurLYiFNhTLdmKG0gfzQVZd97/mar9RsTyPEIEmmGDkAL/cprqz
         KyvwA9sbQqsC+NAhizgA7J9FG3cYEpgyOlECN6ElMv/vURz9ixUWQq4pPD8WImtiBGaP
         aM2A==
X-Gm-Message-State: AOAM532Ffx0UwmhIvG3CJwoZVM+PcVDlicnuX5tq1CzjrlBjIk5+6jYk
        Qr809wyQJikExpxjmK2V8kg=
X-Google-Smtp-Source: ABdhPJz8DNv8UC+cvnA3KSEUH4jbL1XJhNOQ6zDRmRRPttp/pkFHhwmeO45aGK7OTDvv2Ia5IQ1Yqw==
X-Received: by 2002:a05:6402:1b02:: with SMTP id by2mr1245225edb.95.1598253882449;
        Mon, 24 Aug 2020 00:24:42 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id zm10sm5178531ejb.91.2020.08.24.00.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 00:24:41 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/virtio: fix unblank
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        1882851@bugs.launchpad.net
References: <20200818072511.6745-1-kraxel@redhat.com>
 <20200818072511.6745-2-kraxel@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <88ae71c2-c3ed-e0e4-e62c-bdf9d6534f2a@kernel.org>
Date:   Mon, 24 Aug 2020 09:24:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818072511.6745-2-kraxel@redhat.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 08. 20, 9:25, Gerd Hoffmann wrote:
> When going through a disable/enable cycle without changing the
> framebuffer the optimization added by commit 3954ff10e06e ("drm/virtio:
> skip set_scanout if framebuffer didn't change") causes the screen stay
> blank.  Add a bool to force an update to fix that.
> 
> v2: use drm_atomic_crtc_needs_modeset() (Daniel).
> 
> Cc: 1882851@bugs.launchpad.net
> Fixes: 3954ff10e06e ("drm/virtio: skip set_scanout if framebuffer didn't change")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Tested-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h     |  1 +
>  drivers/gpu/drm/virtio/virtgpu_display.c | 11 +++++++++++
>  drivers/gpu/drm/virtio/virtgpu_plane.c   |  4 +++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 9ff9f4ac0522..4ab1b0ba2925 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -138,6 +138,7 @@ struct virtio_gpu_output {
>  	int cur_x;
>  	int cur_y;
>  	bool enabled;
> +	bool needs_modeset;
>  };
>  #define drm_crtc_to_virtio_gpu_output(x) \
>  	container_of(x, struct virtio_gpu_output, crtc)
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 2c2742b8d657..6c26b41f4e0d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -123,6 +123,17 @@ static int virtio_gpu_crtc_atomic_check(struct drm_crtc *crtc,
>  static void virtio_gpu_crtc_atomic_flush(struct drm_crtc *crtc,
>  					 struct drm_crtc_state *old_state)
>  {
> +	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
> +
> +	/*
> +	 * virtio-gpu can't do modeset and plane update operations
> +	 * independant from each other.  So the actual modeset happens
> +	 * in the plane update callback, and here we just check
> +	 * whenever we must force the modeset.
> +	 */
> +	if (drm_atomic_crtc_needs_modeset(crtc->state)) {
> +		output->needs_modeset = true;
> +	}
>  }
>  
>  static const struct drm_crtc_helper_funcs virtio_gpu_crtc_helper_funcs = {
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index 52d24179bcec..65757409d9ed 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -163,7 +163,9 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>  	    plane->state->src_w != old_state->src_w ||
>  	    plane->state->src_h != old_state->src_h ||
>  	    plane->state->src_x != old_state->src_x ||
> -	    plane->state->src_y != old_state->src_y) {
> +	    plane->state->src_y != old_state->src_y ||
> +	    output->needs_modeset) {
> +		output->needs_modeset = false;
>  		DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
>  			  bo->hw_res_handle,
>  			  plane->state->crtc_w, plane->state->crtc_h,
> 


-- 
js
suse labs
