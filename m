Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD0DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6EED20720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgGGSyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:54:43 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:58376 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728183AbgGGSyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:54:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U23IaJm_1594148072;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0U23IaJm_1594148072)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Jul 2020 02:54:39 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hannes@cmpxchg.org, catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, xuyu@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH] mm: avoid access flag update TLB flush for retried page fault
Date:   Wed,  8 Jul 2020 02:54:32 +0800
Message-Id: <1594148072-91273-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we found regression when running will_it_scale/page_fault3 test
on ARM64.  Over 70% down for the multi processes cases and over 20% down
for the multi threads cases.  It turns out the regression is caused by commit
89b15332af7c0312a41e50846819ca6613b58b4c ("mm: drop mmap_sem before
calling balance_dirty_pages() in write fault").

The test mmaps a memory size file then write to the mapping, this would
make all memory dirty and trigger dirty pages throttle, that upstream
commit would release mmap_sem then retry the page fault.  The retried
page fault would see correct PTEs installed by the first try then update
access flags and flush TLBs.  The regression is caused by the excessive
TLB flush.  It is fine on x86 since x86 doesn't need flush TLB for
access flag update.

The page fault would be retried due to:
1. Waiting for page readahead
2. Waiting for page swapped in
3. Waiting for dirty pages throttling

The first two cases don't have PTEs set up at all, so the retried page
fault would install the PTEs, so they don't reach there.  But the #3
case usually has PTEs installed, the retried page fault would reach the
access flag update.  But it seems not necessary to update access flags
for #3 since retried page fault is not real "second access", so it
sounds safe to skip access flag update for retried page fault.

With this fix the test result get back to normal.

Reported-by: Xu Yu <xuyu@linux.alibaba.com>
Debugged-by: Xu Yu <xuyu@linux.alibaba.com>
Tested-by: Xu Yu <xuyu@linux.alibaba.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
I'm not sure if this is safe for non-x86 machines, we did some tests on arm64, but
there may be still corner cases not covered.

 mm/memory.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 87ec87c..3d4e671 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4241,8 +4241,13 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (vmf->flags & FAULT_FLAG_WRITE) {
 		if (!pte_write(entry))
 			return do_wp_page(vmf);
-		entry = pte_mkdirty(entry);
 	}
+
+	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vmf->flags & FAULT_FLAG_TRIED))
+		entry = pte_mkdirty(entry); 
+	else if (vmf->flags & FAULT_FLAG_TRIED)
+		goto unlock;
+
 	entry = pte_mkyoung(entry);
 	if (ptep_set_access_flags(vmf->vma, vmf->address, vmf->pte, entry,
 				vmf->flags & FAULT_FLAG_WRITE)) {
-- 
1.8.3.1

