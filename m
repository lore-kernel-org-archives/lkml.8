Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A445C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 03:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D76F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 03:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="H7wsE3DH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgATDnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 22:43:03 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:38034 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgATDnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 22:43:03 -0500
Received: by mail-qt1-f182.google.com with SMTP id c24so15859265qtp.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 19:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XE7pI/1UkwxiaUIIDslwmE8c/uvsS/a7QnJibWPUjk8=;
        b=H7wsE3DH2UAfgH9BPwA6nHJQWjTlb8LNVMxYkbYMAnsC8wbtsl3pZeHoW35dNX+9bi
         33wubpQLVkJKWHCbLz/bFfSDh3orrINpBFczmFEm11SFvr/afJyQ8bicdsMeoiGru4RE
         iYWx4dAnHJVeI+ms6wvaAKw6D6k1o5l5Q5WEERKtdd/RPXV3JjY/v3QO4d18ucbtrvWF
         J9LymZQzsTTpp/USsaeq2wkSs2daXQ9UseSP4q17wvqwVulOK6VTDWzfDYI8oqm7byDj
         EA63IysBWbb1PtvN+Ude5aBPW6qR0qrVNvdJm3Mli5NzYRoMHapR4Pz1QjtpO7cuvOGR
         4hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XE7pI/1UkwxiaUIIDslwmE8c/uvsS/a7QnJibWPUjk8=;
        b=os2HGmSuzt9bfvsOO4uSQNMAtttn1VIp5BAHrXTS4Dqk4hjHeNsibveRfluIlifaMZ
         B3QLSmKIgzuwSXrA99mJP0PUkAvUwIxdFpvu//qK7rq9eHQALhWEbUajqgMBGLeGW82m
         lRxDrBRX29XsxCR4b5tYKO/m2enRFD4C2edzciKe2mCMwGrIxkjS1EEQxUlYgFbegyHs
         kf1mLKBHNF/Oa1DmfI+TUb/RBYNT5C+4vuBRVBOIxReMOo8ZNu333zG0Yys1dKFUNdax
         AXnuIxh/ODOwv5tpaY2689THrN9CRovDM+qijd2S5zdZljBBXpEvbt4zC6prPpzWKxaU
         Wgqw==
X-Gm-Message-State: APjAAAXfwWz0QkvrJTrQ1lEEKjvlNwoY8IAZRcPpeNl9eC56/eFPTzrP
        se3pF0Vxq9ihuSk6ziEH7ep3VQSrYQuyaA==
X-Google-Smtp-Source: APXvYqyQZ+NKIh4NSv9lo3s1cdPpbMu7ss6hh5VkYE+4i2Iklpcr0kYCTinu2TAYv431zJaOjuJazg==
X-Received: by 2002:ac8:6f63:: with SMTP id u3mr18756005qtv.39.1579491781901;
        Sun, 19 Jan 2020 19:43:01 -0800 (PST)
Received: from ovpn-121-56.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h32sm17240718qth.2.2020.01.19.19.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jan 2020 19:43:01 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -mm] mm/page_isolation: fix potential warning from user
Date:   Sun, 19 Jan 2020 22:42:52 -0500
Message-Id: <20200120034252.1558-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes sense to call the WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE)
from the offlining path, but should avoid triggering it from userspace,
i.e, from is_mem_section_removable().

While at it, simplify the code a bit by removing an unnecessary jump
label and a local variable, so set_migratetype_isolate() could really
return a bool.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_alloc.c     | 11 ++++-------
 mm/page_isolation.c | 31 ++++++++++++++++++-------------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 621716a25639..3c4eb750a199 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8231,7 +8231,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		if (is_migrate_cma(migratetype))
 			return NULL;
 
-		goto unmovable;
+		return page;
 	}
 
 	for (; iter < pageblock_nr_pages; iter++) {
@@ -8241,7 +8241,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		page = pfn_to_page(pfn + iter);
 
 		if (PageReserved(page))
-			goto unmovable;
+			return page;
 
 		/*
 		 * If the zone is movable and we have ruled out all reserved
@@ -8261,7 +8261,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 			unsigned int skip_pages;
 
 			if (!hugepage_migration_supported(page_hstate(head)))
-				goto unmovable;
+				return page;
 
 			skip_pages = compound_nr(head) - (page - head);
 			iter += skip_pages - 1;
@@ -8303,12 +8303,9 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		 * is set to both of a memory hole page and a _used_ kernel
 		 * page at boot.
 		 */
-		goto unmovable;
+		return page;
 	}
 	return NULL;
-unmovable:
-	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
-	return pfn_to_page(pfn + iter);
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index e70586523ca3..97f673d5fefa 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -15,12 +15,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/page_isolation.h>
 
-static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
+static bool set_migratetype_isolate(struct page *page, int migratetype,
+				    int isol_flags)
 {
-	struct page *unmovable = NULL;
+	struct page *unmovable = ERR_PTR(-EBUSY);
 	struct zone *zone;
 	unsigned long flags;
-	int ret = -EBUSY;
 
 	zone = page_zone(page);
 
@@ -49,21 +49,26 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 									NULL);
 
 		__mod_zone_freepage_state(zone, -nr_pages, mt);
-		ret = 0;
 	}
 
 out:
 	spin_unlock_irqrestore(&zone->lock, flags);
-	if (!ret)
+
+	if (!unmovable) {
 		drain_all_pages(zone);
-	else if ((isol_flags & REPORT_FAILURE) && unmovable)
-		/*
-		 * printk() with zone->lock held will guarantee to trigger a
-		 * lockdep splat, so defer it here.
-		 */
-		dump_page(unmovable, "unmovable page");
-
-	return ret;
+	} else {
+		if (isol_flags & MEMORY_OFFLINE)
+			WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
+
+		if ((isol_flags & REPORT_FAILURE) && !IS_ERR(unmovable))
+			/*
+			 * printk() with zone->lock held will likely trigger a
+			 * lockdep splat, so defer it here.
+			 */
+			dump_page(unmovable, "unmovable page");
+	}
+
+	return !!unmovable;
 }
 
 static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
-- 
2.21.0 (Apple Git-122.2)

