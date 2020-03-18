Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5602DC5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C80A20774
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PmLTKI+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCRNjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:39:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52093 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgCRNi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:38:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id c187so2117533wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 06:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=6R5xf9NqTS0jMDexNFwg03hIQwJWepjqVTqQml3+25g=;
        b=PmLTKI+jZxj3t3dDPkHpXoEBiwtAI3ewtlXoBbpkAp+ImmLqcN8JC5QH7GPvRKLcPQ
         +xOBx6iL47cZLqOw1xytvO34OdPn8T8YR3OiTiEnuRpQta9BzxuhKNSukZ9T/BIrdA1N
         SYdLIlQuiwpi5pfQT+xJTLa+Zh7KNkvRsSHcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=6R5xf9NqTS0jMDexNFwg03hIQwJWepjqVTqQml3+25g=;
        b=iY5e84bR1lQhlcuf3hcDt4L4dKWdj8HC3082eSNHtI5O8f8EjUXXVAuNBBQncknp5d
         fSiqXwPU/D5mLhaf+eSZNtuZEDBdsviB5+nPGcUJz0o/9ZLRq4w2sqwJ9b0vNNCeBDRj
         3ZVJrBVO3FIGx8/gEug5pS4wba3mDG7bW+KYtfVJUAo01TbjkJ44LkbAAF0H9D4f+d8V
         RerDHjPiut8d8RAg366NeosCOPJ/sCw9AH/ym5Exy4mqbaMSF/cktVQaQ1z6CD2AncvS
         Af8TkBZU/0V2DR6e2ZRuMZAHKsSmWu/WlNf2Amd8aXEcEOQUul5nA0GbhE4FNGazO02V
         bg9w==
X-Gm-Message-State: ANhLgQ1Fq8xlGtwxhzzJYdMc5103954qgabQMyJ7QgbZXtggN3wAb3OW
        XKtkNbb+FF4F36ttyUhQXcb8RQ==
X-Google-Smtp-Source: ADFU+vuUYj/OYML10zdOHlJ4Njc9aninKsXTvMVWhceXQ6IvYDvu1robtZJWgU11PbUN4ofmJi563Q==
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr5364849wmo.106.1584538735341;
        Wed, 18 Mar 2020 06:38:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j11sm2065580wrt.14.2020.03.18.06.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:38:54 -0700 (PDT)
Date:   Wed, 18 Mar 2020 14:38:52 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        anenbupt@gmail.com
Subject: Re: [PATCH v2] drm/lease: fix WARNING in idr_destroy
Message-ID: <20200318133852.GU2363188@phenom.ffwll.local>
Mail-Followup-To: Qiujun Huang <hqjagain@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, anenbupt@gmail.com
References: <1584518030-4173-1-git-send-email-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584518030-4173-1-git-send-email-hqjagain@gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 03:53:50PM +0800, Qiujun Huang wrote:
> drm_lease_create takes ownership of leases. And leases will be released
> by drm_master_put.
> 
> drm_master_put
>     ->drm_master_destroy
>             ->idr_destroy
> 
> So we needn't call idr_destroy again.
> 
> Reported-and-tested-by: syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>

Thanks for the respin, and I've also seen the syzbot confirmation, so all
great.

Merged to -fixes with a cc: stable.
-Daniel

> ---
>  drivers/gpu/drm/drm_lease.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> index b481caf..825abe3 100644
> --- a/drivers/gpu/drm/drm_lease.c
> +++ b/drivers/gpu/drm/drm_lease.c
> @@ -542,10 +542,12 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
>  	}
>  
>  	DRM_DEBUG_LEASE("Creating lease\n");
> +	/* lessee will take the ownership of leases */
>  	lessee = drm_lease_create(lessor, &leases);
>  
>  	if (IS_ERR(lessee)) {
>  		ret = PTR_ERR(lessee);
> +		idr_destroy(&leases);
>  		goto out_leases;
>  	}
>  
> @@ -580,7 +582,6 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
>  
>  out_leases:
>  	put_unused_fd(fd);
> -	idr_destroy(&leases);
>  
>  	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl failed: %d\n", ret);
>  	return ret;
> -- 
> 1.8.3.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
