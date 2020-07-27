Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1127EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16A82070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GzkYmEP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgG0JjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0JjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:39:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FC7C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:39:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r4so11199300wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=8RCoZkhoieZac/MTCN4IyM+rPgUjma0v0Zq7zVhhyeg=;
        b=GzkYmEP8m/BdmdATLXvwvkzOzhLtQDtPsoDJIKpMsw6nAoTTjeSsPH+lmMoKkiG3Kj
         DTcD374BbOMNZzXWS75vl1qBv/9Y/dSDfDDuK8ZMctiqzZP6pGnOnUTKGkudttUGNZgW
         6z+YyyCmgSWKSay+w/T4/Fb0zM71NJAXUWRtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=8RCoZkhoieZac/MTCN4IyM+rPgUjma0v0Zq7zVhhyeg=;
        b=DjJYJFHhFUpqzHMkVBbZYIfwN6RrMtNwzib9RtHbaMSaR0Y2uOrEiVqEeGdKEhps0Q
         Qtm5FEKeGnqQh8zEFUKF/KDCso+Km9BQkQaExgKTBQbL/Lwe/OVhOrusQnTW6JK4kT3S
         joe0DIXgkanORpUMsMQCllyjPekbK/Ub42CR3bbcPHXc7Qm9RySPdcF6UVhVEIAa9Ufa
         96M+k1Lak5iIml0Gu0UpLYKwtR3l4L7nUAjuNdS+4TTAnkicW7lVZJAsSPBnkVDy8tMi
         KLULF+z/zCj0QgcDuOqrOh6BtknFmaJT8Qx0D31ur5bBP6YpiRb8yEe2DFy4xhURV1Wz
         vbmg==
X-Gm-Message-State: AOAM531JuaD3wjudSUtraKt9uZ1eRzJer+q4V3O0sXWrZbJ8xhXZSyyc
        Q3sa/1gjWS9N9RqU8Hq3OnTq68qpvWY=
X-Google-Smtp-Source: ABdhPJw75vAc101pWEOGCaxoXpoO4Pq+2dtXYVMRaimrbaDttaYjkaCndLVxKo7QwXXGdffqB7vNnQ==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr19767200wrt.154.1595842749725;
        Mon, 27 Jul 2020 02:39:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o2sm3410131wmh.5.2020.07.27.02.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 02:39:08 -0700 (PDT)
Date:   Mon, 27 Jul 2020 11:39:07 +0200
From:   daniel@ffwll.ch
Cc:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 1/2] drm: Remove redundant NULL check
Message-ID: <20200727093907.GN6419@phenom.ffwll.local>
Mail-Followup-To: Li Heng <liheng40@huawei.com>, <airlied@linux.ie>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <1595474863-33112-1-git-send-email-liheng40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595474863-33112-1-git-send-email-liheng40@huawei.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 11:27:42AM +0800, Li Heng wrote:
> Fix below warnings reported by coccicheck:
> ./drivers/gpu/drm/drm_drv.c:819:2-7: WARNING: NULL check before some freeing functions is not needed.
> 
> Fixes: 5dad34f3c444 ("drm: Cleanups after drmm_add_final_kfree rollout")
> Signed-off-by: Li Heng <liheng40@huawei.com>

Queued up, should make it into 5.9 merge window, thanks for your patch.
-Daniel


> ---
>  drivers/gpu/drm/drm_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index bc38322..13068fd 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -815,8 +815,7 @@ static void drm_dev_release(struct kref *ref)
>  
>  	drm_managed_release(dev);
>  
> -	if (dev->managed.final_kfree)
> -		kfree(dev->managed.final_kfree);
> +	kfree(dev->managed.final_kfree);
>  }
>  
>  /**
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
