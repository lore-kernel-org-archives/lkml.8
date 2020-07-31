Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95452C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC3522D0B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHNMfYZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733208AbgGaMVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733200AbgGaMVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:21:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEC3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id c6so7213112pje.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OHzHoMnONnHgmQ6oS0LXj3evSeIK3rt+KuGRMSo863I=;
        b=RHNMfYZ7INmvkYdK1PdCI83KRYWH7DdU877VsMEzOud/rM+KMNB3vlyrgAbZ47hy9O
         LC9If1zMOiN7LX+uDhik8mYzZuJZePDM7vEdxrjzrkdsa010IKdYKoY8TdLW6K22l9+w
         MEc4nA5npneen3+FBqq0bFjnsF0SPCLBeHc22GwMp6nrvw39+Jad3UGOgAFsKULfXfnM
         EsWYACTOAhNQoXalpeK25eyYGlJDRLTlpQvLWYv0+6JjbkIlHJcnBpuDKdQlVe+9XC0p
         Sfdt8nfotLAOuyPujBdsjpHBTNekqBqqH6nV1gBDgyKmAbi2qqlw28pXQ7tIjBgVopII
         f//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OHzHoMnONnHgmQ6oS0LXj3evSeIK3rt+KuGRMSo863I=;
        b=mA8PdACQsjp0ZLuWpO6YlKrcLtXIk2P0mkJc5vZpHakrJEdJYfJY9YCAOaqbRjcv3D
         5b59/QtpkdTNmIcr/WIi1pNCtzSNATa08F7PSEqMadHUm5qCsdXvlB4nF6tNgV3UT1DJ
         Swemwnjxqs7QzecOKEnBJevdsG++SU2MMYbG8mpVQUvaq8pgXPKuApZhquGqIP2rCG92
         lgxGthEbd5IzwHmadFKyaEVkCTax1NfasMKvJi7+bjU53kBvrg///W6beJSGri7npqnx
         iyE3KpWYkVgALWLajd2Y7aQtyHhXlL8zVXGItDI9vy+H7EcyfoTZqeLmI4tdYQEx6B6R
         jANA==
X-Gm-Message-State: AOAM532sOV6y54If6S6HHWkUEZjKU7wneCXnZtmt3wqmC4t7b/FisKZY
        i2UQDb5qk+COg6wBnZ9h1A==
X-Google-Smtp-Source: ABdhPJwYRz5kod3XCHjDVlzL6HDrI8a37sXmIaPl37+kb2V1Wyjx3zKLSM3wYhzIoZfP/orj4c6xXg==
X-Received: by 2002:a63:531e:: with SMTP id h30mr3328177pgb.165.1596198099672;
        Fri, 31 Jul 2020 05:21:39 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:21:39 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/16] mm,hwpoison: Kill put_hwpoison_page
Date:   Fri, 31 Jul 2020 12:21:03 +0000
Message-Id: <20200731122112.11263-8-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

After commit 4e41a30c6d50 ("mm: hwpoison: adjust for new thp refcounting"),
put_hwpoison_page got reduced to a put_page.
Let us just use put_page instead.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/mm.h  |  1 -
 mm/memory-failure.c | 30 +++++++++++++++---------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/mm.h v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/mm.h
index 8f742373a46a..371970dfffc4 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/mm.h
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/mm.h
@@ -2985,7 +2985,6 @@ extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
-#define put_hwpoison_page(page)	put_page(page)
 extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index 405c9bef6ffb..6853bf3a253d 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
@@ -1144,7 +1144,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 		pr_err("Memory failure: %#lx: just unpoisoned\n", pfn);
 		num_poisoned_pages_dec();
 		unlock_page(head);
-		put_hwpoison_page(head);
+		put_page(head);
 		return 0;
 	}
 
@@ -1336,7 +1336,7 @@ int memory_failure(unsigned long pfn, int flags)
 					pfn);
 			if (TestClearPageHWPoison(p))
 				num_poisoned_pages_dec();
