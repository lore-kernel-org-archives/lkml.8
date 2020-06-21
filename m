Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E416DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 22:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5126252E9
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 22:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="prj8Qg8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgFUW55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 18:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgFUW54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 18:57:56 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77550C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 15:57:56 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h23so4244308qtr.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CEgiy9I/oiatyHPqWXqkDfINcP6xuTzqyk+YwtuGaZI=;
        b=prj8Qg8Muy8wmAuH0Xmbh65DHPyfwvAv0kyJGMzDLnHn7DcHDz1tgJOSQR+U9feNid
         E+kqDVMhO91r7pi7cwb0kGrzDeglGMdDkmXsP/Pw2mLxp5xQsEmDymoEKljIIIvMKNfk
         ShD4FrSlznZoFsFiQ6q9lFsziqwVCVVi7buL5nmEwTmQ8NR35uA2faqEa1sLEpRg+S3H
         zNCP5TRRvsWwcZn7mKMRw9OIlLWzlclyqZoU/cSZg4oEuqFkYZ6Ti6TO/54vz8gMfC4b
         /Dlq1LqwipzTndi+2SCMF0LRt3VQLnlXc9cVCHet2nDsyVwgc0qbZgvzEB/8uUfoTnqi
         4j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CEgiy9I/oiatyHPqWXqkDfINcP6xuTzqyk+YwtuGaZI=;
        b=D/UxXKjU7MG3DTj4T7vI0V2PRZUBnm3nrr/F8qR63DZeiQ1MzPoPFTYwJd0Hsq6qgH
         6Y/OePIwkFBwJ/hPMiTGg7IUZFe8guJaSCsrY2QveoCVxQoz4QsCLvV/8tkL2ZamhvTT
         TiN7M40ki5aua919PfMi/mfcyXKyf3VzxDADuBWLkSFrh9rsQaoAtN0pnYdF0l8JK/B8
         t8+5OtbQl+efNTH0VKDSFRuEuGX6awOq19NLC4auLi/yqdMfKKb0GjqcX0uHwEcy5n3N
         dL0Buh/lRUERD7sgkB5i3O4CsaFusygJLiIL9eafWZLvMIwR+h0ulS6TtbLUpAkBSCA9
         7r2w==
X-Gm-Message-State: AOAM530vzYreBwgA7+a/5H5sEyBXVCv6VOU4WLZLMinHkzmO+AHLz+R7
        6OqizsFFLttFoPX+vRsMEt/XMg==
X-Google-Smtp-Source: ABdhPJwfdH58KOfttY3/5PM3O+BFsnlpgyU0KOmmJ7i8+w7wjgp6NqDFV/1qPc8PwjzapzO5GTgpwQ==
X-Received: by 2002:ac8:24e8:: with SMTP id t37mr14117316qtt.319.1592780275532;
        Sun, 21 Jun 2020 15:57:55 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m13sm13945581qta.90.2020.06.21.15.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 15:57:54 -0700 (PDT)
Date:   Sun, 21 Jun 2020 18:57:52 -0400
From:   Qian Cai <cai@lca.pw>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200621225752.GB2034@lca.pw>
References: <20200608230654.828134-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608230654.828134-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 04:06:35PM -0700, Roman Gushchin wrote:
> This is v6 of the slab cgroup controller rework.
> 
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

Reverting this series and its dependency [1], i.e.,

git revert --no-edit 05923a2ccacd..07666ee77fb4

on the top of next-20200621 fixed an issue where kmemleak could report
thousands of leaks like this below using this .config (if ever matters),

https://github.com/cailca/linux-mm/blob/master/x86.config

