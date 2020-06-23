Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547C8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B1120720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbgFWNxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:53:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:39176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732633AbgFWNxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:53:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03814AD4A;
        Tue, 23 Jun 2020 13:53:06 +0000 (UTC)
Subject: Re: [PATCH v7 00/19] The new cgroup slab memory controller
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <20200623015846.1141975-1-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <cd62f7ee-0851-69cd-14e1-e926ecdfd490@suse.cz>
Date:   Tue, 23 Jun 2020 15:53:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623015846.1141975-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/20 3:58 AM, Roman Gushchin wrote:
> This is v7 of the slab cgroup controller rework.

Hi,

As you and Jesper did those measurements on v6, and are sending v7, it would be
great to put some summary in the cover letter?

Thanks,
Vlastimil

> The patchset moves the accounting from the page level to the object
> level. It allows to share slab pages between memory cgroups.
> This leads to a significant win in the slab utilization (up to 45%)
> and the corresponding drop in the total kernel memory footprint.
> The reduced number of unmovable slab pages should also have a positive
> effect on the memory fragmentation.
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
> The slab memory accounting works in exactly the same way for SLAB and SLUB.
> With both allocators the new controller shows significant memory savings,
> with SLUB the difference is bigger. On my 16-core desktop machine running
> Fedora 32 the size of the slab memory measured after the start of the system
> was lower by 58% and 38% with SLUB and SLAB correspondingly.
> 
> v7:
>   1) rebased on top of Vlastimil's slub improvements, by Andrew
>   2) page->obj_cgroups is allocated from the same node, by Shakeel
>   3) perf optimization in get_obj_cgroup_from_current(), by Shakeel
>   4) added synchronization around allocation of page->obj_cgroups,
>      by Shakeel
>   5) fixed kmemleak false positives, by Qian Cai
>   6) fixed a compiler warning on clang, by Nathan
>   7) other minor fixes
> 
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
>  mm/memcontrol.c                            | 610 +++++++++++--------
>  mm/oom_kill.c                              |   2 +-
>  mm/page_alloc.c                            |   8 +-
>  mm/slab.c                                  |  70 +--
>  mm/slab.h                                  | 370 +++++-------
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
>  25 files changed, 1380 insertions(+), 1399 deletions(-)
>  create mode 100644 tools/cgroup/memcg_slabinfo.py
>  create mode 100644 tools/testing/selftests/cgroup/test_kmem.c
> 

