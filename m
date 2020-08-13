Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED7BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF9A206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFOxOzMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHMFTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHMFTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:19:37 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDFBC061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 22:19:37 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id cq28so3207728edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 22:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c67l/Kh4PrxDU+p63GZTC7eyIKKS3Nmd1e/4JTBchUQ=;
        b=CFOxOzMHsFHIuClJ7Zta78lgA88l2r2iwbskY7fQim0eEZPYIowmnsurp72VuktPH8
         fOZOUOPclufD0ZeU68VhjMeG15uPxNmHYNVD4PEas4ZtBsv6hitG+i7Qa9KabQFtjjTE
         8CfD2vYjPb6EQLvugzOTG6yVARndLkyIuEJ0N6avAVPo6obJK9Zu8kRgQ3p9MpnBXdfC
         87gC+Q3ec2CG6HmoH1NQ32hP4IGjcmEB3N6j6r/5AcgGp30iaSHRkElLNCJmpe3OOkc0
         3d/ueLu/zxnAAhDH4gfMvSa+0jSm/G79KBhqqTBRUfm4y1XJrAGVlGzei5s8gTDvxRD+
         Xu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c67l/Kh4PrxDU+p63GZTC7eyIKKS3Nmd1e/4JTBchUQ=;
        b=kW5v5pW+xOI5V2X43aSVyz+1maIfLigcb2oPDZL5zseuKbef2hWOe0QbuYQljT7yiG
         LpM2Pv6O5Ofh92PY6Msx3mi8TLowCYOpnnddIHJtTlOmUNdaT97aeHRoCE2zOq//ZLHH
         dfKsFopKe2uh81SOCFUzWqbRaFkrqFroo67LpvrqOetTXrMzjelIaD9zE7Sn6v2ZVxOe
         rnSOA/ssBzQYDM1UzGsvA/iwN30clSWcEQlsqJflgtjcDTYyjfyXeqoFe+Aei1smdgrB
         ebhnEhw1c/rDfkXBf7f53C4B7eT9e/Qv051ZW12mc7dAZIBkYsD2w3hyPcRx7hvEEIjo
         eoDw==
X-Gm-Message-State: AOAM531T1imMbjdW6JAusgdiPjkbwqUmWgOXMbBr6EHGvh0ZbqBSZyTC
        HEeamUESEC/tVLva8HhtF+vcsF8eECtFek/jEZg=
X-Google-Smtp-Source: ABdhPJzUvmd5BZyQ3p133JmD0914kUtVo6A4n698OGvGsmcdjPh+owzaduroH3A/XF4aNic2WDuoOduAgYsi6JUcTtA=
X-Received: by 2002:a05:6402:2038:: with SMTP id ay24mr3207332edb.200.1597295976320;
 Wed, 12 Aug 2020 22:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200812040423.2707213-1-yuzhao@google.com>
In-Reply-To: <20200812040423.2707213-1-yuzhao@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 12 Aug 2020 22:19:24 -0700
Message-ID: <CAHbLzkqE+i8Y+YQE-6DJgED6Hwpa4BftNdVHgpB1YT7sEcPVcw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: don't call activate_page() on new ksm pages
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joonsoo Kim <js1304@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 9:04 PM Yu Zhao <yuzhao@google.com> wrote:
>
> lru_cache_add_active_or_unevictable() already adds new ksm pages to
> active lru. Calling activate_page() isn't really necessary in this
> case.
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  mm/swapfile.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 6c26916e95fd..cf115ea26a20 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1913,16 +1913,16 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>                    pte_mkold(mk_pte(page, vma->vm_page_prot)));
>         if (page == swapcache) {
>                 page_add_anon_rmap(page, vma, addr, false);
> +               /*
> +                * Move the page to the active list so it is not
> +                * immediately swapped out again after swapon.
> +                */
> +               activate_page(page);

Actually I think we could just remove this activate_page() call with
Joonsoo's anonymous page workingset series merged. The active bit will
be taken care by workingset_refault().

>         } else { /* ksm created a completely new copy */
>                 page_add_new_anon_rmap(page, vma, addr, false);
>                 lru_cache_add_active_or_unevictable(page, vma);

And it looks the latest linus's tree already changed this to
lru_cache_add_inactive_or_unevictable() by commit b518154e59
("mm/vmscan: protect the workingset on anonymous LRU")

Added Joonsoo in this loop.

>         }
>         swap_free(entry);
> -       /*
> -        * Move the page to the active list so it is not
> -        * immediately swapped out again after swapon.
> -        */
> -       activate_page(page);
>  out:
>         pte_unmap_unlock(pte, ptl);
>         if (page != swapcache) {
> --
> 2.28.0.236.gb10cc79966-goog
>
>
