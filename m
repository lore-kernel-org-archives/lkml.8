Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99869C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 756D32078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Xv/iIwQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388305AbgE0IvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388070AbgE0IvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:51:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033EEC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:51:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r7so6495878wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=fhMSWvuNPBXpgKYtNNiDpeOzCXthXUhwfothIO9NKNc=;
        b=Xv/iIwQLTMFPM9ojjW89x4wU6m1Nk4zxlV2lFYOzK/YeX5SVJ2QS7zKO2ep51C8Idy
         stbGc0fsYeZ7fht0c/o9lfGLZTtr8jZZBFGQQMOpEetaU5IW4UPpENwNAuCY9GCGjkKW
         g12dEH4XXpkOyUjPEX3PfxZJomdQ1I72fgCGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=fhMSWvuNPBXpgKYtNNiDpeOzCXthXUhwfothIO9NKNc=;
        b=p9EDT/XXRf8dBvaPng9QH9EKqI1sKBkkk0ldt26U5icIA4sork/Il6C9+/7mV00aaW
         5n0VdlnYdgH9TKtGOvKv6EBorCJvapcov0ltwzaHGNFD0E1udsXCybK8qd2WSVlIRiTk
         xyYbF5ycxfw3nC3rVm5a4ARiXoGpgImHx/rKHb9i9LzJbLYhf21YYS0VbzZgGVC2rruA
         gmxK2YhxrW5B+5vurldxTnrbH84fgRga3z3ZuYGMkLLNDryPIqSiXLAki8Itg6H9oXFJ
         JSZGy6Pd2NCXWBCEiNSibTdvYD0QZ3wHGLjNXgraiVJI63x+U+86qDzu0gOBmqi4Ki1Q
         S4JQ==
X-Gm-Message-State: AOAM533pcTG8XIcNhsivzQsZalvQQrGxnqV8MxvmIMU0s0OFgarrYuYn
        GnrlGdtYW58mJnwmFB6suQwsHw==
X-Google-Smtp-Source: ABdhPJxEZ23G/V3SZPvyhyfGWPt5N2KRE3O+yYWtCD/lwEOS2AoferVAQgqxVybjqghH58UBwveWpQ==
X-Received: by 2002:a5d:4841:: with SMTP id n1mr25171654wrs.64.1590569479666;
        Wed, 27 May 2020 01:51:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q13sm2157909wrn.84.2020.05.27.01.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 01:51:19 -0700 (PDT)
Date:   Wed, 27 May 2020 10:51:17 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/radeon: Convert get_user_pages() --> pin_user_pages()
Message-ID: <20200527085117.GO206103@phenom.ffwll.local>
Mail-Followup-To: John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1590526802-3008-1-git-send-email-jrdr.linux@gmail.com>
 <69a033cf-63b2-7da6-6a5e-a5bbc94b8afb@nvidia.com>
 <20200527084852.GN206103@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527084852.GN206103@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:48:52AM +0200, Daniel Vetter wrote:
> On Tue, May 26, 2020 at 03:57:45PM -0700, John Hubbard wrote:
> > On 2020-05-26 14:00, Souptick Joarder wrote:
> > > This code was using get_user_pages(), in a "Case 2" scenario
> > > (DMA/RDMA), using the categorization from [1]. That means that it's
> > > time to convert the get_user_pages() + release_pages() calls to
> > > pin_user_pages() + unpin_user_pages() calls.
> > > 
> > > There is some helpful background in [2]: basically, this is a small
> > > part of fixing a long-standing disconnect between pinning pages, and
> > > file systems' use of those pages.
> > > 
> > > [1] Documentation/core-api/pin_user_pages.rst
> > > 
> > > [2] "Explicit pinning of user-space pages":
> > >      https://lwn.net/Articles/807108/
> 
> I don't think this is a case 2 here, nor is it any of the others. Feels
> like not covered at all by the doc.
> 
> radeon has a mmu notifier (might be a bit broken, but hey whatever there's
> other drivers which have the same concept, but less broken). So when you
> do an munmap, radeon will release the page refcount.

I forgot to add: It's also not case 3, since there's no hw page fault
support. It's all faked in software, and explicitly synchronizes against
pending io (or preempts it, that depends a bit upon the jobs running).

> Which case it that?
> 
> Note that currently only amdgpu doesn't work like that for gpu dma
> directly to userspace ranges, it uses hmm and afaiui doens't hold a full
> page pin refcount.
> 
> Cheers, Daniel
> 
> 
> > > 
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > 
> > > Hi,
> > > 
> > > I'm compile tested this, but unable to run-time test, so any testing
> > > help is much appriciated.
> > > ---
> > >   drivers/gpu/drm/radeon/radeon_ttm.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> > > index 5d50c9e..e927de2 100644
> > > --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> > > +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> > > @@ -506,7 +506,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
> > >   		uint64_t userptr = gtt->userptr + pinned * PAGE_SIZE;
> > >   		struct page **pages = ttm->pages + pinned;
> > > -		r = get_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
> > > +		r = pin_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
> > >   				   pages, NULL);
> > >   		if (r < 0)
> > >   			goto release_pages;
> > > @@ -535,7 +535,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
> > >   	kfree(ttm->sg);
> > >   release_pages:
> > > -	release_pages(ttm->pages, pinned);
> > > +	unpin_user_pages(ttm->pages, pinned);
> > >   	return r;
> > >   }
> > > @@ -562,7 +562,7 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
> > >   			set_page_dirty(page);
> > 
> > 
> > Maybe we also need a preceding patch, to fix the above? It should be
> > set_page_dirty_lock(), rather than set_page_dirty(), unless I'm overlooking
> > something (which is very possible!).
> > 
> > Either way, from a tunnel vision perspective of changing gup to pup, this
> > looks good to me, so
> > 
> >     Acked-by: John Hubbard <jhubbard@nvidia.com>
> > 
> > 
> > thanks,
> > -- 
> > John Hubbard
> > NVIDIA
> > 
> > >   		mark_page_accessed(page);
> > > -		put_page(page);
> > > +		unpin_user_page(page);
> > >   	}
> > >   	sg_free_table(ttm->sg);
> > > 
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
