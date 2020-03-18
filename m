Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3546BC5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFB32076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="S9NtfciV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgCRP0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:26:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37316 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgCRP0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:26:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so2112276wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ftZVbPmZ/Gi9bDEF3JRvvSJu2bSq6nHdWYvLq6k9FmI=;
        b=S9NtfciVJ5bawZR3kAnkkFc5MIDh22w8czXEdYUVH+Ml18A1q85ppVb3OT2Es6LnCX
         RrMY3G1JWRQdJWRAgeGtrH6hWiklfkmnHHuKTeApabEV5N3te/UN9ZX7meKjiIGTTlu4
         fxIxAuHu/4tkaqlGy4JwO1nOyyR5okFtQHMJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ftZVbPmZ/Gi9bDEF3JRvvSJu2bSq6nHdWYvLq6k9FmI=;
        b=oMOI78tKIcmpDZkbodrmV0ay7oaEj5TYOBr12GPdmx4wJta7ifurUrIAcwtSNkBur8
         ciWfGnnHWbBa9BS8ndOmOgEwB6Swij/XtA46jwyFHJTYtzpCH1coFEfV1u6SKi1L/lK2
         2NLxeANNA71hbLEsrU5bl51sZEru3wxOmtnNggw70y9Jnq8pPsW4KXSWBXCVHwICe80k
         RuA/BwxYIEoKmxZNjdR9VW9QTtiyXJV+jszA6rfQ/NLOwdEan1VzfU/knDgAHLskBiGN
         A6GKGtULW8VQh52Z3NhlDyFoVVO7GZ7q7glLWe5X10J7KeaUob9DuFIHpmLnyMrciErd
         tJGg==
X-Gm-Message-State: ANhLgQ3ho8hGCt41cuffIfWM3+1GGajJJUd9o0A5eA1UNi3agtAOkTDC
        VQAO/NKL7WQIBBlyJ3GQKOKmlmf5+gUxKCK+
X-Google-Smtp-Source: ADFU+vs5nybEV7YJKuEwNm72dGWDm3pOnNTUz+tO14T/TeYa/T21zlqvpFrC0y8hF5JboKD7/evrKg==
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr5976823wrw.289.1584545191105;
        Wed, 18 Mar 2020 08:26:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f207sm4543994wme.9.2020.03.18.08.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 08:26:29 -0700 (PDT)
Date:   Wed, 18 Mar 2020 16:26:27 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 10/17] drm/vram-helper: make
 drm_vram_mm_debugfs_init() return 0
Message-ID: <20200318152627.GY2363188@phenom.ffwll.local>
Mail-Followup-To: Wambui Karuga <wambui.karugax@gmail.com>,
        airlied@linux.ie,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
 <20200310133121.27913-11-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310133121.27913-11-wambui.karugax@gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 04:31:14PM +0300, Wambui Karuga wrote:
> Since 987d65d01356 (drm: debugfs: make
> drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
> fails and should return void. Therefore, remove its use as the
> return value of drm_vram_mm_debugfs_init(), and have the function
> return 0 directly.
> 
> v2: have drm_vram_mm_debugfs_init() return 0 instead of void to avoid
> introducing build issues and build breakage.
> 
> References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_gem_vram_helper.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
> index 92a11bb42365..c8bcc8609650 100644
> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> @@ -1048,14 +1048,12 @@ static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
>   */
>  int drm_vram_mm_debugfs_init(struct drm_minor *minor)
>  {
> -	int ret = 0;
> -
>  #if defined(CONFIG_DEBUG_FS)

Just noticed that this #if here is not needed, we already have a dummy
function for that case. Care to write a quick patch to remove it? On top
of this patch series here ofc, I'm in the processing of merging the entire
pile.

Thanks, Daniel
> -	ret = drm_debugfs_create_files(drm_vram_mm_debugfs_list,
> -				       ARRAY_SIZE(drm_vram_mm_debugfs_list),
> -				       minor->debugfs_root, minor);
> +	drm_debugfs_create_files(drm_vram_mm_debugfs_list,
> +				 ARRAY_SIZE(drm_vram_mm_debugfs_list),
> +				 minor->debugfs_root, minor);
>  #endif
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL(drm_vram_mm_debugfs_init);
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
