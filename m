Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0918AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 05:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD2C2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 05:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnIvOimT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgFZFHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 01:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgFZFHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 01:07:19 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D0AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 22:07:19 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b4so7738912qkn.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 22:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OyVo7f2BmXFqpcJNN/IRbi1Nm65hYP3brL5gwYQ6DgU=;
        b=GnIvOimTuTzUfewaZSD0xkSUnAr+Zxq/I4Zi56jT7pT3cyKowSiCMl61ZkF2UNfG7m
         gbX96hc5WlKUG6cwlcBZsKRz1m89zhybktR97E/ov7Bt6EZxprHh+IDe9weOa95f/uX1
         aJyP//v06bUpe2Hi/lmbBcJAQYC5Cp0rTON78i3w4/RfLexsIfR6wLmQX++5S2YKx3R/
         iyhy0UPJ5D45GhAKUN9q2eKEy14X4vO2eQPrljavyp3RGuucD0PxiHoEt7JsrbcHsoUx
         LSDzyWKXyjqotAhlt4Ae58oyvgOLXqPq1NHjw/2YGJfhT05nXFAcBJH7XfmJw3gwujBJ
         BY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OyVo7f2BmXFqpcJNN/IRbi1Nm65hYP3brL5gwYQ6DgU=;
        b=MyKaXYkNdRkXoyYly1LIVHg82SwrfZp1IDsVCgf9IFMyRsI+eqRt5VSYhPgmf/zdu+
         dPq+1SOd80wSw8lOYLlsGqu2Iojzua7g3pxfpIW/3zsjaXpwiG19/RYMamJwKRTuUJJ4
         zr+d+4txc5Fv0LMtbj3qHBj2c8PkHUOTaIYUsxt61Mx//YQp2pjLemvUUxynindZiKdf
         JDEFODfJSRqT2NmO0JagiO48bd+hkaZBsj0wEI1Q8OKXtPeg1+YMyI/R4/2NBKxBYHjh
         5ZGiq4LLYtSRk47YGA9/3VA0hUu+2PSuFUh7uYtn80hhhLsxp9pVbbX9u9mefNLmyaNG
         o50Q==
X-Gm-Message-State: AOAM533XEjFfDuX7lLKBioOfDShVHWKICNSVbHYSwR/grGkA3dsZqsq9
        Yf5j+i7IjUWAMHJmeBpG5Ty8yTNW1e9PeqdZYws=
X-Google-Smtp-Source: ABdhPJwCVTBtEYjxXNX/tNWbh8kDCMJlN/AFzGHQ6DLfM531Nxikp1fK1eSsdtlLPveZOkDoVI11GGL4fRqs1nrEpxQ=
X-Received: by 2002:ae9:e20c:: with SMTP id c12mr1026536qkc.187.1593148038383;
 Thu, 25 Jun 2020 22:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-5-git-send-email-iamjoonsoo.kim@lge.com>
 <20200617121717.GI8681@bombadil.infradead.org> <20200619013349.GA7847@js1304-desktop>
