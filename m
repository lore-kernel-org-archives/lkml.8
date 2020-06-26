Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FB5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F05A207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgFZNwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:52:40 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:59323 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728955AbgFZNwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:52:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U0lxLZx_1593179552;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0lxLZx_1593179552)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Jun 2020 21:52:32 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, vbabka@suse.cz, willy@infradead.org,
        thomas_os@shipmail.org, thellstrom@vmware.com,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        aneesh.kumar@linux.ibm.com, peterx@redhat.com, walken@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [RESEND Patch v2 4/4] mm/mremap: start addresses are properly aligned
Date:   Fri, 26 Jun 2020 21:52:16 +0800
Message-Id: <20200626135216.24314-5-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
References: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After previous cleanup, extent is the minimal step for both source and
destination. This means when extent is HPAGE_PMD_SIZE or PMD_SIZE,
old_addr and new_addr are properly aligned too.

Since these two functions are only invoked in move_page_tables, it is
safe to remove the check now.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
---
 mm/huge_memory.c | 3 ---
 mm/mremap.c      | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1e580fdad4d0..462a7dbd6350 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1729,9 +1729,6 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	struct mm_struct *mm = vma->vm_mm;
 	bool force_flush = false;
 
-	if ((old_addr & ~HPAGE_PMD_MASK) || (new_addr & ~HPAGE_PMD_MASK))
-		return false;
-
 	/*
 	 * The destination pmd shouldn't be established, free_pgtables()
 	 * should have release it.
diff --git a/mm/mremap.c b/mm/mremap.c
index a30b3e86cc99..f5f17d050617 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -199,9 +199,6 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	struct mm_struct *mm = vma->vm_mm;
 	pmd_t pmd;
 
-	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK))
-		return false;
-
 	/*
 	 * The destination pmd shouldn't be established, free_pgtables()
 	 * should have release it.
-- 
2.20.1 (Apple Git-117)

