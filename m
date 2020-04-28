Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003EDC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D292C21841
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KTinRLzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgD1PTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728431AbgD1PSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:18:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E994C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:18:17 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so3221853wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=EEU0pxcPFX3KP87PwUmGj9xWjqHNRrDzTBDgsvo+zrE=;
        b=KTinRLzrNGkjErt0YFPfEjur37+mTjuuNFWKuMYjujj75gJo4JuKBWlLUFpqe21kD8
         PuGx+XNt9x1outfQa8IQhPFA/zyJi9Ca7Qi5Fkgsb1ZfMD/D/oCBsFlKJqopuqj7OfS6
         k6tEL0y3Ta8cAOVsRinPJEt7/3vwn6tTL45Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EEU0pxcPFX3KP87PwUmGj9xWjqHNRrDzTBDgsvo+zrE=;
        b=SnP/ret7vbKkH7egufwuQoSQJ/GeRP12d1OTtACCZStcHcxZFmiEftAMpqF5PaveBn
         utF9grD8K/C2lQ8oC53o26RH1Xuf9MaNlpkDZda6onlYswWTb7lpcN8+29YoxotKGmU1
         Y8XJPGUwn0oCdjNnPxvDMA1hfBnUAPxrrwZfKbqOBM3RasnqQITxU7948TbtRlEUMKi+
         wj/s5pApqd407/Pv3viC//PQZvYssfnN1rkzG0dKN/Zy4mQvLajjseS2cAfw3mALOw//
         q+2osxF7mDXdNJuoZZWPo+tPFNucpUHiLqozRNKFaun06w0c2V62BuNBfIO5vPBctPwt
         llJg==
X-Gm-Message-State: AGi0PubaFI74Io32iA2a6AaErfJg19DH2vBi0OWn2G7QvPluV8P6rAJm
        HC6Y02sOqnJBqAr0PPooBjZWHg==
X-Google-Smtp-Source: APiQypKaVyMHjzYLTLGIxk+gUvL3MgOQUtvKn1okwXGtKQJUbFiYSWur99gy5wbOdKi7ODJQCqZVMA==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr5193048wmh.93.1588087095920;
        Tue, 28 Apr 2020 08:18:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f83sm3728864wmf.42.2020.04.28.08.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 08:18:15 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:18:13 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Michal Orzel <michalorzel.eng@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, ville.syrjala@linux.intel.com,
        chris@chris-wilson.co.uk, jose.souza@intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] Remove drm_display_mode.hsync
Message-ID: <20200428151813.GW3456981@phenom.ffwll.local>
Mail-Followup-To: Michal Orzel <michalorzel.eng@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        ville.syrjala@linux.intel.com, chris@chris-wilson.co.uk,
        jose.souza@intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
References: <1587974717-14599-1-git-send-email-michalorzel.eng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587974717-14599-1-git-send-email-michalorzel.eng@gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 10:05:17AM +0200, Michal Orzel wrote:
> As suggested by the TODO list of DRM subsystem:
> -remove the member hsync of drm_display_mode
> -convert code using hsync member to use drm_mode_hsync()
> 
> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>

I think Ville has a bunch of patches doing this, we might have some
overlap :-/ Adding Ville.

Please sync with him and get either of these patches reviewed.

Thanks, Daniel

> ---
>  drivers/gpu/drm/drm_modes.c                  |  6 +-----
>  drivers/gpu/drm/i915/display/intel_display.c |  1 -
>  include/drm/drm_modes.h                      | 10 ----------
>  3 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index d4d6451..0340079 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -752,16 +752,12 @@ EXPORT_SYMBOL(drm_mode_set_name);
>   * @mode: mode
>   *
>   * Returns:
> - * @modes's hsync rate in kHz, rounded to the nearest integer. Calculates the
> - * value first if it is not yet set.
> + * @modes's hsync rate in kHz, rounded to the nearest integer.
>   */
>  int drm_mode_hsync(const struct drm_display_mode *mode)
>  {
>  	unsigned int calc_val;
>  
> -	if (mode->hsync)
> -		return mode->hsync;
> -
>  	if (mode->htotal <= 0)
>  		return 0;
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index 3468466..ec7e943 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -8891,7 +8891,6 @@ void intel_mode_from_pipe_config(struct drm_display_mode *mode,
>  
>  	mode->clock = pipe_config->hw.adjusted_mode.crtc_clock;
>  
> -	mode->hsync = drm_mode_hsync(mode);
>  	mode->vrefresh = drm_mode_vrefresh(mode);
>  	drm_mode_set_name(mode);
>  }
> diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
> index 99134d4..7dab7f1 100644
> --- a/include/drm/drm_modes.h
> +++ b/include/drm/drm_modes.h
> @@ -391,16 +391,6 @@ struct drm_display_mode {
>  	int vrefresh;
>  
>  	/**
> -	 * @hsync:
> -	 *
> -	 * Horizontal refresh rate, for debug output in human readable form. Not
> -	 * used in a functional way.
> -	 *
> -	 * This value is in kHz.
> -	 */
> -	int hsync;
> -
> -	/**
>  	 * @picture_aspect_ratio:
>  	 *
>  	 * Field for setting the HDMI picture aspect ratio of a mode.
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