In-Reply-To: <20200619013349.GA7847@js1304-desktop>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 26 Jun 2020 14:07:07 +0900
Message-ID: <CAAmzW4OuYHMOLArjRZTuMCNEQ_u7kaeMuUta4b8-X+m1k2MUdw@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] mm/swapcache: support to handle the exceptional
 entries in swapcache
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 19=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 10:33, =
Joonsoo Kim <js1304@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Jun 17, 2020 at 05:17:17AM -0700, Matthew Wilcox wrote:
> > On Wed, Jun 17, 2020 at 02:26:21PM +0900, js1304@gmail.com wrote:
> > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > >
> > > Swapcache doesn't handle the exceptional entries since there is no ca=
se
> >
> > Don't call them exceptional entries.
> >
> > The radix tree has/had the concecpt of exceptional entries.  The swapca=
che
> > doesn't use the radix tree any more, it uses the XArray.  The XArray
> > has value entries.
> >
> > But you shouldn't call them value entries either; that's an XArray
> > concept.  The swap cache and indeed page cache use value entries to
> > implement shadow entries (they're also used to implement dax entries an=
d
> > swap entries in the page cache).  So just call them shadow entries here=
.
> >
> > I know there are still places which use the term 'nrexceptional' in
> > the kernel.  I just haven't got round to replacing them yet.  Please
> > don't add more.
>
> Okay! Thanks for commenting.
>
> >
> > > +void clear_shadow_from_swap_cache(int type, unsigned long begin,
> > > +                           unsigned long end)
> > > +{
> > > +   unsigned long curr;
> > > +   void *old;
> > > +   swp_entry_t entry =3D swp_entry(type, begin);
> > > +   struct address_space *address_space =3D swap_address_space(entry)=
;
> > > +   XA_STATE(xas, &address_space->i_pages, begin);
> > > +
> > > +retry:
> > > +   xa_lock_irq(&address_space->i_pages);
> > > +   for (curr =3D begin; curr <=3D end; curr++) {
> > > +           entry =3D swp_entry(type, curr);
> > > +           if (swap_address_space(entry) !=3D address_space) {
> > > +                   xa_unlock_irq(&address_space->i_pages);
> > > +                   address_space =3D swap_address_space(entry);
> > > +                   begin =3D curr;
> > > +                   xas_set(&xas, begin);
> > > +                   goto retry;
> > > +           }
> > > +
> > > +           old =3D xas_load(&xas);
> > > +           if (!xa_is_value(old))
> > > +                   continue;
> > > +           xas_store(&xas, NULL);
> > > +           address_space->nrexceptional--;
> > > +           xas_next(&xas);
> > > +   }
> > > +   xa_unlock_irq(&address_space->i_pages);
> > > +}
> >
> > This is a very clunky loop.  I'm not sure it's even right, given that
> > you change address space without changing the xas's address space.  How
> > about this?
>
> You are correct. The xas's address space should be changed.
>
>
> >       for (;;) {
> >               XA_STATE(xas, &address_space->i_pages, begin);
> >               unsigned long nr_shadows =3D 0;
> >
> >               xas_lock_irq(&xas);
> >               xas_for_each(&xas, entry, end) {
> >                       if (!xa_is_value(entry))
> >                               continue;
> >                       xas_store(&xas, NULL);
> >                       nr_shadows++;
> >               }
> >               address_space->nr_exceptionals -=3D nr_shadows;
> >               xas_unlock_irq(&xas);
> >
> >               if (xas.xa_index >=3D end)
> >                       break;
> >               entry =3D swp_entry(type, xas.xa_index);
> >               address_space =3D swap_address_space(entry);
> >       }
>
> Thanks for suggestion.
>
> I make a patch based on your suggestion. IIUC about Xarray,
> after running xas_for_each(), xas.xa_index can be less than the end if
> there are empty slots on last portion of array. Handling this case is
> also considered in my patch.

Hello, Matthew.

Could you check if the following patch (Xarray part) is correct?
Since I made a patch based on your suggestion, I'd like to get your review.=
 :)

Thanks.

