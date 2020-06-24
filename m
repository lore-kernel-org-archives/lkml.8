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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4111DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A698206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+u5EdOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404226AbgFXPCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404215AbgFXPCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:02:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE53AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b16so1255171pfi.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=joeQ3SaeYT7GDsb9cUatgWWRJkFAFZeG8Ak2AOs52Qk=;
        b=W+u5EdOVfTsbqirIRrlaAE605oWdqSInb8/ROWc9uVHpy8/ZacyCg8Cvx1/hmSHNe1
         3t51LQ0cHlHri3xOg02J38+lDjmHh3wBw+foyeO/wqb7929YCVjbddys+s8+dI/LS4PF
         Sxzxf7Hvc2UfpdsS/ehNrjqX3Ph4Hd7h7xsGsSHcfMvWKYD4GpjEA7zaZ9nlGM5Akg3O
         6AoX+kE0TccktjuQ7LhdFewIo+XHlINyZtQLSBwnBBCsiqP2M/uf5J+HSW4MHyciDwnx
         wYGY1PXBe/Snv92WcoAbx1wMStUJ9ssnqFHSnEd6DMBPvYVhD1BoaWW6rUThQAGdqPXA
         0bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=joeQ3SaeYT7GDsb9cUatgWWRJkFAFZeG8Ak2AOs52Qk=;
        b=Pn4/Ymvlw2R/U9glvjKXHW/S1fUNEPcxyiSWTUDbNWtYtVTj3Cg1zBvB94/dlq+7tN
         zX7f8Xr5kS/6iAZyNWPBSBMcd5BIh2srr7hrnazYARuQ8rIc9IdPind94zc3NyvEvCGZ
         n3mhlAqGlUR016Dh73rRdoxyPod6Wd9lrzmMrQBR4pmyvjEz1Z23EmbRr5UoFbE1DdgS
         4R21cilQ4iVW05DBzmePWDw5vD/js6pI0uAHg95YNnT/azbKhjHcOQQRTar2p+/fiPB6
         eNolj3XSJojh1FWuqaAocJPI11vgtSJkuF/2mYXF7CUHyY3C/hQ5c8ermV3bKd6DHsh6
         5R0g==
X-Gm-Message-State: AOAM5339E3AhSd7a8h59/oQxT69bPsX5Fs1N2p64ERQGm4MHICFZU5jW
        43suBZushSQuG7HiHGsFbeZ/hrW+LQ==
X-Google-Smtp-Source: ABdhPJztXHW2r62m+tAG4OOCPW60g7TBHFl5rgmkuHiE/2l+QSOogErW+UJQ+iv40PhXFbMvLae0OA==
X-Received: by 2002:a62:1716:: with SMTP id 22mr2825390pfx.99.1593010933234;
        Wed, 24 Jun 2020 08:02:13 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:02:12 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/15] mm,hwpoison: Unify THP handling for hard and soft offline
Date:   Wed, 24 Jun 2020 15:01:32 +0000
Message-Id: <20200624150137.7052-11-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Place the THP's page handling in a helper and use it
from both hard and soft-offline machinery, so we get rid
of some duplicated code.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 48 +++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
index 03d3aae77f89..2e244d5b83e0 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
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
 
@@ -1847,19 +1853,9 @@ static int soft_offline_in_use_page(struct page *page)
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

