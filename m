Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7F8C10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C6E206D3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx0z5TB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgDBFul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 01:50:41 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44202 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgDBFul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 01:50:41 -0400
Received: by mail-qk1-f195.google.com with SMTP id j4so2743599qkc.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d84jwFa3Dz3B4OMZLn3Rh6hMGOHjGjpuPm0I9bJ6Orw=;
        b=cx0z5TB3iY3LY/S7as/bQEG50M8EDZ8H4Lnuh6+uzwUaxN/PwLUs/CCq+lzMWk/OrT
         PIBI1ug3fcLtQwL8HMNDoVMlpmRc4dhbAvnQH+OWROC8eI0UQPXInXVqcbvCkCq8JEc2
         7h2aYE0Aj+YgkcIANmC0Xv40F8LcfX5UIS/VmhWUtA63ouIhiJld82XCb1Idcdq6Z4+v
         NRsm+QPu5dUr8Cjrf+frNM5qs/j25ZdY5/mwAc5ZW9EVoB+EK7VPjJWiwl/8k07shvSX
         QvN1sGljzrGPhIMylkpX+b6+VH31GQ/QYDAGvxy+Tzg/CPyvp9g0T1BFTendBsvKlmDU
         PfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d84jwFa3Dz3B4OMZLn3Rh6hMGOHjGjpuPm0I9bJ6Orw=;
        b=Shp8bJB2AL1sH+uDLxf/hgjMumbpUwnj7syDspk3oEBfwoJa7F6fHuq7qe8VcT3Hr8
         bJ95MhGaH5of6UM4xw6TzQRYRHU/XqBe0mdbaKKFgbOOPe78zn6NAI7X1SB+IaWLOC+E
         JjxYMCT9uV4yu7lIlfCaX3lY9niWltWN5A2vVFFm/Pc8GhpJ+bPN4egx31EbE5SVT7BS
         PdhUSSzXxbKOhlngAb0+IhJ7BtWufS3C5YIzJpvwCTWW/7yFWXmyAhZE3NU2j2xvIpZ6
         zGO/KNuJfacc0gZXUVFMHX8/LAIQpjAHHcx3wFgJrSQf30oqi2WiEUwaiGHCl+zVJf4R
         kGeQ==
X-Gm-Message-State: AGi0PuaRAZaxqnCT/AT09mMuL0AfiPoj7wgEP73n+jz/FjfuWebNYaMy
        Ni+6IGuBF8ztfWG+qgrRDkADDeIquneA0tgcH3A=
X-Google-Smtp-Source: APiQypKKgVAjzMwyxrDuFIklrP6ceaUewm9tXVdh9D6ihz8trt988m/86IRcI0R0jwbj1EoAPgRk/zv1exTGVL2PIhs=
X-Received: by 2002:ae9:e858:: with SMTP id a85mr1708164qkg.343.1585806639692;
 Wed, 01 Apr 2020 22:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584942732-2184-7-git-send-email-iamjoonsoo.kim@lge.com> <20200323171744.GD204561@cmpxchg.org>
 <CAAmzW4OCofhyOX8-5yrMhUrP-ncUQ_JGzZuNp76GWtqef9DpjQ@mail.gmail.com>
In-Reply-To: <CAAmzW4OCofhyOX8-5yrMhUrP-ncUQ_JGzZuNp76GWtqef9DpjQ@mail.gmail.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 2 Apr 2020 14:50:28 +0900
Message-ID: <CAAmzW4OGThMZk2sRrboZt6nx82CiphKVFpxLGaXFXLB7WYfd3Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] mm/swap: implement workingset detection for
 anonymous LRU
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:25, J=
oonsoo Kim <js1304@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> 2020=EB=85=84 3=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 2:17,=
 Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Mon, Mar 23, 2020 at 02:52:10PM +0900, js1304@gmail.com wrote:
> > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > >
> > > This patch implements workingset detection for anonymous LRU.
> > > All the infrastructure is implemented by the previous patches so this=
 patch