> Thanks.
>
> ------------------->8--------------------------------
> From 72e97600ea294372a13ab8e208ebd3c0e1889408 Mon Sep 17 00:00:00 2001
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Date: Fri, 15 Nov 2019 09:48:32 +0900
> Subject: [PATCH v6 4/6] mm/swapcache: support to handle the shadow entrie=
s
>
> Workingset detection for anonymous page will be implemented in the
> following patch and it requires to store the shadow entries into the
> swapcache. This patch implements an infrastructure to store the shadow
> entry in the swapcache.
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  include/linux/swap.h | 17 ++++++++++++----
>  mm/shmem.c           |  3 ++-
>  mm/swap_state.c      | 57 ++++++++++++++++++++++++++++++++++++++++++++++=
------
>  mm/swapfile.c        |  2 ++
>  mm/vmscan.c          |  2 +-
>  5 files changed, 69 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index f4f5f94..901da54 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -416,9 +416,13 @@ extern struct address_space *swapper_spaces[];
>  extern unsigned long total_swapcache_pages(void);
>  extern void show_swap_cache_info(void);
>  extern int add_to_swap(struct page *page);
> -extern int add_to_swap_cache(struct page *, swp_entry_t, gfp_t);
> -extern void __delete_from_swap_cache(struct page *, swp_entry_t entry);
> +extern int add_to_swap_cache(struct page *page, swp_entry_t entry,
> +                       gfp_t gfp, void **shadowp);
> +extern void __delete_from_swap_cache(struct page *page,
> +                       swp_entry_t entry, void *shadow);
>  extern void delete_from_swap_cache(struct page *);
> +extern void clear_shadow_from_swap_cache(int type, unsigned long begin,
> +                               unsigned long end);
>  extern void free_page_and_swap_cache(struct page *);
>  extern void free_pages_and_swap_cache(struct page **, int);
>  extern struct page *lookup_swap_cache(swp_entry_t entry,
> @@ -572,13 +576,13 @@ static inline int add_to_swap(struct page *page)
>  }
>
>  static inline int add_to_swap_cache(struct page *page, swp_entry_t entry=
,
> -                                                       gfp_t gfp_mask)
> +                                       gfp_t gfp_mask, void **shadowp)
>  {
>         return -1;
>  }
>
>  static inline void __delete_from_swap_cache(struct page *page,
> -                                                       swp_entry_t entry=
)
> +                                       swp_entry_t entry, void *shadow)
>  {
>  }
>
> @@ -586,6 +590,11 @@ static inline void delete_from_swap_cache(struct pag=
e *page)
>  {
>  }
>
> +static inline void clear_shadow_from_swap_cache(int type, unsigned long =
begin,
> +                               unsigned long end)
> +{
> +}
> +
>  static inline int page_swapcount(struct page *page)
>  {
>         return 0;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a0dbe62..e9a99a2 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1374,7 +1374,8 @@ static int shmem_writepage(struct page *page, struc=
t writeback_control *wbc)
>                 list_add(&info->swaplist, &shmem_swaplist);
>
>         if (add_to_swap_cache(page, swap,
> -                       __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN) =3D=
=3D 0) {
> +                       __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
> +                       NULL) =3D=3D 0) {
>                 spin_lock_irq(&info->lock);
>                 shmem_recalc_inode(inode);
>                 info->swapped++;
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 1050fde..49a66dc 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -110,12 +110,14 @@ void show_swap_cache_info(void)
>   * add_to_swap_cache resembles add_to_page_cache_locked on swapper_space=
,
>   * but sets SwapCache flag and private instead of mapping and index.
>   */
> -int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
> +int add_to_swap_cache(struct page *page, swp_entry_t entry,
> +                       gfp_t gfp, void **shadowp)
>  {
>         struct address_space *address_space =3D swap_address_space(entry)=
;
>         pgoff_t idx =3D swp_offset(entry);
>         XA_STATE_ORDER(xas, &address_space->i_pages, idx, compound_order(=
page));
>         unsigned long i, nr =3D hpage_nr_pages(page);
> +       void *old;
>
>         VM_BUG_ON_PAGE(!PageLocked(page), page);
>         VM_BUG_ON_PAGE(PageSwapCache(page), page);
> @@ -125,16 +127,25 @@ int add_to_swap_cache(struct page *page, swp_entry_=
t entry, gfp_t gfp)
>         SetPageSwapCache(page);
>
>         do {
> +               unsigned long nr_shadows =3D 0;
> +
>                 xas_lock_irq(&xas);
>                 xas_create_range(&xas);
>                 if (xas_error(&xas))
>                         goto unlock;
>                 for (i =3D 0; i < nr; i++) {
>                         VM_BUG_ON_PAGE(xas.xa_index !=3D idx + i, page);
> +                       old =3D xas_load(&xas);
> +                       if (xa_is_value(old)) {
> +                               nr_shadows++;
> +                               if (shadowp)
> +                                       *shadowp =3D old;
> +                       }
>                         set_page_private(page + i, entry.val + i);
>                         xas_store(&xas, page);
>                         xas_next(&xas);
>                 }
> +               address_space->nrexceptional -=3D nr_shadows;
>                 address_space->nrpages +=3D nr;
>                 __mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, nr=
);
>                 ADD_CACHE_INFO(add_total, nr);
> @@ -154,7 +165,8 @@ int add_to_swap_cache(struct page *page, swp_entry_t =
entry, gfp_t gfp)
>   * This must be called only on pages that have
>   * been verified to be in the swap cache.
>   */
> -void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
> +void __delete_from_swap_cache(struct page *page,
> +                       swp_entry_t entry, void *shadow)
>  {
>         struct address_space *address_space =3D swap_address_space(entry)=
;
>         int i, nr =3D hpage_nr_pages(page);
> @@ -166,12 +178,14 @@ void __delete_from_swap_cache(struct page *page, sw=
p_entry_t entry)
>         VM_BUG_ON_PAGE(PageWriteback(page), page);
>
>         for (i =3D 0; i < nr; i++) {
> -               void *entry =3D xas_store(&xas, NULL);
> +               void *entry =3D xas_store(&xas, shadow);
>                 VM_BUG_ON_PAGE(entry !=3D page, entry);
>                 set_page_private(page + i, 0);
>                 xas_next(&xas);
>         }
>         ClearPageSwapCache(page);
> +       if (shadow)
> +               address_space->nrexceptional +=3D nr;
>         address_space->nrpages -=3D nr;
>         __mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, -nr);
>         ADD_CACHE_INFO(del_total, nr);
> @@ -208,7 +222,7 @@ int add_to_swap(struct page *page)
>          * Add it to the swap cache.
>          */
>         err =3D add_to_swap_cache(page, entry,
> -                       __GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN);
> +                       __GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN, NULL);
>         if (err)
>                 /*
>                  * add_to_swap_cache() doesn't return -EEXIST, so we can =
safely
> @@ -246,13 +260,44 @@ void delete_from_swap_cache(struct page *page)
>         struct address_space *address_space =3D swap_address_space(entry)=
;
>
>         xa_lock_irq(&address_space->i_pages);
> -       __delete_from_swap_cache(page, entry);
> +       __delete_from_swap_cache(page, entry, NULL);
>         xa_unlock_irq(&address_space->i_pages);
>
>         put_swap_page(page, entry);
>         page_ref_sub(page, hpage_nr_pages(page));
>  }
>
> +void clear_shadow_from_swap_cache(int type, unsigned long begin,
> +                               unsigned long end)
> +{
> +       unsigned long curr =3D begin;
> +       void *old;
> +
> +       for (;;) {
> +               unsigned long nr_shadows =3D 0;
> +               swp_entry_t entry =3D swp_entry(type, curr);
> +               struct address_space *address_space =3D swap_address_spac=
e(entry);
> +               XA_STATE(xas, &address_space->i_pages, curr);
> +
> +               xa_lock_irq(&address_space->i_pages);
> +               xas_for_each(&xas, old, end) {
> +                       if (!xa_is_value(old))
> +                               continue;
> +                       xas_store(&xas, NULL);
> +                       nr_shadows++;
> +               }
> +               address_space->nrexceptional -=3D nr_shadows;
> +               xa_unlock_irq(&address_space->i_pages);
> +
> +               /* search the next swapcache until we meet end */
> +               curr >>=3D SWAP_ADDRESS_SPACE_SHIFT;
> +               curr++;
> +               curr <<=3D SWAP_ADDRESS_SPACE_SHIFT;
> +               if (curr > end)
> +                       break;
> +       }
> +}
> +
>  /*
>   * If we are the only user, then try to free up the swap cache.
>   *
> @@ -429,7 +474,7 @@ struct page *__read_swap_cache_async(swp_entry_t entr=
y, gfp_t gfp_mask,
>         __SetPageSwapBacked(page);
>
>         /* May fail (-ENOMEM) if XArray node allocation failed. */
> -       if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL)) {
> +       if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL, NULL)) =
{
>                 put_swap_page(page, entry);
>                 goto fail_unlock;
>         }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 38f6433..4630db1 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -696,6 +696,7 @@ static void add_to_avail_list(struct swap_info_struct=
 *p)
