Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DB6C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 04:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C3A2072D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 04:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz9A34r6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCGEKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 23:10:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44494 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCGEKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 23:10:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so4927415eds.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 20:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1w4XHH9ZExVYGO7BfaV04CRpYjRNOnECPsUmHdNl1/s=;
        b=lz9A34r6Zw2KZnfhMDS5bDm+n9j8iDTO2PgYJSW+bxJTNuw4oUOyRue7Dj5YFHdBv0
         m3WNU+hjWdK8XzgxpF/N19CNmGFPVCskF8W+qlo15uRi23KcZWYzApOipaG3upmHRabO
         yv4oRUDqLLMcUFjFg7+N2a5e4N9nOBuJS14eHKTNG7DWq/1sAFgSHlnZzHEiacMKy1dq
         QUtbsL14+hxolpR/anuv9J5FgXF90cRKZyKsl+3iBW5oM8DxGrz5AEmGvIveXwl7/qH9
         YgYhWwGPapBYQoqGErXHpK6+lsm+LAjV6BSn7Krn4oKnNvwxUXH/Gu4pfmx6PaPYdiCY
         JvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1w4XHH9ZExVYGO7BfaV04CRpYjRNOnECPsUmHdNl1/s=;
        b=WKkuTUQX6kPuiOzLAqCN8sPuSYN5z8HiSR+Y9VszvvLHu3xh35pg6+l2t9+YWnnOfK
         pxyks9JojoDUreWvvZGQcRlIW4Bm0PkZrjjJAISZS6tNOuc+DW2ii/LFwNxo0TYIpy0p
         4E9wYBKwVk9IE0Nxo7bqPBRQP33CJqnXHOb1xvCxNihwptBQGXSigLL31OtYYad7504L
         Yk0kfuTTSEnL2FLWDQp4P3UaIu0uWZLDiID9emaOqy63tII/F+hXTh1We7eJwFbYWO0k
         SIELFgLqSY7uXwKpbH4M1KA6a2+HFmviuWKvir7yzGwBrIdO75GR8uibYmQcD9B4iIxW
         jTbg==
X-Gm-Message-State: ANhLgQ1ik2TLnLSw+GG3d2CZgg0xGUr8CElA/PsnQvlGdildOGdLxzqi
        g3zWxJ7MCXNQPxSH9LGsCtmmjanXsDUqPL+4GCY=
X-Google-Smtp-Source: ADFU+vvFMqN+v8l1TLveC8NorIjkCniR0/Jt2Y2Zwy1IzbEzFgm2L5ZyGcf7GEoojO6Swvf1JPr9UAp0wfRfENanGQU=
X-Received: by 2002:a17:906:1cc2:: with SMTP id i2mr5910224ejh.283.1583554228599;
 Fri, 06 Mar 2020 20:10:28 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2003061421240.7412@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2003061421240.7412@chino.kir.corp.google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 6 Mar 2020 20:10:15 -0800
Message-ID: <CAHbLzkqQw=KSC1M1aaAYVTV6nWWYi5tGPefEAP776JRREJLggw@mail.gmail.com>
Subject: Re: [patch 1/2] mm, shmem: add vmstat for hugepage fallback
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 2:22 PM David Rientjes <rientjes@google.com> wrote:
>
> The existing thp_fault_fallback indicates when thp attempts to allocate a
> hugepage but fails, or if the hugepage cannot be charged to the mem cgroup
> hierarchy.
>
> Extend this to shmem as well.  Adds a new thp_file_fallback to complement
> thp_file_alloc that gets incremented when a hugepage is attempted to be
> allocated but fails, or if it cannot be charged to the mem cgroup
> hierarchy.
>
> Additionally, remove the check for CONFIG_TRANSPARENT_HUGE_PAGECACHE from
> shmem_alloc_hugepage() since it is only called with this configuration
> option.

Looks good to me. Thanks for taking this suggestion. Reviewed-by: Yang
Shi <yang.shi@linux.alibaba.com>

>
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst |  4 ++++
>  include/linux/vm_event_item.h              |  2 ++
>  mm/shmem.c                                 | 10 ++++++----
>  mm/vmstat.c                                |  1 +
>  4 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -319,6 +319,10 @@ thp_file_alloc
>         is incremented every time a file huge page is successfully
>         allocated.
>
> +thp_file_fallback
> +       is incremented if a file huge page is attempted to be allocated
> +       but fails and instead falls back to using small pages.
> +
>  thp_file_mapped
>         is incremented every time a file huge page is mapped into
>         user address space.
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -76,6 +76,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>                 THP_COLLAPSE_ALLOC,
>                 THP_COLLAPSE_ALLOC_FAILED,
>                 THP_FILE_ALLOC,
> +               THP_FILE_FALLBACK,
>                 THP_FILE_MAPPED,
>                 THP_SPLIT_PAGE,
>                 THP_SPLIT_PAGE_FAILED,
> @@ -115,6 +116,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>
>  #ifndef CONFIG_TRANSPARENT_HUGEPAGE
>  #define THP_FILE_ALLOC ({ BUILD_BUG(); 0; })
> +#define THP_FILE_FALLBACK ({ BUILD_BUG(); 0; })
>  #define THP_FILE_MAPPED ({ BUILD_BUG(); 0; })
>  #endif
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1472,9 +1472,6 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
>         pgoff_t hindex;
>         struct page *page;
>
> -       if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGE_PAGECACHE))
> -               return NULL;
> -
>         hindex = round_down(index, HPAGE_PMD_NR);
>         if (xa_find(&mapping->i_pages, &hindex, hindex + HPAGE_PMD_NR - 1,
>                                                                 XA_PRESENT))
> @@ -1486,6 +1483,8 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
>         shmem_pseudo_vma_destroy(&pvma);
>         if (page)
>                 prep_transhuge_page(page);
> +       else
> +               count_vm_event(THP_FILE_FALLBACK);
>         return page;
>  }
>
> @@ -1871,8 +1870,11 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>
>         error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
>                                             PageTransHuge(page));
> -       if (error)
> +       if (error) {
> +               if (PageTransHuge(page))
> +                       count_vm_event(THP_FILE_FALLBACK);
>                 goto unacct;
> +       }
>         error = shmem_add_to_page_cache(page, mapping, hindex,
>                                         NULL, gfp & GFP_RECLAIM_MASK);
>         if (error) {
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1257,6 +1257,7 @@ const char * const vmstat_text[] = {
>         "thp_collapse_alloc",
>         "thp_collapse_alloc_failed",
>         "thp_file_alloc",
> +       "thp_file_fallback",
>         "thp_file_mapped",
>         "thp_split_page",
>         "thp_split_page_failed",
