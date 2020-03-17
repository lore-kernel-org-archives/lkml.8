Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB06DC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C582073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="A6+A5ao4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgCQQsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:48:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51991 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQQsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:48:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id a132so31649wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=OD9FuwDDG0da4KeudVDubOUcHxfWY0Nj0pIiBKsww3w=;
        b=A6+A5ao4lhYXDfjR31CtRR6eRlIG9boSOk0LtFwG9coQIGNl+zHshCpcveFSX+4Gn4
         8d8WOF3x79ojpchRsP7CKK5l91Y4s5WxEDf/cCoElXqCviNyvWdVWcvHxLZZR7NjHInk
         xJ5fiLtz23awk8+C5cF3rJlh0G6NDkSaI7Mxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=OD9FuwDDG0da4KeudVDubOUcHxfWY0Nj0pIiBKsww3w=;
        b=Or9EMeX2E/R3OXPpyCe2mCE0Cf6mJSYA1umhdrfR2Ze+hYEpsilxWL1W7SWvDxuS99
         PTVdHriZTpD+9zjn8n8SLtqacvqVT7nj2carLWnnJdwl0bTtSWRsG9qzpXetO7DSWLzh
         aOcFUudwUsTMVrxC7xenpnMrC0BMvccuj5AyZQBH3Izl1UatFqze3z3o6yiaDP5MklU7
         cip77LOiUnsGW/sFfRrjq35elAK5NxIOl+9UTQYmEstV9q64QaeiLaESbNqRUd8/Kc/e
         AS+h/W5lfItitp6TZHBEetWkaI4fwQKxkoL0UzRQhduMXrfVeA4DQml3a/V/c03izXk+
         0Hvw==
X-Gm-Message-State: ANhLgQ3fg23ie9doSlhuuclHtsjMjE6o1Lo6e8HeLRpOZerDiUh4QNI+
        m/VgAt0bYd2NlXl/eEghZQOZmw==
X-Google-Smtp-Source: ADFU+vsm2JQbBpClsKbjdFmau5rDZaXHJnGmGZ52VylYOGNH7n6jFxhR5zm2VXPCTiOMmVSNFurUQA==
X-Received: by 2002:a05:600c:29cf:: with SMTP id s15mr180084wmd.117.1584463689832;
        Tue, 17 Mar 2020 09:48:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t124sm20732wmg.13.2020.03.17.09.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 09:48:08 -0700 (PDT)
Date:   Tue, 17 Mar 2020 17:48:06 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Joe Perches <joe@perches.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm: drm_vm: Use fallthrough;
Message-ID: <20200317164806.GO2363188@phenom.ffwll.local>
Mail-Followup-To: Joe Perches <joe@perches.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1584040050.git.joe@perches.com>
 <398db73cdc8a584fd7f34f5013c04df13ba90f64.1584040050.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398db73cdc8a584fd7f34f5013c04df13ba90f64.1584040050.git.joe@perches.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 12:17:12PM -0700, Joe Perches wrote:
> Convert /* fallthrough */ style comments to fallthrough;
> 
> Convert the various uses of fallthrough comments to fallthrough;
> 
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/
> 
> And by hand:
> 
> This file has a fallthrough comment outside of an #ifdef block
> that causes gcc to emit a warning if converted in-place.
> 
> So move the new fallthrough; inside the containing #ifdef/#endif too.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I'm assuming this all lands through a special pull? Or should I apply
this?
-Daniel

> ---
>  drivers/gpu/drm/drm_vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
> index 64619f..fd65c59 100644
> --- a/drivers/gpu/drm/drm_vm.c
> +++ b/drivers/gpu/drm/drm_vm.c
> @@ -595,8 +595,8 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
>  			vma->vm_ops = &drm_vm_ops;
>  			break;
>  		}
> +		fallthrough;	/* to _DRM_FRAME_BUFFER... */
>  #endif
> -		/* fall through - to _DRM_FRAME_BUFFER... */
>  	case _DRM_FRAME_BUFFER:
>  	case _DRM_REGISTERS:
>  		offset = drm_core_get_reg_ofs(dev);
> @@ -621,7 +621,7 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
>  		    vma->vm_end - vma->vm_start, vma->vm_page_prot))
>  			return -EAGAIN;
>  		vma->vm_page_prot = drm_dma_prot(map->type, vma);
> -		/* fall through - to _DRM_SHM */
> +		fallthrough;	/* to _DRM_SHM */
>  	case _DRM_SHM:
>  		vma->vm_ops = &drm_vm_shm_ops;
>  		vma->vm_private_data = (void *)map;
> -- 
> 2.24.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
