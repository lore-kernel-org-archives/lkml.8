Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18898C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 00:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F25932075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 00:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgFZAiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 20:38:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:41253 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgFZAiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 20:38:08 -0400
IronPort-SDR: /DPq3q6v1/UWBlEuXpnVA23qiIEgZsByYhddzv21rYzadC8RXxAZd6+REbpjqNG7hd0Ri/o913
 W+20rBmN9CCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="143363204"
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800"; 
   d="scan'208";a="143363204"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:38:08 -0700
IronPort-SDR: sAP5VUivnXsTTcI+6gTAZIS2F0vRRKKHU0BVhJDSs+qZCrma/ZaGP0LFz0fRePUEXpMwS1f1qW
 4giRs2NaQudA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800"; 
   d="scan'208";a="276205584"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga003.jf.intel.com with ESMTP; 25 Jun 2020 17:38:07 -0700
Subject: [PATCH] mm/vmscan: restore zone_reclaim_mode ABI
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        ben.widawsky@intel.com, alex.shi@linux.alibaba.com,
        dwagner@suse.de, tobin@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, stable@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 25 Jun 2020 17:34:59 -0700
Message-Id: <20200626003459.D8E015CA@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

I went to go add a new RECLAIM_* mode for the zone_reclaim_mode
sysctl.  Like a good kernel developer, I also went to go update the
documentation.  I noticed that the bits in the documentation didn't
match the bits in the #defines.

The VM evidently stopped caring about RECLAIM_ZONE at some point (or
never cared) and the #define itself was later removed as a cleanup.
Those things by themselves are fine.

But, the _other_ bit locations also got changed.  That's not OK because
the bit values are documented to mean one specific thing and users
surely rely on them meaning that one thing and not changing from
kernel to kernel.  The end result is that if someone had a script
that did:

	sysctl vm.zone_reclaim_mode=1

That script went from doing nothing to writing out pages during
node reclaim after the commit in question.  That's not great.

Put the bits back the way they were and add a comment so something
like this is a bit harder to do again.  Update the documentation to
make it clear that the first bit is ignored.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: commit 648b5cf368e0 ("mm/vmscan: remove unused RECLAIM_OFF/RECLAIM_ZONE")
Acked-by: Ben Widawsky <ben.widawsky@intel.com>
Cc: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: "Tobin C. Harding" <tobin@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@kernel.org
---

 b/Documentation/admin-guide/sysctl/vm.rst |   12 ++++++------
 b/mm/vmscan.c                             |    9 +++++++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff -puN mm/vmscan.c~mm-vmscan-restore-old-zone_reclaim_mode-abi mm/vmscan.c
--- a/mm/vmscan.c~mm-vmscan-restore-old-zone_reclaim_mode-abi	2020-06-25 17:32:11.559165912 -0700
+++ b/mm/vmscan.c	2020-06-25 17:32:11.572165912 -0700
@@ -4090,8 +4090,13 @@ module_init(kswapd_init)
  */
 int node_reclaim_mode __read_mostly;
 
-#define RECLAIM_WRITE (1<<0)	/* Writeout pages during reclaim */
-#define RECLAIM_UNMAP (1<<1)	/* Unmap pages during reclaim */
+/*
+ * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
+ * ABI.  New bits are OK, but existing bits can never change.
+ */
+#define RECLAIM_RSVD  (1<<0)	/* (currently ignored/unused) */
+#define RECLAIM_WRITE (1<<1)	/* Writeout pages during reclaim */
+#define RECLAIM_UNMAP (1<<2)	/* Unmap pages during reclaim */
 
 /*
  * Priority for NODE_RECLAIM. This determines the fraction of pages
diff -puN Documentation/admin-guide/sysctl/vm.rst~mm-vmscan-restore-old-zone_reclaim_mode-abi Documentation/admin-guide/sysctl/vm.rst
--- a/Documentation/admin-guide/sysctl/vm.rst~mm-vmscan-restore-old-zone_reclaim_mode-abi	2020-06-25 17:32:11.562165912 -0700
+++ b/Documentation/admin-guide/sysctl/vm.rst	2020-06-25 17:32:11.572165912 -0700
@@ -938,7 +938,7 @@ in the system.
 This is value OR'ed together of
 
 =	===================================
-1	Zone reclaim on
+1	(bit currently ignored)
 2	Zone reclaim writes dirty pages out
 4	Zone reclaim swaps pages
 =	===================================
@@ -948,11 +948,11 @@ that benefit from having their data cach
 left disabled as the caching effect is likely to be more important than
 data locality.
 
-zone_reclaim may be enabled if it's known that the workload is partitioned
-such that each partition fits within a NUMA node and that accessing remote
-memory would cause a measurable performance reduction.  The page allocator
-will then reclaim easily reusable pages (those page cache pages that are
-currently not used) before allocating off node pages.
+Consider enabling one or more zone_reclaim mode bits if it's known that the
+workload is partitioned such that each partition fits within a NUMA node
+and that accessing remote memory would cause a measurable performance
+reduction.  The page allocator will take additional actions before
+allocating off node pages.
 
 Allowing zone reclaim to write out pages stops processes that are
 writing large amounts of data from dirtying pages on other nodes. Zone
_
