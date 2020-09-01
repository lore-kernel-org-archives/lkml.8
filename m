Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E08C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558932078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKOVQTut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgIASuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 14:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIASuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 14:50:21 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32577C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 11:50:21 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n13so2460491edo.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nz5CAELUBJduEX0zdbamYoeJmzl2NIbIAQHq+WzwOh0=;
        b=rKOVQTutXkylaslkF5EDj29k89NmOAbhs93DZDL6uM787tawoR9KRjvoY1P1phgl47
         /iXaVl/WWAtZEnga5dVEl3qYsnN4HKQByetHkE2hq+vkGCEhKz0bgYSyLxe96N+bmOG5
         +qKCPh3eXILlp6hukLZjvOjC0JXDx5qhSNdq+vkjAZSMuDxNDcu1P8sFzGJ50udgvJTc
         3lXXoVf6YzyD4Aa34GRVbzXNzQUeJoB7SnhYrtQ9G4fp7e+bp/O41YeOe6JztGugJp5O
         1d7ilF6gLoYfQzyRA/Qr98vhKk466paXJJPK/CGM2xqJtcy/KRJ6QcLThPAII0aPg1Lm
         Dv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nz5CAELUBJduEX0zdbamYoeJmzl2NIbIAQHq+WzwOh0=;
        b=rpLQBrWiO6KyCdzspscIh2jc1gOLIY70PRVUKy66U+mHpLFvOL/17mkKMrCN7yDdJH
         5Hd/D6jTU9K0+dk/+GbSeZ4nG36EWX7GZyWgeUP4rTByH3AXW22/B1zTD0h58pp4lu/F
         Mu5mdBrlcpYgF4aKhDWhaFp0hg3wo8+a2E1sk9BJdwRhTw6pakvTKgK8cUxX0nnSflHR
         4sk1xant065DYMf+QYH5bHZCMhIliJwgjZmoR06wAfDjwPfvwHCKqxRi4f+hxUIW0+Fl
         cx+g4j6mtLjg6drJvTFl919LmTLqdiGC2CdTmkfulw7LF4X59EX46yWg3yv2rgraJry/
         JTSQ==
X-Gm-Message-State: AOAM53285vEbaPC770un2Gs13fROkgUwty3Wbzzu2RolGPiQaKr6sSbb
        RcmD6bWKmoH1TNJ62S+6agLBtDvWRXgy2OLMsZI=
X-Google-Smtp-Source: ABdhPJzKB2AJV1YlTZ9j7FbpsWqZoNwEZezU1pGjMvLS0fs16gttFi4NcRRnfyxvnn8Pu/t45tEpbFmoqcUcY8uxKjQ=
X-Received: by 2002:aa7:dc05:: with SMTP id b5mr3178718edu.137.1598986218310;
 Tue, 01 Sep 2020 11:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008301401390.5954@eggly.anvils>
 <CAHbLzko5xAyzJ7s31B55uXJPXT+2dzun+XcGPJngTwJ6mE=ETg@mail.gmail.com> <alpine.LSU.2.11.2009011033080.2984@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2009011033080.2984@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 1 Sep 2020 11:50:06 -0700
Message-ID: <CAHbLzkpFX=+M_XDPzSya_M3AsvQXDLi=prpH-MiZP5Cscv4s2g@mail.gmail.com>
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

On Tue, Sep 1, 2020 at 10:39 AM Hugh Dickins <hughd@google.com> wrote:
>
> On Tue, 1 Sep 2020, Yang Shi wrote:
> > On Sun, Aug 30, 2020 at 2:04 PM Hugh Dickins <hughd@google.com> wrote:
> > >
> > > drivers/gpu/drm/i915/gem/i915_gem_shmem.c contains a shmem_writeback()
> > > which calls shmem_writepage() from a shrinker: that usually works well
> > > enough; but if /sys/kernel/mm/transparent_hugepage/shmem_enabled has
> > > been set to "force" (documented as "Force the huge option on for all -
> > > very useful for testing"), shmem_writepage() is surprised to be called
> > > with a huge page, and crashes on the VM_BUG_ON_PAGE(PageCompound) (I
> > > did not find out where the crash happens when CONFIG_DEBUG_VM is off).
> > >
> > > LRU page reclaim always splits the shmem huge page first: I'd prefer not
> > > to demand that of i915, so check and split compound in shmem_writepage().
> > >
> > > Fixes: 2d6692e642e7 ("drm/i915: Start writeback from the shrinker")
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > Cc: stable@vger.kernel.org # v5.3+
> > > ---
> > > I've marked this for stable just for the info, but the number of users
> > > affected is very probably 1, so please feel free to delete that marking.
> > >
> > >  mm/shmem.c |    9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > --- 5.9-rc2/mm/shmem.c  2020-08-16 17:32:50.693507198 -0700
> > > +++ linux/mm/shmem.c    2020-08-28 17:35:08.326024349 -0700
> > > @@ -1362,7 +1362,15 @@ static int shmem_writepage(struct page *
> > >         swp_entry_t swap;
> > >         pgoff_t index;
> > >
> > > -       VM_BUG_ON_PAGE(PageCompound(page), page);
> > > +       /*
> > > +        * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "force",
> > > +        * then drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
> > > +        * and its shmem_writeback() needs them to be split when swapping.
> > > +        */
> > > +       if (PageTransCompound(page))
> > > +               if (split_huge_page(page) < 0)
> > > +                       goto redirty;
> >
> > The change looks good to me. Acked-by: Yang Shi <shy828301@gmail.com>
>
> Thanks.
>
> >
> > Just a nit: it may be better to move the spilte after the !PageLocked
> > assertion? Split needs page locked too.
>
> I hadn't considered that, but I think it's best left as is:
> split_huge_page_to_list() has its own
>         VM_BUG_ON_PAGE(!PageLocked(head), head);
> to enforce its needs: think of the old BUG_ON(!PageLocked(page))
> below as enforcing shmem's needs, checking that split_huge_page()
> did not unlock it :)

Yes, it is definitely fine to keep it as is. I just thought we could
bailout earlier if the page is not locked.

>
> >
> > > +
> > >         BUG_ON(!PageLocked(page));
> > >         mapping = page->mapping;
> > >         index = page->index;
> > >
