Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4598EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED0324655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgAUXKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:10:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbgAUXKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:10:37 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LMlMXQ093251;
        Tue, 21 Jan 2020 18:10:31 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xp46emsb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 18:10:31 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00LMr364138911;
        Tue, 21 Jan 2020 18:10:30 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xp46emsaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 18:10:30 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00LN6YOB014609;
        Tue, 21 Jan 2020 23:10:29 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 2xksn67qe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 23:10:29 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00LNAT8w54460894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 23:10:29 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53324124052;
        Tue, 21 Jan 2020 23:10:29 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94C53124055;
        Tue, 21 Jan 2020 23:10:28 +0000 (GMT)
Received: from rascal.austin.ibm.com (unknown [9.41.179.32])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jan 2020 23:10:28 +0000 (GMT)
From:   Scott Cheloha <cheloha@linux.ibm.com>
To:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        mhocko@suse.com, Scott Cheloha <cheloha@linux.vnet.ibm.com>
Subject: [PATCH v5] drivers/base/memory.c: cache memory blocks in xarray to accelerate lookup
Date:   Tue, 21 Jan 2020 17:10:28 -0600
Message-Id: <20200121231028.13699-1-cheloha@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109212516.17849-1-cheloha@linux.vnet.ibm.com>
References: <20200109212516.17849-1-cheloha@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001210169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Cheloha <cheloha@linux.vnet.ibm.com>

Searching for a particular memory block by id is an O(n) operation
because each memory block's underlying device is kept in an unsorted
linked list on the subsystem bus.

We can cut the lookup cost to O(log n) if we cache each memory block
in an xarray.  This time complexity improvement is significant on
systems with many memory blocks.  For example:

1. A 128GB POWER9 VM with 256MB memblocks has 512 blocks.  With this
   change  memory_dev_init() completes ~12ms faster and walk_memory_blocks()
   completes ~12ms faster.

Before:
[    0.005042] memory_dev_init: adding memory blocks
[    0.021591] memory_dev_init: added memory blocks
[    0.022699] walk_memory_blocks: walking memory blocks
[    0.038730] walk_memory_blocks: walked memory blocks 0-511

After:
[    0.005057] memory_dev_init: adding memory blocks
[    0.009415] memory_dev_init: added memory blocks
[    0.010519] walk_memory_blocks: walking memory blocks
[    0.014135] walk_memory_blocks: walked memory blocks 0-511

2. A 256GB POWER9 LPAR with 256MB memblocks has 1024 blocks.  With
   this change memory_dev_init() completes ~88ms faster and
   walk_memory_blocks() completes ~87ms faster.

Before:
[    0.252246] memory_dev_init: adding memory blocks
[    0.395469] memory_dev_init: added memory blocks
[    0.409413] walk_memory_blocks: walking memory blocks
[    0.433028] walk_memory_blocks: walked memory blocks 0-511
[    0.433094] walk_memory_blocks: walking memory blocks
[    0.500244] walk_memory_blocks: walked memory blocks 131072-131583

After:
[    0.245063] memory_dev_init: adding memory blocks
[    0.299539] memory_dev_init: added memory blocks
[    0.313609] walk_memory_blocks: walking memory blocks
[    0.315287] walk_memory_blocks: walked memory blocks 0-511
[    0.315349] walk_memory_blocks: walking memory blocks
[    0.316988] walk_memory_blocks: walked memory blocks 131072-131583

3. A 32TB POWER9 LPAR with 256MB memblocks has 131072 blocks.  With
   this change we complete memory_dev_init() ~37 minutes faster and
   walk_memory_blocks() at least ~30 minutes faster.  The exact timing
   for walk_memory_blocks() is  missing, though I observed that the
   soft lockups in walk_memory_blocks() disappeared with the change,
   suggesting that lower bound.

Before:
[   13.703907] memory_dev_init: adding blocks
[ 2287.406099] memory_dev_init: added all blocks
[ 2347.494986] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 2527.625378] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 2707.761977] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 2887.899975] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 3068.028318] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 3248.158764] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 3428.287296] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 3608.425357] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 3788.554572] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 3968.695071] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 4148.823970] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160

After:
[   13.696898] memory_dev_init: adding blocks
[   15.660035] memory_dev_init: added all blocks
(the walk_memory_blocks traces disappear)

There should be no significant negative impact for machines with few
memory blocks.  A sparse xarray has a small footprint and an O(log n)
lookup is negligibly slower than an O(n) lookup for only the smallest
number of memory blocks.

