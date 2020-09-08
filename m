Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839B4C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C1D218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgIHH5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:57:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:53204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbgIHH4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:56:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27D88B72F;
        Tue,  8 Sep 2020 07:56:38 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     naoya.horiguchi@nec.com, mhocko@kernel.org, tony.luck@intel.com,
        cai@lca.pw, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 5/5] mm,hwpoison: Remove stale code
Date:   Tue,  8 Sep 2020 09:56:26 +0200
Message-Id: <20200908075626.11976-6-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200908075626.11976-1-osalvador@suse.de>
References: <20200908075626.11976-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we call shake_page and then check whether the page is
Buddy because shake_page calls drain_all_pages, which sends pcp-pages
back to the buddy freelists, so we could have a chance to handle
free pages.

get_hwpoison_page already calls drain_all_pages, and we do call
get_hwpoison_page right before coming here, so we should be on
the safe side.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e57fc5c5117a..eb72360bd78b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1423,18 +1423,6 @@ int memory_failure(unsigned long pfn, int flags)
 	 * walked by the page reclaim code, however that's not a big loss.
 	 */
 	shake_page(p, 0);
-	/* shake_page could have turned it free. */
-	if (!PageLRU(p) && is_free_buddy_page(p)) {
-		if (!take_page_off_buddy(p))
-			res = -EBUSY;
-
-		if (flags & MF_COUNT_INCREASED)
-			action_result(pfn, MF_MSG_BUDDY, res ? MF_IGNORED : MF_RECOVERED);
-		else
-			action_result(pfn, MF_MSG_BUDDY_2ND, res ? MF_IGNORED : MF_RECOVERED);
-
-		return res;
-	}
 
 	lock_page(p);
 
-- 
2.26.2

