Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A938C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99CE2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2hPmbBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgFQBrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 21:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgFQBrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 21:47:11 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2D5C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:47:10 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y11so842624ljm.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKJmGYErZ9H0ka158EMoPYekKFURMtA3vN2REMqWfV0=;
        b=V2hPmbBtrX5NR4ylwcX16+HLpgroG9ByjyyN0A4ZGDfICDSqynbEVxpa3uAwA2fTmS
         iVAscO+KX4/4/G5376kAhvNHV8aEeq7EqOIcFS+be1QexX35ighWK/Y5FHsbXZrYkkP6
         5O2z2Yv72gSZbXjNPZqdqQKVDuQ1Oe/J3SvaaxaEwO+pdC4BMb+5nP4b7Gbb7EpJNYUH
         XOIdgdiUqUR1Kz0IBT4gZcr0dTU3ExISwawYggM63BGNniLOOZhLeEAjNlY4mDbTBGkr
         DLse923+PPANQ+IpWkfIs9X+F0VVsKc7m6x0YBvncIVqFLjkgL0xUf5aR0CzqetHnoN9
         09hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKJmGYErZ9H0ka158EMoPYekKFURMtA3vN2REMqWfV0=;
        b=Dg9sCsVgwNp0QYYf/uTGKOsbd0cyrv04RN9Wa9ECQR/xiLZiW7Y2YbB8s0a+4+SXjD
         NQCSRLBW0bTt40G3TFK+BnElW2ChbSWfafl9fYNVs9vensjmoMU878IRIWVT9KI3PYL7
         eJimYyF9WauorZbqSW4g/St6YvxWBbQSqMzR5pS0DN2guzs3TxdPPhBq814jOuPYC8W7
         C+ofavP/KpzDF0VCToEVGzErSuUoaPfLGG8/qjVAMzDAtjosw+Mz05W/8r4XSaTiB0rb
         WrREilndOXbnZi5zTYATBVw0eb2WlTtFC/hjmS4Lh/VkeMDLknu9vfPm0yvEETHDkMQt
         lIkw==
X-Gm-Message-State: AOAM531JDa/WEXPpcW0Tqw+buMRlx5cl8eHl5MUeLOln5cfrY03DGvxe
        sq2prGOFE0d6VaimjyYtcWbK8orRJXnz//jy6Nqbj7Sg
X-Google-Smtp-Source: ABdhPJzfkOR0hqd4KmM3mVTahJf98MdbU/Q0ZuWYHAIiaj1EHeIpXX+s6iIqWx+BFnWQYcufptXU0WK3wXnBNucO5W0=
X-Received: by 2002:a2e:8754:: with SMTP id q20mr2839836ljj.270.1592358428184;
 Tue, 16 Jun 2020 18:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com>
In-Reply-To: <20200608230654.828134-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Jun 2020 18:46:56 -0700
Message-ID: <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
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
> This is v6 of the slab cgroup controller rework.
>
> The patchset moves the accounting from the page level to the object
> level. It allows to share slab pages between memory cgroups.
> This leads to a significant win in the slab utilization (up to 45%)
> and the corresponding drop in the total kernel memory footprint.

Is this based on just SLUB or does this have a similar impact on SLAB as well?

> The reduced number of unmovable slab pages should also have a positive
> effect on the memory fragmentation.

That would be awesome. We have seen fragmentation getting very bad on
system (or node) level memory pressure. Is that the same for you?

>
> The patchset makes the slab accounting code simpler: there is no more
> need in the complicated dynamic creation and destruction of per-cgroup
> slab caches, all memory cgroups use a global set of shared slab caches.
> The lifetime of slab caches is not more connected to the lifetime
> of memory cgroups.
>
> The more precise accounting does require more CPU, however in practice
> the difference seems to be negligible. We've been using the new slab
> controller in Facebook production for several months with different
> workloads and haven't seen any noticeable regressions. What we've seen
> were memory savings in order of 1 GB per host (it varied heavily depending
> on the actual workload, size of RAM, number of CPUs, memory pressure, etc).
>
> The third version of the patchset added yet another step towards
> the simplification of the code: sharing of slab caches between
> accounted and non-accounted allocations. It comes with significant
> upsides (most noticeable, a complete elimination of dynamic slab caches
> creation) but not without some regression risks, so this change sits
> on top of the patchset and is not completely merged in. So in the unlikely
> event of a noticeable performance regression it can be reverted separately.
>

Have you performed any [perf] testing on SLAB with this patchset?

