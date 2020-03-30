Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5F8C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB20A2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRnnWiJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgC3HcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:32:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32957 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbgC3HcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:32:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so20319109wrd.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 00:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6AP0oxzlHyCwI2w6hD9x2/oGX1rBhd1/H2rc13kjho=;
        b=lRnnWiJojnm59wx62s2BSlLag6ws0Hmwuj7EWgL5aZEC39z48uq2JyIjKt2tlsk9U2
         1B3NZD9vPp5rUJFIrPqb94yj5Bb7sJ0nfCWpZUw0ly3YFDFjiPgff75WDWt8HYN1EMKD
         qblviT7XtmFdDtyjPVPGyGPBPbIR5LDCu1zbS4Fa5SKIaosRgLxmWWyubEvYrR3Gy1pv
         q02oAfl67/6H7CWlPEjhkOuzYt/iv8Ok/KmSUN6EA1g+rmC4ACKuaVjbZmbYjxm0HplP
         cSv8w4j8tq0V2CP6ibOaERca9Q8QY1uApZktatjYOQ4Up18la0a0rMZgQMtbKOk2S4NF
         IqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6AP0oxzlHyCwI2w6hD9x2/oGX1rBhd1/H2rc13kjho=;
        b=qJjfvMkCfF03XhBlcawxCjm0JcSM4nj6ZVRTY0gWxOYvD18lNBxRPK2ZqSs5dIBuc3
         2pgsJNImTA/QF8zFoXnpvARv7xPlyobTYk3zQEann0RViqRKavesVDsPO7k+PChvktFs
         LENBPkau5O4j6fHjbzDa042Y2apftJN5uKKQrHPp41Sik2uCMLX07lrGLW59x46e0pLt
         gCC6AY9TA1OTR24xF0y9bxq9AyoAwx0siCW8zsu5Rh6h9zYGXOLgcg5CjYqPhYPmR+L1
         d1ojoH49sC8fnT1s7+QWIUcwX38MzRW8oTxrkiXz/NHM0VKugewCyiBp2AA5t9pGyX+8
         mk/A==
X-Gm-Message-State: ANhLgQ2rXwhx65SiU7rGItfXyCXw0Di9a8oRAIW3/5j8zFkRGlS5PKdo
        VM4ymfMjI/81fNQXGHwqquEOVovHiQGOsR27UnkZVY1F
X-Google-Smtp-Source: ADFU+vt8o58lezLLJpT8VgIedC03D82muUWQRxLwoYFBwF13A3NrSl8UKDjIw9I7VFWZEXV6d5ueeB7kkp9riUPG258=
X-Received: by 2002:adf:f48d:: with SMTP id l13mr13685529wro.96.1585553533905;
 Mon, 30 Mar 2020 00:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200329080823.7735-1-richard.weiyang@gmail.com>
In-Reply-To: <20200329080823.7735-1-richard.weiyang@gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 30 Mar 2020 09:31:59 +0200
Message-ID: <CAM9Jb+j3tC0ogmmy8HOkNmPEiTzJsDPpGXRVPP3_2YNkhf1BRg@mail.gmail.com>
Subject: Re: [PATCH] mm: rename gfpflags_to_migratetype to gfp_migratetype for
 same convention
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Pageblock migrate type is encoded in GFP flags, just as zone_type and
> zonelist.
>
> Currently we use gfp_zone() and gfp_zonelist() to extract related
> information, it would be proper to use the same naming convention for
> migrate type.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  include/linux/gfp.h | 2 +-
>  mm/compaction.c     | 2 +-
>  mm/page_alloc.c     | 4 ++--
>  mm/page_owner.c     | 7 +++----
>  4 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index e5b817cb86e7..7874b8e1c29f 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -305,7 +305,7 @@ struct vm_area_struct;
>  #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
>  #define GFP_MOVABLE_SHIFT 3
>
> -static inline int gfpflags_to_migratetype(const gfp_t gfp_flags)
> +static inline int gfp_migratetype(const gfp_t gfp_flags)
>  {
>         VM_WARN_ON((gfp_flags & GFP_MOVABLE_MASK) == GFP_MOVABLE_MASK);
>         BUILD_BUG_ON((1UL << GFP_MOVABLE_SHIFT) != ___GFP_MOVABLE);
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 672d3c78c6ab..784128c79e6f 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2089,7 +2089,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>         INIT_LIST_HEAD(&cc->freepages);
>         INIT_LIST_HEAD(&cc->migratepages);
>
> -       cc->migratetype = gfpflags_to_migratetype(cc->gfp_mask);
> +       cc->migratetype = gfp_migratetype(cc->gfp_mask);
>         ret = compaction_suitable(cc->zone, cc->order, cc->alloc_flags,
>                                                         cc->classzone_idx);
>         /* Compaction is likely to fail */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0e823bca3f2f..ef790dfad6aa 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4182,7 +4182,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
>                 alloc_flags |= ALLOC_KSWAPD;
>
>  #ifdef CONFIG_CMA
> -       if (gfpflags_to_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> +       if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
>                 alloc_flags |= ALLOC_CMA;
>  #endif
>         return alloc_flags;
> @@ -4632,7 +4632,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
>         ac->high_zoneidx = gfp_zone(gfp_mask);
>         ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
>         ac->nodemask = nodemask;
> -       ac->migratetype = gfpflags_to_migratetype(gfp_mask);
> +       ac->migratetype = gfp_migratetype(gfp_mask);
>
>         if (cpusets_enabled()) {
>                 *alloc_mask |= __GFP_HARDWALL;
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 18ecde9f45b2..360461509423 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -312,8 +312,7 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>                                 continue;
>
>                         page_owner = get_page_owner(page_ext);
> -                       page_mt = gfpflags_to_migratetype(
> -                                       page_owner->gfp_mask);
> +                       page_mt = gfp_migratetype(page_owner->gfp_mask);
>                         if (pageblock_mt != page_mt) {
>                                 if (is_migrate_cma(pageblock_mt))
>                                         count[MIGRATE_MOVABLE]++;
> @@ -359,7 +358,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>
>         /* Print information relevant to grouping pages by mobility */
>         pageblock_mt = get_pageblock_migratetype(page);
> -       page_mt  = gfpflags_to_migratetype(page_owner->gfp_mask);
> +       page_mt  = gfp_migratetype(page_owner->gfp_mask);
>         ret += snprintf(kbuf + ret, count - ret,
>                         "PFN %lu type %s Block %lu type %s Flags %#lx(%pGp)\n",
>                         pfn,
> @@ -416,7 +415,7 @@ void __dump_page_owner(struct page *page)
>
>         page_owner = get_page_owner(page_ext);
>         gfp_mask = page_owner->gfp_mask;
> -       mt = gfpflags_to_migratetype(gfp_mask);
> +       mt = gfp_migratetype(gfp_mask);
>
>         if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags)) {
>                 pr_alert("page_owner info is not present (never set?)\n");
> --
> 2.23.0

I think it makes sense for naming consistency, at-least to me.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>
>
