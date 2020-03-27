Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6D5C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F8820575
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKk3zRzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgC0SyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:54:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40654 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgC0SyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:54:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id w26so12543417edu.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pcrGpCxgH824Ygm9MUy2KnbWGWn400IfTnGNSoBI9xg=;
        b=uKk3zRzH1OEHCX1RtvyvcGzx4E3IEIVp5Ohw1N+N9Y1iPwnw2kMZh+c/F1fsBA57y2
         lZ/Ybmr4jwUr6FEVYolcsxSkK42qr8fBdzm1kJzKyQg3H9RPbKs4Bxd4G0LZICCwurvb
         Cxfrjj0UpC3t3sV/Uht6AkGJFnk7Zj/nG9EwxZnKmQcRBd5Oy2Tz+b6+eum3DS3VNnl5
         KBTJtJx20X+WihMudbsY4Q+A1Z3cYUw51JQwg1X1YhQpaxJqCFmW3gzaibprmdvLPAGK
         fhbn9gelY7ap+eihtT/nwwpYf1p+LnSmqPNaX2yxhX72xBxuZ3bSMq7XUFt3CMMhnS2m
         h2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pcrGpCxgH824Ygm9MUy2KnbWGWn400IfTnGNSoBI9xg=;
        b=UaYYJSIb56BRjm97IJl2ZzQyKP8OOJQmcMx1qBIp480djLJr21YxsoOx+lIawCk/Ru
         jVAA+RJ4xIzlJculEMIHD4SHSr79v38NvomZRDO3Q7EWBfbdUdZJRd3wwzPAYsWpnsUJ
         43Krrnfx2bzqFsWAjQ1qJXAP8oder+tCQw5mzo4z+G1CJI4irGDEaI35RyMwAIz66NsJ
         rivJBquld1C4ZrimBXy+ccfOVIbvt7zvcCMYh4h7cJkeTw1FFwflJEzQ91POcZJFbuWI
         4qM6WDIvZQ/Qmgcs31gXwRnz9hw2iScG9p2XFiX1l8CCrLT6928iRmw29onRewl24UeU
         Wvmg==
X-Gm-Message-State: ANhLgQ38HK6BgGHeWH4NgiLf2zDsMXod9E6KMbyvsmS2Q2x8noRWQQMM
        2TQjW5CQUNPwrqT4FcU/9yS91t9I0XTPG4pLG18=
X-Google-Smtp-Source: ADFU+vuyIsUnBLuES5LHtMZa05T+VdrxUHyHV72oRhfnbRBc6BJbZATK158iRJsCXSSwUGtlnYSLS17pAGgDZaLgDrg=
X-Received: by 2002:a17:906:3e0c:: with SMTP id k12mr369897eji.309.1585335252748;
 Fri, 27 Mar 2020 11:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com> <20200327170601.18563-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20200327170601.18563-6-kirill.shutemov@linux.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 27 Mar 2020 11:53:57 -0700
Message-ID: <CAHbLzkoVq-ssduiPwdzcsL2bVhPwmw4X9ktAO0CYOVAi8H84oA@mail.gmail.com>
Subject: Re: [PATCH 5/7] khugepaged: Allow to collapse PTE-mapped compound pages
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 10:06 AM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> We can collapse PTE-mapped compound pages. We only need to avoid
> handling them more than once: lock/unlock page only once if it's present
> in the PMD range multiple times as it handled on compound level. The
> same goes for LRU isolation and putpack.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/khugepaged.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b47edfe57f7b..c8c2c463095c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -515,6 +515,17 @@ void __khugepaged_exit(struct mm_struct *mm)
>
>  static void release_pte_page(struct page *page)
>  {
> +       /*
> +        * We need to unlock and put compound page on LRU only once.
> +        * The rest of the pages have to be locked and not on LRU here.
> +        */
> +       VM_BUG_ON_PAGE(!PageCompound(page) &&
> +                       (!PageLocked(page) && PageLRU(page)), page);
> +
> +       if (!PageLocked(page))
> +               return;
> +
> +       page = compound_head(page);
>         dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));

We need count in the number of base pages. The same counter is
modified by vmscan in base page unit. Also need modify the inc path.

>         unlock_page(page);
>         putback_lru_page(page);
> @@ -537,6 +548,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>         pte_t *_pte;
>         int none_or_zero = 0, result = 0, referenced = 0;
>         bool writable = false;
> +       LIST_HEAD(compound_pagelist);
>
>         for (_pte = pte; _pte < pte+HPAGE_PMD_NR;
>              _pte++, address += PAGE_SIZE) {
> @@ -561,13 +573,23 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>                         goto out;
>                 }
>
> -               /* TODO: teach khugepaged to collapse THP mapped with pte */
> +               VM_BUG_ON_PAGE(!PageAnon(page), page);
> +
>                 if (PageCompound(page)) {
> -                       result = SCAN_PAGE_COMPOUND;
> -                       goto out;
> -               }
> +                       struct page *p;
> +                       page = compound_head(page);
>
> -               VM_BUG_ON_PAGE(!PageAnon(page), page);
> +                       /*
> +                        * Check if we have dealt with the compount page

s/compount/compound

> +                        * already
> +                        */
> +                       list_for_each_entry(p, &compound_pagelist, lru) {
> +                               if (page ==  p)
> +                                       break;
> +                       }
> +                       if (page ==  p)
> +                               continue;

I don't quite understand why we need the above check. My understanding
is when we scan the ptes, once the first PTE mapped subpage is found,
then the THP would be added into compound_pagelist, then the later
loop would find the same THP on the list then just break the loop. Did
I miss anything?

> +               }
>
>                 /*
>                  * We can do it before isolate_lru_page because the
> @@ -640,6 +662,9 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>                     page_is_young(page) || PageReferenced(page) ||
>                     mmu_notifier_test_young(vma->vm_mm, address))
>                         referenced++;
> +
> +               if (PageCompound(page))
> +                       list_add_tail(&page->lru, &compound_pagelist);
>         }
>         if (likely(writable)) {
>                 if (likely(referenced)) {
> @@ -1185,11 +1210,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>                         goto out_unmap;
>                 }
>
> -               /* TODO: teach khugepaged to collapse THP mapped with pte */
> -               if (PageCompound(page)) {
> -                       result = SCAN_PAGE_COMPOUND;
> -                       goto out_unmap;
> -               }
> +               page = compound_head(page);
>
>                 /*
>                  * Record which node the original page is from and save this
> --
> 2.26.0
>
>
