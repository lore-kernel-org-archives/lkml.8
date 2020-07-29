Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1079C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D633620786
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgG2Dfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:35:53 -0400
Received: from foss.arm.com ([217.140.110.172]:44668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgG2Dfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:35:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F46A31B;
        Tue, 28 Jul 2020 20:35:52 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93FEF3F66E;
        Tue, 28 Jul 2020 20:35:44 -0700 (PDT)
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
Subject: [RFC PATCH 5/6] device-dax: relax the memblock size alignment for kmem_start
Date:   Wed, 29 Jul 2020 11:34:23 +0800
Message-Id: <20200729033424.2629-6-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729033424.2629-1-justin.he@arm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, kmem_start in dev_dax_kmem_probe should be aligned with
SECTION_SIZE_BITS(30), i.e. 1G memblock size on arm64. Even with Dan
Williams' sub-section patch series, it was not helpful when adding the
dax pmem kmem to memblock:
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
  280000000-2bfffffff : dax0.0          <- boundary are aligned with 1G
    280000000-2bfffffff : System RAM (kmem)
$ lsmem
RANGE                                 SIZE  STATE REMOVABLE BLOCK
0x0000000040000000-0x000000023fffffff   8G online       yes   1-8
0x0000000280000000-0x00000002bfffffff   1G online       yes    10

Memory block size:         1G
Total online memory:       9G
Total offline memory:      0B
...
Hence there is a big gap between 0x2403fffff and 0x280000000 due to the 1G
alignment on arm64. More than that, only 1G memory is returned while 2G is
requested.

On x86, the gap is relatively small due to SECTION_SIZE_BITS(27).

Besides descreasing SECTION_SIZE_BITS on arm64, we can relax the alignment
when adding the kmem.
After this patch:
240000000-33fdfffff : Persistent Memory
  240000000-2421fffff : namespace0.0
  242400000-2bfffffff : dax0.0
    242400000-2bfffffff : System RAM (kmem)
$ lsmem
RANGE                                 SIZE  STATE REMOVABLE BLOCK
0x0000000040000000-0x00000002bfffffff  10G online       yes  1-10

Memory block size:         1G
Total online memory:      10G
Total offline memory:      0B

Notes, block 9-10 are the newly hotplug added.

This patches remove the tight alignment constraint of
memory_block_size_bytes(), but still keep the constraint from
online_pages_range().

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/dax/kmem.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index d77786dc0d92..849d0706dfe0 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -30,9 +30,20 @@ int dev_dax_kmem_probe(struct device *dev)
 	const char *new_res_name;
 	int numa_node;
 	int rc;
+	int order;
 
-	/* Hotplug starting at the beginning of the next block: */
-	kmem_start = ALIGN(res->start, memory_block_size_bytes());
+	/* kmem_start needn't be aligned with memory_block_size_bytes().
+	 * But given the constraint in online_pages_range(), adjust the
+	 * alignment of kmem_start and kmem_size
+	 */
+	kmem_size = resource_size(res);
+	order = min_t(int, MAX_ORDER - 1, get_order(kmem_size));
+	kmem_start = ALIGN(res->start, 1ul << (order + PAGE_SHIFT));
+	/* Adjust the size down to compensate for moving up kmem_start: */
+	kmem_size -= kmem_start - res->start;
+	/* Align the size down to cover only complete blocks: */
+	kmem_size &= ~((1ul << (order + PAGE_SHIFT)) - 1);
+	kmem_end = kmem_start + kmem_size;
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
@@ -48,13 +59,6 @@ int dev_dax_kmem_probe(struct device *dev)
 			numa_node, res);
 	}
 
-	kmem_size = resource_size(res);
-	/* Adjust the size down to compensate for moving up kmem_start: */
-	kmem_size -= kmem_start - res->start;
-	/* Align the size down to cover only complete blocks: */
-	kmem_size &= ~(memory_block_size_bytes() - 1);
-	kmem_end = kmem_start + kmem_size;
-
 	new_res_name = kstrdup(dev_name(dev), GFP_KERNEL);
 	if (!new_res_name)
 		return -ENOMEM;
-- 
2.17.1

