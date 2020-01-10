Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1B7C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B680320673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbgAJDIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 22:08:49 -0500
Received: from foss.arm.com ([217.140.110.172]:38976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbgAJDIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 22:08:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8D211007;
        Thu,  9 Jan 2020 19:08:48 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.42.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 064CB3F703;
        Thu,  9 Jan 2020 19:08:40 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     mark.rutland@arm.com, david@redhat.com, cai@lca.pw,
        logang@deltatee.com, cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com, steve.capper@arm.com,
        broonie@kernel.org, valentin.schneider@arm.com,
        Robin.Murphy@arm.com, steven.price@arm.com, suzuki.poulose@arm.com,
        ira.weiny@intel.com, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH V11 1/5] mm/hotplug: Introduce arch callback validating the hot remove range
Date:   Fri, 10 Jan 2020 08:39:11 +0530
Message-Id: <1578625755-11792-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578625755-11792-1-git-send-email-anshuman.khandual@arm.com>
References: <1578625755-11792-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are two interfaces to initiate memory range hot removal i.e
remove_memory() and __remove_memory() which then calls try_remove_memory().
Platform gets called with arch_remove_memory() to tear down required kernel
page tables and other arch specific procedures. But there are platforms
like arm64 which might want to prevent removal of certain specific memory
ranges irrespective of their present usage or movability properties.

Current arch call back arch_remove_memory() is too late in the process to
abort memory hot removal as memory block devices and firmware memory map
entries would have already been removed. Platforms should be able to abort
the process before taking the mem_hotplug_lock with mem_hotplug_begin().
This essentially requires a new arch callback for memory range validation.

This differentiates memory range validation between memory hot add and hot
remove paths before carving out a new helper check_hotremove_memory_range()
which incorporates a new arch callback. This call back provides platforms
an opportunity to refuse memory removal at the very onset. In future the
same principle can be extended for memory hot add path if required.

Platforms can choose to override this callback in order to reject specific
memory ranges from removal or can just fallback to a default implementation
which allows removal of all memory ranges.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/memory_hotplug.h |  7 +++++++
 mm/memory_hotplug.c            | 21 ++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index ba0dca6..f661bd5 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -305,6 +305,13 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 
+#ifndef arch_memory_removable
+static inline bool arch_memory_removable(u64 base, u64 size)
+{
+	return true;
+}
+#endif
+
 extern bool is_mem_section_removable(unsigned long pfn, unsigned long nr_pages);
 extern void try_offline_node(int nid);
 extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a91a072..7cdf800 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1014,6 +1014,23 @@ static int check_hotplug_memory_range(u64 start, u64 size)
 	return 0;
 }
 
+static int check_hotremove_memory_range(u64 start, u64 size)
+{
+	int rc;
+
+	BUG_ON(check_hotplug_memory_range(start, size));
+
+	/*
+	 * First check if the platform is willing to have this
+	 * memory range removed else just abort.
+	 */
+	rc = arch_memory_removable(start, size);
+	if (!rc)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int online_memory_block(struct memory_block *mem, void *arg)
 {
 	return device_online(&mem->dev);
@@ -1762,7 +1779,9 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
 {
 	int rc = 0;
 
-	BUG_ON(check_hotplug_memory_range(start, size));
+	rc = check_hotremove_memory_range(start, size);
+	if (rc)
+		return rc;
 
 	mem_hotplug_begin();
 
-- 
2.7.4

