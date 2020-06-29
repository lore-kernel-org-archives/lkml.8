Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0208C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6902078D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgF2Xsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:48:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:11691 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgF2Xsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:48:36 -0400
IronPort-SDR: NARoCczc+1EEaPgWaesHpuehkla4kN/ikw1ekRbOaulrWvBpo116gfzPFRlOuVTQbWN7owpytM
 yVF3lF6QDLJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="211173260"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="211173260"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:48:34 -0700
IronPort-SDR: cSvOxbCWprVWDC9jeINzlhUbJCerkYsavNkCk9Uq9WEwYZfOjAVF34iAZDqm10x7jxTHjulg67
 rR543a07qo2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="355607603"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 29 Jun 2020 16:48:34 -0700
Subject: [RFC][PATCH 4/8] mm/vmscan: add page demotion counter
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 29 Jun 2020 16:45:10 -0700
References: <20200629234503.749E5340@viggo.jf.intel.com>
In-Reply-To: <20200629234503.749E5340@viggo.jf.intel.com>
Message-Id: <20200629234510.1BF23254@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Yang Shi <yang.shi@linux.alibaba.com>

Account the number of demoted pages into reclaim_state->nr_demoted.

Add pgdemote_kswapd and pgdemote_direct VM counters showed in
/proc/vmstat.

[ daveh:
   - __count_vm_events() a bit, and made them look at the THP
     size directly rather than getting data from migrate_pages()
]

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---

 b/include/linux/vm_event_item.h |    2 ++
 b/mm/migrate.c                  |   13 ++++++++++++-
 b/mm/vmscan.c                   |    1 +
 b/mm/vmstat.c                   |    2 ++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff -puN include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter include/linux/vm_event_item.h
--- a/include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter	2020-06-29 16:34:40.332312601 -0700
+++ b/include/linux/vm_event_item.h	2020-06-29 16:34:40.342312601 -0700
@@ -32,6 +32,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PS
 		PGREFILL,
 		PGSTEAL_KSWAPD,
 		PGSTEAL_DIRECT,
+		PGDEMOTE_KSWAPD,
+		PGDEMOTE_DIRECT,
 		PGSCAN_KSWAPD,
 		PGSCAN_DIRECT,
 		PGSCAN_DIRECT_THROTTLE,
diff -puN mm/migrate.c~mm-vmscan-add-page-demotion-counter mm/migrate.c
--- a/mm/migrate.c~mm-vmscan-add-page-demotion-counter	2020-06-29 16:34:40.334312601 -0700
+++ b/mm/migrate.c	2020-06-29 16:34:40.343312601 -0700
@@ -1187,6 +1187,7 @@ static struct page *alloc_demote_node_pa
 int migrate_demote_mapping(struct page *page)
 {
 	int next_nid = next_demotion_node(page_to_nid(page));
+	int ret;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageHuge(page), page);
@@ -1198,8 +1199,18 @@ int migrate_demote_mapping(struct page *
 		return -ENOMEM;
 
 	/* MIGRATE_ASYNC is the most light weight and never blocks.*/
-	return __unmap_and_move(alloc_demote_node_page, NULL, next_nid,
+	ret = __unmap_and_move(alloc_demote_node_page, NULL, next_nid,
 				page, MIGRATE_ASYNC, MR_DEMOTION);
+
+	if (ret == MIGRATEPAGE_SUCCESS) {
+		int nr_demoted = hpage_nr_pages(page);
+		if (current_is_kswapd())
+			__count_vm_events(PGDEMOTE_KSWAPD, nr_demoted);
+		else
+			__count_vm_events(PGDEMOTE_DIRECT, nr_demoted);
+	}
+
+	return ret;
 }
 
 
diff -puN mm/vmscan.c~mm-vmscan-add-page-demotion-counter mm/vmscan.c
--- a/mm/vmscan.c~mm-vmscan-add-page-demotion-counter	2020-06-29 16:34:40.336312601 -0700
+++ b/mm/vmscan.c	2020-06-29 16:34:40.344312601 -0700
@@ -140,6 +140,7 @@ struct scan_control {
 		unsigned int immediate;
 		unsigned int file_taken;
 		unsigned int taken;
+		unsigned int demoted;
 	} nr;
 
 	/* for recording the reclaimed slab by now */
diff -puN mm/vmstat.c~mm-vmscan-add-page-demotion-counter mm/vmstat.c
--- a/mm/vmstat.c~mm-vmscan-add-page-demotion-counter	2020-06-29 16:34:40.339312601 -0700
+++ b/mm/vmstat.c	2020-06-29 16:34:40.345312601 -0700
@@ -1198,6 +1198,8 @@ const char * const vmstat_text[] = {
 	"pgrefill",
 	"pgsteal_kswapd",
 	"pgsteal_direct",
+	"pgdemote_kswapd",
+	"pgdemote_direct",
 	"pgscan_kswapd",
 	"pgscan_direct",
 	"pgscan_direct_throttle",
_
