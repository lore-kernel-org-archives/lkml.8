Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BD4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C5F20725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgGJJ3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:29:03 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:43866 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727948AbgGJJ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:28:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0U2HJelg_1594373333;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U2HJelg_1594373333)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jul 2020 17:28:53 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, yang.shi@linux.alibaba.com, thomas_os@shipmail.org,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        richard.weiyang@linux.alibaba.com, peterx@redhat.com,
        aneesh.kumar@linux.ibm.com, willy@infradead.org,
        thellstrom@vmware.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com
Subject: [Patch v5 2/3] mm/mremap: calculate extent in one place
Date:   Fri, 10 Jul 2020 17:28:34 +0800
Message-Id: <20200710092835.56368-3-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200710092835.56368-1-richard.weiyang@linux.alibaba.com>
References: <20200710092835.56368-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/mremap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index de27b12c8a5a..a30b3e86cc99 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -258,6 +258,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		extent = next - old_addr;
 		if (extent > old_end - old_addr)
 			extent = old_end - old_addr;
+		next = (new_addr + PMD_SIZE) & PMD_MASK;
+		if (extent > next - new_addr)
+			extent = next - new_addr;
 		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
 		if (!old_pmd)
 			continue;
@@ -301,9 +304,6 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
 		if (pte_alloc(new_vma->vm_mm, new_pmd))
 			break;
-		next = (new_addr + PMD_SIZE) & PMD_MASK;
-		if (extent > next - new_addr)
-			extent = next - new_addr;
 		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
 			  new_pmd, new_addr, need_rmap_locks);
 	}
-- 
2.20.1 (Apple Git-117)

