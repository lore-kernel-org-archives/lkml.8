Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DB3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706D8207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHcwkVEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHTA0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHTA0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:26:31 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C842C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 17:26:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j15so80060lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 17:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mE4zqw7ry1MfZH9x184nZ2vzhA0MYzok+VpmlWA+zfk=;
        b=gHcwkVEnunAcNAqPlLjtg0pSC0LdqrIfnZYk/Ajg6bM6EpGoCa/IaA4IjPsMfKhIE2
         DWR+LcqK6o1msWSHL7lEADWCyseNQlRdVCWfqN16VTR+v3gg5NnBEhWkUAZEm9+vcnBN
         kubQnJ9KgFgT16G53OTR2T+kS+H1xRWRUd/u9OZxqTCNFZYNrGprPlDtXKwcZ/9IJHGg
         lug2//c6ZgN2mQ5eOHUW5mGeUDmw3ZLKKJzuY8Qn0teavWO/or7bsADvVdHKt5vYi2tu
         ExPBGB8SM56GfFnMXpuzbGH91OapxDb+0b+lTlWPbU/5bQ3t2jRofUPbxva/5kUr4xRC
         fK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mE4zqw7ry1MfZH9x184nZ2vzhA0MYzok+VpmlWA+zfk=;
        b=j3BO9GM95TpfzoMHf7x0e60mFokayW8GNrXEemcOFXvIdW7m0P+8rq/DjDUc2lbA7F
         yuBOOfhX2IqnreChYEsJxfpsnfzc5sp5efhuGwCxD0udQunGmAIL8tK/JOTnzqsEIJwm
         3tC/4qi2sK6sUSzqu9V6WDHZPM8NxowqDcduF22NX5zfFdExR5Nuq+8fgLpRsEccpEeV
         JIBljlQTO5YGsXsP2Qk4wY52KcGpTHHLQkq5hobzl4noFbdWIByAONgRvGKqH0j9s8UF
         YRbZQQfzUalDPYmrGK0Ig0nVNE0w/BN1YdHEfGWhinsWW/8h0LrutHkl+ifsBuo8qUAm
         NJKA==
X-Gm-Message-State: AOAM5324eeET6TcJynOXvogLpl4F0BDi8rkApxRjU4EJMtH2PsPHDlKB
        amYm3yKqTkIULR76OcKjw88UqLwT2R2+53S8m4zsJw==
X-Google-Smtp-Source: ABdhPJzrx/IQU+mOMBkIIzva9xPTUvU8f5r9F0LCweN2I86LVvJdng0MXgFo31CaU5p30Rqf0utS7tPTJOUJidgUNIg=
X-Received: by 2002:a19:c68b:: with SMTP id w133mr284468lff.189.1597883187523;
 Wed, 19 Aug 2020 17:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200818072501.30396-1-sjpark@amazon.com> <20200818072501.30396-7-sjpark@amazon.com>
In-Reply-To: <20200818072501.30396-7-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 19 Aug 2020 17:26:15 -0700
Message-ID: <CALvZod5ZRUHO+=Bvwj4aEKNL0Egwea2dZKuYDKhkvvUyezbgdg@mail.gmail.com>
Subject: Re: [RFC v7 06/10] mm/damon: Implement callbacks for physical memory monitoring
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        Andrea Arcangeli <aarcange@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        "Du, Fan" <fan.du@intel.com>, foersleo@amazon.de,
        Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, jolsa@redhat.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>, mark.rutland@arm.com,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, rppt@kernel.org,
        sblbir@amazon.com, shuah@kernel.org, sj38.park@gmail.com,
        snu@amazon.de, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, zgf574564920@gmail.com,
        linux-damon@amazon.com, Linux MM <linux-mm@kvack.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:27 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit implements the four callbacks (->init_target_regions,
> ->update_target_regions, ->prepare_access_check, and ->check_accesses)
> for the basic access monitoring of the physical memory address space.
> By setting the callback pointers to point those, users can easily
> monitor the accesses to the physical memory.
>
> Internally, it uses the PTE Accessed bit, as similar to that of the
> virtual memory support.  Also, it supports only user memory pages, as
> idle page tracking also does, for the same reason.  If the monitoring
> target physical memory address range contains non-user memory pages,
> access check of the pages will do nothing but simply treat the pages as
> not accessed.
>
> Users who want to use other access check primitives and/or monitor the
> non-user memory regions could implement and use their own callbacks.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
[snip]
> +static void damon_phys_mkold(unsigned long paddr)
> +{
> +       struct page *page = damon_phys_get_page(PHYS_PFN(paddr));
> +       struct rmap_walk_control rwc = {
> +               .rmap_one = damon_page_mkold,
> +               .anon_lock = page_lock_anon_vma_read,
> +       };
> +       bool need_lock;
> +
> +       if (!page)
> +               return;
> +
> +       if (!page_mapped(page) || !page_rmapping(page))
> +               return;

I don't think you want to skip the unmapped pages. The point of
physical address space monitoring was to include the monitoring of
unmapped pages, so, skipping them invalidates the underlying
motivation.

> +
> +       need_lock = !PageAnon(page) || PageKsm(page);
> +       if (need_lock && !trylock_page(page))
> +               return;
> +
> +       rmap_walk(page, &rwc);
> +
> +       if (need_lock)
> +               unlock_page(page);
> +       put_page(page);
> +}
> +
[snip]
> +
> +static bool damon_phys_young(unsigned long paddr, unsigned long *page_sz)
> +{
> +       struct page *page = damon_phys_get_page(PHYS_PFN(paddr));
> +       struct damon_phys_access_chk_result result = {
> +               .page_sz = PAGE_SIZE,
> +               .accessed = false,
> +       };
> +       struct rmap_walk_control rwc = {
> +               .arg = &result,
> +               .rmap_one = damon_page_accessed,
> +               .anon_lock = page_lock_anon_vma_read,
> +       };
> +       bool need_lock;
> +
> +       if (!page)
> +               return false;
> +
> +       if (!page_mapped(page) || !page_rmapping(page))
> +               return false;

Same here.

> +
> +       need_lock = !PageAnon(page) || PageKsm(page);
> +       if (need_lock && !trylock_page(page))
> +               return false;
> +
> +       rmap_walk(page, &rwc);
> +
> +       if (need_lock)
> +               unlock_page(page);
> +       put_page(page);
> +
> +       *page_sz = result.page_sz;
> +       return result.accessed;
> +}
> +