-			put_hwpoison_page(p);
+			put_page(p);
 			return -EBUSY;
 		}
 		unlock_page(p);
@@ -1389,14 +1389,14 @@ int memory_failure(unsigned long pfn, int flags)
 		pr_err("Memory failure: %#lx: just unpoisoned\n", pfn);
 		num_poisoned_pages_dec();
 		unlock_page(p);
-		put_hwpoison_page(p);
+		put_page(p);
 		return 0;
 	}
 	if (hwpoison_filter(p)) {
 		if (TestClearPageHWPoison(p))
 			num_poisoned_pages_dec();
 		unlock_page(p);
-		put_hwpoison_page(p);
+		put_page(p);
 		return 0;
 	}
 
@@ -1630,9 +1630,9 @@ int unpoison_memory(unsigned long pfn)
 	}
 	unlock_page(page);
 
-	put_hwpoison_page(page);
+	put_page(page);
 	if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1))
-		put_hwpoison_page(page);
+		put_page(page);
 
 	return 0;
 }
@@ -1683,7 +1683,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 		/*
 		 * Try to free it.
 		 */
-		put_hwpoison_page(page);
+		put_page(page);
 		shake_page(page, 1);
 
 		/*
@@ -1692,7 +1692,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 		ret = __get_any_page(page, pfn, 0);
 		if (ret == 1 && !PageLRU(page)) {
 			/* Drop page reference which is from __get_any_page() */
-			put_hwpoison_page(page);
+			put_page(page);
 			pr_info("soft_offline: %#lx: unknown non LRU page type %lx (%pGp)\n",
 				pfn, page->flags, &page->flags);
 			return -EIO;
@@ -1715,7 +1715,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 	lock_page(hpage);
 	if (PageHWPoison(hpage)) {
 		unlock_page(hpage);
-		put_hwpoison_page(hpage);
+		put_page(hpage);
 		pr_info("soft offline: %#lx hugepage already poisoned\n", pfn);
 		return -EBUSY;
 	}
@@ -1726,7 +1726,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 	 * get_any_page() and isolate_huge_page() takes a refcount each,
 	 * so need to drop one here.
 	 */
-	put_hwpoison_page(hpage);
+	put_page(hpage);
 	if (!ret) {
 		pr_info("soft offline: %#lx hugepage failed to isolate\n", pfn);
 		return -EBUSY;
@@ -1779,7 +1779,7 @@ static int __soft_offline_page(struct page *page, int flags)
 	wait_on_page_writeback(page);
 	if (PageHWPoison(page)) {
 		unlock_page(page);
-		put_hwpoison_page(page);
+		put_page(page);
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
 		return -EBUSY;
 	}
@@ -1794,7 +1794,7 @@ static int __soft_offline_page(struct page *page, int flags)
 	 * would need to fix isolation locking first.
 	 */
 	if (ret == 1) {
-		put_hwpoison_page(page);
+		put_page(page);
 		pr_info("soft_offline: %#lx: invalidated\n", pfn);
 		SetPageHWPoison(page);
 		num_poisoned_pages_inc();
@@ -1814,7 +1814,7 @@ static int __soft_offline_page(struct page *page, int flags)
 	 * Drop page reference which is came from get_any_page()
 	 * successful isolate_lru_page() already took another one.
 	 */
-	put_hwpoison_page(page);
+	put_page(page);
 	if (!ret) {
 		LIST_HEAD(pagelist);
 		/*
@@ -1858,7 +1858,7 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 				pr_info("soft offline: %#lx: non anonymous thp\n", page_to_pfn(page));
 			else
 				pr_info("soft offline: %#lx: thp split failed\n", page_to_pfn(page));
-			put_hwpoison_page(page);
+			put_page(page);
 			return -EBUSY;
 		}
 		unlock_page(page);
@@ -1931,7 +1931,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 	if (PageHWPoison(page)) {
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
 		if (flags & MF_COUNT_INCREASED)
-			put_hwpoison_page(page);
+			put_page(page);
 		return -EBUSY;
 	}
 
-- 
2.17.1

