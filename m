Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97582C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7143C20740
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbgELVDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:03:14 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36526 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725938AbgELVDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:03:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TyNQql1_1589317383;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TyNQql1_1589317383)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 May 2020 05:03:11 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     kirill.shutemov@linux.intel.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC linux-next PATCH] mm: khugepaged: remove error message when checking external pins
Date:   Wed, 13 May 2020 05:03:03 +0800
Message-Id: <1589317383-9595-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running khugepaged with higher frequency (for example, set
scan_sleep_millisecs to 0), the below error message was reported:

khugepaged: expected_refcount (1024) > refcount (512)
page:ffffd75784258000 count:511 mapcount:1 mapping:ffff968de06c7421 index:0x7fa288600
 compound_mapcount: 0
 flags: 0x17fffc00009003c(uptodate|dirty|lru|active|head|swapbacked)
 raw: 017fffc00009003c ffffd7578ba70788 ffffd7578bdb5148 ffff968de06c7421
 raw: 00000007fa288600 0000000000000000 000001ff00000000 ffff968e5e7d6000
 page dumped because: Unexpected refcount
 page->mem_cgroup:ffff968e5e7d6000

This is introduced by allowing collapsing fork shared and PTE-mapped
THPs.  The check may run into the below race:

Assuming parent process forked child process, then they do

	CPU A		CPU B			CPU C
	-----		-----			-----
Parent			Child			khugepaged

MADV_DONTNEED
  split huge pmd
  Double mapped
			MADV_DONTNEED
			  zap_huge_pmd
			    remove_page_rmap
			      Clear double map
						khugepaged_scan_pmd(parent)
						  check mapcount and refcount
						  --> total_mapcount > refcount
			      dec mapcount

The issue can be reproduced by the below test program.

---8<---
void main()
{
        void *addr;
        int ret;
        pid_t pid;

        addr = memalign(ALIGN, 2 * 1024 * 1024);
        if (!addr) {
                printf("malloc failed\n");
                return;
        }

        ret = madvise(addr, 2 * 1024 * 1024, MADV_HUGEPAGE);
        if (ret < 0) {
                printf("madvise failed\n");
                return;
        }

        memset(addr, 0xdeadbeef, 2 * 1024 * 1024);

        pid = fork();

        if (pid == 0) {
                /* Child process */
                ret = madvise(addr + (2 * 1024 * 1024) - 4096, 4096, MADV_DONTNEED);
                if (ret < 0) {
                        printf("madvise failed in child\n");
                        return;
                }
                sleep(120);
        } else if (pid > 0) {
                sleep(5);
                /* Parent process */
                ret = madvise(addr, 2 * 1024 * 1024, MADV_DONTNEED);
                if (ret < 0) {
                        printf("madvise failed in parent\n");
                        return;
                }
        } else {
                printf("fork failed\n");
                return;
        }

        sleep(120);
}
---8<---

So, total_mapcount > refcount seems not unexpected due to the inherent
race.  Removed the error message even though it is protected by
CONFIG_VM_DEBUG since we have to live with the race and AFAIK some
distros may have CONFIG_VM_DEBUG enabled dy default.

Since such case is ephemeral we could always try collapse the area again
later, so it sounds not harmful.  But, it might report false positive if
the page has excessive GUP pins (i.e. 512), however it might be not that
bad since the same check will be done later.  I didn't figure out a
simple way to prevent the false positive.

Added some notes to elaborate the race and the consequence as well.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/khugepaged.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1fdd677..048f5d4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -602,12 +602,6 @@ static bool is_refcount_suitable(struct page *page)
 	if (PageSwapCache(page))
 		expected_refcount += compound_nr(page);
 
-	if (IS_ENABLED(CONFIG_DEBUG_VM) && expected_refcount > refcount) {
-		pr_err("expected_refcount (%d) > refcount (%d)\n",
-				expected_refcount, refcount);
-		dump_page(page, "Unexpected refcount");
-	}
-
 	return page_count(page) == expected_refcount;
 }
 
@@ -1341,7 +1335,23 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 			goto out_unmap;
 		}
 
-		/* Check if the page has any GUP (or other external) pins */
+		/*
+		 * Check if the page has any GUP (or other external) pins.
+		 *
+		 * Here the check is racy it may see totmal_mapcount > refcount
+		 * in some cases.
+		 * For example, one process with one forked child process.
+		 * The parent has the PMD split due to MADV_DONTNEED, then
+		 * the child is trying unmap the whole PMD, but khugepaged
+		 * may be scanning the parent between the child has
+		 * PageDoubleMap flag cleared and dec the mapcount.  So
+		 * khugepaged may see total_mapcount > refcount.
+		 *
+		 * But such case is ephemeral we could always retry collapse
+		 * later.  However it may report false positive if the page
+		 * has excessive GUP pins (i.e. 512).  Anyway the same check
+		 * will be done again later the risk seems low.
+		 */
 		if (!is_refcount_suitable(page)) {
 			result = SCAN_PAGE_COUNT;
 			goto out_unmap;
-- 
1.8.3.1

