Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B00C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A27120809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSIea/1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgFSBSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgFSBSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:18:21 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614E8C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:18:20 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y11so9560959ljm.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLLyH9dUIWHAb6HECqRyGiz/qdtoWlUwUhUvfx0j4VY=;
        b=RSIea/1fdmF4k1iLDAOOOIup5bIB1WMgBwaOjffgT+EnYQTIY6WAecka/Iq8w+UPuX
         PgwZ3L5dy5wL4e2SJQz6sXW4Nzm4+XFmKJJvoBHxWiy8T/LTqQGCkYkSWWUbcORzszsF
         baVosUxCrtHwdSgunPpl+7PINlpTqhC2ptUevd/9jyDgNwYXGjWj4m/yH+1+so7tyCzL
         vb4qQMNsS/nLeiwOWrf4SMxr6O5F0Vt0Bymk5MNL0gxY2umcBv+rmm9oIi8iWnnBXMuu
         C4inADk+PyFgNddKbSuqR4HJpbH+4iD273kjz4Kam6ngL6LPEdJPa+77XTt1Do/ysEck
         1wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLLyH9dUIWHAb6HECqRyGiz/qdtoWlUwUhUvfx0j4VY=;
        b=YhvJgqJGHOjDL+2nkROHt+8CZ5Rbt7BTHyWgbTQVgqfqVcTS3kY7szJi0b9cHDH8Ya
         dbUhEofEFF884YB39+VicrNR2QXUpP2ZxlJtkLyonWA7HDiyzzsKzwOwQw2TUGv5tMM0
         CO6Imni5rKmCNanrHeZeULLw65OwPxpBJ63Q88phzCxCQnDuxODuEzg8eC3fAnmbOW4+
         UD8Su+25AwEgarQ3gdl7Yrr7zBcFKiuS2w39U0dLnBE3ug5I/hDIXloM/JJOAZSHEK1v
         h+vV6+tYRz/1tIWK4GW4I43K1FTovzsDE2ppAkzKncvMh4SNXjV9n5Ad1mJKZ/z5COAd
         KAfw==
X-Gm-Message-State: AOAM5305RC3hKj6dnb6HA/lP3tbCZzB+e/mArzeJbXdHGoToEz930jFc
        BGHknHxC7yMtmQy+N/VMaR0Vf7sPCcjQdUB99AJgvg==
X-Google-Smtp-Source: ABdhPJwXOVhEtzyb/wAwVA7Vh71GAsBs+1etttuuqscKFC88HjZG9+loY3v81M+/SLK7r9MdPIqAGdCZqqJWoWbeaqk=
X-Received: by 2002:a2e:968a:: with SMTP id q10mr516738lji.192.1592529498411;
 Thu, 18 Jun 2020 18:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-6-guro@fb.com>
 <CALvZod4Jur7EFPPWzoBvQgF0m3hXyohBrBirEySWoPTV23rvUg@mail.gmail.com> <20200619010837.GB135965@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200619010837.GB135965@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 18 Jun 2020 18:18:07 -0700
Message-ID: <CALvZod4UuGizMkt2Ww55PDbtdr1DxfJ6mbDUa5BA221u8ddUsA@mail.gmail.com>
Subject: Re: [PATCH v6 05/19] mm: memcontrol: decouple reference counting from
 page accounting
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

On Thu, Jun 18, 2020 at 6:08 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Jun 18, 2020 at 07:55:35AM -0700, Shakeel Butt wrote:
> > Not sure if my email went through, so, re-sending.
> >
> > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > From: Johannes Weiner <hannes@cmpxchg.org>
> > >
> > [...]
> > > @@ -3003,13 +3004,16 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
> > >   */
> > >  void mem_cgroup_split_huge_fixup(struct page *head)
> > >  {
> > > +       struct mem_cgroup *memcg = head->mem_cgroup;
> > >         int i;
> > >
> > >         if (mem_cgroup_disabled())
> > >                 return;
> > >
> >
> > A memcg NULL check is needed here.
>
> Hm, it seems like the only way how it can be NULL is if mem_cgroup_disabled() is true:
>
> int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
> {
>         unsigned int nr_pages = hpage_nr_pages(page);
>         struct mem_cgroup *memcg = NULL;
>         int ret = 0;
>
>         if (mem_cgroup_disabled())
>                 goto out;
>
>         <...>
>
>         if (!memcg)
>                 memcg = get_mem_cgroup_from_mm(mm);
>
>         ret = try_charge(memcg, gfp_mask, nr_pages);
>         if (ret)
>                 goto out_put;
>
>         css_get(&memcg->css);
>         commit_charge(page, memcg);
>
>
> Did you hit this issue in reality? The only possible scenario I can imagine
> is if the page was allocated before enabling memory cgroups.
>
> Are you about this case?
>
> Otherwise we put root_mem_cgroup there.
>

Oh yes, you are right. I am confusing this with kmem pages for root
memcg where we don't set the page->mem_cgroup and this patch series
should be changing that.

Shakeel
