Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A75C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37BA42089D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="X1hTfLoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbgEYOfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgEYOfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:35:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849D0C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 07:35:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i15so17216142wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3OU2lYvY+SgqrcHfEfITErhSII62zeceqi2ma+ikPJY=;
        b=X1hTfLoD64dbKVoSZ+vwSnV9fWQwb8cTzyukLe5M1BtHLmVBqrtcEIzfnkBf0/IVjB
         25zaYqXUbaLAJ4EW2Wk4l/pEJnYzaZD3uvLuyqHus2MwSc0OITjhfOnFKNAnWUioWLQS
         CpvRiIGR12yq9kOr25XfcmcBgA8J7bVvjwPF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3OU2lYvY+SgqrcHfEfITErhSII62zeceqi2ma+ikPJY=;
        b=MsyigAvx8wFHsL/HgAAEYCDN456NLwE/jEkj3g0ppnl6OdcWyRxZeD3Y6QsfbxKYx7
         a/P9aEhF0ExmT/ianycV0sHHUHUlq4ygLuIM0DdhSFfODPZkx9UuHzQ8+2qXYJKKT+Bh
         FR7SC/Kh67dN12OGITMRD1JyIx3miBifgJUNw1rnh9uRCNHBL2mxjvCeWqXc4J1IGuKV
         P+vYllnku1qwGKeIb6TRkGZpj2cUIRGcd0J2LNMZE06WLZ9mfU9pVjL//0imftyOfSmE
         iBYHLNs7xZ/DJeVGCKfpMBEcA7jMsd+7olUC+LURlIM2pit/HWqn2k/tU60Pxp4kLSw2
         /+HQ==
X-Gm-Message-State: AOAM533UctoWvkAaVs88oAZjXTQbTwu/Ku4FDu1vmIEj7kWFuXbYtr3I
        EJvcsehCI/rDMEvYQuBjLqcEVw==
X-Google-Smtp-Source: ABdhPJwBXEHr/oPTzKNcxF+wDGOoNbeb15FlnUtmBXIYPHPQJpdKoGoFjeAH8PP4KrvL6dakayuN5g==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr15249258wrw.256.1590417341101;
        Mon, 25 May 2020 07:35:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i3sm13285293wrm.83.2020.05.25.07.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 07:35:40 -0700 (PDT)
Date:   Mon, 25 May 2020 16:35:38 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Colin King <colin.king@canonical.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/auth: remove redundant assignment to variable
 ret
Message-ID: <20200525143538.GH206103@phenom.ffwll.local>
Mail-Followup-To: Colin King <colin.king@canonical.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200524222715.27305-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524222715.27305-1-colin.king@canonical.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 11:27:15PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with a value that is
> never read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Queued up, but probably for 5.9. Thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_auth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> index 800ac39f3213..74ce0c29c960 100644
> --- a/drivers/gpu/drm/drm_auth.c
> +++ b/drivers/gpu/drm/drm_auth.c
> @@ -282,7 +282,7 @@ static void drm_drop_master(struct drm_device *dev,
>  int drm_dropmaster_ioctl(struct drm_device *dev, void *data,
>  			 struct drm_file *file_priv)
>  {
> -	int ret = -EINVAL;
> +	int ret;
>  
>  	mutex_lock(&dev->master_mutex);
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
