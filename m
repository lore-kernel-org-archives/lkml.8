Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8335FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5772F20774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gIjqdNal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387933AbgFWRlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:41:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64808 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387824AbgFWRkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:40:55 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NHegRA020532
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:40:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=l2Atjg2cZ92VrXw/Le4Dc9vCYDmS8qVqKkU4wSnDZdk=;
 b=gIjqdNalg94z8SspWRmJlY8S3RiEvJXP78i9kW1hiMOsUJtArEghSk1j6f6+2elQZqZl
 CwDo8ondEMIKOPdEuyLWTvtCpmgmA78bMKkkzF97IoxGqC0uyEqi2ksJpG7Uj7dtPVsr
 BZD7tqtkykZvNM5wR0QjzEk3z9jQo4B9nQA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31uk21h60x-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:40:52 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 10:40:44 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 96203273E5D2; Tue, 23 Jun 2020 10:40:41 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1291.vll0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: vll0c01
Subject: [PATCH v7 00/19] The new cgroup slab memory controller
Date:   Tue, 23 Jun 2020 10:40:18 -0700
Message-ID: <20200623174037.3951353-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_11:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230124
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v7 of the slab cgroup controller rework.

The patchset moves the accounting from the page level to the object
level. It allows to share slab pages between memory cgroups.
This leads to a significant win in the slab utilization (up to 45%)
and the corresponding drop in the total kernel memory footprint.
The reduced number of unmovable slab pages should also have a positive
effect on the memory fragmentation.

The patchset makes the slab accounting code simpler: there is no more
need in the complicated dynamic creation and destruction of per-cgroup
slab caches, all memory cgroups use a global set of shared slab caches.
The lifetime of slab caches is not more connected to the lifetime
of memory cgroups.

The more precise accounting does require more CPU, however in practice
the difference seems to be negligible. We've been using the new slab
controller in Facebook production for several months with different
workloads and haven't seen any noticeable regressions. What we've seen
were memory savings in order of 1 GB per host (it varied heavily dependin=
g
on the actual workload, size of RAM, number of CPUs, memory pressure, etc=
).

The third version of the patchset added yet another step towards
the simplification of the code: sharing of slab caches between
accounted and non-accounted allocations. It comes with significant
upsides (most noticeable, a complete elimination of dynamic slab caches
creation) but not without some regression risks, so this change sits
on top of the patchset and is not completely merged in. So in the unlikel=
y
event of a noticeable performance regression it can be reverted separatel=
y.

The slab memory accounting works in exactly the same way for SLAB and SLU=
B.
With both allocators the new controller shows significant memory savings,
with SLUB the difference is bigger. On my 16-core desktop machine running
Fedora 32 the size of the slab memory measured after the start of the sys=
tem
was lower by 58% and 38% with SLUB and SLAB correspondingly.

As an estimation of a potential CPU overhead, below are results of
slab_bulk_test01 test, kindly provided by Jesper D. Brouer. He also
helped with the evaluation of results.
The test can be found here: https://github.com/netoptimizer/prototype-ker=
nel/
The smallest number in each row should be picked for a comparison.

SLUB-patched - bulk-API
 - SLUB-patched : bulk_quick_reuse objects=3D1 : 187 -  90 - 224  cycles(=
tsc)
 - SLUB-patched : bulk_quick_reuse objects=3D2 : 110 -  53 - 133  cycles(=
tsc)
 - SLUB-patched : bulk_quick_reuse objects=3D3 :  88 -  95 -  42  cycles(=
tsc)
 - SLUB-patched : bulk_quick_reuse objects=3D4 :  91 -  85 -  36  cycles(=
tsc)
 - SLUB-patched : bulk_quick_reuse objects=3D8 :  32 -  66 -  32  cycles(=
tsc)

SLUB-original -  bulk-API
 - SLUB-original: bulk_quick_reuse objects=3D1 :  87 -  87 - 142  cycles(=
tsc)
 - SLUB-original: bulk_quick_reuse objects=3D2 :  52 -  53 -  53  cycles(=
tsc)
 - SLUB-original: bulk_quick_reuse objects=3D3 :  42 -  42 -  91  cycles(=
tsc)
 - SLUB-original: bulk_quick_reuse objects=3D4 :  91 -  37 -  37  cycles(=
tsc)
 - SLUB-original: bulk_quick_reuse objects=3D8 :  31 -  79 -  76  cycles(=
tsc)

SLAB-patched -  bulk-API
 - SLAB-patched : bulk_quick_reuse objects=3D1 :  67 -  67 - 140  cycles(=
tsc)
 - SLAB-patched : bulk_quick_reuse objects=3D2 :  55 -  46 -  46  cycles(=
tsc)
 - SLAB-patched : bulk_quick_reuse objects=3D3 :  93 -  94 -  39  cycles(=
tsc)
 - SLAB-patched : bulk_quick_reuse objects=3D4 :  35 -  88 -  85  cycles(=
tsc)
 - SLAB-patched : bulk_quick_reuse objects=3D8 :  30 -  30 -  30  cycles(=
tsc)

SLAB-original-  bulk-API
 - SLAB-original: bulk_quick_reuse objects=3D1 : 143 - 136 -  67  cycles(=
tsc)
 - SLAB-original: bulk_quick_reuse objects=3D2 :  45 -  46 -  46  cycles(=
tsc)
 - SLAB-original: bulk_quick_reuse objects=3D3 :  38 -  39 -  39  cycles(=
tsc)
 - SLAB-original: bulk_quick_reuse objects=3D4 :  35 -  87 -  87  cycles(=
tsc)
 - SLAB-original: bulk_quick_reuse objects=3D8 :  29 -  66 -  30  cycles(=
tsc)


