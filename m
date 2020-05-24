Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C11C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 18:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373A92076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 18:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luQNcrLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbgEXSuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 14:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbgEXSuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 14:50:16 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB16C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 11:50:16 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id a83so3212687oob.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=YzxjXCwPZcyq3dbQlFh0CZeB6bNa68G6QL/uQ90Wtp8=;
        b=luQNcrLvaWxW3N9dKSgbOzWHbVO2ID25t4Po1D700+18xa0egUySBpr/Qjimg6Gzol
         uI6+rtufd0qDmaC+vqQa9pA9KOtEBqwdL5rbZUa7ZEY7FLC3PV5Xy4+1ZL8+6Wr00KCa
         337W3yBAsaPwGRDos7xkmhKWfo9VdJ0ofKK2scl9Vf1GAKo1pJsBnkc2qbb3zi983jVT
         ClrloMt6LI9DbVumUfwQ37QXALG/MNWv0v7nAtf2kUyr2iw39qNeu5Z4kpeIUbVQJkac
         1O1O27M3ZQBxUy1j5Q6q650qJJCGzjP3aDpRxResDKirmpv+grqfn84eoEa8JM+V5rUb
         G1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=YzxjXCwPZcyq3dbQlFh0CZeB6bNa68G6QL/uQ90Wtp8=;
        b=m7rf6N7yJCN0dN54eCerPjpji8Z+lh5MGNiDNjQ+wex/oHogsjYBFRHmVVC9fcgAFB
         kw4euYxhoMKWIS1m1enMkq+PulwPkYDCHtsDgLyxrilZJAIrNxreoH9Sm6k+RhHp/nPE
         hq0s9DssI7yJUNjeVJIZX55w6QUPiwn4uBwCI9mYmILwkk5LrzZ3e0YJFUQh9aCqcWAW
         qFAn7AvvVc1XHQUXhIG0DJefLDrt9LsiGiW1iXXPRGYJAOl/9TkaKLzK+T8xvu06gYP6
         hXrQYLpvnMVU/JgiIaWA0qnKo1YIFD7j/iL3q5Ii84wIVaxYtJEAx8hxbBVibLXqh7Wu
         pYag==
X-Gm-Message-State: AOAM533KMphf+6nS9/RE5fK421jk0YtYp10DfFltY98ecdtDkUnCc4TZ
        B8f89wrD+5Jmq5UhfIRQmVGzWw==
X-Google-Smtp-Source: ABdhPJxT8E3fKaVcGdfRYrxuKww4fxF9QYBsJduMqpCdojg6lDOKvPMuW3BAJ9XSptcthMaZ80lBPg==
X-Received: by 2002:a4a:2809:: with SMTP id h9mr10815106ooa.36.1590346215532;
        Sun, 24 May 2020 11:50:15 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 95sm4462886otf.72.2020.05.24.11.50.13
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 24 May 2020 11:50:14 -0700 (PDT)
Date:   Sun, 24 May 2020 11:49:58 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2] mm: remove VM_BUG_ON(PageSlab()) from
 page_mapcount()
In-Reply-To: <159032779896.957378.7852761411265662220.stgit@buzz>
Message-ID: <alpine.LSU.2.11.2005241123260.3059@eggly.anvils>
References: <159032779896.957378.7852761411265662220.stgit@buzz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 May 2020, Konstantin Khlebnikov wrote:

> Replace superfluous VM_BUG_ON() with comment about correct usage.
> 
> Technically reverts commit 1d148e218a0d0566b1c06f2f45f1436d53b049b2
> ("mm: add VM_BUG_ON_PAGE() to page_mapcount()"), but context have changed.
> 
> Function isolate_migratepages_block() runs some checks out of lru_lock
> when choose pages for migration. After checking PageLRU() it checks extra
> page references by comparing page_count() and page_mapcount(). Between
> these two checks page could be removed from lru, freed and taken by slab.
> 
> As a result this race triggers VM_BUG_ON(PageSlab()) in page_mapcount().
> Race window is tiny. For certain workload this happens around once a year.
> 
> 
>  page:ffffea0105ca9380 count:1 mapcount:0 mapping:ffff88ff7712c180 index:0x0 compound_mapcount: 0
>  flags: 0x500000000008100(slab|head)
>  raw: 0500000000008100 dead000000000100 dead000000000200 ffff88ff7712c180
>  raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
>  page dumped because: VM_BUG_ON_PAGE(PageSlab(page))
>  ------------[ cut here ]------------
>  kernel BUG at ./include/linux/mm.h:628!
>  invalid opcode: 0000 [#1] SMP NOPTI
>  CPU: 77 PID: 504 Comm: kcompactd1 Tainted: G        W         4.19.109-27 #1
>  Hardware name: Yandex T175-N41-Y3N/MY81-EX0-Y3N, BIOS R05 06/20/2019
>  RIP: 0010:isolate_migratepages_block+0x986/0x9b0
> 
> 
> Code in isolate_migratepages_block() was added in commit 119d6d59dcc0
> ("mm, compaction: avoid isolating pinned pages") before adding VM_BUG_ON
> into page_mapcount().
> 
> This race has been predicted in 2015 by Vlastimil Babka (see link below).

Ah, kudos to Vlastimil.

> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Thanks,
Acked-by: Hugh Dickins <hughd@google.com>

For the BUG deletion.  I got a bit confused by the comments at first:
slight rewording suggested below.

I had also intended a comment in page_mapcount(), on being used in
that racy exceptional way by isolate_migratepages_block(): but now
that the BUG is gone, I think you're right not to add that - it's
not for the function to document its various callers, nor what's
not in it.  That kind of info belongs to the commit message,
as you have done.

> Fixes: 1d148e218a0d ("mm: add VM_BUG_ON_PAGE() to page_mapcount()")
> Link: https://lore.kernel.org/lkml/557710E1.6060103@suse.cz/
> Link: https://lore.kernel.org/linux-mm/158937872515.474360.5066096871639561424.stgit@buzz/T/ (v1)
> ---
>  include/linux/mm.h |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5a323422d783..95f777f482ac 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -782,6 +782,11 @@ static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
>  
>  extern void kvfree(const void *addr);
>  
> +/*
> + * Mapcount of compound page as a whole, not includes mapped sub-pages.

s/not includes/does not include/

> + *
> + * Must be called only for compound pages or any their tail sub-pages.
> + */
>  static inline int compound_mapcount(struct page *page)
>  {
>  	VM_BUG_ON_PAGE(!PageCompound(page), page);
> @@ -801,10 +806,15 @@ static inline void page_mapcount_reset(struct page *page)
>  
>  int __page_mapcount(struct page *page);
>  
> +/*
> + * Mapcount of 0-order page, for sub-page includes compound_mapcount().

s/, for sub-page/; when compound sub-page,/

> + *
> + * Result is undefined for pages which cannot be mapped into userspace.
> + * For example SLAB or special types of pages. See function page_has_type().
> + * They use this place in struct page differently.
> + */
>  static inline int page_mapcount(struct page *page)
>  {
> -	VM_BUG_ON_PAGE(PageSlab(page), page);
> -
>  	if (unlikely(PageCompound(page)))
>  		return __page_mapcount(page);
>  	return atomic_read(&page->_mapcount) + 1;
