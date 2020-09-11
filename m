Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15663C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E26208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwKeCNBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgIKQWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgIKQWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:22:03 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C48C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:22:03 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u21so12923464ljl.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uCs8sK724xgrjgAwvIZNy/g6OhzqOwMIcpbgNs4M6k=;
        b=HwKeCNBRiGDa4BUCzy8CR2l/UJd4vXSUu0N4tOlCrZdJM49ooJ9gEOmR+/JWAtXIgX
         28/Fed29zYW9pTrsc6mchvrgm12+1PUbaBeP/CRvjSCX1nakdfcfUrcqcP/94TKAuNz0
         7NF90iZQblfqWgrFqKDY/XRkWCzr21gci103JWnHGS1BNVZ246yj+iP/8LhuddJGkVWK
         caR0dq8xhLKVqvnXCHYtQ+ECDtGQHEYuhum6p7QTM9s0flV70Fdyu8Zd/FXFjqk8IgDf
         q73wawMp/zzcEjJnL86qrlYZtkW8VZD4rKNJc8PRGO5uuqY7cik3T8jmbu2r+dxJdwts
         ttkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uCs8sK724xgrjgAwvIZNy/g6OhzqOwMIcpbgNs4M6k=;
        b=PvQhmUwaBuAGP1Nf/Ofy2QrkN/zbf1tI78nJYWJT/2ANyYY6WuI6WpzzTa6HZz1TWo
         0D3bQcr1t9ce4DH/nf9+l7M9ggoeV0tUQ10822zOrzYuojSlpEuu9Tu/bQ0V4u1vTson
         lSaTvWM2GP6ggIvot1LUci8Nabxc3MfkjadEDmxX55+F/0QZR1GXB5S+m82WEgcn9UYl
         kdAwFG3BgCrg8YRyAUecNp06KboYsnw6+qXYsuTHpYLPmr+TxGUKrwqmxGdEcWzxtN5U
         W6LDRJVTIWWKF5L63gf/f8Vgcv82AlGepUyqYUXM4j0JQFhy6mrV5nCDRVVDap2FxDUU
         ZmJg==
X-Gm-Message-State: AOAM532VLuYnmnCRSoxVScUg308IsCdOnCjkUFZCXzBkE4vBltgyXp58
        IOa6uYmmPXqaug3sbHfVj4yRDTrCY5v6i5ZbcwuwbA==
X-Google-Smtp-Source: ABdhPJwtHiPRand28SIuaJYBfKMlytcg/m9BTz0IY4B1SVSLiAwLsVzfY9fjFEFxACXaxPfCIT4kr8D+Ra+DI4y2jgo=
X-Received: by 2002:a2e:a202:: with SMTP id h2mr1185600ljm.282.1599841321134;
 Fri, 11 Sep 2020 09:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200910022435.2773735-1-guro@fb.com> <20200910224309.GB1307870@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200910224309.GB1307870@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 11 Sep 2020 09:21:49 -0700
Message-ID: <CALvZod6VZLZ+ABqHK=Vv_S3m=OarSJf0ttGeAOKhw+1zGj65gQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg/slab: fix racy access to page->mem_cgroup in mem_cgroup_from_obj()
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 3:43 PM Roman Gushchin <guro@fb.com> wrote:
>
> Forgot to cc stable@, an updated version is below.
>
> Thanks!
>
> --
>
> From fe61af45ae570b143ca783ba4d013a0a2b923a15 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Wed, 9 Sep 2020 12:19:37 -0700
> Subject: [PATCH] mm: memcg/slab: fix racy access to page->mem_cgroup in
>  mem_cgroup_from_obj()
>
> mem_cgroup_from_obj() checks the lowest bit of the page->mem_cgroup
> pointer to determine if the page has an attached obj_cgroup vector
> instead of a regular memcg pointer. If it's not set, it simple returns
> the page->mem_cgroup value as a struct mem_cgroup pointer.
>
> The commit 10befea91b61 ("mm: memcg/slab: use a single set of
> kmem_caches for all allocations") changed the moment when this bit
> is set: if previously it was set on the allocation of the slab page,
> now it can be set well after, when the first accounted object is
> allocated on this page.
>
> It opened a race: if page->mem_cgroup is set concurrently after the
> first page_has_obj_cgroups(page) check, a pointer to the obj_cgroups
> array can be returned as a memory cgroup pointer.
>
> A simple check for page->mem_cgroup pointer for NULL before the
> page_has_obj_cgroups() check fixes the race. Indeed, if the pointer
> is not NULL, it's either a simple mem_cgroup pointer or a pointer
> to obj_cgroup vector. The pointer can be asynchronously changed
> from NULL to (obj_cgroup_vec | 0x1UL), but can't be changed
> from a valid memcg pointer to objcg vector or back.
>
> If the object passed to mem_cgroup_from_obj() is a slab object
> and page->mem_cgroup is NULL, it means that the object is not
> accounted, so the function must return NULL.
>
> I've discovered the race looking at the code, so far I haven't seen it
> in the wild.
>
> Fixes: 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for all allocations")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: stable@vger.kernel.org
> ---

Is the caller list_lru_from_kmem() the concern or is this more about
making mem_cgroup_from_obj() more future proof?

Also have you taken a look at [1]? I am still trying to figure out how
that is possible.

[1] https://lore.kernel.org/lkml/20200901075321.GL4299@shao2-debian/
