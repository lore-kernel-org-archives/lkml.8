Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8125C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C21082166E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/8U9ZP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbgIAQIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbgIAPjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:39:15 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34409C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:39:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i26so2274664ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 08:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PG5SiNwVZVH2pkgJv+IFK7tt0WCjvP76ZbFGjJc07s=;
        b=i/8U9ZP+xxv0b1D3KLACprbO6f9XSdui6Bpc8qWHCAGjJKdf6SV/BwLJGyCkNI3w8z
         utwAKrw3BY6mIzso/yYfFuWfGTECQ7+S2GJJglSWnuRG1i7Bp7IEakBk2lI8ydIqqedT
         v9oYslNVOGXacY4YbhO1cqsCwlEYrOZUV0biEgmGK1TKRp95SDA12NtKfAwlcUMe93ud
         dHZS9fZM0xCRZnZQ5JOyObYV58dweBq4qelLd7pQ0t8xe9+RE9neWOy4ZWoYf9TCf50V
         L8Wrp+SBtYeR3Pq0uEVbTaRF4pyNXDottPB0Ao1kbMW2rgURZ9yPc+nvFWeuJ8jxGVRD
         S2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PG5SiNwVZVH2pkgJv+IFK7tt0WCjvP76ZbFGjJc07s=;
        b=L3xEM7UVTl3ywXWdfMWQXmZerWoVFfy5pJl25Q7r1lv9Agzoh3GuA/iLeuHZHL0b+p
         Yuk8tnWTEI9TfTd+PWemnU5WYTiqw4ZgP1fmL/1gp1rcGnELIjpBPv7b3c75FQc1sgpq
         mc0dQqO3+q2buCJRQBfnjTpscXdry0Ebb/7fVIB1tYo743hoVZBwZIw/Iqo1eJCrxMPa
         cqVE4YDA15MDZ7hCImE8qFDFOS7J1Zz2fOzZnsKWFqb8W4izB0XwGzuKOZ7MBy2HOZ0h
         ZObKjhYZMig58khOBOXgm4ATiIjCiUpMWUf+x96T6Eqi7JzbyJwJBoJTI6H0fmTucczB
         fKAQ==
X-Gm-Message-State: AOAM532IaKLCVUCE3thEZIxpZJ2o2jIFA5FVNlrfmh04anegjEvw1e18
        TZhm4AT8tqdVCV4hG0np6tarsnaqHyykEDkwq37EzcdG6bs=
X-Google-Smtp-Source: ABdhPJy3CwrJ6zEga+umlT+PQ35ecu20mv5XP4qIonGiniaxceoYl6LbA+wYSR0qjjmWEQ8IBfCfFcdjm5xcXMm/KK8=
X-Received: by 2002:a17:907:2173:: with SMTP id rl19mr1935562ejb.514.1598974752908;
 Tue, 01 Sep 2020 08:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008301401390.5954@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008301401390.5954@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 1 Sep 2020 08:39:00 -0700
Message-ID: <CAHbLzko5xAyzJ7s31B55uXJPXT+2dzun+XcGPJngTwJ6mE=ETg@mail.gmail.com>
Subject: Re: [PATCH 3/5] shmem: shmem_writepage() split unlikely i915 THP
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Kuo-Hsin Yang <vovoy@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 2:04 PM Hugh Dickins <hughd@google.com> wrote:
>
> drivers/gpu/drm/i915/gem/i915_gem_shmem.c contains a shmem_writeback()
> which calls shmem_writepage() from a shrinker: that usually works well
> enough; but if /sys/kernel/mm/transparent_hugepage/shmem_enabled has
> been set to "force" (documented as "Force the huge option on for all -
> very useful for testing"), shmem_writepage() is surprised to be called
> with a huge page, and crashes on the VM_BUG_ON_PAGE(PageCompound) (I
> did not find out where the crash happens when CONFIG_DEBUG_VM is off).
>
> LRU page reclaim always splits the shmem huge page first: I'd prefer not
> to demand that of i915, so check and split compound in shmem_writepage().
>
> Fixes: 2d6692e642e7 ("drm/i915: Start writeback from the shrinker")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org # v5.3+
> ---
> I've marked this for stable just for the info, but the number of users
> affected is very probably 1, so please feel free to delete that marking.
>
>  mm/shmem.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> --- 5.9-rc2/mm/shmem.c  2020-08-16 17:32:50.693507198 -0700
> +++ linux/mm/shmem.c    2020-08-28 17:35:08.326024349 -0700
> @@ -1362,7 +1362,15 @@ static int shmem_writepage(struct page *
>         swp_entry_t swap;
>         pgoff_t index;
>
> -       VM_BUG_ON_PAGE(PageCompound(page), page);
> +       /*
> +        * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "force",
> +        * then drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
> +        * and its shmem_writeback() needs them to be split when swapping.
> +        */
> +       if (PageTransCompound(page))
> +               if (split_huge_page(page) < 0)
> +                       goto redirty;

The change looks good to me. Acked-by: Yang Shi <shy828301@gmail.com>

Just a nit: it may be better to move the spilte after the !PageLocked
assertion? Split needs page locked too.

> +
>         BUG_ON(!PageLocked(page));
>         mapping = page->mapping;
>         index = page->index;
>
