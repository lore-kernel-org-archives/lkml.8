Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B900C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67BCD2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B66nR30x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgHTPr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbgHTPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:47 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8B9C061388
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:46:45 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so2589677ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1RrYNr31NQi6xNHXP2IRc+NcviE0ZSrBQayM98jfLA=;
        b=B66nR30x++j+0C6TC7iGxqjyYlJdwDK1j7E7nieS/4aXdOCO0M8a/jFKAtiw85Q+nG
         ieb5GxU155DY0Dh3SvFGyBaBDNAb6JRuhPmIt7S+QiiKGe2bQTwVYBoA1fGVAU6okfSJ
         RRiTXS4u+PFueBC8wjb2zeohu0Ie7ja9DN+i3K16n3LUK6HEk0fMCd6dWblnnKyS2ei7
         3eQdvarbSACmkDn6nfAzjuUUh8yXU7o3Jcg+0En+/v7rM1MxUqbvc/RReMDdW9up1bHA
         LT7SQl4hEfm16MsHes5PHoJ2qRPzuijyk+uljFR0v7utOJtWG3CitkqEh2kSy7/awP0c
         a3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1RrYNr31NQi6xNHXP2IRc+NcviE0ZSrBQayM98jfLA=;
        b=kjXoHbGFGqLMem3t79UuHhnWFJi4yhZBPE3036BeIs7WLi2kM1AKpgi6phEktGT/5w
         UIds8GkGSNFLScIXifi0JOXBMGQkOXqoG+OKRlAqwzEh71va0wuAyBJB144azH9cN4Pc
         khK/aTFALuaAD4sh2ABBBTl7/bPK3FaqK9hkN80+VXmNm+OG9593DqsNlSgFZ6A4x9sh
         uVbc3AUPks5KoBpRlrgjQc5aJ5oXwDTr12rTtK1MSmRp+LSEkPycStPK+3jomLdFMp/f
         XQGN2ab7npGyEefUSnCZHAHkSEwgP2Z3keWivNzD/r0DL3w6H8cH4uHVMESmKX/oMGHu
         y5Ag==
X-Gm-Message-State: AOAM532YmS3AuNxLNkmzHEMp/CoAwS32zMHSSclzwavHzQC27AvhBIYZ
        IcjkNMF7Z5YKL5ZFNCUgtgZEWvJomJ1Q03iOl5PMNg==
X-Google-Smtp-Source: ABdhPJwoCdm+N1AxiYk/1lBjrYcLmf0ZuNk8IyAfuDNgXgQHz2fUUgkcpq+Tblv/Rig+AH7Vx7Rd11XIpM05l6TL+ws=
X-Received: by 2002:a2e:2a04:: with SMTP id q4mr1770388ljq.192.1597938403738;
 Thu, 20 Aug 2020 08:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200820130350.3211-1-longman@redhat.com> <20200820130350.3211-4-longman@redhat.com>
In-Reply-To: <20200820130350.3211-4-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Aug 2020 08:46:32 -0700
Message-ID: <CALvZod7cNkjgd_YWzPSFm=AeC8sy5kWspX3J_Q7237Q9+N5Pxw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/memcg: Unify swap and memsw page counters
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 6:04 AM Waiman Long <longman@redhat.com> wrote:
>
> The swap page counter is v2 only while memsw is v1 only. As v1 and v2
> controllers cannot be active at the same time, there is no point to keep
> both swap and memsw page counters in mem_cgroup. The previous patch has
> made sure that memsw page counter is updated and accessed only when in
> v1 code paths. So it is now safe to alias the v1 memsw page counter to v2
> swap page counter. This saves 14 long's in the size of mem_cgroup. This
> is a saving of 112 bytes for 64-bit archs.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/memcontrol.h | 3 +--
>  mm/memcontrol.c            | 8 +++++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index d0b036123c6a..d2a819d7db70 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -216,10 +216,9 @@ struct mem_cgroup {
>
>         /* Accounted resources */
>         struct page_counter memory;
> -       struct page_counter swap;
> +       struct page_counter swap;       /* memsw (memory+swap) for v1 */
>
>         /* Legacy consumer-oriented counters */
> -       struct page_counter memsw;
>         struct page_counter kmem;
>         struct page_counter tcpmem;
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d219dca5239f..04c3794cdc98 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -68,6 +68,11 @@
>
>  #include <trace/events/vmscan.h>
>
> +/*
> + * The v1 memsw page counter is aliased to the v2 swap page counter.
> + */
> +#define memsw  swap
> +

Personally I would prefer a union instead of #define.

>  struct cgroup_subsys memory_cgrp_subsys __read_mostly;
>  EXPORT_SYMBOL(memory_cgrp_subsys);
>
> @@ -5279,13 +5284,11 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>                 memcg->use_hierarchy = true;
>                 page_counter_init(&memcg->memory, &parent->memory);
>                 page_counter_init(&memcg->swap, &parent->swap);
> -               page_counter_init(&memcg->memsw, &parent->memsw);
>                 page_counter_init(&memcg->kmem, &parent->kmem);
>                 page_counter_init(&memcg->tcpmem, &parent->tcpmem);
>         } else {
>                 page_counter_init(&memcg->memory, NULL);
>                 page_counter_init(&memcg->swap, NULL);
> -               page_counter_init(&memcg->memsw, NULL);
>                 page_counter_init(&memcg->kmem, NULL);
>                 page_counter_init(&memcg->tcpmem, NULL);
>                 /*
> @@ -5414,7 +5417,6 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
>
>         page_counter_set_max(&memcg->memory, PAGE_COUNTER_MAX);
>         page_counter_set_max(&memcg->swap, PAGE_COUNTER_MAX);
> -       page_counter_set_max(&memcg->memsw, PAGE_COUNTER_MAX);
>         page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
>         page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
>         page_counter_set_min(&memcg->memory, 0);
> --
> 2.18.1
>
