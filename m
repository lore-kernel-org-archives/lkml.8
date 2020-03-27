Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954B4C2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1D92073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="fNHTd/MA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgC0RGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:06:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36884 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgC0RGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:06:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so10996791ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThpcVoxxySBsyGDL9yqIPPj2mnnyBXzq6rEXvZDPIuA=;
        b=fNHTd/MARGBDdMO/5j8pGyv1gV0nBmX6x3XXpQnpq1EssAZZ1iPmkK24TfgSdoIPZ7
         zB+EDT1S8pUEnv4AU2xKOt/qRJw7Brw6WoyxvFeKej16Mv20jxP8xGZSLsE04KJhwz4m
         zYuRXoJsT3WE0gMGKx2NqYQYonIYj6KDAwwAQhsB5sQtLXcKsWmZWMxgNfqbXoENWLYj
         Tm/dpS/UUQagNliXw1OPspoP8YQYKKKbnrditaiksEOnKWJoYKu/QLPfwqOn4FsZ8nZN
         FLuhSnDFJgoGb2EI79yLSfh49rnhZPCtq6WLO1L+oSgIMgFPJbbJ0n7490F2GybiezZ8
         TWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThpcVoxxySBsyGDL9yqIPPj2mnnyBXzq6rEXvZDPIuA=;
        b=A4s0uECxLZ9NW3LWnKvxF9/9MXaeCAESvXOUNaRO8Kc81/d77B4xae1PvgWbeIUi4q
         fkyoZef5P1ZDddNfNeemD+vJ48n926K38NlgmKnW97UE9uG078xsYD6hYBdx8XqhojAF
         ymmJ5YcJZ4FNa22R2SvA/8L0hiBLu4XCy6vTGGlvJ8iyTSQiHZ28q2eyIIKNP65lQ1Ma
         hXKlA7tOT1NHM6tWWA3GWu5BEkwltNXx6g4jtakEEi0STy+NRUR7szb94IurnMruONfR
         o8hBAO3hEfl2Ed0UiumghGjd8/O4TClRw4eSPGNiMJJ2rEG/VcOLsLotW+9OWSy+Ielp
         +zEw==
X-Gm-Message-State: ANhLgQ0+B2usTj2SZhMPMK8k3i5CwBJ5/UBixEAeb68bzjEfD8wpB/iO
        EvHEGkXVMiiprRUK7ZFh0JDZCQ==
X-Google-Smtp-Source: APiQypLtn/NpXZCnCXpoQScUjDIxmuhP+tRIc0nLOzigxrfVLxvwc+v9+cf1EYMqS3kUQzsle5YSxQ==
X-Received: by 2002:a2e:730e:: with SMTP id o14mr8917059ljc.273.1585328765915;
        Fri, 27 Mar 2020 10:06:05 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u8sm3272039lfi.12.2020.03.27.10.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 10:06:05 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 7673A100D2A; Fri, 27 Mar 2020 20:06:07 +0300 (+03)
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 5/7] khugepaged: Allow to collapse PTE-mapped compound pages
Date:   Fri, 27 Mar 2020 20:05:59 +0300
Message-Id: <20200327170601.18563-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can collapse PTE-mapped compound pages. We only need to avoid
handling them more than once: lock/unlock page only once if it's present
in the PMD range multiple times as it handled on compound level. The
same goes for LRU isolation and putpack.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/khugepaged.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b47edfe57f7b..c8c2c463095c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -515,6 +515,17 @@ void __khugepaged_exit(struct mm_struct *mm)
 
 static void release_pte_page(struct page *page)
 {
+	/*
+	 * We need to unlock and put compound page on LRU only once.
+	 * The rest of the pages have to be locked and not on LRU here.
+	 */
+	VM_BUG_ON_PAGE(!PageCompound(page) &&
+			(!PageLocked(page) && PageLRU(page)), page);
+
+	if (!PageLocked(page))
+		return;
+
+	page = compound_head(page);
 	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));
 	unlock_page(page);
 	putback_lru_page(page);
@@ -537,6 +548,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 	pte_t *_pte;
 	int none_or_zero = 0, result = 0, referenced = 0;
 	bool writable = false;
+	LIST_HEAD(compound_pagelist);
 
 	for (_pte = pte; _pte < pte+HPAGE_PMD_NR;
 	     _pte++, address += PAGE_SIZE) {
@@ -561,13 +573,23 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 
-		/* TODO: teach khugepaged to collapse THP mapped with pte */
+		VM_BUG_ON_PAGE(!PageAnon(page), page);
+
 		if (PageCompound(page)) {
-			result = SCAN_PAGE_COMPOUND;
-			goto out;
-		}
+			struct page *p;
+			page = compound_head(page);
 
-		VM_BUG_ON_PAGE(!PageAnon(page), page);
+			/*
+			 * Check if we have dealt with the compount page
+			 * already
+			 */
+			list_for_each_entry(p, &compound_pagelist, lru) {
+				if (page ==  p)
+					break;
+			}
+			if (page ==  p)
+				continue;
+		}
 
 		/*
 		 * We can do it before isolate_lru_page because the
@@ -640,6 +662,9 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		    page_is_young(page) || PageReferenced(page) ||
 		    mmu_notifier_test_young(vma->vm_mm, address))
 			referenced++;
+
+		if (PageCompound(page))
+			list_add_tail(&page->lru, &compound_pagelist);
 	}
 	if (likely(writable)) {
 		if (likely(referenced)) {
@@ -1185,11 +1210,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 			goto out_unmap;
 		}
 
-		/* TODO: teach khugepaged to collapse THP mapped with pte */
-		if (PageCompound(page)) {
-			result = SCAN_PAGE_COMPOUND;
-			goto out_unmap;
-		}
+		page = compound_head(page);
 
 		/*
 		 * Record which node the original page is from and save this
-- 
2.26.0

