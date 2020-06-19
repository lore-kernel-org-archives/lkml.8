Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CD2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB7F20DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlQfQiVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbgFSNY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:24:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30253 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732763AbgFSNYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592573093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4phBcYIcyCrrYt5CM0C0IxjrUdGZT9FNgwbh9vRJOyc=;
        b=WlQfQiVSV/LtHE+FoIlBA2SpHDwW8dxmE863Q4WdERLJ1+G8fSEIu/OJxUU3xsXUr6jDVu
        OPta24chY1zOtIJ22RsnLd874lGbXDjfWxBxnNGRMTJYxKs/CS6+/raHIlxi1BxDMu4CE2
        VmmnMz5etGEAB/XRnXQghMhEOHE3aZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-pMhfVnzJPDWAG6D3Jeqiqg-1; Fri, 19 Jun 2020 09:24:45 -0400
X-MC-Unique: pMhfVnzJPDWAG6D3Jeqiqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB595101326F;
        Fri, 19 Jun 2020 13:24:18 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-137.ams2.redhat.com [10.36.113.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA32BBE9A;
        Fri, 19 Jun 2020 13:24:16 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 1/2] mm: drop vm_total_pages
Date:   Fri, 19 Jun 2020 15:24:09 +0200
Message-Id: <20200619132410.23859-2-david@redhat.com>
In-Reply-To: <20200619132410.23859-1-david@redhat.com>
References: <20200619132410.23859-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global variable "vm_total_pages" is a relict from older days. There
is only a single user that reads the variable - build_all_zonelists() -
and the first thing it does is updating it. Use a local variable in
build_all_zonelists() instead and drop the local variable.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/swap.h | 1 -
 mm/memory_hotplug.c  | 3 ---
 mm/page-writeback.c  | 6 ++----
 mm/page_alloc.c      | 2 ++
 mm/vmscan.c          | 5 -----
 5 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4c5974bb9ba94..124261acd5d0a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -371,7 +371,6 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 extern unsigned long shrink_all_memory(unsigned long nr_pages);
 extern int vm_swappiness;
 extern int remove_mapping(struct address_space *mapping, struct page *page);
-extern unsigned long vm_total_pages;
 
 extern unsigned long reclaim_pages(struct list_head *page_list);
 #ifdef CONFIG_NUMA
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9b34e03e730a4..d682781cce48d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -835,8 +835,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	kswapd_run(nid);
 	kcompactd_run(nid);
 
-	vm_total_pages = nr_free_pagecache_pages();
-
 	writeback_set_ratelimit();
 
 	memory_notify(MEM_ONLINE, &arg);
@@ -1586,7 +1584,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
 		kcompactd_stop(node);
 	}
 
-	vm_total_pages = nr_free_pagecache_pages();
 	writeback_set_ratelimit();
 
 	memory_notify(MEM_OFFLINE, &arg);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 28b3e7a675657..4e4ddd67b71e5 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2076,13 +2076,11 @@ static int page_writeback_cpu_online(unsigned int cpu)
  * Called early on to tune the page writeback dirty limits.
  *
  * We used to scale dirty pages according to how total memory
- * related to pages that could be allocated for buffers (by
- * comparing nr_free_buffer_pages() to vm_total_pages.
+ * related to pages that could be allocated for buffers.
  *
  * However, that was when we used "dirty_ratio" to scale with
  * all memory, and we don't do that any more. "dirty_ratio"
- * is now applied to total non-HIGHPAGE memory (by subtracting
- * totalhigh_pages from vm_total_pages), and as such we can't
+ * is now applied to total non-HIGHPAGE memory, and as such we can't
  * get into the old insane situation any more where we had
  * large amounts of dirty pages compared to a small amount of
  * non-HIGHMEM memory.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0c435b2ed665c..7b0dde69748c1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5903,6 +5903,8 @@ build_all_zonelists_init(void)
  */
 void __ref build_all_zonelists(pg_data_t *pgdat)
 {
+	unsigned long vm_total_pages;
+
 	if (system_state == SYSTEM_BOOTING) {
 		build_all_zonelists_init();
 	} else {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b6d84326bdf2d..0010859747df2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -170,11 +170,6 @@ struct scan_control {
  * From 0 .. 200.  Higher means more swappy.
  */
 int vm_swappiness = 60;
-/*
- * The total number of pages which are beyond the high watermark within all
- * zones.
- */
-unsigned long vm_total_pages;
 
 static void set_task_reclaim_state(struct task_struct *task,
 				   struct reclaim_state *rs)
-- 
2.26.2

