Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3330AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 13:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E842223BCF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 13:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZLxft09D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgIHNNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbgIHLhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:37:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D8EC061757
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 04:35:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so1677837wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 04:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=WSL45Uni0wlxXIfxBtB/5y1z+V6rIa7ooXBAdktfl/A=;
        b=ZLxft09DWWUQ61e1fg70TdQn/PgGhrvi+SfoTYjEbKMGf2binVugy8MuM9Xj99eAEe
         VJLWkbCEhx0Q+0u1QI5c9QlkB5pVHml2SnWMDDRBQ9uR8HBRc6kNmOcsXnb8pl0Il5H7
         XC9oedgjy1s3YBZnSyLsf4JQOOOfT7ZCvDezk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=WSL45Uni0wlxXIfxBtB/5y1z+V6rIa7ooXBAdktfl/A=;
        b=Oni/dOGM2ktkr24mvSwxErrsH0K6V89U2iMtpr930aAWwGBhury5EGdgP5p21ClsaO
         ZRXmhBm39LMmWTBxj6ofdex9JLbyH6YvOjKhbXOh/SJbhYt6M0Ai2jyJKQahP9stW1Pb
         0z1gQQfebridIuLTY8PGWbj3avbAQ9EC9MctNB+57qcclahAbV3ydvO6I5W9KzeA7UhQ
         HpgxPZcqxEut7aUf5GkjbCxnrLZRYJAWRGbD0PodLfVMevJEWA1ZNfYOdpryCyn9qJUg
         UkBbIL50SUKa1U1me+OoZnII0h0877lBgmZNOCvACGmw9ALJRuvb6+lSUP+/lShtPGlo
         FRWA==
X-Gm-Message-State: AOAM531vXXFlfZ0jhJ7S2Z87rMrx8I5J0We0nrP6bRl5/9dPA+Zs5hwj
        rhoH/rYXRZbov+LeCwZDjlJiFg==
X-Google-Smtp-Source: ABdhPJwO92ecdG4LyeNex6dqtxEb2Oh6YdMfEcJIZ3ccJ7o2d+SykbHHt95D77rql1tnIOcP64ekjA==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr4226341wmc.154.1599564924815;
        Tue, 08 Sep 2020 04:35:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c6sm33689920wrr.15.2020.09.08.04.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 04:35:24 -0700 (PDT)
Date:   Tue, 8 Sep 2020 13:35:22 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm/qxl: use drmm_mode_config_init
Message-ID: <20200908113522.GK2352366@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200908093912.26792-1-kraxel@redhat.com>
 <20200908093912.26792-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908093912.26792-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 11:39:10AM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Btw going all in on devm_drm_dev_alloc and managed functions might be good
cleanup for virtio.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index fa79688013b7..4be04eaf7f37 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1190,7 +1190,9 @@ int qxl_modeset_init(struct qxl_device *qdev)
>  	int i;
>  	int ret;
>  
> -	drm_mode_config_init(&qdev->ddev);
> +	ret = drmm_mode_config_init(&qdev->ddev);
> +	if (ret)
> +		return ret;
>  
>  	ret = qxl_create_monitors_object(qdev);
>  	if (ret)
> @@ -1223,5 +1225,4 @@ int qxl_modeset_init(struct qxl_device *qdev)
>  void qxl_modeset_fini(struct qxl_device *qdev)
>  {
>  	qxl_destroy_monitors_object(qdev);
> -	drm_mode_config_cleanup(&qdev->ddev);
>  }
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
