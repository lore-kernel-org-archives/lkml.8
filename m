Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42319C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFD82464B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgAQXXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:23:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:9953 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbgAQXXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:23:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 15:23:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; 
   d="scan'208";a="306388179"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga001.jf.intel.com with ESMTP; 17 Jan 2020 15:23:09 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, kirill@shutemov.name,
        yang.shi@linux.alibaba.com, richardw.yang@linux.intel.com,
        thellstrom@vmware.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 4/5] mm/mremap: calculate extent in one place
Date:   Sat, 18 Jan 2020 07:22:53 +0800
Message-Id: <20200117232254.2792-5-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117232254.2792-1-richardw.yang@linux.intel.com>
References: <20200117232254.2792-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page tables is moved on the base of PMD. This requires both source
and destination range should meet the requirement.

Current code works well since move_huge_pmd() and move_normal_pmd()
would check old_addr and new_addr again. And then return to move_ptes()
if the either of them is not aligned.

In stead of calculating the extent separately, it is better to calculate
in one place, so we know it is not necessary to try move pmd. By doing
so, the logic seems a little clear.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/mremap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index a258914f3ee1..37335a10779d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -240,7 +240,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long new_addr, unsigned long len,
 		bool need_rmap_locks)
 {
-	unsigned long extent, next, old_end;
+	unsigned long extent, old_next, new_next, old_end;
 	struct mmu_notifier_range range;
 	pmd_t *old_pmd, *new_pmd;
 
@@ -253,8 +253,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
 	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
 		cond_resched();
-		next = pmd_addr_end(old_addr, old_end);
-		extent = next - old_addr;
+		old_next = pmd_addr_end(old_addr, old_end);
+		new_next = pmd_addr_end(new_addr, new_addr + len);
+		extent = min((old_next - old_addr), (new_next - new_addr));
 		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
 		if (!old_pmd)
 			continue;
@@ -298,9 +299,6 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
 		if (pte_alloc(new_vma->vm_mm, new_pmd))
 			break;
-		next = pmd_addr_end(new_addr, new_addr + len);
-		if (extent > next - new_addr)
-			extent = next - new_addr;
 		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
 			  new_pmd, new_addr, need_rmap_locks);
 	}
-- 
2.17.1

