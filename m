Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15D5C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B412073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="kGB2Kiza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgC0RGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:06:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45553 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgC0RGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:06:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id t17so10967164ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCQS2NypN0JhzS0ypfUQeVkn+9tCE2dlRA9LI38iq5A=;
        b=kGB2Kiza8RBWjYqxA3azU6g8J+6XrN9ulu4WXST9nTuu7lCP+8CM9665C9vnVCYq54
         a54sLLad2b2bTddxdKbxR7qHl+0LKFhsMw61E1fYfXl7LzKcj+gX4gaotJhuZNR4aKUF
         s2u6W4nwNqfG9/o7+MBxAp0NSDCKH6hAROgHEnlVip56MyiJ7W3YZYHlgIvp9m2ZyLuG
         Ah2k+r1+ivnzGTsaJwo5xxCsuEd7s3YIYTHKWJJnhB38iR2aXTLScV37U1ksZN6YNXMX
         6IiWaat9A/HJGfNaanM/u784X4QNsGw7Uit8DElFc6L58KRu9Br4VDrfkFVrR0M8FTzW
         rS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCQS2NypN0JhzS0ypfUQeVkn+9tCE2dlRA9LI38iq5A=;
        b=evGQqnBjGEgKKLIsjmriMP+XdIk/fuNq9EWlRzuOusRpuux5Ibd3/FHp0fm7vgGOiV
         L8o8VcOY0UB+I2aV/1tSUufhT/PqTT0pfr0gaPXXKC00e9K3Eftq3BfyXjkcjzkrjIPC
         Qi4pE7uOyYTSH97JL6BBz6bS+tC9Rue9DGXU4XjdnDht0cLYlu33RvWVXKBJ9BTxLHMa
         71pmJOfhbHNlJ5ocimVB66wq7vtxwTgbZqOIEAjpE2Xuc0nueSA3iUtrsuC1kKmK6L7n
         6f6KPwIACasIGgd+yti+GUMBa6hEBv6T3IzDFCE/4zKPPyi7pV6Hxzi2vsyk+V0rhjg1
         /k/g==
X-Gm-Message-State: AGi0PuYx2rXJx8o3DYHhnI6VapR//M8CHLfXaRTjhh4wadn0+gntSkqR
        Ep133N+vteqtiDDklZa69+aNNQ==
X-Google-Smtp-Source: APiQypKBQAwVwbRAVi/qZWZFWn/tOxio6lk6NKivsgpAW6fPbyvc3MwwRJKbLPJvgEySXhgoHQQ6lQ==
X-Received: by 2002:a2e:854e:: with SMTP id u14mr8553799ljj.182.1585328763840;
        Fri, 27 Mar 2020 10:06:03 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o68sm3692303lff.81.2020.03.27.10.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 10:06:03 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 6FEFD100D29; Fri, 27 Mar 2020 20:06:07 +0300 (+03)
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 4/7] khugepaged: Allow to callapse a page shared across fork
Date:   Fri, 27 Mar 2020 20:05:58 +0300
Message-Id: <20200327170601.18563-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
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
 mm/khugepaged.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 39e0994abeb8..b47edfe57f7b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -581,18 +581,26 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
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
 			/*
 			 * Drain pagevec and retry just in case we can get rid
 			 * of the extra pin, like in swapin case.
 			 */
 			lru_add_drain();
 		}
-		if (page_count(page) != 1 + PageSwapCache(page)) {
+		if (total_mapcount(page) + PageSwapCache(page) !=
+				page_count(page)) {
 			unlock_page(page);
 			result = SCAN_PAGE_COUNT;
 			goto out;
@@ -680,7 +688,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 		} else {
 			src_page = pte_page(pteval);
 			copy_user_highpage(page, src_page, address, vma);
-			VM_BUG_ON_PAGE(page_mapcount(src_page) != 1, src_page);
 			release_pte_page(src_page);
 			/*
 			 * ptl mostly unnecessary, but preempt has to
@@ -1209,12 +1216,9 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
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

