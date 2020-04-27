Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E19AC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 02:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E114A206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 02:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgD0C5G convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 22:57:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:40072 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgD0C5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 22:57:06 -0400
IronPort-SDR: 92/UWhhskW6sfUb3mvkEKsOZ70zwVYY9/VpCQkTB7FUFpW0d9bZMcZSGRJSTmLXzMye/F8CoDU
 4trvciq6iing==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2020 19:57:05 -0700
IronPort-SDR: fXBplnlhjTnOcBgl4KGXwZfgfSku3IWQ/Ek03rGYwMTiTW/qXBiCNL+YInD2q6rfcC5tFwkqCp
 VWVB7xClqKCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,321,1583222400"; 
   d="scan'208";a="245955392"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga007.jf.intel.com with ESMTP; 26 Apr 2020 19:57:04 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 26 Apr 2020 19:57:04 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 26 Apr 2020 19:56:58 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.129]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.146]) with mapi id 14.03.0439.000;
 Mon, 27 Apr 2020 10:56:56 +0800
From:   "Ma, Jianpeng" <jianpeng.ma@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: block: remove unused header includes.
Thread-Topic: block: remove unused header includes.
Thread-Index: AdYcP3CXILghGS16Sc6WaotIgRxXXw==
Date:   Mon, 27 Apr 2020 02:56:55 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C73C55940@SHSMSX101.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This used deheader(git@gitlab.com:esr/deheader.git) to produce.

Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
---
 block/badblocks.c        |  6 ------
 block/bfq-cgroup.c       | 10 ----------
 block/bfq-iosched.c      | 13 -------------
 block/bio-integrity.c    |  6 ------
 block/bio.c              | 14 --------------
 block/blk-cgroup.c       | 10 ----------
 block/blk-core.c         | 24 ------------------------
 block/blk-exec.c         |  5 -----
 block/blk-flush.c        | 10 ----------
 block/blk-integrity.c    |  6 ------
 block/blk-ioc.c          |  7 -------
 block/blk-lib.c          |  5 -----
 block/blk-map.c          |  4 ----
 block/blk-merge.c        |  5 -----
 block/blk-mq-cpumap.c    |  8 --------
 block/blk-mq-debugfs.c   |  6 ------
 block/blk-mq-pci.c       |  4 ----
 block/blk-mq-rdma.c      |  1 -
 block/blk-mq-sched.c     |  7 -------
 block/blk-mq-sysfs.c     | 15 +--------------
 block/blk-mq-tag.c       |  5 -----
 block/blk-mq-virtio.c    |  4 ----
 block/blk-mq.c           | 22 ----------------------
 block/blk-pm.c           |  4 ----
 block/blk-settings.c     |  8 --------
 block/blk-softirq.c      |  6 ------
 block/blk-stat.c         |  5 -----
 block/blk-sysfs.c        |  9 ---------
 block/blk-throttle.c     |  5 -----
 block/blk-timeout.c      |  5 -----
 block/blk-wbt.c          |  6 ------
 block/blk-zoned.c        |  7 -------
 block/bounce.c           | 15 ---------------
 block/bsg-lib.c          |  5 -----
 block/bsg.c              | 11 -----------
 block/cmdline-parser.c   |  1 -
 block/elevator.c         | 15 ---------------
 block/genhd.c            | 14 --------------
 block/ioctl.c            |  8 --------
 block/ioprio.c           | 11 -----------
 block/kyber-iosched.c    |  9 ---------
 block/mq-deadline.c      | 14 --------------
 block/partitions/amiga.c |  1 -
 block/partitions/core.c  |  4 ----
 block/partitions/efi.c   |  3 ---
 block/partitions/karma.c |  1 -
 block/partitions/ldm.c   |  4 ----
 block/partitions/mac.c   |  1 -
 block/scsi_ioctl.c       | 14 --------------
 block/sed-opal.c         |  9 ---------
 block/t10-pi.c           |  1 -
 fs/block_dev.c           | 16 ----------------
 52 files changed, 1 insertion(+), 408 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 2e5f5697db35..4e4eb0fc9eb9 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -8,12 +8,6 @@
  */
 
 #include <linux/badblocks.h>
