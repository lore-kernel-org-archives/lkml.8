Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63163C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E8A2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tkFfa4iF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgAQUy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:54:56 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37097 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQUyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 15:54:55 -0500
Received: by mail-oi1-f196.google.com with SMTP id z64so23440217oia.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 12:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpP4mR6++ym0+clDqbbYwXk+no5QrN1xJrvrHjjjmE0=;
        b=tkFfa4iFAd+jroP8t34rOqeszZpg427nMtkcpusKGMgHGjCefWrryEVOMtujEljy5/
         8qBfL2I8nyxfFuvhe/AtgEqDVAn0fOBwJzcjvISKvZpsWdqQOMYAy4KFak70JS1HnX0k
         elDvn2zKcpoEAm/I3kWJUSLN2S9YnOUpZQzhBdlIP5T1rJ8K6heSdC74uqdp4dLrYHh/
         E+GO6qgTMLJmm4mkIcxWxuGKdiD6gBbOfb/+2Eo2iBSTeGy1m/7p986Xh/aVF3TEfiyy
         Sr9KhWjSN6L+WeraAo09KnX44N7Jyvu7HM4PrYeh5dpGq3AvahTuDNE49oZkOyTC4C/w
         06aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpP4mR6++ym0+clDqbbYwXk+no5QrN1xJrvrHjjjmE0=;
        b=r/Wm8YTHtkGg3mAf+6L0g/sfa00RgMucrq2At70LWZQkGGhhVlxVHNlANK1ZnqXFfh
         ORJryvofMzz/4dLUSWRNCoLvTmzkfWK0EHzZzKPV+JH/1W0x72abho9VFqug9cApj1OX
         Sj0uxoYSF+0wo6JGY0xcXdpSnAoAmcmlZeW7T+x1THWMf7F1GPb5zftrVcBO1Fm7mNAz
         K4RuVNR7mdOBrG5gAgKKBfmlHmZwmFa0zp4hnq3zimzzqz7BMizIUd6H4Xd2/rx2T4qe
         j7u+z2CRqbXLRv5R7yQrIwXSogD8yvG6rePSCfNQUZ3aPJjifjy56qVdRJRztrxaaHPc
         RgGQ==
X-Gm-Message-State: APjAAAXuEaGmQC8A/Ucypn/AJZjwVNJIG7jEr5KPnbeLmFY4oTK5mgZ0
        2+sfFfy//1K9iak1AMTy6/t/aJ5nifHkHGJb7wClOw==
X-Google-Smtp-Source: APXvYqyzdxUUBvm+6osC1RRrqdzxgenbyaoz4CMFFZqjH6owgPtbnJZKARkwMewNMJ70ydOGsHL3POvx59nMEwed01M=
X-Received: by 2002:aca:3cd7:: with SMTP id j206mr4978548oia.142.1579294494766;
 Fri, 17 Jan 2020 12:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20200117203609.3146239-1-guro@fb.com>
In-Reply-To: <20200117203609.3146239-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 Jan 2020 12:54:43 -0800
Message-ID: <CALvZod4opj-eMYmeK0KaOmFvbQV75ZgP=vAEu_x5MFdswDwSBA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg/slab: introduce mem_cgroup_from_obj()
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 12:36 PM Roman Gushchin <guro@fb.com> wrote:
>
> Sometimes we need to get a memcg pointer from a charged kernel object.
> The right way to get it depends on whether it's a proper slab object
> or it's backed by raw pages (e.g. it's a vmalloc alloction). In the
> first case the kmem_cache->memcg_params.memcg indirection should be
> used; in other cases it's just page->mem_cgroup.
>
> To simplify this task and hide the implementation details let's
> introduce a mem_cgroup_from_obj() helper, which takes a pointer
> to any kernel object and returns a valid memcg pointer or NULL.
>
> Passing a kernel address rather than a pointer to a page will allow
> to use this helper for per-object (rather than per-page) tracked
> objects in the future.
>
> The caller is still responsible to ensure that the returned memcg
> isn't going away underneath: take the rcu read lock, cgroup mutex etc;
> depending on the context.
>
> mem_cgroup_from_kmem() defined in mm/list_lru.c is now obsolete
> and can be removed.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
