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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0766BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8DD02087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsLxJoNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733231AbgGaMVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733200AbgGaMVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:21:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B20AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:49 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t6so3813919pjr.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xft2h5FohjfWqnBcTKXmA02wYQ8Sl17A7am29j5Mcz4=;
        b=XsLxJoNaCXyJMenZtH47jIDCecoY0NPI+oIT8mRxAwzFTQwvpVYtgrQmDqoCxZQS2j
         OkQkZGa3bB3lohBRuKB4KlRF1cx/nqhc0jF/j4qh/VIokvCJE/16aoZ5M9AZTi0NuXX3
         ZVZOFHbJ9fQLxe5QccT/2LDXZuD33zVxYF4GPW5RRutWLf5Q9SES9ZTablJGOKNbEa0G
         4rfMnwIjlYFSHvnXE10SIrnzcMOPyUJxusBJGs9YEXWBYjVEt0pfqwuMxr4KYzzUtQ3M
         n78Up05OOiIafcJ4Nm6qBQV/6LafOamSVbp03LF4yxx8MKuKXcUS6Bwsjbvhu0uaPTeD
         jhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xft2h5FohjfWqnBcTKXmA02wYQ8Sl17A7am29j5Mcz4=;
        b=IYpJF2OZrnsyfMCPh1WOCKIGdQqOZDbBZXTeHxffprF+OZL8uuziPP039YTUKkjyOP
         Ifc8jCMHACMi7ZRs0PJycWsjq/gsqtkXZLmH98S0YEZ8svpzs6TX+6huJqdP9+aE8Zuo
         SQpYSv1s38e4LUUPDPLYmtLGmNsJqCcOm9Zm/ftztfgClYXIFDstZzU7yo17jlVDp2gU
         bB2+8b30E3iaDkNt06+8Bz3fpEDfbGj6k1pj67KH+YmHUlRUhIJWigxf/W8GUDHONuPG
         ClcsOs8kJpo8uwoUyG51S+/vt/vi9ygPuHpzTVq9pPJ7c4Hk0tJ7Daqs8JwswGEbIgZj
         Q/ew==
X-Gm-Message-State: AOAM532UxgjF2jJrsUhFIMwbq68W6S74rsO8oD1vUIQAU2lHklZ9GmCb
        v/yaplJg7MfDZ1/3NZQ7PQ==
X-Google-Smtp-Source: ABdhPJyyOpZYacooGR5RU61olGUZyx0GrN1JXL6Y1g3Sx4pMqV32qBOed44LN62ckgW/2WaK7H+Lcw==
X-Received: by 2002:a17:90b:4d0f:: with SMTP id mw15mr3787072pjb.174.1596198108893;
        Fri, 31 Jul 2020 05:21:48 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:21:48 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/16] mm,hwpoison: Unify THP handling for hard and soft offline
Date:   Fri, 31 Jul 2020 12:21:06 +0000
Message-Id: <20200731122112.11263-11-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Place the THP's page handling in a helper and use it
from both hard and soft-offline machinery, so we get rid
of some duplicated code.

Signed-off-by: Oscar Salvador <osalvador@suse.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 48 +++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index 7c0a2f8cfe0c..803f4b2ac510 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
@@ -1103,6 +1103,25 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 	return page_action(ps, p, pfn);
 }
 
+static int try_to_split_thp_page(struct page *page, const char *msg)
+{
+	lock_page(page);
+	if (!PageAnon(page) || unlikely(split_huge_page(page))) {
+		unsigned long pfn = page_to_pfn(page);
+
+		unlock_page(page);
+		if (!PageAnon(page))
+			pr_info("%s: %#lx: non anonymous thp\n", msg, pfn);
+		else
+			pr_info("%s: %#lx: thp split failed\n", msg, pfn);
+		put_page(page);
+		return -EBUSY;
+	}
+	unlock_page(page);
+
+	return 0;
+}
+
 static int memory_failure_hugetlb(unsigned long pfn, int flags)
 {
 	struct page *p = pfn_to_page(pfn);
@@ -1325,21 +1344,8 @@ int memory_failure(unsigned long pfn, int flags)
 	}
 
 	if (PageTransHuge(hpage)) {
-		lock_page(p);
-		if (!PageAnon(p) || unlikely(split_huge_page(p))) {
-			unlock_page(p);
-			if (!PageAnon(p))
-				pr_err("Memory failure: %#lx: non anonymous thp\n",
-					pfn);
-			else
-				pr_err("Memory failure: %#lx: thp split failed\n",
-					pfn);
-			if (TestClearPageHWPoison(p))
-				num_poisoned_pages_dec();
-			put_page(p);
+		if (try_to_split_thp_page(p, "Memory Failure") < 0)
 			return -EBUSY;
-		}
-		unlock_page(p);
 		VM_BUG_ON_PAGE(!page_count(p), p);
 	}
 
@@ -1844,19 +1850,9 @@ static int soft_offline_in_use_page(struct page *page)
 	int mt;
 	struct page *hpage = compound_head(page);
 
-	if (!PageHuge(page) && PageTransHuge(hpage)) {
-		lock_page(page);
-		if (!PageAnon(page) || unlikely(split_huge_page(page))) {
-			unlock_page(page);
-			if (!PageAnon(page))
-				pr_info("soft offline: %#lx: non anonymous thp\n", page_to_pfn(page));
-			else
-				pr_info("soft offline: %#lx: thp split failed\n", page_to_pfn(page));
-			put_page(page);
+	if (!PageHuge(page) && PageTransHuge(hpage))
+		if (try_to_split_thp_page(page, "soft offline") < 0)
 			return -EBUSY;
-		}
-		unlock_page(page);
-	}
 
 	/*
 	 * Setting MIGRATE_ISOLATE here ensures that the page will be linked
-- 
2.17.1