unreferenced object 0xffff888ff2bf6200 (size 512):
  comm "systemd-udevd", pid 794, jiffies 4294940381 (age 602.740s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000e8e9272e>] __kmalloc_node+0x149/0x260
    [<0000000021c1b4a2>] slab_post_alloc_hook+0x172/0x4d0
    [<00000000f38fad30>] kmem_cache_alloc_node+0x110/0x2e0
    [<00000000fdf1d747>] __alloc_skb+0x92/0x520
    [<00000000bda2c48f>] alloc_skb_with_frags+0x72/0x530
    [<0000000023d10084>] sock_alloc_send_pskb+0x5a1/0x720
    [<00000000dd3334cc>] unix_dgram_sendmsg+0x32a/0xe70
    [<000000001ad988ff>] sock_write_iter+0x341/0x420
    [<0000000056d15d07>] new_sync_write+0x4b6/0x610
    [<0000000090b14475>] vfs_write+0x18b/0x4d0
    [<000000009e7ba1b4>] ksys_write+0x180/0x1c0
    [<00000000713e3b98>] do_syscall_64+0x5f/0x310
    [<00000000b1c204e0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
unreferenced object 0xffff8888040fac00 (size 512):
  comm "systemd-udevd", pid 1096, jiffies 4294941658 (age 590.010s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000e8e9272e>] __kmalloc_node+0x149/0x260
    [<0000000021c1b4a2>] slab_post_alloc_hook+0x172/0x4d0
    [<00000000e26f0785>] kmem_cache_alloc+0xe5/0x2a0
    [<00000000ac28147d>] __alloc_file+0x22/0x2a0
    [<0000000031c82651>] alloc_empty_file+0x3e/0x100
    [<000000000e337bda>] path_openat+0x10c/0x1b00
    [<000000008969cf2d>] do_filp_open+0x171/0x240
    [<000000009462ef7b>] do_sys_openat2+0x2db/0x500
    [<0000000007340ff0>] do_sys_open+0x85/0xd0
    [<00000000713e3b98>] do_syscall_64+0x5f/0x310
    [<00000000b1c204e0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
unreferenced object 0xffff8885bf0c8200 (size 512):
  comm "systemd-udevd", pid 1075, jiffies 4294941661 (age 589.980s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000e8e9272e>] __kmalloc_node+0x149/0x260
    [<0000000021c1b4a2>] slab_post_alloc_hook+0x172/0x4d0
    [<00000000e26f0785>] kmem_cache_alloc+0xe5/0x2a0
    [<00000000ac28147d>] __alloc_file+0x22/0x2a0
    [<0000000031c82651>] alloc_empty_file+0x3e/0x100
    [<000000000e337bda>] path_openat+0x10c/0x1b00
    [<000000008969cf2d>] do_filp_open+0x171/0x240
    [<000000009462ef7b>] do_sys_openat2+0x2db/0x500
    [<0000000007340ff0>] do_sys_open+0x85/0xd0
    [<00000000713e3b98>] do_syscall_64+0x5f/0x310
    [<00000000b1c204e0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
unreferenced object 0xffff88903ce24a00 (size 512):
  comm "systemd-udevd", pid 1078, jiffies 4294941806 (age 588.540s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000e8e9272e>] __kmalloc_node+0x149/0x260
    [<0000000021c1b4a2>] slab_post_alloc_hook+0x172/0x4d0
    [<00000000e26f0785>] kmem_cache_alloc+0xe5/0x2a0
    [<0000000002285574>] vm_area_dup+0x71/0x2a0
    [<000000006c732816>] dup_mm+0x548/0xfc0
    [<000000001cf5c685>] copy_process+0x2a33/0x62c0
    [<000000006e2a8069>] _do_fork+0xf8/0xce0
    [<00000000e7ba268e>] __do_sys_clone+0xda/0x120
    [<00000000713e3b98>] do_syscall_64+0x5f/0x310
    [<00000000b1c204e0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

[1] https://lore.kernel.org/linux-mm/20200608230819.832349-1-guro@fb.com/
Also, confirmed that only reverting the "mm: memcg accounting of percpu
memory" series alone did not help.

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
> 
