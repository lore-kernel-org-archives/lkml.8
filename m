Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BD2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C61A206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2DYXq4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgCMTeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:34:03 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43885 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgCMTeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:34:02 -0400
Received: by mail-oi1-f196.google.com with SMTP id p125so10642945oif.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wb4/KS6+9uhEG0B4TwSigcUJLPiMeOYxLqlueo3jlPY=;
        b=I2DYXq4wlPraz2yYvmEBl6cJPy+kZcx9eML4K5Lu6Ymfoj4Vt+HtkujwCjlRvMMXjO
         Mu11l0fUPAK2FeIrPyU+VrCFEAUnyO2zIJpGosjgBSID4zNAlPWlIzVDER9bSOtK6eoB
         Tm2MQK2sUPrxjtCM+2CLduS0jF0aLXeFsGZiqyLP86hPmZF7fHSTciMfgnZb99X457A/
         rIm7nlzzRk6dKKj9f5bny7/RNNsVgjbo7RmexmwtNQf6BmOFHdDoMI3JJDRqTmkXpCiH
         h8670GqFZEtAQDKQgUr4fkL4JZjPYk8dhFwSK9nL4EqvPVFrcLSkIEG473+VuH2xAz2Z
         D1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wb4/KS6+9uhEG0B4TwSigcUJLPiMeOYxLqlueo3jlPY=;
        b=UWGX3yWQ21POtDIahmTQF316mXiCNmRAYbcXLXth7KRpmZl22JDxVqP4L71Gx8OBAI
         yTWUQJWAQFlLBOmpNf3zBf3Z7JU7QGmfU6XRgNG0oH7z6uamlo0TAQY19joT0Sd9r0js
         cvh/p2jstVcfap6gMxUYwILj49jiaPUQaHOscAu5uSjuFDXx3y/970Ohnh8R5tZhumVx
         z9RML0IWkwQYniSD/KPEFNcB9i//lPAGI7jue5cYAHWcPtw71Afz5HVEXo6M+Ks6sOB8
         Ea7pG0NMq1BjSNKcMUwBZ6pfe38lFeR15m4JUcTg8NpTFBh1IZIkyG/lAbswxOz6/kvN
         ieAA==
X-Gm-Message-State: ANhLgQ2hC99sWodJyxkIIY/STpsy4q69NFiuYy2rgIlnDBht7nOwOh85
        hF8K416Huy9GxKVLJcnypZEZ8NcwJrsXDQ8k7HHh1Se7
X-Google-Smtp-Source: ADFU+vuZ7tGVbK62NPw97jFsj8xgjZ9obwM2nBww/pDbRIMb+cNXkiwCRmQtfT+Jdaj9kGjLblHNmHEiFu8cj13Xe/w=
X-Received: by 2002:aca:af93:: with SMTP id y141mr8043044oie.144.1584128041488;
 Fri, 13 Mar 2020 12:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <1584124476-76534-1-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1584124476-76534-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 13 Mar 2020 12:33:50 -0700
Message-ID: <CALvZod4W9kkh578Kix7+M9Jkwm1sxx2zvvPG+0Us3R8bEkpEpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: swap: make page_evictable() inline
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 11:34 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> When backporting commit 9c4e6b1a7027 ("mm, mlock, vmscan: no more
> skipping pagevecs") to our 4.9 kernel, our test bench noticed around 10%
> down with a couple of vm-scalability's test cases (lru-file-readonce,
> lru-file-readtwice and lru-file-mmap-read).  I didn't see that much down
> on my VM (32c-64g-2nodes).  It might be caused by the test configuration,
> which is 32c-256g with NUMA disabled and the tests were run in root memcg,
> so the tests actually stress only one inactive and active lru.  It
> sounds not very usual in mordern production environment.
>
> That commit did two major changes:
> 1. Call page_evictable()
> 2. Use smp_mb to force the PG_lru set visible
>
> It looks they contribute the most overhead.  The page_evictable() is a
> function which does function prologue and epilogue, and that was used by
> page reclaim path only.  However, lru add is a very hot path, so it
> sounds better to make it inline.  However, it calls page_mapping() which
> is not inlined either, but the disassemble shows it doesn't do push and
> pop operations and it sounds not very straightforward to inline it.
>
> Other than this, it sounds smp_mb() is not necessary for x86 since
> SetPageLRU is atomic which enforces memory barrier already, replace it
> with smp_mb__after_atomic() in the following patch.
>
> With the two fixes applied, the tests can get back around 5% on that
> test bench and get back normal on my VM.  Since the test bench
> configuration is not that usual and I also saw around 6% up on the
> latest upstream, so it sounds good enough IMHO.
>
> The below is test data (lru-file-readtwice throughput) against the v5.6-rc4:
>         mainline        w/ inline fix
>           150MB            154MB
>

What is the test setup for the above experiment? I would like to get a repro.

> With this patch the throughput gets 2.67% up.  The data with using
> smp_mb__after_atomic() is showed in the following patch.
>
> Fixes: 9c4e6b1a7027 ("mm, mlock, vmscan: no more skipping pagevecs")
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  include/linux/swap.h | 24 +++++++++++++++++++++++-
>  mm/vmscan.c          | 23 -----------------------
>  2 files changed, 23 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 1e99f7a..297eb66 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -374,7 +374,29 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
>  #define node_reclaim_mode 0
>  #endif
>
> -extern int page_evictable(struct page *page);
> +/*
> + * page_evictable - test whether a page is evictable
> + * @page: the page to test
> + *
> + * Test whether page is evictable--i.e., should be placed on active/inactive
> + * lists vs unevictable list.
> + *
> + * Reasons page might not be evictable:
> + * (1) page's mapping marked unevictable
> + * (2) page is part of an mlocked VMA
> + *
> + */
> +static inline int page_evictable(struct page *page)
> +{
> +       int ret;
> +
> +       /* Prevent address_space of inode and swap cache from being freed */
> +       rcu_read_lock();
> +       ret = !mapping_unevictable(page_mapping(page)) && !PageMlocked(page);
> +       rcu_read_unlock();
> +       return ret;
> +}
> +
>  extern void check_move_unevictable_pages(struct pagevec *pvec);
>
>  extern int kswapd_run(int nid);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 8763705..855c395 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4277,29 +4277,6 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
>  }
>  #endif
>
> -/*
> - * page_evictable - test whether a page is evictable
> - * @page: the page to test
> - *
> - * Test whether page is evictable--i.e., should be placed on active/inactive
> - * lists vs unevictable list.
> - *
> - * Reasons page might not be evictable:
> - * (1) page's mapping marked unevictable
> - * (2) page is part of an mlocked VMA
> - *
> - */
> -int page_evictable(struct page *page)
> -{
> -       int ret;
> -
> -       /* Prevent address_space of inode and swap cache from being freed */
> -       rcu_read_lock();
> -       ret = !mapping_unevictable(page_mapping(page)) && !PageMlocked(page);
> -       rcu_read_unlock();
> -       return ret;
> -}
> -
>  /**
>   * check_move_unevictable_pages - check pages for evictability and move to
>   * appropriate zone lru list
> --
> 1.8.3.1
>
