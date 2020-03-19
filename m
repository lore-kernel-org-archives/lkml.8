Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F73CC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 06:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1C420714
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 06:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWPvFVq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCSGVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 02:21:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38429 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSGVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 02:21:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id z12so883060qtq.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 23:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6N67oDZqhu8rSLAYYLp2ntwe2aF0H/t/Nu/zVU+OFmM=;
        b=DWPvFVq5zlOEI0Tl77YPjaTO3BIHu2WPCpD1l9C9T7qy7olwa3XYkI0ojrhLIjuUog
         uP/NR3WA3BOA0+VxFFyXK5n2hRu9o4LuxjI+ho8aSmxa2JEIg6v3qajPC3opeSmeIFsH
         gEj9XH0jMQ0b/WMJM+N+9aBYVUyelpfEXLGhSgK15utmqx2CoYt/QpwmcWd0Q70QfAXk
         rNfkurYDfIKN+qkLlNvTqbjk/+OCT1NcmCjAED1rjfyzjI5XWxQ0rUZ2bk57RDIhKNVe
         bc3V2Lg1wOMDRmlUFVZg0Fk6uYqcEOMO3TZM9WmkYlFt41ngzq1VM4Zplr1mePkX9lfp
         3dXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6N67oDZqhu8rSLAYYLp2ntwe2aF0H/t/Nu/zVU+OFmM=;
        b=klOKXUbDTUo/KVNIZaIdxb8VYimrI9SzmN6S+q5VGrajKGAHyNAlcKOAvV6IA2fTtI
         mJOGSL55M50WiLBhwZwXziO1QbnvmE0TNcvD7MNliYx210yii52oF3BUPopj8MXZJwPl
         iwAmodXxbUphymOvjNYCV1pHShGbx7mhZD7fyIGhxhzZWS0KTfA8iGt2X/+h8+3Iyysz
         JoALKOCc75g/41hHrkoMurYJsVtOTtfMfVY+HsSzQufnqE5/My0ymnOw8k67N2UVZzXS
         G8O793AntORPGDgsKxRcnsSWocqbO91fQfXgkVYVhkrp44epTKrA1CwrINjy07EmCC1R
         ZIag==
X-Gm-Message-State: ANhLgQ34EeNjIJTLTY8u3rxAbqLHDm3XdtTqtvWVHQMO1zuGuzmtFohc
        SPfgELJr9JFzzJTcQTcy+qzPO7BP2m18/5R9ig8=
X-Google-Smtp-Source: ADFU+vscKyZHNbMCtl2/iFWUZlXclsIoINI1RO6RGx+haf8VMdqbtc8vzepCImbMCet4nAPLPyenM23sUej3398V7zY=
X-Received: by 2002:ac8:708f:: with SMTP id y15mr1384354qto.35.1584598865112;
 Wed, 18 Mar 2020 23:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584423717-3440-6-git-send-email-iamjoonsoo.kim@lge.com> <20200318191802.GE154135@cmpxchg.org>
In-Reply-To: <20200318191802.GE154135@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 19 Mar 2020 15:20:54 +0900
Message-ID: <CAAmzW4PxuabZq-HXEBfW8cPxMwWHKPJjxCQs1D-07ixNw_M4Ww@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] mm/workingset: use the node counter if memcg is
 the root memcg
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

