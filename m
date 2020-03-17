Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609D9C3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 05:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC9E20719
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 05:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q89VZ2uY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgCQFmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 01:42:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45181 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgCQFmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 01:42:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id 2so11288206pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 22:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hBrLYM/9uSi8g6nS8B9WyEA1pqMc4um2i31vSUqKF2g=;
        b=q89VZ2uYKKe19l5rCRXrShPP5RiP1MJHJHV0KSTl07nWZgFKgftWALM37jlBDm0IGy
         Qk1NYDRsVuW5sJJNxMUklzTakhgNaVXTRr3OK0+oMvVc20aGJWhLUVLgQYJeE4yLYAtt
         gGCBqnM78BK+G16HDjC867AQrTUPC4OUxbmq1nSdlobAEeGYMJr0Ts5/gpGdaAzvxi6j
         nSP0DSa1j7n8zml78FK+x1AKPZuTAObKhHFBLGUCdPNwFZkkSCzjMziGoBcIp6nskZuJ
         bfwqgO8pjZD/WbhYxb3PAWmDn1W0LuIYj686zw+lJQKduTbPJH2hdjsvBfHhNGPdPm8y
         lTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hBrLYM/9uSi8g6nS8B9WyEA1pqMc4um2i31vSUqKF2g=;
        b=Ah9kwH75dkg2uNUpmTAij9QldVdA9kbjwzoVpCS0fDifGQc96nenudZZX2nSF5sOQs
         tLg3sQ6oV2y1tF3Epx6Sqkj9RifgZCySarcBzYyyvdODbq/GuVCbv8n9KsFRJfX9R98x
         vXbP25N5Vcvf+NMd03PvMmGbIJ5HVbWXvpqX003zQZuk8ZYoCVmBNtfbmD3+WTthJQ+m
         06//rGmdc9oxwHTauHlAkzhEBKEFQyVXiNC7fHI9neDmn0L6bjEAZ60uPkxRyvZkpea7
         N6ciBUHaANkjEnYJ74BaKx/cMnAfb5YZ/Si4Db9yi2uxkQMBgXTQ92rHBLpAK/mD0gGz
         d6wA==
X-Gm-Message-State: ANhLgQ1r7U5Zk+dgefRotop047B3hvlgiaAgJN5AOpWKJ1P6QXxfG6RB
        sdeh2OjrzOhDPjitUlXxp9c=
X-Google-Smtp-Source: ADFU+vtEUq+JlJHl4KLR+UHFKo0Q3BULSJ27k2VJssU8yYo5dRYaIQyOptQbOJcPgzKpfCNlczWuMg==
X-Received: by 2002:a65:5688:: with SMTP id v8mr3120660pgs.403.1584423739186;
        Mon, 16 Mar 2020 22:42:19 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id i21sm1141757pgn.5.2020.03.16.22.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 22:42:18 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v3 4/9] mm/swapcache: support to handle the value in swapcache
Date:   Tue, 17 Mar 2020 14:41:52 +0900
Message-Id: <1584423717-3440-5-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Swapcache doesn't handle the value since there is no case using the value.
In the following patch, workingset detection for anonymous page will be
implemented and it stores the value into the swapcache. So, we need to
handle it and this patch implement handling.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/swap.h |  5 +++--
 mm/swap_state.c      | 23 ++++++++++++++++++++---
 mm/vmscan.c          |  2 +-
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 954e13e..0df8b3f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -410,7 +410,8 @@ extern void show_swap_cache_info(void);
 extern int add_to_swap(struct page *page);
 extern int add_to_swap_cache(struct page *, swp_entry_t, gfp_t);
 extern int __add_to_swap_cache(struct page *page, swp_entry_t entry);
-extern void __delete_from_swap_cache(struct page *, swp_entry_t entry);
+extern void __delete_from_swap_cache(struct page *page,
+			swp_entry_t entry, void *shadow);
 extern void delete_from_swap_cache(struct page *);
 extern void free_page_and_swap_cache(struct page *);
 extern void free_pages_and_swap_cache(struct page **, int);
@@ -571,7 +572,7 @@ static inline int add_to_swap_cache(struct page *page, swp_entry_t entry,
 }
 
 static inline void __delete_from_swap_cache(struct page *page,
-							swp_entry_t entry)
+					swp_entry_t entry, void *shadow)
 {
 }
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8e7ce9a..3fbbe45 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -117,6 +117,10 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 	pgoff_t idx = swp_offset(entry);
 	XA_STATE_ORDER(xas, &address_space->i_pages, idx, compound_order(page));
 	unsigned long i, nr = compound_nr(page);
+	unsigned long nrexceptional = 0;
+	void *old;
+
+	xas_set_update(&xas, workingset_update_node);
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageSwapCache(page), page);
@@ -132,10 +136,14 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 			goto unlock;
 		for (i = 0; i < nr; i++) {
 			VM_BUG_ON_PAGE(xas.xa_index != idx + i, page);
+			old = xas_load(&xas);
+			if (xa_is_value(old))
+				nrexceptional++;
 			set_page_private(page + i, entry.val + i);
 			xas_store(&xas, page);
 			xas_next(&xas);
 		}
+		address_space->nrexceptional -= nrexceptional;
 		address_space->nrpages += nr;
 		__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, nr);
 		ADD_CACHE_INFO(add_total, nr);
@@ -155,24 +163,33 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
  * This must be called only on pages that have
  * been verified to be in the swap cache.
  */
-void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
+void __delete_from_swap_cache(struct page *page,
+			swp_entry_t entry, void *shadow)
 {
 	struct address_space *address_space = swap_address_space(entry);
 	int i, nr = hpage_nr_pages(page);
 	pgoff_t idx = swp_offset(entry);
 	XA_STATE(xas, &address_space->i_pages, idx);
 
+	/* Do not apply workingset detection for the hugh page */
+	if (nr > 1)
+		shadow = NULL;
+
+	xas_set_update(&xas, workingset_update_node);
+
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(!PageSwapCache(page), page);
 	VM_BUG_ON_PAGE(PageWriteback(page), page);
 
 	for (i = 0; i < nr; i++) {
-		void *entry = xas_store(&xas, NULL);
+		void *entry = xas_store(&xas, shadow);
 		VM_BUG_ON_PAGE(entry != page, entry);
 		set_page_private(page + i, 0);
 		xas_next(&xas);
 	}
 	ClearPageSwapCache(page);
+	if (shadow)
+		address_space->nrexceptional += nr;
 	address_space->nrpages -= nr;
 	__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, -nr);
 	ADD_CACHE_INFO(del_total, nr);
@@ -247,7 +264,7 @@ void delete_from_swap_cache(struct page *page)
 	struct address_space *address_space = swap_address_space(entry);
 
 	xa_lock_irq(&address_space->i_pages);
-	__delete_from_swap_cache(page, entry);
+	__delete_from_swap_cache(page, entry, NULL);
 	xa_unlock_irq(&address_space->i_pages);
 
 	put_swap_page(page, entry);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0493c25..9871861 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -909,7 +909,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	if (PageSwapCache(page)) {
 		swp_entry_t swap = { .val = page_private(page) };
 		mem_cgroup_swapout(page, swap);
-		__delete_from_swap_cache(page, swap);
+		__delete_from_swap_cache(page, swap, NULL);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 		put_swap_page(page, swap);
 	} else {
-- 
2.7.4

