Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D70C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6212224D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg0nVi4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgHFStv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgHFSts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:49:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90484C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:49:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so15146948plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=waWNBxGk6iMPpav8Mj47fC2tLAwOLjpd+rtwaTivLoM=;
        b=Pg0nVi4qfc3JE7BvbZZqMTxAl/O4+2QJe9KQgrXh8iuL9xnFQzxEtbNK9spmDqEEzq
         lphsXWqzRETj5yg7O6xd7xWKVAnr57l9YK62W14XO8MvAKBiQHluh+D1m4iTCsIxHXsu
         iLNyVxm4UasjFzZ73MhjOjSajlgz5OI26CobetVi1z0w9tRPRTJeIDBRQmodpQRe3jGx
         nJp0DvCjcvVlzImdFoY/R7iZYgOrXhv1JXDyuyOqRt8AcytxYY9BwkDr9i4/FVrSfLVS
         2Har4jeTBZXvQwrwT3CnoazHJhRVxwPFS4ociGyiHi3Ai9djwPftESUTTPw/6FW6p5OP
         Xanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=waWNBxGk6iMPpav8Mj47fC2tLAwOLjpd+rtwaTivLoM=;
        b=G72rxVuNrYufgIXT1DUxanpSHOfK2xHf1AygJ+k1BkGBq50PX1RcWiWHGHtZWsHxuu
         4wOh2aB8emIuAnag/xnXdK67K7BVeHAuEzsSwzgDUE9SOj3XOzpCU4n3Y/gxX4TtdNbM
         zu0PCgmej3Riqgbbpq/dd5JfVvLSV2rGeuSV2PomzX4wEmy+kH9NFMBz0NIeEeEl1tFs
         Jbpjw9YLFobisNd/QFKFrcVerSPhNtGDSveYyWgzZxkhrHmgVWq7XSW5FUJxB1HZup0t
         IiUoJlvBpqCJePNY7BkDU5Es23KsASwEgxiArN+Le1w+okm6bYenpOueRJpiJSYgFviW
         aeIQ==
X-Gm-Message-State: AOAM532bHzlhm8fcfdwk7FgZRzgkCxtQRpyFaeYfCh2JSFnkjfzNunLm
        HHYxkr0HZm0P+pvsla9j7A==
X-Google-Smtp-Source: ABdhPJy23FvrXJY1ir5JHfjRf2aw0PiitzQkRSXbVYYiLuoHqYf7AnXsXuad9Ycm/ZBgfq6fDoibTQ==
X-Received: by 2002:a17:90b:1c06:: with SMTP id oc6mr9305658pjb.182.1596739787945;
        Thu, 06 Aug 2020 11:49:47 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id u24sm9096730pfm.20.2020.08.06.11.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 11:49:47 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/12] mm,hwpoison: Unify THP handling for hard and soft offline
Date:   Thu,  6 Aug 2020 18:49:17 +0000
Message-Id: <20200806184923.7007-7-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806184923.7007-1-nao.horiguchi@gmail.com>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
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
index 6853bf3a253d..276c1588f82a 100644
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
 
@@ -1850,19 +1856,9 @@ static int soft_offline_in_use_page(struct page *page, int flags)
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

