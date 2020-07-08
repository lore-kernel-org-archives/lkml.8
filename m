Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85309C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA3F20708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgGHBZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 21:25:57 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51002 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729325AbgGHBZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 21:25:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0U23pI3U_1594171545;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U23pI3U_1594171545)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Jul 2020 09:25:45 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, yang.shi@linux.alibaba.com, thomas_os@shipmail.org,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        richard.weiyang@linux.alibaba.com, peterx@redhat.com,
        aneesh.kumar@linux.ibm.com, willy@infradead.org,
        thellstrom@vmware.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com
Subject: [Patch v3 4/4] mm/mremap: use pmd_addr_end to simplify the calculate of extent
Date:   Wed,  8 Jul 2020 09:24:53 +0800
Message-Id: <20200708012453.36588-5-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200708012453.36588-1-richard.weiyang@linux.alibaba.com>
References: <20200708012453.36588-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this code is to calculate the smaller extent in old and
new range. Let's leverage pmd_addr_end() to do the calculation.

Hope this would make the code easier to read.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/mremap.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index f5f17d050617..76e7fdf567c3 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -237,11 +237,12 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long new_addr, unsigned long len,
 		bool need_rmap_locks)
 {
-	unsigned long extent, next, old_end;
+	unsigned long extent, old_next, new_next, old_end, new_end;
 	struct mmu_notifier_range range;
 	pmd_t *old_pmd, *new_pmd;
 
 	old_end = old_addr + len;
+	new_end = new_addr + len;
 	flush_cache_range(vma, old_addr, old_end);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
@@ -250,14 +251,11 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
 	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
 		cond_resched();
-		next = (old_addr + PMD_SIZE) & PMD_MASK;
-		/* even if next overflowed, extent below will be ok */
-		extent = next - old_addr;
-		if (extent > old_end - old_addr)
-			extent = old_end - old_addr;
-		next = (new_addr + PMD_SIZE) & PMD_MASK;
-		if (extent > next - new_addr)
-			extent = next - new_addr;
+
+		old_next = pmd_addr_end(old_addr, old_end);
+		new_next = pmd_addr_end(new_addr, new_end);
+		extent = min((old_next - old_addr), (new_next - new_addr));
+
 		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
 		if (!old_pmd)
 			continue;
-- 
2.20.1 (Apple Git-117)

