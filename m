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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7ABC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160A5206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7MoKVKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404219AbgFXPCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404207AbgFXPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:02:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAA0C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so1543809pgb.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jEC53F5SPXIDcc5jWStknbQ9117ExLc2PS78CholLvg=;
        b=G7MoKVKx1VUGb9vnXguZhgBeFJkuKF9NEW8T8jp0k/P1z3BFRRySMLN0qoKTHSBe60
         A2AnZ0JeffOGNpnbnDtlTVMezWm50xKTcBXrIbK4jiiLXXsqkCK9Dica8fq+dc8e9VQ3
         wKsmIOoBbb73v6dLhUP+Y85Gj9AK/vXIReG/iPPBCaFu2vTHHtq4F+9YIZbkoU8HOCd3
         D5k2dMQw0lVRJvH6tfznXyD7/yc2cLpB1AX2fN87E7AjzSaPJbIuod6bz5S/pvC7TKMV
         EDAN48Cv3KLAMFhvQG16KcjQSS5SdHErK7gvNnFFP/Vfhyrvn7ogxDyyZGyD+UE3Ic4B
         ePvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jEC53F5SPXIDcc5jWStknbQ9117ExLc2PS78CholLvg=;
        b=ULRYFBbO6PqLInNEcLKqKNcjCxTehKUjyqRReq/UaMasgaTBEhN1w8DYkz19LS0oHJ
         oVn6cw1MEndNVXBVkk7j/ptls7Iq9i8YLEe/1dE5lrFOG2YKwn0ctEyRfJAsfdCW8UfA
         oA5u1Q6ALTOJWwyqexIHEhHBdOcy8VSNIFSgb/gNuhIeoUbKkHu/mY3sEYlGphPKsfMW
         4ZhgrYkOlnTDPySl3FxiVtvJly7SPwW63tgZcAqlfWuvib7NvboP2vwi99wT77y1CgJA
         Lmm+43LwkGigaiSdb9vSf+MeqHWObbGT+E7PbNClpBV0hVi+9AAsP4lAZrYsBPtDCJpc
         tFNA==
X-Gm-Message-State: AOAM532y56DJXRK1JZGboRG2EPYDYrM9QuzBcq5u7VY+23Hqqdr3d+h3
        72tjE/X73LEDUYakiZBtSg==
X-Google-Smtp-Source: ABdhPJxm+JnjvpU80AoxHh+Had8XftzaYnZAP7GzsXlzh51MZfQygKr75m3W9vBMzEYpKNHFs9KV4Q==
X-Received: by 2002:a62:834c:: with SMTP id h73mr31147208pfe.221.1593010930240;
        Wed, 24 Jun 2020 08:02:10 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:02:09 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/15] mm,hwpoison: remove flag argument from soft offline functions
Date:   Wed, 24 Jun 2020 15:01:31 +0000
Message-Id: <20200624150137.7052-10-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

The argument @flag no longer affects the behavior of soft_offline_page()
and its variants, so let's remove them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/memory.c |  2 +-
 include/linux/mm.h    |  2 +-
 mm/madvise.c          |  2 +-
 mm/memory-failure.c   | 27 +++++++++++++--------------
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git v5.8-rc1-mmots-2020-06-20-21-44/drivers/base/memory.c v5.8-rc1-mmots-2020-06-20-21-44_patched/drivers/base/memory.c
index 2b09b68b9f78..20664f279c99 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/drivers/base/memory.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/drivers/base/memory.c
@@ -463,7 +463,7 @@ static ssize_t soft_offline_page_store(struct device *dev,
 	if (kstrtoull(buf, 0, &pfn) < 0)
 		return -EINVAL;
 	pfn >>= PAGE_SHIFT;
-	ret = soft_offline_page(pfn, 0);
+	ret = soft_offline_page(pfn);
 	return ret == 0 ? count : ret;
 }
 
diff --git v5.8-rc1-mmots-2020-06-20-21-44/include/linux/mm.h v5.8-rc1-mmots-2020-06-20-21-44_patched/include/linux/mm.h
index 229efb3479b1..d708033c50c0 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/include/linux/mm.h
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/include/linux/mm.h
@@ -2998,7 +2998,7 @@ extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
 extern atomic_long_t num_poisoned_pages __read_mostly;
