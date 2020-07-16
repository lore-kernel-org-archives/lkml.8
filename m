Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F03C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DFE207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgGPMiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:38:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:36176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728813AbgGPMii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:38:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51871B945;
        Thu, 16 Jul 2020 12:38:40 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, linux-mm@kvack.org, mike.kravetz@oracle.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Oscar Salvador <osalvador@suse.com>
Subject: [PATCH v4 14/15] mm,hwpoison: Return 0 if the page is already poisoned in soft-offline
Date:   Thu, 16 Jul 2020 14:38:08 +0200
Message-Id: <20200716123810.25292-15-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200716123810.25292-1-osalvador@suse.de>
References: <20200716123810.25292-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is an inconsistency when calling soft-offline from
different paths on a page that is already poisoned.

1) madvise:

        madvise_inject_error skips any poisoned page and continues
        the loop.
        If that was the only page to madvise, it returns 0.

2) /sys/devices/system/memory/:

        When calling soft_offline_page_store()->soft_offline_page(),
        we return -EBUSY in case the page is already poisoned.
        This is inconsistent with a) the above example and b)
        memory_failure, where we return 0 if the page was poisoned.

Fix this by dropping the PageHWPoison() check in madvise_inject_error,
and let soft_offline_page return 0 if it finds the page already poisoned.

Please, note that this represents a user-api change, since now the
return error when calling soft_offline_page_store()->soft_offline_page()
will be different.

Signed-off-by: Oscar Salvador <osalvador@suse.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/madvise.c        | 3 ---
 mm/memory-failure.c | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 226f0fcf0828..7b5ca96108cd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -920,9 +920,6 @@ static int madvise_inject_error(int behavior,
 		 */
 		put_page(page);
 
-		if (PageHWPoison(page))
-			continue;
-
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c6c83337708a..2b2aa5a76b9b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1781,7 +1781,7 @@ static int __soft_offline_page(struct page *page)
 		unlock_page(page);
 		put_page(page);
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-		return -EBUSY;
+		return 0;
 	}
 
 	if (!PageHuge(page))
@@ -1881,7 +1881,7 @@ int soft_offline_page(unsigned long pfn)
 
 	if (PageHWPoison(page)) {
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-		return -EBUSY;
+		return 0;
 	}
 
 	get_online_mems();
-- 
2.26.2

