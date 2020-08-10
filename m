Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BE2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD84F2075F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HM7oYo6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgHJNNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgHJNNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:13:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26226C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 06:13:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f12so8121874wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=TrZwb620Hz71sfU/k5dAR4LB1pIwkE/ea0quH9JSpzM=;
        b=HM7oYo6K3fJxWIR8x+0drnpWjVhrBdO50qE+dWcIqR5/oC9uYZUuwR7iagR04m1TNV
         H0AuDtOlggvOXdo3XO4GHJnVJ5nBZcabZ8fffgHaZlbS0g6b1h9CFtOaX/hqFnTf6v3e
         7C/EZFdN6rMqZQ2LWIMze6Umg7aWjUUTDt6T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=TrZwb620Hz71sfU/k5dAR4LB1pIwkE/ea0quH9JSpzM=;
        b=lK7zcnXg+s9BU4D+70iPunvZHMydtTz1PQkF4TMhF4nu4dvVnZW+xMn+j/f4Fy5IQN
         lKY+hnq4vgZiozs/bFk+wi1LzspPgqECIfd6CmYDf22OMSQXMzMHXe/P0QoKq9bVpYll
         rQNjCXXYUw8p20KsWWQ8f0rA8j5WBi06X6jLrAcD5JqvtzhbmLCcfR/ydxai1RChftGQ
         yd460oCElc2ABcv/ZnxlXZp24LOtrE0vx0vJx67K7fMWKluqD675UH/9EQNHdFy1REWo
         nS5Y/e5i0spZ7FKEND9HIfwdhtpsXTqNysUun7eZvwYmX4tpG3//nHreWJuDwmWHYbKV
         2lkw==
X-Gm-Message-State: AOAM531qp4Z6n+YkJkVBAnPQxnAXomJqbuHad/R/NTLxslVoZGBy6cyb
        CiMV9Im+ej90kgQTB5lXAHI4Bg==
X-Google-Smtp-Source: ABdhPJzqMtWNZOVPtAjaOpl8/MRH2p+hSFH2Gy7kOohMkzxgp3egVhv0ZI/g57f/cTHzvbKhayGR6Q==
X-Received: by 2002:adf:ed0f:: with SMTP id a15mr1474297wro.341.1597065198916;
        Mon, 10 Aug 2020 06:13:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h13sm20752323wrx.17.2020.08.10.06.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 06:13:18 -0700 (PDT)
Date:   Mon, 10 Aug 2020 15:13:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: convert to use module_platform_driver
Message-ID: <20200810131316.GV2352366@phenom.ffwll.local>
Mail-Followup-To: Qinglang Miao <miaoqinglang@huawei.com>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200810125931.186456-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810125931.186456-1-miaoqinglang@huawei.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 08:59:31PM +0800, Qinglang Miao wrote:
> Get rid of boilerplate code by using module_platform_driver macro
> for v3d_drm.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

lgtm, merged to drm-misc-next for 5.10
-Daniel

> ---
>  drivers/gpu/drm/v3d/v3d_drv.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> index 82a7dfdd1..9f7c26193 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.c
> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> @@ -358,18 +358,7 @@ static struct platform_driver v3d_platform_driver = {
>  	},
>  };
>  
> -static int __init v3d_drm_register(void)
> -{
> -	return platform_driver_register(&v3d_platform_driver);
> -}
> -
> -static void __exit v3d_drm_unregister(void)
> -{
> -	platform_driver_unregister(&v3d_platform_driver);
> -}
> -
> -module_init(v3d_drm_register);
> -module_exit(v3d_drm_unregister);
> +module_platform_driver(v3d_platform_driver);
>  
>  MODULE_ALIAS("platform:v3d-drm");
>  MODULE_DESCRIPTION("Broadcom V3D DRM Driver");
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
