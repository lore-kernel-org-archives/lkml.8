Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7ECC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED31206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="UGx5kynZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qhcVowDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgIBSH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:58 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54865 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727944AbgIBSGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E8605C0174;
        Wed,  2 Sep 2020 14:06:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=W8y/hMwf2uJ9y
        W3fuBaKgbgy0fOnMgqFI5aw7zRR3JY=; b=UGx5kynZxCJQaVCAk5YbyXr6jMzyI
        4yhj762Ke3rbG4bzrn5KuQ5amp/1xkbvvfTFG8eKebolmOQ2bpvi0aJ/0PT9mDSA
        K5EyGXxNpKeonlfMUyKsVKMTbDNI2GUHeZYyQS6f3oHp1q+wWo0TgqOb3xwdJZ74
        fX77Vgnc1ByQHDVbQtq0pCiV0OLvhSHR+7MrsnIN9oSOjN2mkbpBZYAvTqT8oP/9
        tm17a0OvzT+RUwEbylaK71lHNKiDgmxrzFI0hyXVm/L6J0Cc1WbC/W69AcWAsxTf
        hhyY1dqSvDrlSK+lNiy0SHm0bJw/MmKa4a4PA7io1GKYm7dne1+9/KMrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=W8y/hMwf2uJ9yW3fuBaKgbgy0fOnMgqFI5aw7zRR3JY=; b=qhcVowDL
        sxs+uk520A2zHqb0PStyXqZIp38AiPOP6/dzF4P43weETxkehYN7tHB8lu71R2rF
        EvhIugSn3FSKS5TNc4eJRb0n1BhcqbD0hluwVcdbpetzmUdfENLR5vge31DGNrHY
        SCb33fWL1zO1oxnnI4ygJnvnDjbhA+caSmCcXjrNZ+mnV0Wq4peRERF0Ifhx70o/
        sssnn4n5JxqcwQINk+Y56kiPHxXWn8GED4tkyqOTuWDcSOQ4UBOjMhn2CwbOb6Cr
        uQVq+aDjwZRG+Ob1K0VZDOB3bTm98y20LSS1kYM8wmL2GvavUJqb6mzNu7qmqRfn
        4HZyQmz+Gx/2DQ==
X-ME-Sender: <xms:Kd9PX9Z0NRTTeVtorOnj-9vfBPVLmoBOxghJ9GeXTJKFrb-IlBET1Q>
    <xme:Kd9PX0Yf-TIIhP05yTpwi26KXS3FUKHKSBsEKnw_vPPrGSSPILXINhaJDlUfxvAm2
    Vcl3prxxMN3f-Cw5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:Kt9PX_-MEwYL59SeVrClInP5rQBw9EgF84YJmd1q7_vZG2mlHr_9lw>
    <xmx:Kt9PX7qO94iDRTLqFg7YTcCv06CFlEdVDjGVTzRYy22V5M8Q0N9sYA>
    <xmx:Kt9PX4qlXtcomrWuzaaQtH1NjbICWBcLD5jbo-CjdDXaDCJLpcEjdA>
    <xmx:Kt9PXwIHoUGYldIiksl-1hTUa7xsU_5UVRvrCKX_0mzyQBQ-WebKBg>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9646C30600A9;
        Wed,  2 Sep 2020 14:06:33 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 12/16] mm: support 1GB THP pagemap support.
Date:   Wed,  2 Sep 2020 14:06:24 -0400
Message-Id: <20200902180628.4052244-13-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902180628.4052244-1-zi.yan@sent.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Print page flags properly.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 fs/proc/task_mmu.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2ff80a9c8b57..7254c7ecf659 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1557,6 +1557,64 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	return err;
 }
 
+static int pagemap_pud_range(pud_t *pudp, unsigned long addr, unsigned long end,
+			     struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+	struct pagemapread *pm = walk->private;
+	spinlock_t *ptl;
+	int err = 0;
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	ptl = pud_trans_huge_lock(pudp, vma);
+	if (ptl) {
+		u64 flags = 0, frame = 0;
+		pud_t pud = *pudp;
+		struct page *page = NULL;
+
+		if (vma->vm_flags & VM_SOFTDIRTY)
+			flags |= PM_SOFT_DIRTY;
+
+		if (pud_present(pud)) {
+			page = pud_page(pud);
+
+			flags |= PM_PRESENT;
+			if (pud_soft_dirty(pud))
+				flags |= PM_SOFT_DIRTY;
+			if (pm->show_pfn)
+				frame = pud_pfn(pud) +
+					((addr & ~PUD_MASK) >> PAGE_SHIFT);
+		}
+
+		if (page && page_mapcount(page) == 1)
+			flags |= PM_MMAP_EXCLUSIVE;
+
+		for (; addr != end; addr += PAGE_SIZE) {
+			pagemap_entry_t pme = make_pme(frame, flags);
+
+			err = add_to_pagemap(addr, &pme, pm);
+			if (err)
+				break;
+			if (pm->show_pfn) {
+				if (flags & PM_PRESENT)
+					frame++;
+				else if (flags & PM_SWAP)
+					frame += (1 << MAX_SWAPFILES_SHIFT);
+			}
+		}
+		spin_unlock(ptl);
+		walk->action = ACTION_CONTINUE;
+		return err;
+	}
+
+	if (pud_trans_unstable(pudp)) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
+#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
+	return err;
+}
+
 #ifdef CONFIG_HUGETLB_PAGE
 /* This function walks within one hugetlb entry in the single call */
 static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
@@ -1607,6 +1665,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 #endif /* HUGETLB_PAGE */
 
 static const struct mm_walk_ops pagemap_ops = {
+	.pud_entry	= pagemap_pud_range,
 	.pmd_entry	= pagemap_pmd_range,
 	.pte_hole	= pagemap_pte_hole,
 	.hugetlb_entry	= pagemap_hugetlb_range,
-- 
2.28.0

