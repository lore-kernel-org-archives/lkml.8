Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A97C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA5F20767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQ8czgD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgFVSDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbgFVSDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:03:37 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB6EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:03:36 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s9so163925ljm.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6uNblF/rXntI2vUFLHgVoQcOmV81G4Sdgcnf6Y/+mg=;
        b=PQ8czgD42vYqwGYRKTO2n84gpWsgACtpIyto/Qj+3uP0Fp23q3YhCvcvrkOVpYPhbB
         7r0U/ZLlxkT9dNsUuP1YLtZxJN1U5xGUd+s9TuNYaH80Uf+SWChxTFREe81qxHferMAu
         nQgbZexkvAOT2kZsBgMA/D8ctQeOicnFcn/oVl7Nz9Xz+YexO2EJ7fJQqP1US/p95hLz
         t2eiLQSnwQXQFdxFFZVFWi+vTYSTFsB/YDMnESWUcLGLzvUSnVKmGxIDEQj9f3tpoXK8
         c++d4d/3UNVEfiSCgIyGN8xZvJxPg+HoNffbgr0qzMr17GhZGxioj6iPK3QVp/nw9M7G
         E1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6uNblF/rXntI2vUFLHgVoQcOmV81G4Sdgcnf6Y/+mg=;
        b=CV/QZFuhBmBuiUHH6kBNO3QoLaYMS7PQYme/d1uPImo3YK/K5L29eKNb//bN/DzyJ9
         wC+PGRcZ9Lgift7cBLrhXyxcANcSBkyPTieZmr4ymcUbQAdD1v8xkjMe7r0z/d82E+AP
         mlJjM0w78wiM9gC38Sf20XETNpy/KzjNCdzgdELx/o/IhwN501vxLPw+pMF6cUAaY3NU
         tM6TpngHHA4oo14JkMsK/+EpN4958MMY7eof09J+w47Zh/JXHrVN9tf09qQgsUBSAylF
         poJFVrnKE99tNL0XcIG0sZZHPDu4ZPjojxUQlj/VyZLj5teWTrd+KlUYcGR9mQXrxdQO
         ttLQ==
X-Gm-Message-State: AOAM531zN3y+fgH2OQNQVOKtJogypynlHrLwGYRZsFe9emqVjycqOhMa
        qkHwSy2MDP6j8fsT3nwYhWDVxzdkf29tDGGru2dMUQ==
X-Google-Smtp-Source: ABdhPJyF/4zJuz+o/BmV2JOrZPUd49gn+SLi7pW8uR5OeFRcTVNp6E0zC1bo8zna5f6JF2YpMqsO3uhFJ+g+efi9uPc=
X-Received: by 2002:a2e:8754:: with SMTP id q20mr9392152ljj.270.1592849015104;
 Mon, 22 Jun 2020 11:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-14-guro@fb.com>
 <CALvZod50rUqhknV50zwvm4sLxdP=OWCLqFRKPPO_8Pff_v4EOg@mail.gmail.com> <20200622174035.GA301338@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200622174035.GA301338@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 11:03:23 -0700
Message-ID: <CALvZod6_ugMf0CrBz9ZSALCQOo6wMc2n0w-7zVG5UyhfFaXh5g@mail.gmail.com>
Subject: Re: [PATCH v6 13/19] mm: memcg/slab: simplify memcg cache creation
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

On Mon, Jun 22, 2020 at 10:40 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Jun 22, 2020 at 10:29:29AM -0700, Shakeel Butt wrote:
> > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > Because the number of non-root kmem_caches doesn't depend on the
> > > number of memory cgroups anymore and is generally not very big,
> > > there is no more need for a dedicated workqueue.
> > >
> > > Also, as there is no more need to pass any arguments to the
> > > memcg_create_kmem_cache() except the root kmem_cache, it's
> > > possible to just embed the work structure into the kmem_cache
> > > and avoid the dynamic allocation of the work structure.
> > >
> > > This will also simplify the synchronization: for each root kmem_cache
> > > there is only one work. So there will be no more concurrent attempts
> > > to create a non-root kmem_cache for a root kmem_cache: the second and
> > > all following attempts to queue the work will fail.
> > >
> > >
> > > On the kmem_cache destruction path there is no more need to call the
> > > expensive flush_workqueue() and wait for all pending works to be
> > > finished. Instead, cancel_work_sync() can be used to cancel/wait for
> > > only one work.
> > >
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >
> > Why not pre-allocate the non-root kmem_cache at the kmem_cache
> > creation time? No need for work_struct, queue_work() or
> > cancel_work_sync() at all.
>
> Simple because some kmem_caches are created very early, so we don't
> even know at that time if we will need memcg slab caches. But this
> code is likely going away if we're going with a single set for all
> allocations.
>

LGTM.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