1. A 16GB x86 machine with 128MB memblocks has 132 blocks.  With this
   change memory_dev_init() completes ~300us faster and walk_memory_blocks()
   completes no faster or slower.  The improvement is pretty close to noise.

Before:
[    0.224752] memory_dev_init: adding memory blocks
[    0.227116] memory_dev_init: added memory blocks
[    0.227183] walk_memory_blocks: walking memory blocks
[    0.227183] walk_memory_blocks: walked memory blocks 0-131

After:
[    0.224911] memory_dev_init: adding memory blocks
[    0.226935] memory_dev_init: added memory blocks
[    0.227089] walk_memory_blocks: walking memory blocks
[    0.227089] walk_memory_blocks: walked memory blocks 0-131

Signed-off-by: Scott Cheloha <cheloha@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Nathan Lynch <nathanl@linux.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
v2 incorporates suggestions from David Hildenbrand.

v3 changes:
  - Rebase atop "drivers/base/memory.c: drop the mem_sysfs_mutex"

  - Be conservative: don't use radix_tree_for_each_slot() in
    walk_memory_blocks() yet.  It introduces RCU which could
    change behavior.  Walking the tree "by hand" with
    find_memory_block_by_id() is slower but keeps the patch
    simple.

v4 changes:
  - Rewrite commit message to explicitly note the time
    complexity improvements.

  - Provide anecdotal accounts of time-savings in changelog

v5 changes:
  - Switch from the radix_tree API to the xarray API to conform
    to current kernel preferences.

  - Move the time savings accounts into the commit message itself.
    Remeasure performance changes on the machines I had available.

    It should be noted that I was not able to get time on the 32TB
    machine to remeasure the improvements for v5.  The quoted traces
    are from v4 of the patch.  However, the xarray API is used to
    implement the radix_tree API, so I expect the performance changes
    will be identical.

    I did test v5 of the patch on the other machines mentioned in the
    commit message to ensure there were no regressions.

 drivers/base/memory.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 799b43191dea..2178d3e6d063 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
+#include <linux/xarray.h>
 
 #include <linux/atomic.h>
 #include <linux/uaccess.h>
@@ -56,6 +57,13 @@ static struct bus_type memory_subsys = {
 	.offline = memory_subsys_offline,
 };
 
+/*
+ * Memory blocks are cached in a local radix tree to avoid
+ * a costly linear search for the corresponding device on
+ * the subsystem bus.
+ */
+static DEFINE_XARRAY(memory_blocks);
+
 static BLOCKING_NOTIFIER_HEAD(memory_chain);
 
 int register_memory_notifier(struct notifier_block *nb)
@@ -572,20 +580,14 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
 /* A reference for the returned memory block device is acquired. */
 static struct memory_block *find_memory_block_by_id(unsigned long block_id)
 {
-	struct device *dev;
+	struct memory_block *mem;
 
-	dev = subsys_find_device_by_id(&memory_subsys, block_id, NULL);
-	return dev ? to_memory_block(dev) : NULL;
+	mem = xa_load(&memory_blocks, block_id);
+	if (mem)
+		get_device(&mem->dev);
+	return mem;
 }
 
-/*
- * For now, we have a linear search to go find the appropriate
- * memory_block corresponding to a particular phys_index. If
- * this gets to be a real problem, we can always use a radix
- * tree or something here.
- *
- * This could be made generic for all device subsystems.
- */
 struct memory_block *find_memory_block(struct mem_section *section)
 {
 	unsigned long block_id = base_memory_block_id(__section_nr(section));
@@ -628,9 +630,16 @@ int register_memory(struct memory_block *memory)
 	memory->dev.offline = memory->state == MEM_OFFLINE;
 
 	ret = device_register(&memory->dev);
-	if (ret)
+	if (ret) {
 		put_device(&memory->dev);
-
+		return ret;
+	}
+	ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
+			      GFP_KERNEL));
+	if (ret) {
+		put_device(&memory->dev);
+		device_unregister(&memory->dev);
+	}
 	return ret;
 }
 
@@ -688,6 +697,8 @@ static void unregister_memory(struct memory_block *memory)
 	if (WARN_ON_ONCE(memory->dev.bus != &memory_subsys))
 		return;
 
+	WARN_ON(xa_erase(&memory_blocks, memory->dev.id) == NULL);
+
 	/* drop the ref. we got via find_memory_block() */
 	put_device(&memory->dev);
 	device_unregister(&memory->dev);
-- 
2.24.1

