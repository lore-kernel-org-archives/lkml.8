Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92079C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF0D2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeREAFiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404208AbgFXPCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404182AbgFXPCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:02:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FA4C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so1556534pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WIp32P5EtOq+fwbI5DTsLYoiz2wHcW1kKrBDwwP58qc=;
        b=QeREAFiEgaNBS4YRTqqFz2rem0RoU+ypFV3pOa3g9stlE+R4D1whcZhBtTL+hNIylf
         WYRaVIXj0M47cSmcdflAEHp7L8cHP9X8MXErtgXs8J3oJ/V9u1Er5qau1FMStlctTE3q
         wAH1VadiOn20gm2EJs2NOGJS0jsv+0zUzh5ntz/sGG+njNrEiPCn1RSw3KRDJ7HHe+wG
         9CJiMNUxUG6eBh1jf3EsZ2hRVpcOjKMI671AQ2YL3PflTWugVTgoLQ9R1NyfDx5CnLtN
         ntvYw/FFqfVGFzQ4bKqQVv+3B6Z/XDAHDk9lF/XyiUF02CIgjL7YcBrotCGSVgul+GAP
         MuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WIp32P5EtOq+fwbI5DTsLYoiz2wHcW1kKrBDwwP58qc=;
        b=E2hUfKTrXL2E3gw3mczT04d094FnlZCxIHZVA2ylLQ+AyTVIUQV7DO7+KCxX0ngC6q
         r3Xvn6QSvkf+uGSbsJx+6m1j9NRWExaQBJv1Al262Pvjcfw4CXO8yNDwnAhQN5dnt8sD
         eWUY3TZHu6UEP/YM/g/xuQsPtLJBtO3wrZU7uT+B/5XwNtkS2lgF2Q4Afv0gJz1HzZwf
         Q3NhlgkU+1AbC633YN+VhvsuJNd+HVJL+fIpbXKPF5Ax3zPVKBR1mz02LduLic1kDsbR
         NN0p70Cuc3I1q/UDkdhePgbirP0HS2CaMFH3Zh38/6JMyOZCrCCpPJESWHp1HISA9pJK
         Uwkg==
X-Gm-Message-State: AOAM530uULXoZ8RyuyaPA9ZtJYBmxKnizwJ1HB51F9BrTVTElIMyGg15
        TW2c7fnlMXjrQ/94rn1YXg==
X-Google-Smtp-Source: ABdhPJxcv5SZFzXZ84c+ThvF5kyNv7fJOWZ9YSNA90GU6F5kZmjIk37nmIyvzofkgL5cHZeJ6WHdOg==
X-Received: by 2002:a62:de84:: with SMTP id h126mr28948688pfg.37.1593010927232;
        Wed, 24 Jun 2020 08:02:07 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:02:06 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/15] mm,hwpoison: remove MF_COUNT_INCREASED
Date:   Wed, 24 Jun 2020 15:01:30 +0000
Message-Id: <20200624150137.7052-9-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Now there's no user of MF_COUNT_INCREASED, so we can safely remove
it from all calling points.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/mm.h  |  7 +++----
 mm/memory-failure.c | 14 +++-----------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git v5.8-rc1-mmots-2020-06-20-21-44/include/linux/mm.h v5.8-rc1-mmots-2020-06-20-21-44_patched/include/linux/mm.h
index c64ffec363b5..229efb3479b1 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/include/linux/mm.h
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/include/linux/mm.h
@@ -2986,10 +2986,9 @@ void register_page_bootmem_memmap(unsigned long section_nr, struct page *map,
 				  unsigned long nr_pages);
 
 enum mf_flags {
-	MF_COUNT_INCREASED = 1 << 0,
-	MF_ACTION_REQUIRED = 1 << 1,
-	MF_MUST_KILL = 1 << 2,
-	MF_SOFT_OFFLINE = 1 << 3,
+	MF_ACTION_REQUIRED = 1 << 0,
+	MF_MUST_KILL = 1 << 1,
+	MF_SOFT_OFFLINE = 1 << 2,
 };
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
index 0b7d9769cf29..15b8e7fd94ed 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
@@ -1118,7 +1118,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 
 	num_poisoned_pages_inc();
 
-	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
+	if (!get_hwpoison_page(p)) {
 		/*
 		 * Check "filter hit" and "race with other subpage."
 		 */
@@ -1314,7 +1314,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * In fact it's dangerous to directly bump up page count from 0,
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
-	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
+	if (!get_hwpoison_page(p)) {
 		if (is_free_buddy_page(p)) {
 			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
 			return 0;
@@ -1354,10 +1354,7 @@ int memory_failure(unsigned long pfn, int flags)
 	shake_page(p, 0);
 	/* shake_page could have turned it free. */
 	if (!PageLRU(p) && is_free_buddy_page(p)) {
-		if (flags & MF_COUNT_INCREASED)
-			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
-		else
-			action_result(pfn, MF_MSG_BUDDY_2ND, MF_DELAYED);
+		action_result(pfn, MF_MSG_BUDDY_2ND, MF_DELAYED);
 		return 0;
 	}
 
@@ -1655,9 +1652,6 @@ static int __get_any_page(struct page *p, unsigned long pfn, int flags)
 {
 	int ret;
 
-	if (flags & MF_COUNT_INCREASED)
-		return 1;
-
 	/*
 	 * When the target page is a free hugepage, just remove it
 	 * from free hugepage list.
@@ -1933,8 +1927,6 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 	if (PageHWPoison(page)) {
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-		if (flags & MF_COUNT_INCREASED)
-			put_page(page);
 		return -EBUSY;
 	}
 
-- 
2.17.1

