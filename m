Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A0CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33F22086A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgHRSso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:48:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:14589 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgHRSsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:48:19 -0400
IronPort-SDR: JBoku43r4y0hL67kjFJ8aoDxMdMDspJ3vlt5+q9/Wjmxx1EoQ/34YemrITD+KV6UZ+4897g/sZ
 /Excz9XrX97Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="135055393"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="135055393"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 11:48:17 -0700
IronPort-SDR: d9q7J56+mG8EgqUnr2U/NM5hDKU/yMWTOkNCzvdZpgk0jd5aMDCnwhQvMa4pv0ALFBT7Kr3nfW
 hMd5Ncc2rAqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="497466957"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2020 11:48:17 -0700
Subject: [RFC][PATCH 9/9] mm/migrate: new zone_reclaim_mode to enable reclaim migration
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 18 Aug 2020 11:41:38 -0700
References: <20200818184122.29C415DF@viggo.jf.intel.com>
In-Reply-To: <20200818184122.29C415DF@viggo.jf.intel.com>
Message-Id: <20200818184138.1325BE39@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Some method is obviously needed to enable reclaim-based migration.

Just like traditional autonuma, there will be some workloads that
will benefit like workloads with more "static" configurations where
hot pages stay hot and cold pages stay cold.  If pages come and go
from the hot and cold sets, the benefits of this approach will be
more limited.

The benefits are truly workload-based and *not* hardware-based.
We do not believe that there is a viable threshold where certain
hardware configurations should have this mechanism enabled while
others do not.

To be conservative, earlier work defaulted to disable reclaim-
based migration and did not include a mechanism to enable it.
This propses extending the existing "zone_reclaim_mode" (now
now really node_reclaim_mode) as a method to enable it.

We are open to any alternative that allows end users to enable
this mechanism or disable it it workload harm is detected (just
like traditional autonuma).

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---

 b/Documentation/admin-guide/sysctl/vm.rst |    9 +++++++++
 b/include/linux/swap.h                    |    3 ++-
 b/include/uapi/linux/mempolicy.h          |    1 +
 b/mm/vmscan.c                             |    6 ++++--
 4 files changed, 16 insertions(+), 3 deletions(-)

diff -puN Documentation/admin-guide/sysctl/vm.rst~RECLAIM_MIGRATE Documentation/admin-guide/sysctl/vm.rst
--- a/Documentation/admin-guide/sysctl/vm.rst~RECLAIM_MIGRATE	2020-08-18 11:36:57.516583167 -0700
+++ b/Documentation/admin-guide/sysctl/vm.rst	2020-08-18 11:36:57.527583167 -0700
@@ -954,6 +954,7 @@ This is value OR'ed together of
 1	Zone reclaim on
 2	Zone reclaim writes dirty pages out
 4	Zone reclaim swaps pages
+8	Zone reclaim migrates pages
 =	===================================
 
 zone_reclaim_mode is disabled by default.  For file servers or workloads
@@ -978,3 +979,11 @@ of other processes running on other node
 Allowing regular swap effectively restricts allocations to the local
 node unless explicitly overridden by memory policies or cpuset
 configurations.
+
+Page migration during reclaim is intended for systems with tiered memory
+configurations.  These systems have multiple types of memory with varied
+performance characteristics instead of plain NUMA systems where the same
+kind of memory is found at varied distances.  Allowing page migration
+during reclaim enables these systems to migrate pages from fast tiers to
+slow tiers when the fast tier is under pressure.  This migration is
+performed before swap.
diff -puN include/linux/swap.h~RECLAIM_MIGRATE include/linux/swap.h
--- a/include/linux/swap.h~RECLAIM_MIGRATE	2020-08-18 11:36:57.518583167 -0700
+++ b/include/linux/swap.h	2020-08-18 11:36:57.527583167 -0700
@@ -387,7 +387,8 @@ extern int sysctl_min_slab_ratio;
 static inline bool node_reclaim_enabled(void)
 {
 	/* Is any node_reclaim_mode bit set? */
-	return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
+	return node_reclaim_mode & (RECLAIM_ZONE |RECLAIM_WRITE|
+				    RECLAIM_UNMAP|RECLAIM_MIGRATE);
 }
 
 extern void check_move_unevictable_pages(struct pagevec *pvec);
diff -puN include/uapi/linux/mempolicy.h~RECLAIM_MIGRATE include/uapi/linux/mempolicy.h
--- a/include/uapi/linux/mempolicy.h~RECLAIM_MIGRATE	2020-08-18 11:36:57.520583167 -0700
+++ b/include/uapi/linux/mempolicy.h	2020-08-18 11:36:57.527583167 -0700
@@ -69,5 +69,6 @@ enum {
 #define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
 #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
 #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
+#define RECLAIM_MIGRATE	(1<<3)	/* Migrate to other nodes during reclaim */
 
 #endif /* _UAPI_LINUX_MEMPOLICY_H */
diff -puN mm/vmscan.c~RECLAIM_MIGRATE mm/vmscan.c
--- a/mm/vmscan.c~RECLAIM_MIGRATE	2020-08-18 11:36:57.522583167 -0700
+++ b/mm/vmscan.c	2020-08-18 11:36:57.528583167 -0700
@@ -1083,6 +1083,9 @@ bool migrate_demote_page_ok(struct page
 	VM_BUG_ON_PAGE(PageHuge(page), page);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
+	if (!(node_reclaim_mode & RECLAIM_MIGRATE))
+		return false;
+
 	/* It is pointless to do demotion in memcg reclaim */
 	if (cgroup_reclaim(sc))
 		return false;
@@ -1092,8 +1095,7 @@ bool migrate_demote_page_ok(struct page
 	if (PageTransHuge(page) && !thp_migration_supported())
 		return false;
 
-	// FIXME: actually enable this later in the series
-	return false;
+	return true;
 }
 
 
_
