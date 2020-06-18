Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C18AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31DF521D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592472439;
	bh=8wECwgc5hKi39iBo9jVMj/pKo0+wvQgO5b7cj4ZGlq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oQ14ofARPCk38vH/8XaD+Z7cdONQtEra1ZzTOWE1riJAJnKRBeQJ7K2vunCIZXreD
	 WjRkLYkvBQdai2iYVUZkJby8UDi99cqHm7PTLFvonBDXkjsclfo0rfEQ0/daCITpZ1
	 9XuSMi2AWo8aazctbDsHL/rPJ3/jFUE5Nux0z1a8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgFRJ1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728819AbgFRJ1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:27:17 -0400
Received: from kernel.org (unknown [87.70.103.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5494B21974;
        Thu, 18 Jun 2020 09:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592472436;
        bh=8wECwgc5hKi39iBo9jVMj/pKo0+wvQgO5b7cj4ZGlq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZF9LDAlrxNjvLaoplstboKqdflKlv544Zsgup8H0jSsLT4Txi6nziwslGP1y1oa2
         A5wHPHyX7BbcqDSbXlUNK0X/CxuxRo9ou2qYYYjPPMI4gRKQM0jmtWH8UhFMgPi498
         g/twwc7fqhO41hqmQ+LH+6e3m64Dv0S8WbruOCZI=
Date:   Thu, 18 Jun 2020 12:27:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200618092707.GD6571@kernel.org>
References: <20200608230654.828134-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608230654.828134-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Mon, Jun 08, 2020 at 04:06:35PM -0700, Roman Gushchin wrote:
> This is v6 of the slab cgroup controller rework.
> 
> The patchset moves the accounting from the page level to the object
> level. It allows to share slab pages between memory cgroups.
> This leads to a significant win in the slab utilization (up to 45%)
> and the corresponding drop in the total kernel memory footprint.
> The reduced number of unmovable slab pages should also have a positive
> effect on the memory fragmentation.
 
... 
 
> Johannes Weiner (1):
>   mm: memcontrol: decouple reference counting from page accounting
> 
> Roman Gushchin (18):
>   mm: memcg: factor out memcg- and lruvec-level changes out of __mod_lruvec_state()
>   mm: memcg: prepare for byte-sized vmstat items
>   mm: memcg: convert vmstat slab counters to bytes
>   mm: slub: implement SLUB version of obj_to_index()
>   mm: memcg/slab: obj_cgroup API
>   mm: memcg/slab: allocate obj_cgroups for non-root slab pages
>   mm: memcg/slab: save obj_cgroup for non-root slab objects
>   mm: memcg/slab: charge individual slab objects instead of pages
>   mm: memcg/slab: deprecate memory.kmem.slabinfo
>   mm: memcg/slab: move memcg_kmem_bypass() to memcontrol.h
>   mm: memcg/slab: use a single set of kmem_caches for all accounted allocations
>   mm: memcg/slab: simplify memcg cache creation
>   mm: memcg/slab: remove memcg_kmem_get_cache()
>   mm: memcg/slab: deprecate slab_root_caches
>   mm: memcg/slab: remove redundant check in memcg_accumulate_slabinfo()
>   mm: memcg/slab: use a single set of kmem_caches for all allocations
>   kselftests: cgroup: add kernel memory accounting tests
>   tools/cgroup: add memcg_slabinfo.py tool
 
Sorry for jumping late, but I'm really missing 

   Documentation/vm/cgroup-slab.rst	      | < lots of + >

in this series ;-)

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

-- 
Sincerely yours,
Mike.
