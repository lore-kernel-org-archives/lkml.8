Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06824C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA41206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634929AbgDOGkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:40:25 -0400
Received: from foss.arm.com ([217.140.110.172]:38164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634919AbgDOGkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:40:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F234F101E;
        Tue, 14 Apr 2020 23:40:20 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 049363F73D;
        Tue, 14 Apr 2020 23:44:28 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.com, mark.rutland@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/hotplug: Enumerate memory range offlining failure reasons
Date:   Wed, 15 Apr 2020 12:09:43 +0530
Message-Id: <1586932784-16315-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586932784-16315-1-git-send-email-anshuman.khandual@arm.com>
References: <1586932784-16315-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently just a debug message is shown describing the reason during memory
range offline failure. Even though just sufficient for debugging purpose,
these messages can not be used in registered memory event notifiers that
might be interested in MEM_CANCEL_OFFLINE event and it's possible reasons.

This enumerates all existing memory range offline failure reason codes thus
enabling their further effective utilization. It also adds a new element in
memory notifier structure (void *data) that will carry this offline failure
reason code into all registered notifiers when offlining process fails and
MEM_CANCEL_OFFLINE is triggered.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/base/memory.c  |  9 +++++++++
 include/linux/memory.h | 27 +++++++++++++++++++++++++++
 mm/memory_hotplug.c    | 24 ++++++++++++++++--------
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index dbec3a05590a..2a6d52984803 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -159,6 +159,15 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 
 int memory_notify(unsigned long val, void *v)
 {
+	struct memory_notify *arg = v;
+
+	/*
+	 * arg->data should be available and processed only for
+	 * MEM_CANCEL_OFFLINE event. Drop this warning when it's
+	 * usage goes beyond MEM_CANCEL_OFFLINE.
+	 */
+	WARN_ON((val != MEM_CANCEL_OFFLINE) && arg->data);
+
 	return blocking_notifier_call_chain(&memory_chain, val, v);
 }
 
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 439a89e758d8..7914b0dbd4bb 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -44,12 +44,39 @@ int set_memory_block_size_order(unsigned int order);
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
+	OFFLINE_FAILURE_DISSOLVE,
+};
+
+static const char *const offline_failure_names[] = {
+	[OFFLINE_FAILURE_MEMHOLES]	= "memory holes",
+	[OFFLINE_FAILURE_MULTIZONE]	= "multizone range",
+	[OFFLINE_FAILURE_ISOLATE]	= "failure to isolate range",
+	[OFFLINE_FAILURE_NOTIFIER]	= "notifier failure",
+	[OFFLINE_FAILURE_SIGNAL]	= "signal backoff",
+	[OFFLINE_FAILURE_DISSOLVE]	= "failure to dissolve huge pages",
+};
+
+static inline const char *offline_failure(int reason)
+{
+	return offline_failure_names[reason];
+}
+
 struct memory_notify {
 	unsigned long start_pfn;
 	unsigned long nr_pages;
 	int status_change_nid_normal;
 	int status_change_nid_high;
 	int status_change_nid;
+	void *data;
 };
 
 struct notifier_block;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fc0aad0bc1f5..2b733902dfcf 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -787,6 +787,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 
 	arg.start_pfn = pfn;
 	arg.nr_pages = nr_pages;
+	arg.data = NULL;
 	node_states_check_changes_online(nr_pages, zone, &arg);
 
 	ret = memory_notify(MEM_GOING_ONLINE, &arg);
@@ -1466,7 +1467,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	unsigned long flags;
 	struct zone *zone;
 	struct memory_notify arg;
-	char *reason;
+	enum offline_failure_reason reason;
 
 	mem_hotplug_begin();
 
@@ -1482,7 +1483,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 			      count_system_ram_pages_cb);
 	if (nr_pages != end_pfn - start_pfn) {
 		ret = -EINVAL;
-		reason = "memory holes";
+		reason = OFFLINE_FAILURE_MEMHOLES;
 		goto failed_removal;
 	}
 
@@ -1491,7 +1492,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	zone = test_pages_in_a_zone(start_pfn, end_pfn);
 	if (!zone) {
 		ret = -EINVAL;
-		reason = "multizone range";
+		reason = OFFLINE_FAILURE_MULTIZONE;
 		goto failed_removal;
 	}
 	node = zone_to_nid(zone);
@@ -1501,19 +1502,20 @@ static int __ref __offline_pages(unsigned long start_pfn,
 				       MIGRATE_MOVABLE,
 				       MEMORY_OFFLINE | REPORT_FAILURE);
 	if (ret < 0) {
-		reason = "failure to isolate range";
+		reason = OFFLINE_FAILURE_ISOLATE;
 		goto failed_removal;
 	}
 	nr_isolate_pageblock = ret;
 
 	arg.start_pfn = start_pfn;
 	arg.nr_pages = nr_pages;
+	arg.data = NULL;
 	node_states_check_changes_offline(nr_pages, zone, &arg);
 
 	ret = memory_notify(MEM_GOING_OFFLINE, &arg);
 	ret = notifier_to_errno(ret);
 	if (ret) {
-		reason = "notifier failure";
+		reason = OFFLINE_FAILURE_NOTIFIER;
 		goto failed_removal_isolated;
 	}
 
@@ -1521,7 +1523,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 		for (pfn = start_pfn; pfn;) {
 			if (signal_pending(current)) {
 				ret = -EINTR;
-				reason = "signal backoff";
+				reason = OFFLINE_FAILURE_SIGNAL;
 				goto failed_removal_isolated;
 			}
 
@@ -1545,7 +1547,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
 		 */
 		ret = dissolve_free_huge_pages(start_pfn, end_pfn);
 		if (ret) {
-			reason = "failure to dissolve huge pages";
+			reason = OFFLINE_FAILURE_DISSOLVE;
 			goto failed_removal_isolated;
 		}
 		/* check again */
@@ -1599,12 +1601,18 @@ static int __ref __offline_pages(unsigned long start_pfn,
 
 failed_removal_isolated:
 	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
+
+	/*
+	 * Send the offline failure reason to all registered
+	 * notifiers for MEM_CANCEL_OFFLINE.
+	 */
+	arg.data = &reason;
 	memory_notify(MEM_CANCEL_OFFLINE, &arg);
 failed_removal:
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

