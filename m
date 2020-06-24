Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF12220FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390279AbgFXIDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:03:31 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:62455 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387606AbgFXID3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:03:29 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from build.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 21599198-1500050 
        for multiple; Wed, 24 Jun 2020 09:02:53 +0100
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 1/2] mm/mmu_notifier: Mark up direct reclaim paths with MAYFAIL
Date:   Wed, 24 Jun 2020 09:02:47 +0100
Message-Id: <20200624080248.3701-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When direct reclaim enters the shrinker and tries to reclaim pages, it
has to opportunitically unmap them [try_to_unmap_one]. For direct
reclaim, the calling context is unknown and may include attempts to
unmap one page of a dma object while attempting to allocate more pages
for that object. Pass the information along that we are inside an
opportunistic unmap that can allow that page to remain referenced and
mapped, and let the callback opt in to avoiding a recursive wait.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>
---
 include/linux/mmu_notifier.h | 15 ++++++++++++++-
 mm/mmu_notifier.c            |  3 +++
 mm/rmap.c                    |  5 +++--
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index fc68f3570e19..ee1ad008951c 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -48,7 +48,8 @@ enum mmu_notifier_event {
 	MMU_NOTIFY_RELEASE,
 };
 
-#define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
+#define MMU_NOTIFIER_RANGE_BLOCKABLE	BIT(0)
+#define MMU_NOTIFIER_RANGE_MAYFAIL	BIT(1)
 
 struct mmu_notifier_ops {
 	/*
@@ -169,6 +170,12 @@ struct mmu_notifier_ops {
 	 * a non-blocking behavior then the same applies to
 	 * invalidate_range_end.
 	 *
+	 * If mayfail is set then the callback may return -EAGAIN while still
+	 * holding its page references. This flag is set inside direct
+	 * reclaim paths that are opportunistically trying to unmap pages
+	 * from unknown contexts. The callback must be prepared to handle
+	 * the matching invalidate_range_end even after failing the
+	 * invalidate_range_start.
 	 */
 	int (*invalidate_range_start)(struct mmu_notifier *subscription,
 				      const struct mmu_notifier_range *range);
@@ -397,6 +404,12 @@ mmu_notifier_range_blockable(const struct mmu_notifier_range *range)
 	return (range->flags & MMU_NOTIFIER_RANGE_BLOCKABLE);
 }
 
+static inline bool
+mmu_notifier_range_mayfail(const struct mmu_notifier_range *range)
+{
+	return (range->flags & MMU_NOTIFIER_RANGE_MAYFAIL);
+}
+
 static inline void mmu_notifier_release(struct mm_struct *mm)
 {
 	if (mm_has_notifiers(mm))
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 352bb9f3ecc0..95b89cee7af4 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -493,6 +493,9 @@ static int mn_hlist_invalidate_range_start(
 			_ret = ops->invalidate_range_start(subscription, range);
 			if (!mmu_notifier_range_blockable(range))
 				non_block_end();
+			if (_ret == -EAGAIN &&
+			    mmu_notifier_range_mayfail(range))
+				_ret = 0;
 			if (_ret) {
 				pr_info("%pS callback failed with %d in %sblockable context.\n",
 					ops->invalidate_range_start, _ret,
diff --git a/mm/rmap.c b/mm/rmap.c
index 5fe2dedce1fc..912b737a3353 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1406,8 +1406,9 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	 * Note that the page can not be free in this function as call of
 	 * try_to_unmap() must hold a reference on the page.
 	 */
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
-				address,
+	mmu_notifier_range_init(&range,
+				MMU_NOTIFY_CLEAR, MMU_NOTIFIER_RANGE_MAYFAIL,
+				vma, vma->vm_mm, address,
 				min(vma->vm_end, address + page_size(page)));
 	if (PageHuge(page)) {
 		/*
-- 
2.20.1

