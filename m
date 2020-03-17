Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE5EC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3E320738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GrvBiO89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgCQQ5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:57:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36079 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQQ5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:57:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id s5so26709998wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=wrfChOUz/lAaBXiE3qY2UNw2+SxM9+DHELQmHfgnM64=;
        b=GrvBiO890g/VncbMjDzgbmrlwtosSNomp7QQc4Q1ksYopcgnqyo199zvFrfrAyBL8y
         JUc/9D6ixg8Mh8PdAhK0nJ0ZEsyrJDYwvgCb9RDAQELwMd/TDSJ128ls95P6HlVi90Vc
         yKMOhcftgm7t6pyG+4H2D/ggA2v6HONmXEgPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=wrfChOUz/lAaBXiE3qY2UNw2+SxM9+DHELQmHfgnM64=;
        b=g1mx1vLszMtgOGj2+U+sIIRBasWzjojvDhFHIh5T4OwsEa9zio+zFRXuw7rq10BvG2
         u/69OGJ+4/wwST+wpJC47REzhPA9FudYDoPiogWa/zgrs3hSMAGDwwh0luCLmyJ0m4yV
         cSrCB0WqsegOQ/zhUnVqiFXiB6bp9WYDmUFi81X0++EBKqi8BXQyHsvVPbsLf1fOKrk4
         08OHuoIqJrf2WipEfvXVeJBS+SLf8VbVMqtx1bhptKHzK3c4OCEhAbphkdDyOxQVWPZj
         9sAcpb0OIOzO56bff11YFGeRGvADHBdkWC7gx/eQGfYjX9FPlz+77y6kMZk/49vWSvNp
         G6Og==
X-Gm-Message-State: ANhLgQ1M1HH4FQrEsXe0GISSsSZlNSw4iBxYRZRkJL07J5MMkrPutKKw
        V3CzyzRWMbSP55I2LYLgwQXi/A==
X-Google-Smtp-Source: ADFU+vspECOtqtMTvLpFlQUwdK8IeDVk+/wKnuMtgt4gmzOuA3KijQEyjlIBgw/c5JZcSajTRdOe7Q==
X-Received: by 2002:a05:6000:41:: with SMTP id k1mr7434833wrx.53.1584464251820;
        Tue, 17 Mar 2020 09:57:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c5sm508387wma.3.2020.03.17.09.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 09:57:31 -0700 (PDT)
Date:   Tue, 17 Mar 2020 17:57:29 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/lease: fix WARNING in idr_destroy
Message-ID: <20200317165729.GQ2363188@phenom.ffwll.local>
Mail-Followup-To: Qiujun Huang <hqjagain@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1584329768-16119-1-git-send-email-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584329768-16119-1-git-send-email-hqjagain@gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 11:36:08AM +0800, Qiujun Huang wrote:
> leases has been destroyed:
> drm_master_put
>     ->drm_master_destroy
>             ->idr_destroy
> 
> so the "out_lessee" needn't to call idr_destroy again.
> 
> Reported-and-tested-by: syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  drivers/gpu/drm/drm_lease.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> index b481caf..54506c2 100644
> --- a/drivers/gpu/drm/drm_lease.c
> +++ b/drivers/gpu/drm/drm_lease.c
> @@ -577,11 +577,14 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
>  
>  out_lessee:
>  	drm_master_put(&lessee);
> +	goto err_exit;

I think this is correct, but also confusioning and inconsistent with the
existing style. Most error cases before drm_lease_create explicit destroy
the idr, except the one for drm_lease_create.

Instead of your patch I'd
- remove the idr_destry from the error unrolling here
- add it the to drm_lease_create error case
- add a comment above the call to drm_lease_crete that it takes ownership
  of the lease idr

Can you pls respin and retest to make sure that patch is still correct?

Thanks, Daniel

>  
>  out_leases:
> -	put_unused_fd(fd);
>  	idr_destroy(&leases);
>  
> +err_exit:
> +	put_unused_fd(fd);
> +
>  	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl failed: %d\n", ret);
>  	return ret;
>  }
> -- 
> 1.8.3.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
