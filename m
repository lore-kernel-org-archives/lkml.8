Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98080C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 04:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8106A2078D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 04:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHREWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 00:22:47 -0400
Received: from foss.arm.com ([217.140.110.172]:36216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgHREWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 00:22:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 583B331B;
        Mon, 17 Aug 2020 21:22:45 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.65.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 123343F6CF;
        Mon, 17 Aug 2020 21:22:42 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hotplug: Enumerate memory range offlining failure reasons
Date:   Tue, 18 Aug 2020 09:52:02 +0530
Message-Id: <1597724522-31545-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a debug message is printed describing the reason for memory range
offline failure. This just enumerates existing reason codes which improves
overall readability and makes it cleaner. This does not add any functional
change.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This is based on 5.9-rc1

 include/linux/memory.h | 28 ++++++++++++++++++++++++++++
 mm/memory_hotplug.c    | 18 +++++++++---------
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index 439a89e758d8..4b52d706edc1 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -44,6 +44,34 @@ int set_memory_block_size_order(unsigned int order);
 #define	MEM_CANCEL_ONLINE	(1<<4)
 #define	MEM_CANCEL_OFFLINE	(1<<5)
 
+/*
+ * Memory offline failure reasons
+ */
+enum offline_failure_reason {
+	OFFLINE_FAILURE_MEMHOLES,
+	OFFLINE_FAILURE_MULTIZONE,
+	OFFLINE_FAILURE_ISOLATE,
+	OFFLINE_FAILURE_NOTIFIER,
+	OFFLINE_FAILURE_SIGNAL,
+	OFFLINE_FAILURE_UNMOVABLE,
+	OFFLINE_FAILURE_DISSOLVE,
+};
+
+static const char *const offline_failure_names[] = {
+	[OFFLINE_FAILURE_MEMHOLES]	= "memory holes",
+	[OFFLINE_FAILURE_MULTIZONE]	= "multizone range",
+	[OFFLINE_FAILURE_ISOLATE]	= "failure to isolate range",
+	[OFFLINE_FAILURE_NOTIFIER]	= "notifier failure",
+	[OFFLINE_FAILURE_SIGNAL]	= "signal backoff",
+	[OFFLINE_FAILURE_UNMOVABLE]	= "unmovable page",
+	[OFFLINE_FAILURE_DISSOLVE]	= "failure to dissolve huge pages",
+};
+
+static inline const char *offline_failure(enum offline_failure_reason reason)
+{
+	return offline_failure_names[reason];
+}
+
 struct memory_notify {
 	unsigned long start_pfn;
 	unsigned long nr_pages;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e9d5ab5d3ca0..b3fa36a09d7f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1484,7 +1484,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	unsigned long flags;
 	struct zone *zone;
 	struct memory_notify arg;
-	char *reason;
+	enum offline_failure_reason reason;
 
 	mem_hotplug_begin();
 
@@ -1500,7 +1500,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 			      count_system_ram_pages_cb);
 	if (nr_pages != end_pfn - start_pfn) {
 		ret = -EINVAL;
-		reason = "memory holes";
+		reason = OFFLINE_FAILURE_MEMHOLES;
 		goto failed_removal;
 	}
 
@@ -1509,7 +1509,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	zone = test_pages_in_a_zone(start_pfn, end_pfn);
 	if (!zone) {
 		ret = -EINVAL;
-		reason = "multizone range";
+		reason = OFFLINE_FAILURE_MULTIZONE;
 		goto failed_removal;
 	}
 	node = zone_to_nid(zone);
@@ -1519,7 +1519,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 				       MIGRATE_MOVABLE,
 				       MEMORY_OFFLINE | REPORT_FAILURE);
 	if (ret < 0) {
-		reason = "failure to isolate range";
+		reason = OFFLINE_FAILURE_ISOLATE;
 		goto failed_removal;
 	}
 	nr_isolate_pageblock = ret;
@@ -1531,7 +1531,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	ret = memory_notify(MEM_GOING_OFFLINE, &arg);
 	ret = notifier_to_errno(ret);
 	if (ret) {
-		reason = "notifier failure";
+		reason = OFFLINE_FAILURE_NOTIFIER;
 		goto failed_removal_isolated;
 	}
 
@@ -1540,7 +1540,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 		do {
 			if (signal_pending(current)) {
 				ret = -EINTR;
-				reason = "signal backoff";
+				reason = OFFLINE_FAILURE_SIGNAL;
 				goto failed_removal_isolated;
 			}
 
@@ -1558,7 +1558,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 		} while (!ret);
 
 		if (ret != -ENOENT) {
-			reason = "unmovable page";
+			reason = OFFLINE_FAILURE_UNMOVABLE;
 			goto failed_removal_isolated;
 		}
 
@@ -1569,7 +1569,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 		 */
 		ret = dissolve_free_huge_pages(start_pfn, end_pfn);
 		if (ret) {
-			reason = "failure to dissolve huge pages";
+			reason = OFFLINE_FAILURE_DISSOLVE;
 			goto failed_removal_isolated;
 		}
 		/* check again */
@@ -1627,7 +1627,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	pr_debug("memory offlining [mem %#010llx-%#010llx] failed due to %s\n",
 		 (unsigned long long) start_pfn << PAGE_SHIFT,
 		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
-		 reason);
+		 offline_failure(reason));
 	/* pushback to free area */
 	mem_hotplug_done();
 	return ret;
-- 
2.20.1

