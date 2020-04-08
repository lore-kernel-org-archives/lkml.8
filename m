Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D090C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DF820857
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OdPalx7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgDHMEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:04:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43635 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDHMEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:04:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id i10so1203143wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 05:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=OBnPwGNSGc7YJF6/MDIm1ZT+7em3pqRoLIRd/7b9PxA=;
        b=OdPalx7xuX4cjKnOHWh9tRuE5bTeRqir5JEhzSbax2+5ltx0Bo82JE5nTq2jKSyUNo
         EnQyjl56VgC34kFmXVjM5F3zPYcSq2VER8j1v36UD8n+FNghQuOZRUpdlfu2ZIuYnOR3
         0QpjV4mQsG1i9Sf/WuB0iVARtp9CBtX+ZYcK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=OBnPwGNSGc7YJF6/MDIm1ZT+7em3pqRoLIRd/7b9PxA=;
        b=ZhXSLtIf6v2AkaR4RbOYC61TaBBM2Ogi18bV7GftKx60CLS7T51xO3EYkjq4VSozZX
         8v/BOtAWCADdfiZaQzX+u90Ub939rT/H3Gzsc3QDsm3MQ/CS/k5Rtbs7jvYHjJiH1xOD
         Jmal5PYUsXOi2D9ZfdmpK08BrBQ49nr4pEt1rUfZGEJ1D2lL/n+la2KhF/7+ou03hxMX
         7KXygo/CSx42dCmyycvta/Nd7MP4ApYQ236nLYB8aMgD5zdO2cY4idA8pUIEj+K5rVJV
         cTEkZZBBzlzbYJJ708VWQN+J3c7juq5nT4/p2Ur0WMsFbPlGIpThhl5tT2AItLWfSrSE
         d9Tg==
X-Gm-Message-State: AGi0Puac/hM9prjym8fBwCMQZ3uDrSOYnJy1L63sCcTxescx7Vfagw/u
        mrNfvsP2SE5lZ0WCh5ppeKtdXw==
X-Google-Smtp-Source: APiQypJXFUS9vFZ2P9v4AgkbysWA38eTSvtMPkZ8z0bqKgeLMkvmrgrnq8Osd1i+8L1IowleNPNkGQ==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr8282635wru.317.1586347487880;
        Wed, 08 Apr 2020 05:04:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a67sm6981132wmc.30.2020.04.08.05.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 05:04:46 -0700 (PDT)
Date:   Wed, 8 Apr 2020 14:04:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] gpu/drm: ingenic: Switch emulated fbdev to 16bpp
Message-ID: <20200408120444.GJ3456981@phenom.ffwll.local>
Mail-Followup-To: Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200226043041.289764-1-paul@crapouillou.net>
 <20200226043041.289764-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226043041.289764-2-paul@crapouillou.net>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 01:30:40AM -0300, Paul Cercueil wrote:
> The fbdev emulation is only ever used on Ingenic SoCs to run old SDL1
> based games at 16bpp (rgb565). Recent applications generally talk to
> DRM directly, and can request their favourite pixel format; so we can
> make everybody happy by switching the emulated fbdev to 16bpp.
> 
> v2: No change
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/ingenic/ingenic-drm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
> index 5493a80d7d2f..3f8cc98d41fe 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
> @@ -807,7 +807,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
>  		goto err_devclk_disable;
>  	}
>  
> -	ret = drm_fbdev_generic_setup(drm, 32);
> +	ret = drm_fbdev_generic_setup(drm, 16);

This will conflict with Thomas' work to remove the error code, so might
need a rebase. Now for the patch itself your supposed to set
drm_device->mode_config.preferred_bpp and leave this here as 0. That way
userspace can also know what's the best option.

Maybe in the future we could auto-compute the preferred_bpp from just
taking the first format of the first primary plane, but atm not there.

With the above change:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>  	if (ret)
>  		dev_warn(dev, "Unable to start fbdev emulation: %i", ret);
>  
> -- 
> 2.25.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
