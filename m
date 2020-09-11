Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390E5C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7C7206CA
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="djiuqUUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgIKIyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgIKIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:54:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AA3C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:54:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so10667917wrx.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=l74wd6NMB+UUQWVCt5aPCq/IVe0WNLlAuB214FZvfPA=;
        b=djiuqUUHblnIjuVEPh1h1h+trIWDBS9HBnr4ZJaFNmHq+G1S6nAY47wGtWEHwHA6w/
         741TeKcHqv+TY0/qITjAROtrPQgps9vL1t5QbVClQfvHR7ubiziA2BvzpRQaTLMAFNwz
         TtLnF52tSljeTVYASrgsOoZ+bRSLFfTv03WKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=l74wd6NMB+UUQWVCt5aPCq/IVe0WNLlAuB214FZvfPA=;
        b=enXqyWW315ftuq8wryG+50ssVBXYuNZl2YfUCXqI4Iioo8fA3pTYi4NJDS6+kSN2Z2
         qQ0xQj1w35Rbks2KIWEk/3svjALtB47ku60k0TnB1Y3m0eU3wONC0fWEo5S96rFn5b8V
         E031FNTZcNmiRZaGZ5fAqCO0VoqPAgfcmeVmqb2oMaEx8TJaPmKls8uOVHEi5DyIZkIH
         5DFHLgsyIMU899zj8KFTSoLxqFjaLx7lgFkcGfRspMBFI1nGLLoTcyAKED7K9MAPSX7U
         i1YYGvE9xYy9oYdyHP9wtoFpBVB8Fme+g6uuRRhDuADGbfulNletgjligdE/5R7zMLz/
         tVbw==
X-Gm-Message-State: AOAM531oPB94ETUaUXj+fFT4E2QP/h1Kei1gjsF+OaAqmOW9tPL6IshM
        obsitCqgf3AOHutSGt2TbtbACg==
X-Google-Smtp-Source: ABdhPJwCo+rJODET6mRLi+uobSSYyKWOVpB0S1spxGhqb3+t6ZBlutn7gP1xklANUJCZ+GSc6GfVCw==
X-Received: by 2002:a5d:40c7:: with SMTP id b7mr992023wrq.300.1599814474727;
        Fri, 11 Sep 2020 01:54:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 2sm3178204wrs.64.2020.09.11.01.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 01:54:34 -0700 (PDT)
Date:   Fri, 11 Sep 2020 10:54:32 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] drm/i810: make i810_flush_queue() return void
Message-ID: <20200911085432.GQ438822@phenom.ffwll.local>
Mail-Followup-To: Jason Yan <yanaijie@huawei.com>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
References: <20200910140610.1191578-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910140610.1191578-1-yanaijie@huawei.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:06:10PM +0800, Jason Yan wrote:
> This function always return '0' and no callers use the return value. So
> make it a void function.
> 
> This eliminates the following coccicheck warning:
> 
> drivers/gpu/drm/i810/i810_dma.c:860:8-11: Unneeded variable: "ret".
> Return "0" on line 885
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Queued up for 5.10 in drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/i810/i810_dma.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i810/i810_dma.c b/drivers/gpu/drm/i810/i810_dma.c
> index 303c2d483c6e..88250860f8e4 100644
> --- a/drivers/gpu/drm/i810/i810_dma.c
> +++ b/drivers/gpu/drm/i810/i810_dma.c
> @@ -853,11 +853,11 @@ static void i810_dma_quiescent(struct drm_device *dev)
>  	i810_wait_ring(dev, dev_priv->ring.Size - 8);
>  }
>  
> -static int i810_flush_queue(struct drm_device *dev)
> +static void i810_flush_queue(struct drm_device *dev)
>  {
>  	drm_i810_private_t *dev_priv = dev->dev_private;
>  	struct drm_device_dma *dma = dev->dma;
> -	int i, ret = 0;
> +	int i;
>  	RING_LOCALS;
>  
>  	i810_kernel_lost_context(dev);
> @@ -882,7 +882,7 @@ static int i810_flush_queue(struct drm_device *dev)
>  			DRM_DEBUG("still on client\n");
>  	}
>  
> -	return ret;
> +	return;
>  }
>  
>  /* Must be called with the lock held */
> -- 
> 2.25.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
