Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24802C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AD32087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ASUufhoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgBCS2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:28:00 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32830 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbgBCS17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:27:59 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so12254054qto.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=45arIOagvyiMcACXk6TG313wTzmAuQ92wsNv5LJ1hc8=;
        b=ASUufhoBL/L9gjOgIkVl+X/+1iojQplgBD0VuNH7dJxHS53U51nj9lk6T+XrOx1bGB
         6FhwaIcWUq0m6oUsuoVUcq65SfGZGdkhEvUttST4cN9lGnIAU0ScWVV9D5UZTMHFF+9t
         3ZZE+J67I0F2c5PI42St3dgAE1nhiLcm+xY79T2NG5ydHt5a4n4sG0k72KHVRHrB9Ftv
         0VQhKUFhkklTI9/w4Fn6i9IokhCQmdMv6jXf3uRgmxp4O8LOPyncxuDrK0leF2VLWRBK
         updFD+lT5yCKK4RoOSfXt463oLuxlKB+5fW8Uz6zGwRAXzmbCjBT+q0/OL/O8UEQ0gTx
         xYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=45arIOagvyiMcACXk6TG313wTzmAuQ92wsNv5LJ1hc8=;
        b=oMHqt2l1gEiBgMR7pafIjswzT6M/rE3AGb1D77g3jnv4V9ewjXKBoKyip9PYaBFSgc
         qI5Hn4qJkulESuUrwX2vWYFaYXy2Eqxa0jXOCt7wDMXj/DzYlPso4CtZdAw3+ELmh6dw
         +aamzT9PPOgVPppxG85jxOo03tzwhcgZXcmskNq+80jDk6R+fyzOtSFUHDSZG5FaEy1e
         IV5VEKs0zoKQD894Me0IUmQUfDX/bJPFYjIkc7Qk/Lb1fPIJwRGfCfYU/I3FMFDRHNLc
         m8zipGOjwx4+ugkVJmQfusV8SdV/9XbKMl+CSx91sAe1HtG+OSrYharKAEhEEdK6MDqw
         9DLw==
X-Gm-Message-State: APjAAAVfR40UkAxFNSPoQELHQNf2EM4QcnPp9jSPmJI/R/3HWNBPUF66
        T9aJ0/EKHgmP/qtKadTyG9Gp5A==
X-Google-Smtp-Source: APXvYqxFjnYIl31gVkLL/LJxKmRjaPwN+bZfw8A2uqCAXnaZuB/fPi6DZWJzl2D6CFC1+LLJendSew==
X-Received: by 2002:aed:25a4:: with SMTP id x33mr25400876qtc.165.1580754478425;
        Mon, 03 Feb 2020 10:27:58 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::e256])
        by smtp.gmail.com with ESMTPSA id v10sm10134764qtq.58.2020.02.03.10.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:27:57 -0800 (PST)
Date:   Mon, 3 Feb 2020 13:27:56 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 16/28] mm: memcg/slab: allocate obj_cgroups for
 non-root slab pages
Message-ID: <20200203182756.GG1697@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-17-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127173453.2089565-17-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:34:41AM -0800, Roman Gushchin wrote:
> Allocate and release memory to store obj_cgroup pointers for each
> non-root slab page. Reuse page->mem_cgroup pointer to store a pointer
> to the allocated space.
> 
> To distinguish between obj_cgroups and memcg pointers in case
> when it's not obvious which one is used (as in page_cgroup_ino()),
> let's always set the lowest bit in the obj_cgroup case.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  include/linux/mm.h       | 25 ++++++++++++++++++--
>  include/linux/mm_types.h |  5 +++-
>  mm/memcontrol.c          |  5 ++--
>  mm/slab.c                |  3 ++-
>  mm/slab.h                | 51 +++++++++++++++++++++++++++++++++++++++-
>  mm/slub.c                |  2 +-
>  6 files changed, 83 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 080f8ac8bfb7..65224becc4ca 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1264,12 +1264,33 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
>  #ifdef CONFIG_MEMCG
>  static inline struct mem_cgroup *page_memcg(struct page *page)
>  {
> -	return page->mem_cgroup;
> +	struct mem_cgroup *memcg = page->mem_cgroup;
> +
> +	/*
> +	 * The lowest bit set means that memcg isn't a valid memcg pointer,
> +	 * but a obj_cgroups pointer. In this case the page is shared and
> +	 * isn't charged to any specific memory cgroup. Return NULL.
> +	 */
> +	if ((unsigned long) memcg & 0x1UL)
> +		memcg = NULL;
> +
> +	return memcg;

That should really WARN instead of silently returning NULL. Which
callsite optimistically asks a page's cgroup when it has no idea
whether that page is actually a userpage or not?

>  static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
>  {
> +	struct mem_cgroup *memcg = READ_ONCE(page->mem_cgroup);
> +
>  	WARN_ON_ONCE(!rcu_read_lock_held());
> -	return READ_ONCE(page->mem_cgroup);
> +
> +	/*
> +	 * The lowest bit set means that memcg isn't a valid memcg pointer,
> +	 * but a obj_cgroups pointer. In this case the page is shared and
> +	 * isn't charged to any specific memory cgroup. Return NULL.
> +	 */
> +	if ((unsigned long) memcg & 0x1UL)
> +		memcg = NULL;
> +
> +	return memcg;

Same here.

>  }
>  #else
>  static inline struct mem_cgroup *page_memcg(struct page *page)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 270aa8fd2800..5102f00f3336 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -198,7 +198,10 @@ struct page {
>  	atomic_t _refcount;
>  
>  #ifdef CONFIG_MEMCG
> -	struct mem_cgroup *mem_cgroup;
> +	union {
> +		struct mem_cgroup *mem_cgroup;
> +		struct obj_cgroup **obj_cgroups;
> +	};

Since you need the casts in both cases anyway, it's safer (and
simpler) to do

	unsigned long mem_cgroup;

to prevent accidental direct derefs in future code.

Otherwise, this patch looks good to me!
