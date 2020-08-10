Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40034C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6B2206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XgunidY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgHJNcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHJNcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:32:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EF3C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 06:32:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p20so8201311wrf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=a+nmwnQku2NPETSpBDN/P5VVyyO+hZH4dE82TSAC310=;
        b=XgunidY4u2HlfrT7vWG1augSLzJLtFtt3MwWEaGZU0TEkWgCm8vp13Wp9OEkdH8cif
         Myvc84JtAWcLoxHkNL54GxRSxWXMuRjjH6BJf4aKPj78zZmGJ3l/dUaVNmHN81D5faLR
         NB3OTBiN1rgf+K3sqXS7g2el9wItvmalo6Wlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=a+nmwnQku2NPETSpBDN/P5VVyyO+hZH4dE82TSAC310=;
        b=l5OwZapXLzdnqqJdWZ+eGtRRoNXYIamO5UGLfm9TzFzFawtzOjnAzSKtAMSiM03TDQ
         d6AaemcZPLS1Ypf2m33OsdnfhOaguGzLsgijBzH9axMiXywDaAwnn9gPYr97ENNnYO2L
         x8rfVc8VSHSjGiQT5/gXuckVRNy2ozSUhN3Ly++KPerR7WByjuZcnmLmGRCnYXZPBb05
         25l44Ury1i66yP5GrbRHlOLMK62idv6tl2ZsSxIvRqic+W8y7WTsdL1/JhJlpS/3aqp7
         8ZLK/AVsx0D7X2uHbzSgB2VYP0kHlquhesgRD9sh7DMOCL/Ze8LBisG0KvGeCVIPJ1R4
         veQg==
X-Gm-Message-State: AOAM530MUbzLHhPau0ziRPXzJ85XCZQkzX9J/Wkx7Pddcb8Zlg5aO/cA
        o6ULdq8xGso6aDo+lJaU1lqWxA==
X-Google-Smtp-Source: ABdhPJwTLj+RebIoQLWCXGNcoMBm0EOS1JlGZLvmXwPU1hi7d1FhGfALDOJkrCtq5nQijkDH6PGBsQ==
X-Received: by 2002:adf:a351:: with SMTP id d17mr24489798wrb.111.1597066361100;
        Mon, 10 Aug 2020 06:32:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k10sm20501231wrm.74.2020.08.10.06.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 06:32:40 -0700 (PDT)
Date:   Mon, 10 Aug 2020 15:32:38 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: add missing platform_device_unregister() in
 vkms_init()
Message-ID: <20200810133238.GW2352366@phenom.ffwll.local>
Mail-Followup-To: Qinglang Miao <miaoqinglang@huawei.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200810130011.187691-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810130011.187691-1-miaoqinglang@huawei.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 09:00:11PM +0800, Qinglang Miao wrote:
> When vkms_init() get into out_put, the unregister call of
> vkms_device->platform is missing. So add it before return.
> 
> Fixes: c27f0cc4d43a "drm/vkms: enable cursor by default"

This is the wrong commit, I fixed that up while applying.
-Daniel

> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 57a8a397d..83dd5567d 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -190,8 +190,8 @@ static int __init vkms_init(void)
>  
>  out_put:
>  	drm_dev_put(&vkms_device->drm);
> +	platform_device_unregister(vkms_device->platform);
>  	return ret;
> -
>  out_unregister:
>  	platform_device_unregister(vkms_device->platform);
>  out_free:
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
