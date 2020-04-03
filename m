Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1EEC2BA17
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF33C20857
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="e7D7Emgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390815AbgDCL3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:29:49 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38890 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390696AbgDCL3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:29:38 -0400
Received: by mail-lj1-f170.google.com with SMTP id v16so6581561ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JyG4ZK4aUipdi7l1+T9raGPiyVfjwGerp10mgDADK/g=;
        b=e7D7EmgbeOg4wV7XYkB6LstaOwCRw67bTZ64C4M23mg6OujN+tMKmAkpzQ9jKTpyTJ
         KxuyKX9jKpE+54QURhvJKVl6D91OVqshcTmGntYjrpOrRN9Xsa79rJBPFl++qnp484tX
         yBPZQRoEesmxEQBb0ohdDqb3FYEhmSTuA+D7bmCVanFSAg/leJEfQp0/rkFHjc90Rt8c
         Gqx37GTb6CIFM2nz/wuMUUNIOqtHWTIyWKf341A4xRTJUCW7nBhwDmF8W8hdgaK756YS
         DvqxrRwGJHAQxWysJkOlgVwFrOiRaA+HpZNlWBVQsoPfZUOoK0G3KQYxrNB8ePQT6Hyy
         BtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JyG4ZK4aUipdi7l1+T9raGPiyVfjwGerp10mgDADK/g=;
        b=k39L2Qv05McR3B/M3dtVPEOZf6xgi2QDSiGjA9mtOmvr0O7ipUHcyhC1PwAusoR43B
         EWd9ipYaVD0E1B1/4z9tZXg2YSkg5uiMQSxRonw6YIbDf3iAwIHhkZ/IvRVgg0iVDa/v
         dSJXa7qH5i7UZ2sKn9jpteJjBcy7t1Zr6mRhSW0r3JBzjldebW931DBlks6CWsiukHs0
         rlTRIA4M5rlWIJNXFMTmOQy+ztkR2lsXxNBiJ0s2xOWC7MBg/Ss9W6TNyFpIOSZkTYgY
         lw8AV6u1Jsf6Clz2lNTEdtE0Ynzsn5OAZlS1BUzo0CSzR7CZGHHvF5CzwFzzZl17x13s
         cPCQ==
X-Gm-Message-State: AGi0PuZtxsQpwwClaOzxYLL01hHkog9Wt8U4fegjDED8wwlldoZeBlAC
        PA44hn9x4zfq6wREsaHa9i7lpw==
X-Google-Smtp-Source: APiQypJ8HECNkEXU+lf1IzeCv/XpLsXDQZbo2YR6k66TkqgEGuWkHBHPcBP20GcHpu4L0lv61PyUhA==
X-Received: by 2002:a2e:7a0b:: with SMTP id v11mr4343569ljc.120.1585913376132;
        Fri, 03 Apr 2020 04:29:36 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c2sm6070260lfb.43.2020.04.03.04.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 04:29:34 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 7FF00101333; Fri,  3 Apr 2020 14:29:31 +0300 (+03)
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 5/8] khugepaged: Allow to callapse a page shared across fork
Date:   Fri,  3 Apr 2020 14:29:25 +0300
Message-Id: <20200403112928.19742-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page can be included into collapse as long as it doesn't have extra
pins (from GUP or otherwise).

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/khugepaged.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 57ff287caf6b..1e7e6543ebca 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -581,11 +581,18 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		}
 
 		/*
-		 * cannot use mapcount: can't collapse if there's a gup pin.
-		 * The page must only be referenced by the scanned process
-		 * and page swap cache.
+		 * Check if the page has any GUP (or other external) pins.
+		 *
+		 * The page table that maps the page has been already unlinked
+		 * from the page table tree and this process cannot get
+		 * additinal pin on the page.
+		 *
+		 * New pins can come later if the page is shared across fork,
+		 * but not for the this process. It is fine. The other process
+		 * cannot write to the page, only trigger CoW.
 		 */
-		if (page_count(page) != 1 + PageSwapCache(page)) {
+		if (total_mapcount(page) + PageSwapCache(page) !=
+				page_count(page)) {
 			unlock_page(page);
 			result = SCAN_PAGE_COUNT;
 			goto out;
@@ -672,7 +679,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 		} else {
 			src_page = pte_page(pteval);
 			copy_user_highpage(page, src_page, address, vma);
-			VM_BUG_ON_PAGE(page_mapcount(src_page) != 1, src_page);
 			release_pte_page(src_page);
 			/*
 			 * ptl mostly unnecessary, but preempt has to
@@ -1206,12 +1212,9 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 			goto out_unmap;
 		}
 
-		/*
-		 * cannot use mapcount: can't collapse if there's a gup pin.
-		 * The page must only be referenced by the scanned process
-		 * and page swap cache.
-		 */
-		if (page_count(page) != 1 + PageSwapCache(page)) {
+		/* Check if the page has any GUP (or other external) pins */
+		if (total_mapcount(page) + PageSwapCache(page) !=
+				page_count(page)) {
 			result = SCAN_PAGE_COUNT;
 			goto out_unmap;
 		}
-- 
2.26.0

