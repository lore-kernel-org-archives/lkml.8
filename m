Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BD9C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C062071B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="B0b0XZ+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgGOMFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgGOMFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:05:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDFDC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 05:05:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so2319553wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=AeobqevlgxW6S/1jvLpikz7Xrm71aKFvBeFHoL5vYBU=;
        b=B0b0XZ+i5RC8QqHCTi1/oPWnTYCTs8binzuyaCBrmwad7iS+ZyuVeakYQlEqMEYp1C
         AQaBkw13rbn/FoTf8p9gawQZJx/soYCdMXyJyompkc8wFsNop8LNAx5W1c+GSPwloEnk
         iZVMtt/kwRUz7kgyjXDD8vPV34og8PbV1h8k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=AeobqevlgxW6S/1jvLpikz7Xrm71aKFvBeFHoL5vYBU=;
        b=Pfls7Cana4lFxUUwz7ogeESnrmCO4No09dfnmkoffEmXP7YnvFeEDzTE34jLXef+8T
         lZd1/mWLjVFYHBS0R72WGDwxcj29Owy3BJPHz6mNystE42cNlSzkly46/c/vgoRyFzp0
         l4Hy4kdSXHPGXazVKkGvOPC7Zt2q/fW/ceDMqM4fBff+QKVDR8gWYCdGuGcW1wJcOIEL
         3D5IRT/GktzcuBL216Q1n0qcLNIMdgPwUXw7STxDvo7UVd28WweUHrqyqAcJz18wYcuo
         AjTtzIkZL0UjIoSxU57rcWTUQasOPLe0Y76qNeWvQdeU1+AXxVDJG5XAi+TdIw+aYXfQ
         x+Zg==
X-Gm-Message-State: AOAM532eIoEi3J/EviFD1vpDj6z4JzrK4DxWMGNkpLRDFVfRAB/4xpmE
        JpUw5Wjq+4XKWq8SE1PGZ2HkdA==
X-Google-Smtp-Source: ABdhPJzxbvgaL49qg+VF1cCI2CqYh4iGKEd2eaSGpqaN7AokBtncLtpiemoeX8OdEUnF8geVMYdl+Q==
X-Received: by 2002:a5d:6a06:: with SMTP id m6mr10891043wru.321.1594814706200;
        Wed, 15 Jul 2020 05:05:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 129sm3169967wmd.48.2020.07.15.05.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 05:05:05 -0700 (PDT)
Date:   Wed, 15 Jul 2020 14:05:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        ajax@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: remove redundant assignment to variable 'ret'
Message-ID: <20200715120503.GJ3278063@phenom.ffwll.local>
Mail-Followup-To: Jing Xiangfeng <jingxiangfeng@huawei.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, ajax@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200715070559.180986-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715070559.180986-1-jingxiangfeng@huawei.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 03:05:59PM +0800, Jing Xiangfeng wrote:
> The variable ret has been assigned the value '-EINVAL'. The assignment
> in the if() is redundant. We can remove it.

Nope, that's not correct. Before this assignement ret is guaranteed to be
0.
-Daniel

> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>  drivers/gpu/drm/drm_auth.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> index 800ac39f3213..6e1b502f2797 100644
> --- a/drivers/gpu/drm/drm_auth.c
> +++ b/drivers/gpu/drm/drm_auth.c
> @@ -299,7 +299,6 @@ int drm_dropmaster_ioctl(struct drm_device *dev, void *data,
>  
>  	if (file_priv->master->lessor != NULL) {
>  		DRM_DEBUG_LEASE("Attempt to drop lessee %d as master\n", file_priv->master->lessee_id);
> -		ret = -EINVAL;
>  		goto out_unlock;
>  	}
>  
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
