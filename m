Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB18C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89FE2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EMK4bcnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388284AbgE0Is5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388227AbgE0Is4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:48:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D97FC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:48:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q11so11028610wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=VqFFiZfGTbc8P2V8UkxE4/9YOD3nXn4RELpwJoqQ81I=;
        b=EMK4bcnQ7/+Q5MfW9rh9+O6CGjH+D8d4W+4xa0rWGd2pgNmC1N2cxia66QgtL8hkJ6
         kVJ283VUAzpEMylrepZH+71qgNpQvQ36boHdljw3jencpgVYymWr5N1wvioH4/r5ZMfW
         vLdRrBL31nK8Ib/W5DsqFKci93EFPmviaeEmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=VqFFiZfGTbc8P2V8UkxE4/9YOD3nXn4RELpwJoqQ81I=;
        b=GMumykCDkamm/QxFtk9dFlsB2iEhHkqhRV9n7K4YzL21Nl4tf+z51kLF0fB3iozywB
         MS4VaGG3AAm3UAOho4Ckpgge+CzEd52RnQfTv7FYrVyqXifDXsgCy7WKr7Yl13SxlEjS
         wDxCMD0+ASsPK5EuVtQy1PqcRWXSyt9ekJy5G07zQU/Vr9dl1AW4ZUGM8+5Wsm3AAmHQ
         q0hmTDpF2jJiB9y/Ss4E9eJQkmlnb6MKPoI2FTSgVQ3KsnWff/6YK3bTQJPie79O6dv0
         lIOg4QxtIuBysB+Jrl2huL0A7RiV4B7WGkQnJhyxqJ/wCbCgeDubyeiNw64aI6eGgfFk
         RolA==
X-Gm-Message-State: AOAM530WaTZYuMemyZPvfj+x+ZSmgKXdfXOSJitwj5l2O7w7ulLtdjmx
        Ps8dJO4DTNB5lRmZnzy8YRoGwA==
X-Google-Smtp-Source: ABdhPJxBgHLELumDQ6KR3S9SHzcOIiQ+gJIdtc/ogj+uZAf3f2SROpvRAbWhfyAQGSzLHPcAGpjB9Q==
X-Received: by 2002:a5d:608d:: with SMTP id w13mr23428615wrt.298.1590569334883;
        Wed, 27 May 2020 01:48:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 1sm2112167wms.25.2020.05.27.01.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 01:48:54 -0700 (PDT)
Date:   Wed, 27 May 2020 10:48:52 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/radeon: Convert get_user_pages() --> pin_user_pages()
Message-ID: <20200527084852.GN206103@phenom.ffwll.local>
Mail-Followup-To: John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1590526802-3008-1-git-send-email-jrdr.linux@gmail.com>
 <69a033cf-63b2-7da6-6a5e-a5bbc94b8afb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a033cf-63b2-7da6-6a5e-a5bbc94b8afb@nvidia.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 03:57:45PM -0700, John Hubbard wrote:
> On 2020-05-26 14:00, Souptick Joarder wrote:
> > This code was using get_user_pages(), in a "Case 2" scenario
> > (DMA/RDMA), using the categorization from [1]. That means that it's
> > time to convert the get_user_pages() + release_pages() calls to
> > pin_user_pages() + unpin_user_pages() calls.
> > 
> > There is some helpful background in [2]: basically, this is a small
> > part of fixing a long-standing disconnect between pinning pages, and
> > file systems' use of those pages.
> > 
> > [1] Documentation/core-api/pin_user_pages.rst
> > 
> > [2] "Explicit pinning of user-space pages":
> >      https://lwn.net/Articles/807108/

I don't think this is a case 2 here, nor is it any of the others. Feels
like not covered at all by the doc.

radeon has a mmu notifier (might be a bit broken, but hey whatever there's
other drivers which have the same concept, but less broken). So when you
do an munmap, radeon will release the page refcount.

Which case it that?

Note that currently only amdgpu doesn't work like that for gpu dma
directly to userspace ranges, it uses hmm and afaiui doens't hold a full
page pin refcount.

Cheers, Daniel


> > 
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > 
> > Hi,
> > 
> > I'm compile tested this, but unable to run-time test, so any testing
> > help is much appriciated.
> > ---
> >   drivers/gpu/drm/radeon/radeon_ttm.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> > index 5d50c9e..e927de2 100644
> > --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> > +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> > @@ -506,7 +506,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
> >   		uint64_t userptr = gtt->userptr + pinned * PAGE_SIZE;
> >   		struct page **pages = ttm->pages + pinned;
> > -		r = get_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
> > +		r = pin_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
> >   				   pages, NULL);
> >   		if (r < 0)
> >   			goto release_pages;
> > @@ -535,7 +535,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
> >   	kfree(ttm->sg);
> >   release_pages:
> > -	release_pages(ttm->pages, pinned);
> > +	unpin_user_pages(ttm->pages, pinned);
> >   	return r;
> >   }
> > @@ -562,7 +562,7 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
> >   			set_page_dirty(page);
> 
> 
> Maybe we also need a preceding patch, to fix the above? It should be
> set_page_dirty_lock(), rather than set_page_dirty(), unless I'm overlooking
> something (which is very possible!).
> 
> Either way, from a tunnel vision perspective of changing gup to pup, this
> looks good to me, so
> 
>     Acked-by: John Hubbard <jhubbard@nvidia.com>
> 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 
> >   		mark_page_accessed(page);
> > -		put_page(page);
> > +		unpin_user_page(page);
> >   	}
> >   	sg_free_table(ttm->sg);
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