v7:
  1) rebased on top of Vlastimil's slub improvements, by Andrew
  2) page->obj_cgroups is allocated from the same node, by Shakeel
  3) perf optimization in get_obj_cgroup_from_current(), by Shakeel
  4) added synchronization around allocation of page->obj_cgroups,
     by Shakeel
  5) fixed kmemleak false positives, by Qian Cai
  6) fixed a compiler warning on clang, by Nathan
  7) other minor fixes

v6:
  1) rebased on top of the mm tree
  2) removed a redundant check from cache_from_obj(), suggested by Vlasti=
mil

v5:
  1) fixed a build error, spotted by Vlastimil
  2) added a comment about memcg->nr_charged_bytes, asked by Johannes
  3) added missed acks and reviews

v4:
  1) rebased on top of the mm tree, some fixes here and there
  2) merged obj_to_index() with slab_index(), suggested by Vlastimil
  3) changed objects_per_slab() to a better objects_per_slab_page(),
     suggested by Vlastimil
  4) other minor fixes and changes

v3:
  1) added a patch that switches to a global single set of kmem_caches
  2) kmem API clean up dropped, because if has been already merged
  3) byte-sized slab vmstat API over page-sized global counters and
     bytes-sized memcg/lruvec counters
  3) obj_cgroup refcounting simplifications and other minor fixes
  4) other minor changes

v2:
  1) implemented re-layering and renaming suggested by Johannes,
     added his patch to the set. Thanks!
  2) fixed the issue discovered by Bharata B Rao. Thanks!
  3) added kmem API clean up part
  4) added slab/memcg follow-up clean up part
  5) fixed a couple of issues discovered by internal testing on FB fleet.
  6) added kselftests
  7) included metadata into the charge calculation
  8) refreshed commit logs, regrouped patches, rebased onto mm tree, etc

v1:
  1) fixed a bug in zoneinfo_show_print()
  2) added some comments to the subpage charging API, a minor fix
  3) separated memory.kmem.slabinfo deprecation into a separate patch,
     provided a drgn-based replacement
  4) rebased on top of the current mm tree

RFC:
  https://lwn.net/Articles/798605/


Johannes Weiner (1):
  mm: memcontrol: decouple reference counting from page accounting

Roman Gushchin (18):
  mm: memcg: factor out memcg- and lruvec-level changes out of
    __mod_lruvec_state()
  mm: memcg: prepare for byte-sized vmstat items
  mm: memcg: convert vmstat slab counters to bytes
  mm: slub: implement SLUB version of obj_to_index()
  mm: memcg/slab: obj_cgroup API
  mm: memcg/slab: allocate obj_cgroups for non-root slab pages
  mm: memcg/slab: save obj_cgroup for non-root slab objects
  mm: memcg/slab: charge individual slab objects instead of pages
  mm: memcg/slab: deprecate memory.kmem.slabinfo
  mm: memcg/slab: move memcg_kmem_bypass() to memcontrol.h
  mm: memcg/slab: use a single set of kmem_caches for all accounted
    allocations
  mm: memcg/slab: simplify memcg cache creation
  mm: memcg/slab: remove memcg_kmem_get_cache()
  mm: memcg/slab: deprecate slab_root_caches
  mm: memcg/slab: remove redundant check in memcg_accumulate_slabinfo()
  mm: memcg/slab: use a single set of kmem_caches for all allocations
  kselftests: cgroup: add kernel memory accounting tests
  tools/cgroup: add memcg_slabinfo.py tool

 drivers/base/node.c                        |   6 +-
 fs/proc/meminfo.c                          |   4 +-
 include/linux/memcontrol.h                 |  85 ++-
 include/linux/mm_types.h                   |   5 +-
 include/linux/mmzone.h                     |  24 +-
 include/linux/slab.h                       |   5 -
 include/linux/slab_def.h                   |   9 +-
 include/linux/slub_def.h                   |  31 +-
 include/linux/vmstat.h                     |  14 +-
 kernel/power/snapshot.c                    |   2 +-
 mm/memcontrol.c                            | 610 +++++++++++--------
 mm/oom_kill.c                              |   2 +-
 mm/page_alloc.c                            |   8 +-
 mm/slab.c                                  |  70 +--
 mm/slab.h                                  | 370 +++++-------
 mm/slab_common.c                           | 643 +--------------------
 mm/slob.c                                  |  12 +-
 mm/slub.c                                  | 229 +-------
 mm/vmscan.c                                |   3 +-
 mm/vmstat.c                                |  30 +-
 mm/workingset.c                            |   6 +-
 tools/cgroup/memcg_slabinfo.py             | 226 ++++++++
 tools/testing/selftests/cgroup/.gitignore  |   1 +
 tools/testing/selftests/cgroup/Makefile    |   2 +
 tools/testing/selftests/cgroup/test_kmem.c | 382 ++++++++++++
 25 files changed, 1380 insertions(+), 1399 deletions(-)
 create mode 100644 tools/cgroup/memcg_slabinfo.py
 create mode 100644 tools/testing/selftests/cgroup/test_kmem.c

--=20
2.26.2

