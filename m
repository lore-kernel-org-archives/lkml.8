Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798E3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58DD320823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590514402;
	bh=lbK/NnvQIQSJaitrCSivAE5U2uxTHBSqQpwGc3le/pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2V1uEdN5Tzy/BdiI6Nm3g82+ielvgp3bqAWMahSlwX/Ie3GTd6MNpF8nbWOWbMOZf
	 +ova1BpZ0mEqNzoBPz6xFWWcBXXpacchBQFIPchwXU18Q6Fpjtj3gKu/NoGdv0GiFf
	 6Wjv60OjVysnaj6NuGEnJnkMM8QfkwR4qrL7ko9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgEZRdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbgEZRdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:33:17 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E7752084C;
        Tue, 26 May 2020 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590514396;
        bh=lbK/NnvQIQSJaitrCSivAE5U2uxTHBSqQpwGc3le/pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSwIqx93A7dTWzoRvRfZxBng7tCYOkMubn2HuaULgKFiG67Kbu4MJ8XYUB5uVDPvP
         JgvBJIYnLl/A7h2w3brGL8dzlxJMTWrmHjQwkL80evOMw6HZyAy1Bcho9kWoY4dDok
         5rFZ6FY3UkdrTB2zTClZ1Ird+/i4a1+h/AqDt7Kk=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     sparclinux@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Mike Rapoport <rppt@kernel.org>, kernel-team@android.com
Subject: [PATCH 3/3] sparc32: mm: Only call ctor()/dtor() functions for first and last user
Date:   Tue, 26 May 2020 18:33:02 +0100
Message-Id: <20200526173302.377-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200526173302.377-1-will@kernel.org>
References: <20200526173302.377-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRMMU page-table allocator allocates multiple PTE tables per page,
since they are only 1K in size. However, this means that calls to
pgtable_pte_page_{ctor,dtor}() must be serialised and performed only by
the first and last page-table allocation for the page respectively.

Use the page reference count to track how many PTE tables we have
allocated for a given page returned by the SRMMU allocator and only
call the ctor()/dtor() functions for the first and last user respectively.

Cc: David S. Miller <davem@davemloft.net>
Fixes: 8c8f3156dd40 ("sparc32: mm: Reduce allocation size for PMD and PTE tables")
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/sparc/mm/srmmu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 589370a21b12..116d19a390f2 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -364,9 +364,13 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 	if ((ptep = pte_alloc_one_kernel(mm)) == 0)
 		return NULL;
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
-	if (!pgtable_pte_page_ctor(page)) {
-		return NULL;
+	spin_lock(&mm->page_table_lock);
+	if (page_ref_inc_return(page) == 2 && !pgtable_pte_page_ctor(page)) {
+		page_ref_dec(page);
+		ptep = NULL;
 	}
+	spin_unlock(&mm->page_table_lock);
+
 	return ptep;
 }
 
@@ -375,7 +379,11 @@ void pte_free(struct mm_struct *mm, pgtable_t ptep)
 	struct page *page;
 
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
-	pgtable_pte_page_dtor(page);
+	spin_lock(&mm->page_table_lock);
+	if (page_ref_dec_return(page) == 1)
+		pgtable_pte_page_dtor(page);
+	spin_unlock(&mm->page_table_lock);
+
 	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
 }
 
-- 
2.27.0.rc0.183.gde8f92d652-goog

