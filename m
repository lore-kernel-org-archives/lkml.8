Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3387FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DBD52072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJkgyWD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgE2Gtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2Gto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:49:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCF3C03E969
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 23:49:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id e125so650134lfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 23:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duvqSauRz0FpWQFF0Eq5g7XEMfQ1c+DCTu7LukoHlpY=;
        b=dJkgyWD0ciBIQfF3woOJbQsYsbg0j2sy53gHMGBk66/DLQVlD2Li/OnKmZ1HHOVylg
         OycFqaMIkKyafxY/aMbGwwkeXJiMVJUXvFG099Qsm7Y7okuRyQ5BQWOhVZuIXkhnD4dC
         l13AE1muQIzF6gGJAoO8XCvDadFCwzfNCIi9IoIDSTQqwb1cLeUP0v98PMzsnuuj8+M8
         YHrEkMNXcCByn5nkIKZovzH55tyS+dWSVpFQMULT8K2MK79Qy1g09WIyKItusQdo2dZZ
         fS4J/QFUB/tnatg7f9CibGRQ8hnWVhTsMFIXxj3kQfuY8srH8ee6dw+7jqLX7lfiOQql
         +ejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duvqSauRz0FpWQFF0Eq5g7XEMfQ1c+DCTu7LukoHlpY=;
        b=Z4unU1MPlDI7uLHQ4mHRORUGYGSoONMCH0GE1K60QirYG4qFomE8vQ3t8D22XZ8Hm+
         r88JjUDu1lhdsmXcTrlT36oUWiaFFo4YNEH6L/6Un+NHx1hbB26N3Ixqty/Cobg8jfho
         jzuDjc/Yj8E/E61bRPI+hO4quk8btaCqs6LWqfWSiYWu9TIGf5v0Ixbbwy8tJBaE2ECo
         alEeUV8sRE6J6WtBuxIy+RNd6jrkhDj0wn1Ln2W1FsFPVFr6uazxaJ76rAWlJ88yhmoG
         GID4xQuy26Pxmd+9zhR5QV+hdQHvw7kFprWisKWgN8iHQzjnBUlHqV2BhVNGSnyI7FN1
         aE6A==
X-Gm-Message-State: AOAM530tCufwIHqs30nTf54ow9h3vvEQwza+sNJD63fL4ZGGTwTvBdpH
        2OCzz8z2zqAaz7tY3JDeN4H6ytkW5HP35a/vItg=
X-Google-Smtp-Source: ABdhPJw2x0Tix5Tq5shT8N9Y2U5/m2pu3yTz3m3OmwzFD46UBDyZDMSbl4hATVzRPu6/m60TcMaci0i2xANR2AYiOTc=
X-Received: by 2002:a19:500e:: with SMTP id e14mr3595899lfb.88.1590734982916;
 Thu, 28 May 2020 23:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <1590526802-3008-1-git-send-email-jrdr.linux@gmail.com>
 <69a033cf-63b2-7da6-6a5e-a5bbc94b8afb@nvidia.com> <20200527084852.GN206103@phenom.ffwll.local>
 <20200527085117.GO206103@phenom.ffwll.local> <aaf62285-981e-3753-5501-07bbba98fc36@nvidia.com>