>  static void swap_range_free(struct swap_info_struct *si, unsigned long o=
ffset,
>                             unsigned int nr_entries)
>  {
> +       unsigned long begin =3D offset;
>         unsigned long end =3D offset + nr_entries - 1;
>         void (*swap_slot_free_notify)(struct block_device *, unsigned lon=
g);
>
> @@ -721,6 +722,7 @@ static void swap_range_free(struct swap_info_struct *=
si, unsigned long offset,
>                         swap_slot_free_notify(si->bdev, offset);
>                 offset++;
>         }
> +       clear_shadow_from_swap_cache(si->type, begin, end);
>  }
>
>  static void set_cluster_next(struct swap_info_struct *si, unsigned long =
next)
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 3caa35f..37943bf 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -901,7 +901,7 @@ static int __remove_mapping(struct address_space *map=
ping, struct page *page,
>         if (PageSwapCache(page)) {
>                 swp_entry_t swap =3D { .val =3D page_private(page) };
>                 mem_cgroup_swapout(page, swap);
> -               __delete_from_swap_cache(page, swap);
> +               __delete_from_swap_cache(page, swap, NULL);
>                 xa_unlock_irqrestore(&mapping->i_pages, flags);
>                 put_swap_page(page, swap);
>                 workingset_eviction(page, target_memcg);
> --
> 2.7.4
>