-extern int soft_offline_page(unsigned long pfn, int flags);
+extern int soft_offline_page(unsigned long pfn);
 
 
 /*
diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/madvise.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/madvise.c
index bee1f4ac70d6..2b5080253406 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/madvise.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/madvise.c
@@ -908,7 +908,7 @@ static int madvise_inject_error(int behavior,
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 				pfn, start);
-			ret = soft_offline_page(pfn, 0);
+			ret = soft_offline_page(pfn);
 		} else {
 			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				pfn, start);
diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
index 15b8e7fd94ed..03d3aae77f89 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
@@ -1502,7 +1502,7 @@ static void memory_failure_work_func(struct work_struct *work)
 		if (!gotten)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
-			soft_offline_page(entry.pfn, entry.flags);
+			soft_offline_page(entry.pfn);
 		else
 			memory_failure(entry.pfn, entry.flags);
 	}
@@ -1648,7 +1648,7 @@ static struct page *new_page(struct page *p, unsigned long private)
  * that is not free, and 1 for any other page type.
  * For 1 the page is returned with increased page count, otherwise not.
  */
-static int __get_any_page(struct page *p, unsigned long pfn, int flags)
+static int __get_any_page(struct page *p, unsigned long pfn)
 {
 	int ret;
 
@@ -1675,9 +1675,9 @@ static int __get_any_page(struct page *p, unsigned long pfn, int flags)
 	return ret;
 }
 
-static int get_any_page(struct page *page, unsigned long pfn, int flags)
+static int get_any_page(struct page *page, unsigned long pfn)
 {
-	int ret = __get_any_page(page, pfn, flags);
+	int ret = __get_any_page(page, pfn);
 
 	if (ret == 1 && !PageHuge(page) &&
 	    !PageLRU(page) && !__PageMovable(page)) {
@@ -1690,7 +1690,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 		/*
 		 * Did it turn free?
 		 */
-		ret = __get_any_page(page, pfn, 0);
+		ret = __get_any_page(page, pfn);
 		if (ret == 1 && !PageLRU(page)) {
 			/* Drop page reference which is from __get_any_page() */
 			put_page(page);
@@ -1702,7 +1702,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 	return ret;
 }
 
-static int soft_offline_huge_page(struct page *page, int flags)
+static int soft_offline_huge_page(struct page *page)
 {
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
@@ -1761,7 +1761,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 	return ret;
 }
 
-static int __soft_offline_page(struct page *page, int flags)
+static int __soft_offline_page(struct page *page)
 {
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
@@ -1841,7 +1841,7 @@ static int __soft_offline_page(struct page *page, int flags)
 	return ret;
 }
 
-static int soft_offline_in_use_page(struct page *page, int flags)
+static int soft_offline_in_use_page(struct page *page)
 {
 	int ret;
 	int mt;
@@ -1871,9 +1871,9 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 	mt = get_pageblock_migratetype(page);
 	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 	if (PageHuge(page))
-		ret = soft_offline_huge_page(page, flags);
+		ret = soft_offline_huge_page(page);
 	else
-		ret = __soft_offline_page(page, flags);
+		ret = __soft_offline_page(page);
 	set_pageblock_migratetype(page, mt);
 	return ret;
 }
@@ -1894,7 +1894,6 @@ static int soft_offline_free_page(struct page *page)
 /**
  * soft_offline_page - Soft offline a page.
  * @pfn: pfn to soft-offline
- * @flags: flags. Same as memory_failure().
  *
  * Returns 0 on success, otherwise negated errno.
  *
@@ -1913,7 +1912,7 @@ static int soft_offline_free_page(struct page *page)
  * This is not a 100% solution for all memory, but tries to be
  * ``good enough'' for the majority of memory.
  */
-int soft_offline_page(unsigned long pfn, int flags)
+int soft_offline_page(unsigned long pfn)
 {
 	int ret;
 	struct page *page;
@@ -1931,11 +1930,11 @@ int soft_offline_page(unsigned long pfn, int flags)
 	}
 
 	get_online_mems();
-	ret = get_any_page(page, pfn, flags);
+	ret = get_any_page(page, pfn);
 	put_online_mems();
 
 	if (ret > 0)
-		ret = soft_offline_in_use_page(page, flags);
+		ret = soft_offline_in_use_page(page);
 	else if (ret == 0)
 		ret = soft_offline_free_page(page);
 
-- 
2.17.1

