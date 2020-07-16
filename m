Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA366C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B5220739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgGPMim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:38:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:36074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbgGPMii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:38:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5501B947;
        Thu, 16 Jul 2020 12:38:40 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, linux-mm@kvack.org, mike.kravetz@oracle.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Oscar Salvador <osalvador@suse.com>
Subject: [PATCH v4 15/15] mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
Date:   Thu, 16 Jul 2020 14:38:09 +0200
Message-Id: <20200716123810.25292-16-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200716123810.25292-1-osalvador@suse.de>
References: <20200716123810.25292-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory_failure() is supposed to call action_result() when it handles
a memory error event, but there's one missing case. So let's add it.

I find that include/ras/ras_event.h has some other MF_MSG_* undefined,
so this patch also adds them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.com
---
 include/linux/mm.h      | 1 +
 include/ras/ras_event.h | 3 +++
 mm/memory-failure.c     | 5 ++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f6a45165ec8..678ea25625d7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3046,6 +3046,7 @@ enum mf_action_page_type {
 	MF_MSG_BUDDY,
 	MF_MSG_BUDDY_2ND,
 	MF_MSG_DAX,
+	MF_MSG_UNSPLIT_THP,
 	MF_MSG_UNKNOWN,
 };
 
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 36c5c5e38c1d..0bdbc0d17d2f 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -361,6 +361,7 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_POISONED_HUGE, "huge page already hardware poisoned" )	\
 	EM ( MF_MSG_HUGE, "huge page" )					\
 	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
+	EM ( MF_MSG_NON_PMD_HUGE, "non-pmd-sized huge page" )		\
 	EM ( MF_MSG_UNMAP_FAILED, "unmapping failed page" )		\
 	EM ( MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page" )		\
 	EM ( MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page" )		\
@@ -373,6 +374,8 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_TRUNCATED_LRU, "already truncated LRU page" )	\
 	EM ( MF_MSG_BUDDY, "free buddy page" )				\
 	EM ( MF_MSG_BUDDY_2ND, "free buddy page (2nd try)" )		\
+	EM ( MF_MSG_DAX, "dax page" )					\
+	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
 	EMe ( MF_MSG_UNKNOWN, "unknown page" )
 
 /*
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2b2aa5a76b9b..7359164c3fe9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -569,6 +569,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_BUDDY_2ND]		= "free buddy page (2nd try)",
 	[MF_MSG_DAX]			= "dax page",
+	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -1359,8 +1360,10 @@ int memory_failure(unsigned long pfn, int flags)
 	}
 
 	if (PageTransHuge(hpage)) {
-		if (try_to_split_thp_page(p, "Memory Failure") < 0)
+		if (try_to_split_thp_page(p, "Memory Failure") < 0) {
+			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
 			return -EBUSY;
+		}
 		VM_BUG_ON_PAGE(!page_count(p), p);
 	}
 
-- 
2.26.2