In-Reply-To: <aaf62285-981e-3753-5501-07bbba98fc36@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 29 May 2020 12:19:30 +0530
Message-ID: <CAFqt6zZVAQ3LKwud85LgHe9300xVjyGYXjvdWKTdezZA1uRewg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Convert get_user_pages() --> pin_user_pages()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:37 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-05-27 01:51, Daniel Vetter wrote:
> > On Wed, May 27, 2020 at 10:48:52AM +0200, Daniel Vetter wrote:
> >> On Tue, May 26, 2020 at 03:57:45PM -0700, John Hubbard wrote:
> >>> On 2020-05-26 14:00, Souptick Joarder wrote:
> >>>> This code was using get_user_pages(), in a "Case 2" scenario
> >>>> (DMA/RDMA), using the categorization from [1]. That means that it's
> >>>> time to convert the get_user_pages() + release_pages() calls to
> >>>> pin_user_pages() + unpin_user_pages() calls.
> >>>>
> >>>> There is some helpful background in [2]: basically, this is a small
> >>>> part of fixing a long-standing disconnect between pinning pages, and
> >>>> file systems' use of those pages.
> >>>>
> >>>> [1] Documentation/core-api/pin_user_pages.rst
> >>>>
> >>>> [2] "Explicit pinning of user-space pages":
> >>>>       https://lwn.net/Articles/807108/
> >>
> >> I don't think this is a case 2 here, nor is it any of the others. Feels
> >> like not covered at all by the doc.
> >>
> >> radeon has a mmu notifier (might be a bit broken, but hey whatever there's
> >> other drivers which have the same concept, but less broken). So when you
> >> do an munmap, radeon will release the page refcount.
> >
>
> Aha, thanks Daniel. I withdraw my misinformed ACK, then.
>
> > I forgot to add: It's also not case 3, since there's no hw page fault
> > support. It's all faked in software, and explicitly synchronizes against
> > pending io (or preempts it, that depends a bit upon the jobs running).
> >
>
> This is what case 3 was *intended* to cover, but it looks like case 3 needs to
> be written a little better. I'll attempt that, and Cc you on the actual patch
> to -mm. (I think we also need a case 5 for an unrelated scenario, too, so
> it's time.)

There were no *case 5* in the other patch posted in -mm. Do we need to add it ?

>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
>
> >> Which case it that?
> >>
> >> Note that currently only amdgpu doesn't work like that for gpu dma
> >> directly to userspace ranges, it uses hmm and afaiui doens't hold a full
> >> page pin refcount.
> >>
> >> Cheers, Daniel
> >>
> >>
> >>>>
> >>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>>> Cc: John Hubbard <jhubbard@nvidia.com>
> >>>>
> >>>> Hi,
> >>>>
> >>>> I'm compile tested this, but unable to run-time test, so any testing
> >>>> help is much appriciated.
> >>>> ---
> >>>>    drivers/gpu/drm/radeon/radeon_ttm.c | 6 +++---
> >>>>    1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> >>>> index 5d50c9e..e927de2 100644
> >>>> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> >>>> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> >>>> @@ -506,7 +506,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
> >>>>                    uint64_t userptr = gtt->userptr + pinned * PAGE_SIZE;
> >>>>                    struct page **pages = ttm->pages + pinned;
> >>>> -          r = get_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
> >>>> +          r = pin_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
> >>>>                                       pages, NULL);
> >>>>                    if (r < 0)
> >>>>                            goto release_pages;
> >>>> @@ -535,7 +535,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
> >>>>            kfree(ttm->sg);
> >>>>    release_pages:
> >>>> -  release_pages(ttm->pages, pinned);
> >>>> +  unpin_user_pages(ttm->pages, pinned);
> >>>>            return r;
> >>>>    }
> >>>> @@ -562,7 +562,7 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
> >>>>                            set_page_dirty(page);
> >>>
> >>>
> >>> Maybe we also need a preceding patch, to fix the above? It should be
> >>> set_page_dirty_lock(), rather than set_page_dirty(), unless I'm overlooking
> >>> something (which is very possible!).
> >>>
> >>> Either way, from a tunnel vision perspective of changing gup to pup, this
> >>> looks good to me, so
> >>>
> >>>      Acked-by: John Hubbard <jhubbard@nvidia.com>
> >>>
> >>>
> >>> thanks,
> >>> --
> >>> John Hubbard
> >>> NVIDIA
> >>>
> >>>>                    mark_page_accessed(page);
> >>>> -          put_page(page);
> >>>> +          unpin_user_page(page);
> >>>>            }
> >>>>            sg_free_table(ttm->sg);
> >>>>
> >>>
> >>
> >> --
> >> Daniel Vetter
> >> Software Engineer, Intel Corporation
> >> http://blog.ffwll.ch
> >
>
