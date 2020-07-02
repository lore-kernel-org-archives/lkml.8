Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852DFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 495A620772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aZmuATkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgGBNQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGBNQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:16:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FE4C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 06:16:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so6041538wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 06:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=nC8Lz2S3EJ6vZ8/1nqOq5YPWNqhdwapmW7150qhoX70=;
        b=aZmuATkxN/T6ldpfVP9oIFv/9MPvKQJaWmFWtXeCizxERJyB0kmerR8d9J/2QG92gR
         wFf/e3ARMhNbdik7W71HDtbl9Tokf8XkywH1oQWJVsk0yHWffMp0jWt4PLuE9YJXoiGV
         NMb+oJ3sXAXjczCrTHPemuNtyUbfJCqlQSN4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nC8Lz2S3EJ6vZ8/1nqOq5YPWNqhdwapmW7150qhoX70=;
        b=JLQTOyrb+r2lg0vzFAy0Ol+1lsAlVal4klH8SrqCxfU9VlFanRSIqREDFFVl7zqmC+
         EMES5VyhjpVeaaa8hu+dGRdxM0dp7vRu91KADzUVYu0oEeBx+TAxPtRKk38z6a8yVxaz
         k3Mxvgs6l1DoiGY5SMmKoahslaM36XlxdLw8QtJMZrwIrycve3brCH779tzibH/2YS30
         oqHk7dT726jVb7MpaVwvJuI9xaPasiF6/7td1yC72I7KDdoeG3rmZ1jEonIaAqJn09Zq
         feide8ELo78S6FnVT4jy0vNngbNxkJT2gXsVA3efHX57Jpw+XJLkZy2bPxhQtc+Q3mCc
         qmXA==
X-Gm-Message-State: AOAM531cTPQj3HNpkwhrFN1PdN89hBv5guDSQydylPGfSCTQbCVSScNw
        hVIp/7lSqVUomtdTpX4uf8dltQ==
X-Google-Smtp-Source: ABdhPJzOcOeKpBUEH4Z3UMS97wgUix2XhD4klj7oKwRt/2qndlfGdZO7UwA9Ri3x6xavOubdbiZTbw==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr9845741wrs.105.1593695780741;
        Thu, 02 Jul 2020 06:16:20 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e23sm10144322wme.35.2020.07.02.06.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 06:16:19 -0700 (PDT)
Date:   Thu, 2 Jul 2020 15:16:17 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     puck.chen@hisilicon.com, airlied@linux.ie, daniel@ffwll.ch,
        tzimmermann@suse.de, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org,
        inuxarm@huawei.com
Subject: Re: [PATCH] drm/hisilicon: Use drmm_kzalloc() instead of
 devm_kzalloc()
Message-ID: <20200702131617.GY3278063@phenom.ffwll.local>
Mail-Followup-To: Tian Tao <tiantao6@hisilicon.com>,
        puck.chen@hisilicon.com, airlied@linux.ie, tzimmermann@suse.de,
        kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
        linux-kernel@vger.kernel.org, inuxarm@huawei.com
References: <1593652914-19639-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593652914-19639-1-git-send-email-tiantao6@hisilicon.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 09:21:54AM +0800, Tian Tao wrote:
> using the new API drmm_kzalloc() instead of devm_kzalloc()
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index a6fd0c2..2f20704 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -23,6 +23,7 @@
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_vblank.h>
> +#include <drm/drm_managed.h>
>  
>  #include "hibmc_drm_drv.h"
>  #include "hibmc_drm_regs.h"
> @@ -267,7 +268,7 @@ static int hibmc_load(struct drm_device *dev)
>  	struct hibmc_drm_private *priv;
>  	int ret;
>  
> -	priv = devm_kzalloc(dev->dev, sizeof(*priv), GFP_KERNEL);
> +	priv = drmm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);

Hm would be nice if hisilicon could entirely switch over to embedding, and
stop using the driver private pointer. Quite a bit more work though. As-is
this change here isn't really brining you closer to that, pretty much all
the lifetime bugs around hotunload are still there.
-Daniel

>  	if (!priv) {
>  		DRM_ERROR("no memory to allocate for hibmc_drm_private\n");
>  		return -ENOMEM;
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
