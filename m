Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2581FC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04814208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgCKMjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:39:05 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:40463 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729272AbgCKMjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:39:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TsIgzPL_1583930331;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TsIgzPL_1583930331)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 Mar 2020 20:38:59 +0800
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [PATCH v3] mm: fix tick timer stall during deferred page init
Date:   Wed, 11 Mar 2020 20:38:48 +0800
Message-Id: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdatinit' kthread will
initialise the deferred pages with local interrupts disabled. It is
introduced by commit 3a2d7fa8a3d5 ("mm: disable interrupts while
initializing deferred pages").

On machine with NCPUS <= 2, the 'pgdatinit' kthread could be bound to
the boot CPU, which could caused the tick timer long time stall, system
jiffies not be updated in time.

The dmesg shown that:

    [    0.197975] node 0 initialised, 32170688 pages in 1ms

Obviously, 1ms is unreasonable.

Now, fix it by restore in the pending interrupts for every 32*1204 pages
(128MB) initialized, give the chance to update the systemd jiffies.
The reasonable demsg shown likes:

    [    1.069306] node 0 initialised, 32203456 pages in 894ms

Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages").

Co-developed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 mm/page_alloc.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..a3a47845e150 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1763,12 +1763,17 @@ deferred_init_maxorder(u64 *i, struct zone *zone, unsigned long *start_pfn,
 	return nr_pages;
 }
 
+/*
+ * Release the pending interrupts for every TICK_PAGE_COUNT pages.
+ */
+#define TICK_PAGE_COUNT	(32 * 1024)
+
 /* Initialise remaining memory on a node */
 static int __init deferred_init_memmap(void *data)
 {
 	pg_data_t *pgdat = data;
 	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
-	unsigned long spfn = 0, epfn = 0, nr_pages = 0;
+	unsigned long spfn = 0, epfn = 0, nr_pages = 0, prev_nr_pages = 0;
 	unsigned long first_init_pfn, flags;
 	unsigned long start = jiffies;
 	struct zone *zone;
@@ -1779,6 +1784,7 @@ static int __init deferred_init_memmap(void *data)
 	if (!cpumask_empty(cpumask))
 		set_cpus_allowed_ptr(current, cpumask);
 
+again:
 	pgdat_resize_lock(pgdat, &flags);
 	first_init_pfn = pgdat->first_deferred_pfn;
 	if (first_init_pfn == ULONG_MAX) {
@@ -1790,7 +1796,6 @@ static int __init deferred_init_memmap(void *data)
 	/* Sanity check boundaries */
 	BUG_ON(pgdat->first_deferred_pfn < pgdat->node_start_pfn);
 	BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
-	pgdat->first_deferred_pfn = ULONG_MAX;
 
 	/* Only the highest zone is deferred so find it */
 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
@@ -1809,9 +1814,23 @@ static int __init deferred_init_memmap(void *data)
 	 * that we can avoid introducing any issues with the buddy
 	 * allocator.
 	 */
-	while (spfn < epfn)
+	while (spfn < epfn) {
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+		/*
+		 * Release the interrupts for every TICK_PAGE_COUNT pages
+		 * (128MB) to give tick timer the chance to update the
+		 * system jiffies.
+		 */
+		if ((nr_pages - prev_nr_pages) > TICK_PAGE_COUNT) {
+			prev_nr_pages = nr_pages;
+			pgdat->first_deferred_pfn = spfn;
+			pgdat_resize_unlock(pgdat, &flags);
+			goto again;
+		}
+	}
+
 zone_empty:
+	pgdat->first_deferred_pfn = ULONG_MAX;
 	pgdat_resize_unlock(pgdat, &flags);
 
 	/* Sanity check that the next zone really is unpopulated */
-- 
2.24.0.rc2