> v6:
>   1) rebased on top of the mm tree
>   2) removed a redundant check from cache_from_obj(), suggested by Vlastimil
>
> v5:
>   1) fixed a build error, spotted by Vlastimil
>   2) added a comment about memcg->nr_charged_bytes, asked by Johannes
>   3) added missed acks and reviews
>
> v4:
>   1) rebased on top of the mm tree, some fixes here and there
>   2) merged obj_to_index() with slab_index(), suggested by Vlastimil
>   3) changed objects_per_slab() to a better objects_per_slab_page(),
>      suggested by Vlastimil
>   4) other minor fixes and changes
>
> v3:
>   1) added a patch that switches to a global single set of kmem_caches
>   2) kmem API clean up dropped, because if has been already merged
>   3) byte-sized slab vmstat API over page-sized global counters and
>      bytes-sized memcg/lruvec counters
>   3) obj_cgroup refcounting simplifications and other minor fixes
>   4) other minor changes
>
> v2:
>   1) implemented re-layering and renaming suggested by Johannes,
>      added his patch to the set. Thanks!
>   2) fixed the issue discovered by Bharata B Rao. Thanks!
>   3) added kmem API clean up part
>   4) added slab/memcg follow-up clean up part
>   5) fixed a couple of issues discovered by internal testing on FB fleet.
>   6) added kselftests
>   7) included metadata into the charge calculation
>   8) refreshed commit logs, regrouped patches, rebased onto mm tree, etc
>
> v1:
>   1) fixed a bug in zoneinfo_show_print()
>   2) added some comments to the subpage charging API, a minor fix
>   3) separated memory.kmem.slabinfo deprecation into a separate patch,
>      provided a drgn-based replacement
>   4) rebased on top of the current mm tree
>
> RFC:
>   https://lwn.net/Articles/798605/
>
>
> Johannes Weiner (1):
>   mm: memcontrol: decouple reference counting from page accounting
>
> Roman Gushchin (18):
>   mm: memcg: factor out memcg- and lruvec-level changes out of
>     __mod_lruvec_state()
>   mm: memcg: prepare for byte-sized vmstat items
>   mm: memcg: convert vmstat slab counters to bytes
>   mm: slub: implement SLUB version of obj_to_index()
>   mm: memcg/slab: obj_cgroup API
>   mm: memcg/slab: allocate obj_cgroups for non-root slab pages
>   mm: memcg/slab: save obj_cgroup for non-root slab objects
>   mm: memcg/slab: charge individual slab objects instead of pages
>   mm: memcg/slab: deprecate memory.kmem.slabinfo
>   mm: memcg/slab: move memcg_kmem_bypass() to memcontrol.h
>   mm: memcg/slab: use a single set of kmem_caches for all accounted
>     allocations
>   mm: memcg/slab: simplify memcg cache creation
>   mm: memcg/slab: remove memcg_kmem_get_cache()
>   mm: memcg/slab: deprecate slab_root_caches
>   mm: memcg/slab: remove redundant check in memcg_accumulate_slabinfo()
>   mm: memcg/slab: use a single set of kmem_caches for all allocations
>   kselftests: cgroup: add kernel memory accounting tests
>   tools/cgroup: add memcg_slabinfo.py tool
>
>  drivers/base/node.c                        |   6 +-
>  fs/proc/meminfo.c                          |   4 +-
>  include/linux/memcontrol.h                 |  85 ++-
>  include/linux/mm_types.h                   |   5 +-
>  include/linux/mmzone.h                     |  24 +-
>  include/linux/slab.h                       |   5 -
>  include/linux/slab_def.h                   |   9 +-
>  include/linux/slub_def.h                   |  31 +-
>  include/linux/vmstat.h                     |  14 +-
>  kernel/power/snapshot.c                    |   2 +-
>  mm/memcontrol.c                            | 608 +++++++++++--------
>  mm/oom_kill.c                              |   2 +-
>  mm/page_alloc.c                            |   8 +-
>  mm/slab.c                                  |  70 +--
>  mm/slab.h                                  | 372 +++++-------
>  mm/slab_common.c                           | 643 +--------------------
>  mm/slob.c                                  |  12 +-
>  mm/slub.c                                  | 229 +-------
>  mm/vmscan.c                                |   3 +-
>  mm/vmstat.c                                |  30 +-
>  mm/workingset.c                            |   6 +-
>  tools/cgroup/memcg_slabinfo.py             | 226 ++++++++
>  tools/testing/selftests/cgroup/.gitignore  |   1 +
>  tools/testing/selftests/cgroup/Makefile    |   2 +
>  tools/testing/selftests/cgroup/test_kmem.c | 382 ++++++++++++
>  25 files changed, 1374 insertions(+), 1405 deletions(-)
>  create mode 100755 tools/cgroup/memcg_slabinfo.py
>  create mode 100644 tools/testing/selftests/cgroup/test_kmem.c
>
> --
> 2.25.4
>
