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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D717C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE6F22B42
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbKje5uI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbgGaMVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733210AbgGaMVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:21:43 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FB5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w17so17217254ply.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LNtUR/zVIQaYBxFfor/p8rzccCbsJTTUqM4Vi3aweCQ=;
        b=sbKje5uIs6vCbwISQGSsY7ywCySYHLZXwGfBBzrrDlpKgZEwgXpkNnojXjn7XLjGP/
         LCVVujswgi1kcKfAHve7pLUcRsbbTqELSBhvEYUW/53GDHRah+nKmDcVdOyNptggcte0
         V3SW4VKwwje/98Hpyg8fTcf8q1o93Sg4eMBrrazVM2rqH79v8HW8x7qrDmwCC+ngDeSS
         ch8A6lSwj//OBO1B2xpREwfP/rmOxj82xg8rBvQQjx7geQJvQS5ZxCFkLL6dW/FCi506
         m/rDix44wr2xoGqudd1ZNDA06C+fNSIJMkkHKMloNYydDjMPuZc2u+LIp64Yuur2h1pA
         RJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LNtUR/zVIQaYBxFfor/p8rzccCbsJTTUqM4Vi3aweCQ=;
        b=sZMFykm1kwSlB/+WYtALHidwhjxQB/gN+NecpX7G7xn3wcpugZzoCbHUiwIPt74aj1
         symhIDlALvT0ex14X+U79FxsxVgfmTmN3K74AGNQy1dTyaTZkBrcfJEyOtsCo3TSc/5e
         pUaJ+61BRv9FDo8gHxkgz/YtKGvj/U0c0sVI2zvpwFQJCfpj7WyUTqdiBTqcq00EE6pk
         zBkKh/y7iWJRe1p4Z1nTQQFf1OLettHx0PLXNw4AupoYAFNTQ2ymJMR8z3cqCkFQNYIm
         tOSixlW4YZJSuxtQxQ3jAPj+AixV2+I1hCMsMUuXG7BWoZvNQqZPtQxAUpgOFnkFl525
         S01Q==
X-Gm-Message-State: AOAM530xXqRF2w1xRrL+QMw8L2nMPt1oOAUgBpwE/f8C4DDExZoA1stb
        Py0lrOaX4Bh3h8h/4XxaHQ==
X-Google-Smtp-Source: ABdhPJxYEpIrkMi6DnA+PXFhpdicTO+XfTlrSG7PPUPUyCZCiyePLqhVJJpOvhq2DRtPaUJItgn1AQ==
X-Received: by 2002:a65:5c43:: with SMTP id v3mr3378625pgr.214.1596198102753;
        Fri, 31 Jul 2020 05:21:42 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:21:42 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/16] mm,hwpoison: remove MF_COUNT_INCREASED
Date:   Fri, 31 Jul 2020 12:21:04 +0000
Message-Id: <20200731122112.11263-9-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
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

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/mm.h v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/mm.h
index 371970dfffc4..c09111e8eac8 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/mm.h
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/mm.h
@@ -2976,10 +2976,9 @@ void register_page_bootmem_memmap(unsigned long section_nr, struct page *map,
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
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index 6853bf3a253d..9768ab5f51ef 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
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
 
@@ -1648,9 +1645,6 @@ static int __get_any_page(struct page *p, unsigned long pfn, int flags)
 {
 	int ret;
 
-	if (flags & MF_COUNT_INCREASED)
-		return 1;
-
 	/*
 	 * When the target page is a free hugepage, just remove it
 	 * from free hugepage list.
@@ -1930,8 +1924,6 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 	if (PageHWPoison(page)) {
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-		if (flags & MF_COUNT_INCREASED)
-			put_page(page);
 		return -EBUSY;
 	}
 
-- 
2.17.1

