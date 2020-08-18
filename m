Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A53C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E886C206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHRSsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:48:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:63808 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgHRSsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:48:23 -0400
IronPort-SDR: qTNauo3aHQQWb+GSeW7FoTOb57VGJK/FrWzxdT/d+PQ/J3sTRU97fomufnhKHDT+NkyBKkllGw
 x3vpli/6q+zQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="154248727"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="154248727"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 11:48:12 -0700
IronPort-SDR: E3z3vf0Z4vbvVsBQMVjaZaN2jjLqkEHo5YC8ail0B+oqzSlxQSMCG1EyRfkjUE4nbeZX4nUhJF
 G45EqyKAZ3aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="370983342"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2020 11:48:11 -0700
Subject: [RFC][PATCH 6/9] mm/vmscan: add page demotion counter
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 18 Aug 2020 11:41:33 -0700
References: <20200818184122.29C415DF@viggo.jf.intel.com>
In-Reply-To: <20200818184122.29C415DF@viggo.jf.intel.com>
Message-Id: <20200818184133.DCF58B5F@viggo.jf.intel.com>
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
 b/mm/vmscan.c                   |    6 ++++++
 b/mm/vmstat.c                   |    2 ++
 3 files changed, 10 insertions(+)

diff -puN include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter include/linux/vm_event_item.h
--- a/include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter	2020-08-18 11:36:54.062583176 -0700
+++ b/include/linux/vm_event_item.h	2020-08-18 11:36:54.070583176 -0700
@@ -32,6 +32,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PS
 		PGREFILL,
 		PGSTEAL_KSWAPD,
 		PGSTEAL_DIRECT,
+		PGDEMOTE_KSWAPD,
+		PGDEMOTE_DIRECT,
 		PGSCAN_KSWAPD,
 		PGSCAN_DIRECT,
 		PGSCAN_DIRECT_THROTTLE,
diff -puN mm/vmscan.c~mm-vmscan-add-page-demotion-counter mm/vmscan.c
--- a/mm/vmscan.c~mm-vmscan-add-page-demotion-counter	2020-08-18 11:36:54.064583176 -0700
+++ b/mm/vmscan.c	2020-08-18 11:36:54.072583176 -0700
@@ -147,6 +147,7 @@ struct scan_control {
 		unsigned int immediate;
 		unsigned int file_taken;
 		unsigned int taken;
+		unsigned int demoted;
 	} nr;
 
 	/* for recording the reclaimed slab by now */
@@ -1146,6 +1147,11 @@ static unsigned int demote_page_list(str
 		list_splice(ret_list, demote_pages);
 	}
 
+	if (current_is_kswapd())
+		__count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
+	else
+		__count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
+
 	return nr_succeeded;
 }
 
diff -puN mm/vmstat.c~mm-vmscan-add-page-demotion-counter mm/vmstat.c
--- a/mm/vmstat.c~mm-vmscan-add-page-demotion-counter	2020-08-18 11:36:54.067583176 -0700
+++ b/mm/vmstat.c	2020-08-18 11:36:54.072583176 -0700
@@ -1200,6 +1200,8 @@ const char * const vmstat_text[] = {
 	"pgrefill",
 	"pgsteal_kswapd",
 	"pgsteal_direct",
+	"pgdemote_kswapd",
+	"pgdemote_direct",
 	"pgscan_kswapd",
 	"pgscan_direct",
 	"pgscan_direct_throttle",
_