-#include <linux/seqlock.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/stddef.h>
-#include <linux/types.h>
 #include <linux/slab.h>
 
 /**
diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 68882b9b8f11..7e8c1ad41ad5 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -2,16 +2,6 @@
 /*
  * cgroups support for the BFQ I/O scheduler.
  */
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/blkdev.h>
-#include <linux/cgroup.h>
-#include <linux/elevator.h>
-#include <linux/ktime.h>
-#include <linux/rbtree.h>
-#include <linux/ioprio.h>
-#include <linux/sbitmap.h>
-#include <linux/delay.h>
 
 #include "bfq-iosched.h"
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 78ba57efd16b..39fb3279c46e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -113,21 +113,8 @@
  *
  * http://www.cs.berkeley.edu/~istoica/papers/eevdf-tr-95.pdf
  */
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/blkdev.h>
-#include <linux/cgroup.h>
-#include <linux/elevator.h>
-#include <linux/ktime.h>
-#include <linux/rbtree.h>
-#include <linux/ioprio.h>
-#include <linux/sbitmap.h>
-#include <linux/delay.h>
 
 #include "blk.h"
-#include "blk-mq.h"
-#include "blk-mq-tag.h"
-#include "blk-mq-sched.h"
 #include "bfq-iosched.h"
 #include "blk-wbt.h"
 
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index bf62c25cde8f..5415b0755e7c 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -6,12 +6,6 @@
  * Written by: Martin K. Petersen <martin.petersen@oracle.com>
  */
 
-#include <linux/blkdev.h>
-#include <linux/mempool.h>
-#include <linux/export.h>
-#include <linux/bio.h>
-#include <linux/workqueue.h>
-#include <linux/slab.h>
 #include "blk.h"
 
 #define BIP_INLINE_VECS	4
diff --git a/block/bio.c b/block/bio.c
index 21cbaa6a1c20..c98aefa3236f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2,21 +2,7 @@
 /*
  * Copyright (C) 2001 Jens Axboe <axboe@kernel.dk>
  */
-#include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
-#include <linux/uio.h>
-#include <linux/iocontext.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/export.h>
-#include <linux/mempool.h>
-#include <linux/workqueue.h>
-#include <linux/cgroup.h>
-#include <linux/blk-cgroup.h>
-#include <linux/highmem.h>
 #include <linux/sched/sysctl.h>
 
 #include <trace/events/block.h>
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c5dc833212e1..f60dac43afc4 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -15,19 +15,9 @@
  * Copyright (C) 2015 Paolo Valente <paolo.valente@unimore.it>
  *                    Arianna Avanzini <avanzini.arianna@gmail.com>
  */
-#include <linux/ioprio.h>
-#include <linux/kdev_t.h>
-#include <linux/module.h>
-#include <linux/sched/signal.h>
-#include <linux/err.h>
-#include <linux/blkdev.h>
 #include <linux/backing-dev.h>
-#include <linux/slab.h>
-#include <linux/genhd.h>
 #include <linux/delay.h>
-#include <linux/atomic.h>
 #include <linux/ctype.h>
-#include <linux/blk-cgroup.h>
 #include <linux/tracehook.h>
 #include <linux/psi.h>
 #include "blk.h"
diff --git a/block/blk-core.c b/block/blk-core.c
index 7e4a1da0715e..c2176e451326 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -12,39 +12,15 @@
 /*
  * This handles all read/write requests to block devices
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/backing-dev.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
-#include <linux/blk-mq.h>
-#include <linux/highmem.h>
-#include <linux/mm.h>
-#include <linux/kernel_stat.h>
-#include <linux/string.h>
-#include <linux/init.h>
-#include <linux/completion.h>
-#include <linux/slab.h>
-#include <linux/swap.h>
-#include <linux/writeback.h>
 #include <linux/task_io_accounting_ops.h>
-#include <linux/fault-inject.h>
-#include <linux/list_sort.h>
-#include <linux/delay.h>
-#include <linux/ratelimit.h>
-#include <linux/pm_runtime.h>
-#include <linux/blk-cgroup.h>
-#include <linux/t10-pi.h>
 #include <linux/debugfs.h>
-#include <linux/bpf.h>
 #include <linux/psi.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
 
 #include "blk.h"
-#include "blk-mq.h"
-#include "blk-mq-sched.h"
 #include "blk-pm.h"
 #include "blk-rq-qos.h"
 
diff --git a/block/blk-exec.c b/block/blk-exec.c
index e20a852ae432..6ddf927169da 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -3,14 +3,9 @@
  * Functions related to setting various queue properties from drivers
  */
 #include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
