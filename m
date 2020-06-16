Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A96C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A4220776
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H0amGzbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgFPMNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPMNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:13:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31681C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:13:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so20480512wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=XOpwR4mIR2BCAlfbtgwg7hVDYytNk2LC5Gn0C2pFEjI=;
        b=H0amGzbKmNHajF0PJbw8sQ0GVUVnGZbR5ikJ3UIrjhWzwtqmVos/IvMs5zlHorsuTe
         H6/Rn9mJXHaVeMVmkDsGytnzd5eu/63BgtnDKza/LvmRWe04CfIbaJ7VxhN6wc5527GZ
         jC5lZY1MtJ2HPn4LSF/yUc4agZjN0G+q5lPb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XOpwR4mIR2BCAlfbtgwg7hVDYytNk2LC5Gn0C2pFEjI=;
        b=TbOOyTGOpPn42N/itRtQS2xzMTvWP6CyqRZJmPq/fv4bGqCUIikfvLF8m5ITR1RFHl
         heDMADlSQdYjPo671FaWotWrMG698/hiugbgFGukB1bsa3Y6ZQcpFX6UaKVV6rdzMyZi
         HllKR0Q0dqeWOK9yG8YaN+vDt++E7VpbilcaaTXMVHl5OEIYLHzlzzJWFigITgQ9Ga9h
         VfDl3jHAymKM6xR2aLY9wA1pFmTvLm4Z+7UzQyWEHbcgAfnvlZ00FHgE+rL97SacWvKH
         nMAmfo7hb0mv6e5eGEIqb/sjgJj/gA6qPDuMwZinc3WV1vui9XlfA2Yox0JpGE/sm6AA
         GGQw==
X-Gm-Message-State: AOAM533AIpcARc0S5K91TL3CyJN3MDcrxrqV/T1D/yJy4WxsrWDbO3gD
        zGf0RvdbcWPbceqRjy9ltQVRfg==
X-Google-Smtp-Source: ABdhPJw/BfFtQEbS61mEKoH0YXR2JtcvUHpUygOCU7K0n0/KtoXZhakuzt4lYFic9+8J6LVf6k3NmA==
X-Received: by 2002:a5d:5483:: with SMTP id h3mr2900010wrv.10.1592309615920;
        Tue, 16 Jun 2020 05:13:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n204sm3991714wma.5.2020.06.16.05.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:13:35 -0700 (PDT)
Date:   Tue, 16 Jun 2020 14:13:33 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, daniel@ffwll.ch, chris@chris-wilson.co.uk
Subject: Re: [PATCH] drm/kselftest: fix spellint typo in test-drm_mm.c
Message-ID: <20200616121333.GO20149@phenom.ffwll.local>
Mail-Followup-To: Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, chris@chris-wilson.co.uk
References: <20200615121151.1557985-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615121151.1557985-1-standby24x7@gmail.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 09:11:51PM +0900, Masanari Iida wrote:
> This patch fix a spelling typo in test-drm_mm.c
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Applied, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/selftests/test-drm_mm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
> index 9aabe82dcd3a..31602134c515 100644
> --- a/drivers/gpu/drm/selftests/test-drm_mm.c
> +++ b/drivers/gpu/drm/selftests/test-drm_mm.c
> @@ -2359,7 +2359,7 @@ static int __init test_drm_mm_init(void)
>  	while (!random_seed)
>  		random_seed = get_random_int();
>  
> -	pr_info("Testing DRM range manger (struct drm_mm), with random_seed=0x%x max_iterations=%u max_prime=%u\n",
> +	pr_info("Testing DRM range manager (struct drm_mm), with random_seed=0x%x max_iterations=%u max_prime=%u\n",
>  		random_seed, max_iterations, max_prime);
>  	err = run_selftests(selftests, ARRAY_SIZE(selftests), NULL);
>  
> -- 
> 2.27.0.83.g0313f36c6ebe
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