2020=EB=85=84 3=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 4:18, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Mar 17, 2020 at 02:41:53PM +0900, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > In the following patch, workingset detection is implemented for the
> > swap cache. Swap cache's node is usually allocated by kswapd and it
> > isn't charged by kmemcg since it is from the kernel thread. So the swap
> > cache's shadow node is managed by the node list of the list_lru rather
> > than the memcg specific one.
> >
> > If counting the shadow node on the root memcg happens to reclaim the sl=
ab
> > object, the shadow node count returns the number of the shadow node on
> > the node list of the list_lru since root memcg has the kmem_cache_id, -=
1.
> >
> > However, the size of pages on the LRU is calculated by using the specif=
ic
> > memcg, so mismatch happens. This causes the number of shadow node not t=
o
> > be increased to the enough size and, therefore, workingset detection
> > cannot work correctly. This patch fixes this bug by checking if the mem=
cg
> > is the root memcg or not. If it is the root memcg, instead of using
> > the memcg-specific LRU, the system-wide LRU is used to calculate proper
> > size of the shadow node so that the number of the shadow node can grow
> > as expected.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > ---
> >  mm/workingset.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/workingset.c b/mm/workingset.c
> > index 5fb8f85..a9f474a 100644
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -468,7 +468,13 @@ static unsigned long count_shadow_nodes(struct shr=
inker *shrinker,
> >        * PAGE_SIZE / xa_nodes / node_entries * 8 / PAGE_SIZE
> >        */
> >  #ifdef CONFIG_MEMCG
> > -     if (sc->memcg) {
> > +     /*
> > +      * Kernel allocation on root memcg isn't regarded as allocation o=
f
> > +      * specific memcg. So, if sc->memcg is the root memcg, we need to
> > +      * use the count for the node rather than one for the specific
> > +      * memcg.
> > +      */
> > +     if (sc->memcg && !mem_cgroup_is_root(sc->memcg)) {
>
> This is no good, unfortunately.
>
> It allows the root cgroup's shadows to grow way too large. Consider a
> large memory system where several workloads run in containers and only
> some host software runs in the root, yet that tiny root group will
> grow shadow entries in proportion to the entire RAM.

Okay.

> IMO, we have some choices here:
>
> 1. We say the swapcache is a shared system facility and its memory is
> not accounted to anyone. In that case, we should either
>    1a. Reclaim them to a fixed threshold, regardless of cgroup, or
>    1b. Not reclaim them at all. Or
> 2. We account all nodes to the groups for which they are allocated.
>    Essentially like this:
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 8e7ce9a9bc5e..d0d0dcc357fb 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -125,6 +125,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t =
entry, gfp_t gfp)
>         page_ref_add(page, nr);
>         SetPageSwapCache(page);
>
> +       memalloc_use_memcg(page_memcg(page));
>         do {
>                 xas_lock_irq(&xas);
>                 xas_create_range(&xas);
> @@ -142,6 +143,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t =
entry, gfp_t gfp)
>  unlock:
>                 xas_unlock_irq(&xas);
>         } while (xas_nomem(&xas, gfp));
> +       memalloc_unuse_memcg();
>
>         if (!xas_error(&xas))
>                 return 0;
> @@ -605,7 +607,8 @@ int init_swap_address_space(unsigned int type, unsign=
ed long nr_pages)
>                 return -ENOMEM;
>         for (i =3D 0; i < nr; i++) {
>                 space =3D spaces + i;
> -               xa_init_flags(&space->i_pages, XA_FLAGS_LOCK_IRQ);
> +               xa_init_flags(&space->i_pages,
> +                             XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
>                 atomic_set(&space->i_mmap_writable, 0);
>                 space->a_ops =3D &swap_aops;
>                 /* swap cache doesn't use writeback related tags */
>
> (A reclaimer has PF_MEMALLOC set, so we'll bypass the limit when
> recursing into charging the node.)
>
> I'm leaning more toward 1b, actually. The shadow shrinker was written
> because the combined address space of files on the filesystem can
> easily be in the terabytes, and practically unbounded with sparse
> files. The shadow shrinker is there to keep users from DoSing the
> system with shadow entries for files.
>
> However, the swap address space is bounded by a privileged user. And
> the size is usually in the GB range. On my system, radix_tree_node is
> ~583 bytes, so a for a 16G swapfile, the swapcache xarray should max
> out below 40M (36M worth of leaf nodes, plus some intermediate nodes).
>
> It doesn't seem worth messing with the shrinker at all for these.

40M / 16G, 0.25% of the amount of the used swap looks okay to me.
I will rework the patch on that way.

Thanks.