> > > just activates the workingset detection by installing/retrieving
> > > the shadow entry.
> > >
> > > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > ---
> > >  include/linux/swap.h |  6 ++++++
> > >  mm/memory.c          |  7 ++++++-
> > >  mm/swap_state.c      | 20 ++++++++++++++++++--
> > >  mm/vmscan.c          |  7 +++++--
> > >  4 files changed, 35 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > index 273de48..fb4772e 100644
> > > --- a/include/linux/swap.h
> > > +++ b/include/linux/swap.h
> > > @@ -408,6 +408,7 @@ extern struct address_space *swapper_spaces[];
> > >  extern unsigned long total_swapcache_pages(void);
> > >  extern void show_swap_cache_info(void);
> > >  extern int add_to_swap(struct page *page);
> > > +extern void *get_shadow_from_swap_cache(swp_entry_t entry);
> > >  extern int add_to_swap_cache(struct page *page, swp_entry_t entry,
> > >                       gfp_t gfp, void **shadowp);
> > >  extern int __add_to_swap_cache(struct page *page, swp_entry_t entry)=
;
> > > @@ -566,6 +567,11 @@ static inline int add_to_swap(struct page *page)
> > >       return 0;
> > >  }
> > >
> > > +static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
> > > +{
> > > +     return NULL;
> > > +}
> > > +
> > >  static inline int add_to_swap_cache(struct page *page, swp_entry_t e=
ntry,
> > >                                       gfp_t gfp_mask, void **shadowp)
> > >  {
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 5f7813a..91a2097 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -2925,10 +2925,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >                       page =3D alloc_page_vma(GFP_HIGHUSER_MOVABLE, v=
ma,
> > >                                                       vmf->address);
> > >                       if (page) {
> > > +                             void *shadow;
> > > +
> > >                               __SetPageLocked(page);
> > >                               __SetPageSwapBacked(page);
> > >                               set_page_private(page, entry.val);
> > > -                             lru_cache_add_anon(page);
> > > +                             shadow =3D get_shadow_from_swap_cache(e=
ntry);
> > > +                             if (shadow)
> > > +                                     workingset_refault(page, shadow=
);
> >
> > Hm, this is calling workingset_refault() on a page that isn't charged
> > to a cgroup yet. That means the refault stats and inactive age counter
> > will be bumped incorrectly in the root cgroup instead of the real one.
>
> Okay.
>
> > > +                             lru_cache_add(page);
> > >                               swap_readpage(page, true);
> > >                       }
> > >               } else {
> >
> > You need to look up and remember the shadow entry at the top and call
> > workingset_refault() after mem_cgroup_commit_charge() has run.
>
> Okay. I will call workingset_refault() after charging.
>
> I completely missed that workingset_refault() should be called after char=
ging.
> workingset_refault() in __read_swap_cache_async() also has the same probl=
em.
>
> > It'd be nice if we could do the shadow lookup for everybody in
> > lookup_swap_cache(), but that's subject to race conditions if multiple
> > faults on the same swap page happen in multiple vmas concurrently. The
> > swapcache bypass scenario is only safe because it checks that there is
> > a single pte under the mmap sem to prevent forking. So it looks like
> > you have to bubble up the shadow entry through swapin_readahead().
>
> The problem looks not that easy. Hmm...
>
> In current code, there is a large time gap between the shadow entries
> are poped up and the page is charged to the memcg, especially,
> for readahead-ed pages. We cannot maintain the shadow entries of
> the readahead-ed pages until the pages are charged.
>
> My plan to solve this problem is propagating the charged mm to
> __read_swap_cache_async(), like as file cache, charging when
> the page is added on to the swap cache and calling workingset_refault()
> there. Charging will only occur if:
>
> 1. faulted page
> 2. readahead-ed page with the shadow entry for the same memcg
>
> Also, readahead only happens when shadow entry's memcg is the same
> with the charged memcg. If not the same, it's mostly not ours so
> readahead isn't needed.
>
> Please let me know how you think of the feasibility of this idea.

Hello, Johannes.

Could you let me know your opinion about the idea above?
In fact, since your reply is delayed, I completed the solution about the
above idea. If you want, I will submit it first. Then, we could discuss
the solution more easily.

Thanks.
