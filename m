Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B6DC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 141F42078B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0aFcnJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHMHeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMHeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:34:14 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DB3C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:34:14 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g19so6333312ioh.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ryf5fGw5oCWMRzMmPDIi8H4OUJLFk1UlxqLUOtcsis0=;
        b=A0aFcnJB3JsLQsy4qt8qtqczT1YXW4P+la45OXuxqXARr1Pc1ZRSKAtJpNaaGXWyVs
         8xIrtVuG9uWPS3DObjKB18JIcWCvX+uz7fsuU/pZ1sq7lpHB6IAZxweyj5/x0GKHm0iz
         bQTFhgk+aIJ56JjZInpeNBnmVeslnUvPssLQ5BHfZAuVPDTcac1wFI1cWwY+yV2malro
         6vMQIW7Uxgf2yKxX7xpc8zTHmbdA1A1KaPkcpCDkLF4oovHqhXlZg6RTWp5fuUz6E0uu
         2Zt61BDW/sqkPpyEY7IgaT8pWJ4X96gJA7Ds0yazMqL5l1RWX6wGnSCrgbZ2brv6LivY
         X6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ryf5fGw5oCWMRzMmPDIi8H4OUJLFk1UlxqLUOtcsis0=;
        b=KoNXHmfOtS8uEuBgFk0W9g99Asnz7f/Jr01VGCCzj5gL+eXgWKzd8po0fmZgB33Eoq
         7mKtLoAcqMXCFWeXPNvjutjscnpHAlOilDdH9C65s0BLl7CKjCCO244xtgkZg2ToLXBd
         MfPQ5fY3/7uNjTzWWq9r4Rhmqv3LPsGsO6bumEor7NHw5+HXMKvrIxC9WGLOUqAaZMgf
         NTEnlMZgaoOHOWc+vICALwfSXJoCltA+aHS1Sih3FfIvBRrWzmcM4w1yYxPPXIyR1Yqr
         GXwRAsZTMyo9pOxhBs6FVc30pEqh4s5knyrBkYnd64Eh9PNvYTv2Rv9ID3bgcqrHcUau
         d9TQ==
X-Gm-Message-State: AOAM533KXoI/Gfgx34X3bHVsabRZmc7rrOh8LDU/gTg1/ReGNjVbH8gI
        fLNyLdduQzJXjRFikXdCbV0RdA==
X-Google-Smtp-Source: ABdhPJxveLhNP8CNKYSk+jGtnSw5WanQ8MvKW0++lgFjpliPrFD/CR5Z5lzMXPQaKIjkyJiQOfFsNw==
X-Received: by 2002:a6b:7e41:: with SMTP id k1mr3675559ioq.130.1597304053589;
        Thu, 13 Aug 2020 00:34:13 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id e206sm2269252ioa.38.2020.08.13.00.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 00:34:12 -0700 (PDT)
Date:   Thu, 13 Aug 2020 01:34:08 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joonsoo Kim <js1304@gmail.com>
Subject: Re: [PATCH 1/3] mm: don't call activate_page() on new ksm pages
Message-ID: <20200813073408.GA3996183@google.com>
References: <20200812040423.2707213-1-yuzhao@google.com>
 <CAHbLzkqE+i8Y+YQE-6DJgED6Hwpa4BftNdVHgpB1YT7sEcPVcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqE+i8Y+YQE-6DJgED6Hwpa4BftNdVHgpB1YT7sEcPVcw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 10:19:24PM -0700, Yang Shi wrote:
> On Tue, Aug 11, 2020 at 9:04 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > lru_cache_add_active_or_unevictable() already adds new ksm pages to
> > active lru. Calling activate_page() isn't really necessary in this
> > case.
> >
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  mm/swapfile.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 6c26916e95fd..cf115ea26a20 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1913,16 +1913,16 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
> >                    pte_mkold(mk_pte(page, vma->vm_page_prot)));
> >         if (page == swapcache) {
> >                 page_add_anon_rmap(page, vma, addr, false);
> > +               /*
> > +                * Move the page to the active list so it is not
> > +                * immediately swapped out again after swapon.
> > +                */
> > +               activate_page(page);
> 
> Actually I think we could just remove this activate_page() call with
> Joonsoo's anonymous page workingset series merged. The active bit will
> be taken care by workingset_refault().
> 
> >         } else { /* ksm created a completely new copy */
> >                 page_add_new_anon_rmap(page, vma, addr, false);
> >                 lru_cache_add_active_or_unevictable(page, vma);
> 
> And it looks the latest linus's tree already changed this to
> lru_cache_add_inactive_or_unevictable() by commit b518154e59
> ("mm/vmscan: protect the workingset on anonymous LRU")

Oops, apparently my tree is out of date. I'll work on a new version
that removes the superfluous activate_page(). Meanwhile, can you
please take a look at the rest of this series and let me know if
there is anything else that we might want to change? Thank you.
