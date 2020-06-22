Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71046C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9CD2076E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYzEciFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgFVTVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgFVTVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:21:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:21:41 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i27so20620631ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJuqB/6CoFx9yCUp+dgzl1DNhtbZVVAluC5mMbz4xzg=;
        b=iYzEciFzvjRk2HslD5ugE8E5HVAbMuSpO+MOQIHtaFUenzUTRD9pQVMXQer8QnKy3A
         1zUfoVzNXce+Y6DrSRiASI7Z34to2vGhxIK9QuutHKFyKiZP4KK0YpaZXDUx/iFs6tSR
         A1qWGKDHdqanisXN/Sq8YzRgRThUZcJCJ0avgPhUZDb0dpkUMCrDAOHKWCXsruX2aOcR
         ugXN+N5o6fykRlrq0OEd6rVORUPKLzhXmjx/hB0TVpANXEdy/lDc40pluB7/vqdGtvtp
         KJcH8WqugC18CmwxxeXiDYoq7E8Y2WnQ8W2YAU5524hWJUiOWBBVo5WiNjC2PO1j3GX5
         96zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJuqB/6CoFx9yCUp+dgzl1DNhtbZVVAluC5mMbz4xzg=;
        b=lR0CeAz0Do31GSK41ox2wx04+4vn8puriwNLKmLcfM6G+1K2b4agAsbSPaCeOccIfV
         ZwZvG69MeKRPQFL95XQiS2iMIY/JKT9v1vk/wiqDzoOMeGdJOWB7I6fTeaCo23yp5e3M
         SxBXBMb04BhqIAmoT4OwRN9gkUxpv6wQwPJ/fQhXRm8vzPk/TkGoSEwXNKWhmuWwNsuU
         F6IW/4J6Gyapq2ZZtCuzcX9KhAMEye1ilfpB6yNo+J2oI9RipDUIGlqNJ36LjEUZ/TmN
         gPp/VLfRdCjFqbRBdP5nCh0iIZkkRqbsXQ6xJNSfAwa7pZ73EWrrB8uDBsruefKOSj7v
         fZgA==
X-Gm-Message-State: AOAM533ZE6zLREQzPZSGE6An10p8moKoY4uCfa2vttUJsgEA8LX74unp
        alRKphMI1yF3JNkNu/RCjgQqu3XBKFFaH26QE0CQkQ==
X-Google-Smtp-Source: ABdhPJzbXooN9tV7nx64M1tm58nEmrZNTHiGIXMxG9V/EscIZfaCPDtF/clo/Hnf9iFaAdDThpE3Os5VXV2a+3UKP4w=
X-Received: by 2002:a2e:910c:: with SMTP id m12mr9770386ljg.332.1592853699940;
 Mon, 22 Jun 2020 12:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-18-guro@fb.com>
In-Reply-To: <20200608230654.828134-18-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 12:21:28 -0700
Message-ID: <CALvZod5NCCpt2rkyXXr69OnVXb9ew7875vAV=iWZdqJhXcKEWQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/19] mm: memcg/slab: use a single set of kmem_caches
 for all allocations
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> Instead of having two sets of kmem_caches: one for system-wide and
> non-accounted allocations and the second one shared by all accounted
> allocations, we can use just one.
>
> The idea is simple: space for obj_cgroup metadata can be allocated
> on demand and filled only for accounted allocations.
>
> It allows to remove a bunch of code which is required to handle
> kmem_cache clones for accounted allocations. There is no more need
> to create them, accumulate statistics, propagate attributes, etc.
> It's a quite significant simplification.
>
> Also, because the total number of slab_caches is reduced almost twice
> (not all kmem_caches have a memcg clone), some additional memory
> savings are expected. On my devvm it additionally saves about 3.5%
> of slab memory.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
[snip]
>  static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>                                               struct obj_cgroup *objcg,
> -                                             size_t size, void **p)
> +                                             gfp_t flags, size_t size,
> +                                             void **p)
>  {
>         struct page *page;
>         unsigned long off;
>         size_t i;
>
> +       if (!objcg)
> +               return;
> +
> +       flags &= ~__GFP_ACCOUNT;
>         for (i = 0; i < size; i++) {
>                 if (likely(p[i])) {
>                         page = virt_to_head_page(p[i]);
> +
> +                       if (!page_has_obj_cgroups(page) &&

The page is already linked into the kmem_cache, don't you need
synchronization for memcg_alloc_page_obj_cgroups(). What's the reason
to remove this from charge_slab_page()?

> +                           memcg_alloc_page_obj_cgroups(page, s, flags)) {
> +                               obj_cgroup_uncharge(objcg, obj_full_size(s));
> +                               continue;
> +                       }
> +
>                         off = obj_to_index(s, page, p[i]);
>                         obj_cgroup_get(objcg);
>                         page_obj_cgroups(page)[off] = objcg;