-#include <linux/blk-mq.h>
 #include <linux/sched/sysctl.h>
 
 #include "blk.h"
-#include "blk-mq-sched.h"
 
 /**
  * blk_end_sync_rq - executes a completion event on a request
diff --git a/block/blk-flush.c b/block/blk-flush.c
index c7f396e3d5e2..7e21d7a60dc7 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -63,18 +63,8 @@
  * merged in the usual way.
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
-#include <linux/gfp.h>
-#include <linux/blk-mq.h>
-#include <linux/lockdep.h>
 
 #include "blk.h"
-#include "blk-mq.h"
-#include "blk-mq-tag.h"
-#include "blk-mq-sched.h"
 
 /* PREFLUSH/FUA sequences */
 enum {
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index ff1070edbb40..30e6171c5926 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -6,13 +6,7 @@
  * Written by: Martin K. Petersen <martin.petersen@oracle.com>
  */
 
-#include <linux/blkdev.h>
 #include <linux/backing-dev.h>
-#include <linux/mempool.h>
-#include <linux/bio.h>
-#include <linux/scatterlist.h>
-#include <linux/export.h>
-#include <linux/slab.h>
 
 #include "blk.h"
 
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 9df50fb507ca..2f073c28dbea 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -2,15 +2,8 @@
 /*
  * Functions related to io context handling
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/bio.h>
 #include <linux/blkdev.h>
-#include <linux/slab.h>
-#include <linux/sched/task.h>
 
-#include "blk.h"
 
 /*
  * For io context allocations
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 5f2c429d4378..161c76557287 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -2,11 +2,6 @@
 /*
  * Functions related to generic helpers functions
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
-#include <linux/scatterlist.h>
 
 #include "blk.h"
 
diff --git a/block/blk-map.c b/block/blk-map.c
index b72c361911a4..517fe5c1b582 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -2,11 +2,7 @@
 /*
  * Functions related to mapping data to requests
  */
-#include <linux/kernel.h>
 #include <linux/sched/task_stack.h>
-#include <linux/module.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
 #include <linux/uio.h>
 
 #include "blk.h"
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1534ed736363..cd64253e7a0a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -2,11 +2,6 @@
 /*
  * Functions related to segment and merge handling
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
-#include <linux/scatterlist.h>
 
 #include <trace/events/block.h>
 
diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 0157f2b3485a..54f364de462b 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -4,16 +4,8 @@
  *
  * Copyright (C) 2013-2014 Jens Axboe
  */
-#include <linux/kernel.h>
-#include <linux/threads.h>
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/smp.h>
-#include <linux/cpu.h>
 
 #include <linux/blk-mq.h>
-#include "blk.h"
-#include "blk-mq.h"
 
 static int queue_index(struct blk_mq_queue_map *qmap,
 		       unsigned int nr_queues, const int q)
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b3f2ba483992..f4c90e730040 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -3,15 +3,9 @@
  * Copyright (C) 2017 Facebook
  */
 
-#include <linux/kernel.h>
-#include <linux/blkdev.h>
 #include <linux/debugfs.h>
 
-#include <linux/blk-mq.h>
 #include "blk.h"
-#include "blk-mq.h"
-#include "blk-mq-debugfs.h"
-#include "blk-mq-tag.h"
 #include "blk-rq-qos.h"
 
 static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index b595a94c4d16..17ce43996726 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -2,12 +2,8 @@
 /*
  * Copyright (c) 2016 Christoph Hellwig.
  */
-#include <linux/kobject.h>
-#include <linux/blkdev.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/pci.h>
-#include <linux/module.h>
 
 #include "blk-mq.h"
 
diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
index 14f968e58b8f..a42009431fef 100644
--- a/block/blk-mq-rdma.c
+++ b/block/blk-mq-rdma.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2017 Sagi Grimberg.
  */
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-rdma.h>
 #include <rdma/ib_verbs.h>
 
 /**
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 74cedea56034..795f4ff10b14 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -4,18 +4,11 @@
  *
  * Copyright (C) 2016 Jens Axboe
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/blk-mq.h>
 
 #include <trace/events/block.h>
 
 #include "blk.h"
-#include "blk-mq.h"
 #include "blk-mq-debugfs.h"
-#include "blk-mq-sched.h"
-#include "blk-mq-tag.h"
-#include "blk-wbt.h"
 
 void blk_mq_sched_free_hctx_data(struct request_queue *q,
 				 void (*exit)(struct blk_mq_hw_ctx *))
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 062229395a50..492288dd6578 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -1,19 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/backing-dev.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/workqueue.h>
-#include <linux/smp.h>
-
-#include <linux/blk-mq.h>
+
 #include "blk.h"
-#include "blk-mq.h"
-#include "blk-mq-tag.h"
 
 static void blk_mq_sysfs_release(struct kobject *kobj)
 {
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 586c9d6e904a..47687e56ceb4 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -6,14 +6,9 @@
  *
  * Copyright (C) 2013-2014 Jens Axboe
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
 
-#include <linux/blk-mq.h>
 #include <linux/delay.h>
 #include "blk.h"
-#include "blk-mq.h"
-#include "blk-mq-tag.h"
 
 /*
  * If a previously inactive queue goes active, bump the active user count.
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
index 7b8a42c35102..4ea8a6636a46 100644
--- a/block/blk-mq-virtio.c
+++ b/block/blk-mq-virtio.c
@@ -2,12 +2,8 @@
 /*
  * Copyright (c) 2016 Christoph Hellwig.
  */
-#include <linux/device.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-virtio.h>
 #include <linux/virtio_config.h>
-#include <linux/module.h>
-#include "blk-mq.h"
 
 /**
  * blk_mq_virtio_map_queues - provide a default queue mapping for virtio device
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a7785df2c944..3fa43a3d3a89 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5,39 +5,17 @@
  * Copyright (C) 2013-2014 Jens Axboe
  * Copyright (C) 2013-2014 Christoph Hellwig
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/backing-dev.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
 #include <linux/kmemleak.h>
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/workqueue.h>
-#include <linux/smp.h>
-#include <linux/llist.h>
 #include <linux/list_sort.h>
 #include <linux/cpu.h>
-#include <linux/cache.h>
-#include <linux/sched/sysctl.h>
 #include <linux/sched/topology.h>
-#include <linux/sched/signal.h>
-#include <linux/delay.h>
 #include <linux/crash_dump.h>
-#include <linux/prefetch.h>
 
 #include <trace/events/block.h>
 
-#include <linux/blk-mq.h>
-#include <linux/t10-pi.h>
 #include "blk.h"
-#include "blk-mq.h"
-#include "blk-mq-debugfs.h"
-#include "blk-mq-tag.h"
 #include "blk-pm.h"
-#include "blk-stat.h"
-#include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
 static void blk_mq_poll_stats_start(struct request_queue *q);
diff --git a/block/blk-pm.c b/block/blk-pm.c
index 1adc1cd748b4..00b1627b94e6 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -1,11 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/blk-mq.h>
-#include <linux/blk-pm.h>
-#include <linux/blkdev.h>
 #include <linux/pm_runtime.h>
-#include "blk-mq.h"
-#include "blk-mq-tag.h"
 
 /**
  * blk_pm_runtime_init - Block layer runtime PM initialization routine
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 14397b4c4b53..00a11df111d8 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -2,16 +2,8 @@
 /*
  * Functions related to setting various queue properties from drivers
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
-#include <linux/gcd.h>
 #include <linux/lcm.h>
-#include <linux/jiffies.h>
-#include <linux/gfp.h>
 #include <linux/dma-mapping.h>
 
 #include "blk.h"
diff --git a/block/blk-softirq.c b/block/blk-softirq.c
index 6e7ec87d49fa..4c1ef56d381e 100644
--- a/block/blk-softirq.c
+++ b/block/blk-softirq.c
@@ -2,14 +2,8 @@
 /*
  * Functions related to softirq rq completions
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
-#include <linux/sched.h>
 #include <linux/sched/topology.h>
 
 #include "blk.h"
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 7da302ff88d0..8271f8497539 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -4,12 +4,7 @@
  *
  * Copyright (C) 2016 Jens Axboe
  */
-#include <linux/kernel.h>
-#include <linux/rculist.h>
-#include <linux/blk-mq.h>
 
-#include "blk-stat.h"
-#include "blk-mq.h"
 #include "blk.h"
 
 struct blk_queue_stats {
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fca9b158f4a0..63f79ab81a24 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -2,19 +2,10 @@
 /*
  * Functions related to sysfs handling
  */
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/blktrace_api.h>
-#include <linux/blk-mq.h>
-#include <linux/blk-cgroup.h>
 
 #include "blk.h"
-#include "blk-mq.h"
-#include "blk-mq-debugfs.h"
 #include "blk-wbt.h"
 
 struct queue_sysfs_entry {
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 98233c9c65a8..04a7639aa3c7 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -5,12 +5,7 @@
  * Copyright (C) 2010 Vivek Goyal <vgoyal@redhat.com>
  */
 
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/blkdev.h>
-#include <linux/bio.h>
 #include <linux/blktrace_api.h>
-#include <linux/blk-cgroup.h>
 #include "blk.h"
 #include "blk-cgroup-rwstat.h"
 
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 8aa68fae96ad..c62b9f36c0f5 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -2,13 +2,8 @@
 /*
  * Functions related to generic timeout handling of requests.
  */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/blkdev.h>
-#include <linux/fault-inject.h>
 
 #include "blk.h"
-#include "blk-mq.h"
 
 #ifdef CONFIG_FAIL_IO_TIMEOUT
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 9cb082f38b93..b21fb1bbf1ab 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -19,14 +19,8 @@
  * Copyright (C) 2016 Jens Axboe
  *
  */
-#include <linux/kernel.h>
-#include <linux/blk_types.h>
-#include <linux/slab.h>
-#include <linux/backing-dev.h>
 #include <linux/swap.h>
 
-#include "blk-wbt.h"
-#include "blk-rq-qos.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/wbt.h>
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index f87956e0dcaf..8b6d03b6bfe5 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -9,13 +9,6 @@
  * Copyright (c) 2016, Western Digital
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/rbtree.h>
-#include <linux/blkdev.h>
-#include <linux/blk-mq.h>
-#include <linux/mm.h>
-#include <linux/vmalloc.h>
 #include <linux/sched/mm.h>
 
 #include "blk.h"
diff --git a/block/bounce.c b/block/bounce.c
index f8ed677a1bf7..1e5e9f109917 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -6,24 +6,9 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/mm.h>
-#include <linux/export.h>
 #include <linux/swap.h>
-#include <linux/gfp.h>
-#include <linux/bio.h>
-#include <linux/pagemap.h>
-#include <linux/mempool.h>
-#include <linux/blkdev.h>
-#include <linux/backing-dev.h>
-#include <linux/init.h>
-#include <linux/hash.h>
-#include <linux/highmem.h>
-#include <linux/memblock.h>
-#include <linux/printk.h>
-#include <asm/tlbflush.h>
 
 #include <trace/events/block.h>
-#include "blk.h"
 
 #define POOL_SIZE	64
 #define ISA_POOL_SIZE	16
diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 6cbb7926534c..0559c1f159b0 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -6,12 +6,7 @@
  *  Copyright (C) 2011   Red Hat, Inc.  All rights reserved.
  *  Copyright (C) 2011   Mike Christie
  */
-#include <linux/slab.h>
-#include <linux/blk-mq.h>
-#include <linux/delay.h>
-#include <linux/scatterlist.h>
 #include <linux/bsg-lib.h>
-#include <linux/export.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/sg.h>
 
diff --git a/block/bsg.c b/block/bsg.c
index d7bae94b64d9..c6a0537b0093 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -3,21 +3,10 @@
  * bsg.c - block layer implementation of the sg v4 interface
  */
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/file.h>
-#include <linux/blkdev.h>
 #include <linux/cdev.h>
-#include <linux/jiffies.h>
-#include <linux/percpu.h>
-#include <linux/idr.h>
-#include <linux/bsg.h>
-#include <linux/slab.h>
 
-#include <scsi/scsi.h>
 #include <scsi/scsi_ioctl.h>
 #include <scsi/scsi_cmnd.h>
-#include <scsi/scsi_device.h>
-#include <scsi/scsi_driver.h>
 #include <scsi/sg.h>
 
 #define BSG_DESCRIPTION	"Block layer SCSI generic (bsg) driver"
diff --git a/block/cmdline-parser.c b/block/cmdline-parser.c
index f2a14571882b..f62d0b1cf016 100644
--- a/block/cmdline-parser.c
+++ b/block/cmdline-parser.c
@@ -5,7 +5,6 @@
  * Written by Cai Zhiyong <caizhiyong@huawei.com>
  *
  */
-#include <linux/export.h>
 #include <linux/cmdline-parser.h>
 
 static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)
diff --git a/block/elevator.c b/block/elevator.c
index 4eab3d70e880..f6ef3759040d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -23,26 +23,11 @@
  * - completely modularize elevator setup and teardown
  *
  */
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/blkdev.h>
-#include <linux/elevator.h>
-#include <linux/bio.h>
 #include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/compiler.h>
 #include <linux/blktrace_api.h>
-#include <linux/hash.h>
-#include <linux/uaccess.h>
-#include <linux/pm_runtime.h>
-#include <linux/blk-cgroup.h>
 
-#include <trace/events/block.h>
 
 #include "blk.h"
-#include "blk-mq-sched.h"
-#include "blk-pm.h"
 #include "blk-wbt.h"
 
 static DEFINE_SPINLOCK(elv_list_lock);
diff --git a/block/genhd.c b/block/genhd.c
index 06b642b23a07..e5bcf7d580ed 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -3,24 +3,10 @@
  *  gendisk handling
  */
 
-#include <linux/module.h>
 #include <linux/ctype.h>
-#include <linux/fs.h>
-#include <linux/genhd.h>
-#include <linux/kdev_t.h>
-#include <linux/kernel.h>
-#include <linux/blkdev.h>
 #include <linux/backing-dev.h>
-#include <linux/init.h>
-#include <linux/spinlock.h>
 #include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
-#include <linux/kmod.h>
 #include <linux/kobj_map.h>
-#include <linux/mutex.h>
-#include <linux/idr.h>
-#include <linux/log2.h>
 #include <linux/pm_runtime.h>
 #include <linux/badblocks.h>
 
diff --git a/block/ioctl.c b/block/ioctl.c
index 6e827de1a4c4..68a41ad96e1a 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -1,16 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/capability.h>
-#include <linux/compat.h>
-#include <linux/blkdev.h>
-#include <linux/export.h>
-#include <linux/gfp.h>
 #include <linux/blkpg.h>
 #include <linux/hdreg.h>
-#include <linux/backing-dev.h>
-#include <linux/fs.h>
 #include <linux/blktrace_api.h>
 #include <linux/pr.h>
-#include <linux/uaccess.h>
 #include "blk.h"
 
 static int blkpg_do_ioctl(struct block_device *bdev,
diff --git a/block/ioprio.c b/block/ioprio.c
index 77bcab11dce5..def8d3263836 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -20,18 +20,7 @@
  * See also Documentation/block/ioprio.rst
  *
  */
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/export.h>
-#include <linux/ioprio.h>
-#include <linux/cred.h>
-#include <linux/blkdev.h>
-#include <linux/capability.h>
-#include <linux/sched/user.h>
-#include <linux/sched/task.h>
 #include <linux/syscalls.h>
-#include <linux/security.h>
-#include <linux/pid_namespace.h>
 
 int set_task_ioprio(struct task_struct *task, int ioprio)
 {
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 34dcea0ef637..07defcb0dec2 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -6,18 +6,9 @@
  * Copyright (C) 2017 Facebook
  */
 
-#include <linux/kernel.h>
-#include <linux/blkdev.h>
-#include <linux/blk-mq.h>
-#include <linux/elevator.h>
-#include <linux/module.h>
-#include <linux/sbitmap.h>
 
 #include "blk.h"
-#include "blk-mq.h"
 #include "blk-mq-debugfs.h"
-#include "blk-mq-sched.h"
-#include "blk-mq-tag.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/kyber.h>
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b490f47fd553..2ff1814f113d 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -5,24 +5,10 @@
  *
  *  Copyright (C) 2016 Jens Axboe <axboe@kernel.dk>
  */
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/blkdev.h>
-#include <linux/blk-mq.h>
-#include <linux/elevator.h>
-#include <linux/bio.h>
 #include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/compiler.h>
-#include <linux/rbtree.h>
-#include <linux/sbitmap.h>
 
 #include "blk.h"
-#include "blk-mq.h"
 #include "blk-mq-debugfs.h"
-#include "blk-mq-tag.h"
-#include "blk-mq-sched.h"
 
 /*
  * See Documentation/block/deadline-iosched.rst
diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 9526491d9aed..a9f29e21b01c 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -10,7 +10,6 @@
 
 #define pr_fmt(fmt) fmt
 
-#include <linux/types.h>
 #include <linux/affs_hardblocks.h>
 
 #include "check.h"
diff --git a/block/partitions/core.c b/block/partitions/core.c
index bc1ded1331b1..3d412976ccd0 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -3,11 +3,7 @@
  * Copyright (C) 1991-1998  Linus Torvalds
  * Re-organised Feb 1998 Russell King
  */
-#include <linux/fs.h>
-#include <linux/slab.h>
 #include <linux/ctype.h>
-#include <linux/genhd.h>
-#include <linux/vmalloc.h>
 #include <linux/blktrace_api.h>
 #include <linux/raid/detect.h>
 #include "check.h"
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index b64bfdd4326c..8ab8fb896fa1 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -82,11 +82,8 @@
  * - Code works, detects all the partitions.
  *
  ************************************************************/
-#include <linux/kernel.h>
 #include <linux/crc32.h>
 #include <linux/ctype.h>
-#include <linux/math64.h>
-#include <linux/slab.h>
 #include "check.h"
 #include "efi.h"
 
diff --git a/block/partitions/karma.c b/block/partitions/karma.c
index 4d93512f4bd4..a8e84c9994ce 100644
--- a/block/partitions/karma.c
+++ b/block/partitions/karma.c
@@ -8,7 +8,6 @@
  */
 
 #include "check.h"
-#include <linux/compiler.h>
 
 #define KARMA_LABEL_MAGIC		0xAB56
 
diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 6fdfcb40c537..165757c34034 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -10,10 +10,6 @@
  */
 
 #include <linux/slab.h>
-#include <linux/pagemap.h>
-#include <linux/stringify.h>
-#include <linux/kernel.h>
-#include <linux/uuid.h>
 #include <linux/msdos_partition.h>
 
 #include "ldm.h"
diff --git a/block/partitions/mac.c b/block/partitions/mac.c
index b6095335636c..0d6f122030da 100644
--- a/block/partitions/mac.c
+++ b/block/partitions/mac.c
@@ -7,7 +7,6 @@
  *  Re-organised Feb 1998 Russell King
  */
 
-#include <linux/ctype.h>
 #include "check.h"
 #include "mac.h"
 
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index ef722f04f88a..a7f864bf5048 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -2,22 +2,8 @@
 /*
  * Copyright (C) 2001 Jens Axboe <axboe@suse.de>
  */
-#include <linux/compat.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/module.h>
-#include <linux/blkdev.h>
-#include <linux/capability.h>
-#include <linux/completion.h>
 #include <linux/cdrom.h>
-#include <linux/ratelimit.h>
-#include <linux/slab.h>
-#include <linux/times.h>
-#include <linux/uio.h>
-#include <linux/uaccess.h>
 
-#include <scsi/scsi.h>
 #include <scsi/scsi_ioctl.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/sg.h>
diff --git a/block/sed-opal.c b/block/sed-opal.c
index daafadbb88ca..267127f52a75 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -9,17 +9,8 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ":OPAL: " fmt
 
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
 #include <linux/genhd.h>
-#include <linux/slab.h>
-#include <linux/uaccess.h>
-#include <uapi/linux/sed-opal.h>
 #include <linux/sed-opal.h>
-#include <linux/string.h>
-#include <linux/kdev_t.h>
 
 #include "opal_proto.h"
 
diff --git a/block/t10-pi.c b/block/t10-pi.c
index d910534b3a41..ca5270162807 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/t10-pi.h>
-#include <linux/blkdev.h>
 #include <linux/crc-t10dif.h>
 #include <linux/module.h>
 #include <net/checksum.h>
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 93672c3f1c78..f41ff47186ab 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -6,33 +6,17 @@
  *  Copyright (C) 2001  Andrea Arcangeli <andrea@suse.de> SuSE
  */
 
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/fcntl.h>
-#include <linux/slab.h>
-#include <linux/kmod.h>
-#include <linux/major.h>
 #include <linux/device_cgroup.h>
-#include <linux/highmem.h>
-#include <linux/blkdev.h>
 #include <linux/backing-dev.h>
-#include <linux/module.h>
 #include <linux/blkpg.h>
-#include <linux/magic.h>
 #include <linux/buffer_head.h>
-#include <linux/swap.h>
-#include <linux/pagevec.h>
-#include <linux/writeback.h>
 #include <linux/mpage.h>
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
-#include <linux/uio.h>
 #include <linux/namei.h>
-#include <linux/log2.h>
 #include <linux/cleancache.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/falloc.h>
-#include <linux/uaccess.h>
 #include <linux/suspend.h>
 #include "internal.h"
 
-- 
2.20.1


