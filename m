Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3D8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E5D42074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgG2DfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:35:13 -0400
Received: from foss.arm.com ([217.140.110.172]:44496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgG2DfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:35:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 309D631B;
        Tue, 28 Jul 2020 20:35:12 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A94CC3F66E;
        Tue, 28 Jul 2020 20:35:04 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Wei Yang <richardw.yang@linux.intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, Kaly Xin <Kaly.Xin@arm.com>,
        Jia He <justin.he@arm.com>
Subject: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem alignment
Date:   Wed, 29 Jul 2020 11:34:18 +0800
Message-Id: <20200729033424.2629-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling dax pmem as RAM device on arm64, I noticed that kmem_start
addr in dev_dax_kmem_probe() should be aligned w/ SECTION_SIZE_BITS(30),i.e.
1G memblock size. Even Dan Williams' sub-section patch series [1] had been
upstream merged, it was not helpful due to hard limitation of kmem_start:
$ndctl create-namespace -e namespace0.0 --mode=devdax --map=dev -s 2g -f -a 2M
$echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
$echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
$cat /proc/iomem
...
23c000000-23fffffff : System RAM
  23dd40000-23fecffff : reserved
  23fed0000-23fffffff : reserved
240000000-33fdfffff : Persistent Memory
  240000000-2403fffff : namespace0.0
  280000000-2bfffffff : dax0.0          <- aligned with 1G boundary
    280000000-2bfffffff : System RAM
Hence there is a big gap between 0x2403fffff and 0x280000000 due to the 1G
alignment.
 
Without this series, if qemu creates a 4G bytes nvdimm device, we can only
use 2G bytes for dax pmem(kmem) in the worst case.
e.g.
240000000-33fdfffff : Persistent Memory 
We can only use the memblock between [240000000, 2ffffffff] due to the hard
limitation. It wastes too much memory space.

Decreasing the SECTION_SIZE_BITS on arm64 might be an alternative, but there
are too many concerns from other constraints, e.g. PAGE_SIZE, hugetlb,
SPARSEMEM_VMEMMAP, page bits in struct page ...

Beside decreasing the SECTION_SIZE_BITS, we can also relax the kmem alignment
with memory_block_size_bytes().

Tested on arm64 guest and x86 guest, qemu creates a 4G pmem device. dax pmem
can be used as ram with smaller gap. Also the kmem hotplug add/remove are both
tested on arm64/x86 guest.

This patch series (mainly patch6/6) is based on the fixing patch, ~v5.8-rc5 [2].

[1] https://lkml.org/lkml/2019/6/19/67
[2] https://lkml.org/lkml/2020/7/8/1546
Jia He (6):
  mm/memory_hotplug: remove redundant memory block size alignment check
  resource: export find_next_iomem_res() helper
  mm/memory_hotplug: allow pmem kmem not to align with memory_block_size
  mm/page_alloc: adjust the start,end in dax pmem kmem case
  device-dax: relax the memblock size alignment for kmem_start
  arm64: fall back to vmemmap_populate_basepages if not aligned  with
    PMD_SIZE

 arch/arm64/mm/mmu.c    |  4 ++++
 drivers/base/memory.c  | 24 ++++++++++++++++--------
 drivers/dax/kmem.c     | 22 +++++++++++++---------
 include/linux/ioport.h |  3 +++
 kernel/resource.c      |  3 ++-
 mm/memory_hotplug.c    | 39 ++++++++++++++++++++++++++++++++++++++-
 mm/page_alloc.c        | 14 ++++++++++++++
 7 files changed, 90 insertions(+), 19 deletions(-)

-- 
2.17.1

