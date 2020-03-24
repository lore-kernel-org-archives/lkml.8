Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB704C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4DC20663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3LbszWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgCXGZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:25:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35956 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCXGZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:25:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id m33so14105637qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 23:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hnFtKskjEUoSB/cM+Sr24K4Mo3xd4EiFmglX9E5cidY=;
        b=D3LbszWCwUn3nLht6Zos3LQNcu7l+GfnuPIxuIXwjOQ7ZvTMNG7qEzrvSXHtpOiHAb
         J4lNMEmJS4kbOqJFp9VOshvROOz80K0G3shjojpVTfdiizFlprWW5a1dz0EZiyx0d9/Z
         jAd7D8431kQig+0EhwAySO7A3k4V2d0oMsVGXlNn5Simfh3zmreylaQBDhkq2cTFJqgE
         iSBaDQaFiDl7e0QnVh6kVDk9dRuwsP4kZlFx0GdtNaj8hvP/Rbtm+5luRXtmWoWwNqoG
         G6yHziwUf1XR9SU+yybfnn4YhmuvntEBaeh4jnUCGOBlVuoA+RSmYhoBI1O8xcBcJYx6
         nAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hnFtKskjEUoSB/cM+Sr24K4Mo3xd4EiFmglX9E5cidY=;
        b=CSNvJDscP3LLTGBcMJ5DYic3T8/wd+qjRzsI2ZYIKBd5QuxgO78NsNW/yWM7uETEDW
         oqPwRTdvFGZDUU3R/Yr0BY8nqZXvjfL2/v3bzjslFvr8oMJNSXOVYpCnShqBxWIWHk4v
         /a7lOHT64SNZUWO0bFe8Ic3u0r4aXCfg4mVRkzUxEUF0kQ2oTFGbvmPkND6oaKg7cCHm
         nae1GiNWMHR5vZzBdR9fYGzraaWYW9CLiOUw9FGNQHrM5d+P0Rc0PRcJ8A0xLv6qNIk0
         B1+Z+aXgrgyxHdVA0j7R8Bz29O9ZEXuUqdhCxQEq4bkMJN8+pu/WM6RQ8wdiGFvnPKay
         jNRQ==
X-Gm-Message-State: ANhLgQ3ogyuKpWKHECFUqbHG0/JNYxfDtZppUm78/54CqejjfT0lpceY
        mtyF55YGXwd0sVd5TWQijM77IK08O34h9lCl0Ds=
X-Google-Smtp-Source: ADFU+vtxkBOvnOnt0G70WCNJE4PiHuHrf8LXjBJ76Edzhz42wUN/6Wi43p+iSlLG3iN9/GETWeCELt96IBJrr1QDfSo=
X-Received: by 2002:ac8:2a0e:: with SMTP id k14mr25449011qtk.232.1585031152323;
 Mon, 23 Mar 2020 23:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584942732-2184-7-git-send-email-iamjoonsoo.kim@lge.com> <20200323171744.GD204561@cmpxchg.org>
In-Reply-To: <20200323171744.GD204561@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 24 Mar 2020 15:25:41 +0900
Message-ID: <CAAmzW4OCofhyOX8-5yrMhUrP-ncUQ_JGzZuNp76GWtqef9DpjQ@mail.gmail.com>
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

2020=EB=85=84 3=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 2:17, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Mar 23, 2020 at 02:52:10PM +0900, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > This patch implements workingset detection for anonymous LRU.
> > All the infrastructure is implemented by the previous patches so this p=
atch
> > just activates the workingset detection by installing/retrieving
> > the shadow entry.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > ---
> >  include/linux/swap.h |  6 ++++++
> >  mm/memory.c          |  7 ++++++-
> >  mm/swap_state.c      | 20 ++++++++++++++++++--
> >  mm/vmscan.c          |  7 +++++--
> >  4 files changed, 35 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 273de48..fb4772e 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -408,6 +408,7 @@ extern struct address_space *swapper_spaces[];
> >  extern unsigned long total_swapcache_pages(void);
> >  extern void show_swap_cache_info(void);
> >  extern int add_to_swap(struct page *page);
> > +extern void *get_shadow_from_swap_cache(swp_entry_t entry);
> >  extern int add_to_swap_cache(struct page *page, swp_entry_t entry,
> >                       gfp_t gfp, void **shadowp);
> >  extern int __add_to_swap_cache(struct page *page, swp_entry_t entry);
> > @@ -566,6 +567,11 @@ static inline int add_to_swap(struct page *page)
> >       return 0;
> >  }
> >
> > +static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
> > +{
> > +     return NULL;
> > +}
> > +
> >  static inline int add_to_swap_cache(struct page *page, swp_entry_t ent=
ry,
> >                                       gfp_t gfp_mask, void **shadowp)
> >  {
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 5f7813a..91a2097 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2925,10 +2925,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                       page =3D alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma=
,
> >                                                       vmf->address);
> >                       if (page) {
> > +                             void *shadow;
> > +
> >                               __SetPageLocked(page);
> >                               __SetPageSwapBacked(page);
> >                               set_page_private(page, entry.val);
> > -                             lru_cache_add_anon(page);
> > +                             shadow =3D get_shadow_from_swap_cache(ent=
ry);
> > +                             if (shadow)
> > +                                     workingset_refault(page, shadow);
>
> Hm, this is calling workingset_refault() on a page that isn't charged
> to a cgroup yet. That means the refault stats and inactive age counter
> will be bumped incorrectly in the root cgroup instead of the real one.

Okay.

> > +                             lru_cache_add(page);
> >                               swap_readpage(page, true);
> >                       }
> >               } else {
>
> You need to look up and remember the shadow entry at the top and call
> workingset_refault() after mem_cgroup_commit_charge() has run.

Okay. I will call workingset_refault() after charging.

I completely missed that workingset_refault() should be called after chargi=
ng.
workingset_refault() in __read_swap_cache_async() also has the same problem=
.

> It'd be nice if we could do the shadow lookup for everybody in
> lookup_swap_cache(), but that's subject to race conditions if multiple
> faults on the same swap page happen in multiple vmas concurrently. The
> swapcache bypass scenario is only safe because it checks that there is
> a single pte under the mmap sem to prevent forking. So it looks like
> you have to bubble up the shadow entry through swapin_readahead().

The problem looks not that easy. Hmm...

In current code, there is a large time gap between the shadow entries
are poped up and the page is charged to the memcg, especially,
for readahead-ed pages. We cannot maintain the shadow entries of
the readahead-ed pages until the pages are charged.

My plan to solve this problem is propagating the charged mm to
__read_swap_cache_async(), like as file cache, charging when
the page is added on to the swap cache and calling workingset_refault()
there. Charging will only occur if:

1. faulted page
2. readahead-ed page with the shadow entry for the same memcg

Also, readahead only happens when shadow entry's memcg is the same
with the charged memcg. If not the same, it's mostly not ours so
readahead isn't needed.

Please let me know how you think of the feasibility of this idea.

Thanks.
