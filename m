Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D5FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FC820760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbgGAPaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:30:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:50999 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731999AbgGAP36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:29:58 -0400
IronPort-SDR: CXPyJREHJuFWJlytuaOLl0nGFaPObY52Ja0eXmtQZEqEllEtwltZlBnx+mWBSGr8KvZt8EzIg4
 LJ7dgdUtO2/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="164629248"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="164629248"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 08:29:57 -0700
IronPort-SDR: Ismp2V6GfaWh0PhhqHlR4SeVuXkAW4a/LP+kKW3DVQREFdbuUd2Hp5TEkyqyIQX6x+Db6tT6Ow
 M3O+yVRDHeqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="312726341"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga008.jf.intel.com with ESMTP; 01 Jul 2020 08:29:57 -0700
Subject: [PATCH 3/3] mm/vmscan: replace implicit RECLAIM_ZONE checks with explicit checks
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        ben.widawsky@intel.com, alex.shi@linux.alibaba.com,
        dwagner@suse.de, tobin@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 01 Jul 2020 08:26:27 -0700
References: <20200701152621.D520E62B@viggo.jf.intel.com>
In-Reply-To: <20200701152621.D520E62B@viggo.jf.intel.com>
Message-Id: <20200701152627.8761147E@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

RECLAIM_ZONE was assumed to be unused because it was never explicitly
used in the kernel.  However, there were a number of places where it
was checked implicitly by checking 'node_reclaim_mode' for a zero
value.

These zero checks are not great because it is not obvious what a zero
mode *means* in the code.  Replace them with a helper which makes it
more obvious: node_reclaim_enabled().

This helper also provides a handy place to explicitly check the
RECLAIM_ZONE bit itself.  Check it explicitly there to make it more
obvious where the bit can affect behavior.

This should have no functional impact.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: "Tobin C. Harding" <tobin@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Daniel Wagner <dwagner@suse.de>

--

Note: This is not cc'd to stable.  It does not fix any bugs.
---

 b/include/linux/swap.h |    7 +++++++
 b/mm/khugepaged.c      |    2 +-
 b/mm/page_alloc.c      |    2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff -puN include/linux/swap.h~mm-vmscan-node_reclaim_mode_helper include/linux/swap.h
--- a/include/linux/swap.h~mm-vmscan-node_reclaim_mode_helper	2020-07-01 08:22:13.650955330 -0700
+++ b/include/linux/swap.h	2020-07-01 08:22:13.659955330 -0700
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/atomic.h>
 #include <linux/page-flags.h>
+#include <uapi/linux/mempolicy.h>
 #include <asm/page.h>
 
 struct notifier_block;
@@ -374,6 +375,12 @@ extern int sysctl_min_slab_ratio;
 #define node_reclaim_mode 0
 #endif
 
+static inline bool node_reclaim_enabled(void)
+{
+	/* Is any node_reclaim_mode bit set? */
+	return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
+}
+
 extern void check_move_unevictable_pages(struct pagevec *pvec);
 
 extern int kswapd_run(int nid);
diff -puN mm/khugepaged.c~mm-vmscan-node_reclaim_mode_helper mm/khugepaged.c
--- a/mm/khugepaged.c~mm-vmscan-node_reclaim_mode_helper	2020-07-01 08:22:13.652955330 -0700
+++ b/mm/khugepaged.c	2020-07-01 08:22:13.660955330 -0700
@@ -709,7 +709,7 @@ static bool khugepaged_scan_abort(int ni
 	 * If node_reclaim_mode is disabled, then no extra effort is made to
 	 * allocate memory locally.
 	 */
-	if (!node_reclaim_mode)
+	if (!node_reclaim_enabled())
 		return false;
 
 	/* If there is a count for this node already, it must be acceptable */
diff -puN mm/page_alloc.c~mm-vmscan-node_reclaim_mode_helper mm/page_alloc.c
--- a/mm/page_alloc.c~mm-vmscan-node_reclaim_mode_helper	2020-07-01 08:22:13.655955330 -0700
+++ b/mm/page_alloc.c	2020-07-01 08:22:13.662955330 -0700
@@ -3733,7 +3733,7 @@ retry:
 			if (alloc_flags & ALLOC_NO_WATERMARKS)
 				goto try_this_zone;
 
-			if (node_reclaim_mode == 0 ||
+			if (!node_reclaim_enabled() ||
 			    !zone_allows_reclaim(ac->preferred_zoneref->zone, zone))
 				continue;
 
_
