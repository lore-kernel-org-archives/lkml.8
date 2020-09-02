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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F75C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFC1206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="KyXUVz3o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Soqx4+uH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgIBSHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:12 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46339 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727929AbgIBSGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A0DF5C01B7;
        Wed,  2 Sep 2020 14:06:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=uV0fK8A8kyNXU
        7VUiy/PxZphd7Odkhk2JVfsAnagHMA=; b=KyXUVz3o8pbUikkX3gIY6OzDUrVdo
        lJZPkDDssk92G83YzNS6IudfjKbKwektFnszCCSdcOL3QPzd6Ripk0pa+okmTBJS
        9YutRA/C57/UZyWE2neOW1jmWfWpw/tSUKGGwBCzCrJg3QWaDdtz14BTyIreDlQD
        Y767g4Tthf9MM5uzf4BCcrZXmM7dB9P/RB8Blil0Z92zfZQf9unYNM1aBhCq+cr4
        SsZ/oVPyxZUsgurQjkKR3Ei68wjp5+sUXo9eZLn45WIE3c3C6B9tiJLXhFk3sYsS
        KGHbApaOLdL6qh4SqZVF0suQZkPs9EGla7uypGM7hDmE4SJEbkzW9pLAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=uV0fK8A8kyNXU7VUiy/PxZphd7Odkhk2JVfsAnagHMA=; b=Soqx4+uH
        CG+o25MOr/QSIRCN3hrUPo6jC71tJuT4TYMcPJcaSW8LPYAU9ZsbE0YaLrGgk6uN
        WmZDVhqOCQDLFuaEFU6xYjyD9i42lq3EkpAK3uPqYHqSwsGQAl5OgVnsAhlL7AFe
        eFIz1as9E9UUovorMa8QaFh4ldY2oHqJ69/VmsvljpvRSqd+xieYvVrbGtrLGhe+
        Q8nCMvNKK25MOjC/WWhgyUAAF66y7zj0AN7CFO3VgNIpj+j6c031TFdJZjWs3cB/
        3zL7p35gv7gMDaVoqvNcWsonCzI3O51j+cl50SMKZ9RaBEIdzOZ+jU3+26uB6e5p
        UUcmwjbcSKnQUw==
X-ME-Sender: <xms:KN9PXy7jZhc--P9FTUpTLozQaOuSCSdNbjSkum1KpulNzXg5qM56zg>
    <xme:KN9PX74qSAE-1B7lxiB04FlnQTOIqpej-X0Y94F8aWqaaiP0XazksYlkU1ZSeVNwp
    MKiuta4d_qEJ1KVyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:KN9PXxc_qYTTzrrKzAgv0mxzoG32xTtguO8zd5dPYMEI6hLBQieJgQ>
    <xmx:KN9PX_Ly1eo4iOYj4s4r8G1hD6wYEH-JeZ8bwkB21eqw8GNY0IjAKw>
    <xmx:KN9PX2KhuUT997uB8ARr6GbAKm9HoxGo32dfLuCU4q3bStqvJj5xzw>
    <xmx:Kd9PX3rgKXQF-owIZywJHHE4Kyh5XyJvlQ1LFrRF_47CvdNR6ReG-A>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6C61D30600A9;
        Wed,  2 Sep 2020 14:06:32 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 07/16] mm: stats: make smap stats understand PUD THPs.
Date:   Wed,  2 Sep 2020 14:06:19 -0400
Message-Id: <20200902180628.4052244-8-zi.yan@sent.com>
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

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 fs/proc/task_mmu.c | 63 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 7fc9b3cc48d3..2ff80a9c8b57 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -430,10 +430,9 @@ static void smaps_page_accumulate(struct mem_size_stats *mss,
 }
 
 static void smaps_account(struct mem_size_stats *mss, struct page *page,
-		bool compound, bool young, bool dirty, bool locked)
+		unsigned long size, bool young, bool dirty, bool locked)
 {
-	int i, nr = compound ? compound_nr(page) : 1;
-	unsigned long size = nr * PAGE_SIZE;
+	int i, nr = size / PAGE_SIZE;
 
 	/*
 	 * First accumulate quantities that depend only on |size| and the type
@@ -536,7 +535,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	if (!page)
 		return;
 
-	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte), locked);
+	smaps_account(mss, page, PAGE_SIZE, pte_young(*pte), pte_dirty(*pte), locked);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -567,8 +566,44 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 		/* pass */;
 	else
 		mss->file_thp += HPAGE_PMD_SIZE;
-	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd), locked);
+	smaps_account(mss, page, HPAGE_PMD_SIZE, pmd_young(*pmd),
+		      pmd_dirty(*pmd), locked);
 }
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+static void smaps_pud_entry(pud_t *pud, unsigned long addr,
+		struct mm_walk *walk)
+{
+	struct mem_size_stats *mss = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	bool locked = !!(vma->vm_flags & VM_LOCKED);
+	struct page *page = NULL;
+
+	if (pud_present(*pud)) {
+		/* FOLL_DUMP will return -EFAULT on huge zero page */
+		page = follow_trans_huge_pud(vma, addr, pud, FOLL_DUMP);
+	}
+	if (IS_ERR_OR_NULL(page))
+		return;
+	if (PageAnon(page))
+		mss->anonymous_thp += HPAGE_PUD_SIZE;
+	else if (PageSwapBacked(page))
+		mss->shmem_thp += HPAGE_PUD_SIZE;
+	else if (is_zone_device_page(page))
+		/* pass */;
+	else
+		mss->file_thp += HPAGE_PUD_SIZE;
+	smaps_account(mss, page, HPAGE_PUD_SIZE, pud_young(*pud),
+		      pud_dirty(*pud), locked);
+}
+#else
+static void smaps_pud_entry(pud_t *pud, unsigned long addr,
+		struct mm_walk *walk)
+{
+}
+#endif
+
+
 #else
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 		struct mm_walk *walk)
@@ -576,6 +611,23 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 }
 #endif
 
+static int smaps_pud_range(pud_t *pud, unsigned long addr, unsigned long end,
+			   struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+	spinlock_t *ptl;
+
+	ptl = pud_trans_huge_lock(pud, vma);
+	if (ptl) {
+		smaps_pud_entry(pud, addr, walk);
+		spin_unlock(ptl);
+		walk->action = ACTION_CONTINUE;
+	}
+
+	cond_resched();
+	return 0;
+}
+
 static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			   struct mm_walk *walk)
 {
@@ -713,6 +765,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 #endif /* HUGETLB_PAGE */
 
 static const struct mm_walk_ops smaps_walk_ops = {
+	.pud_entry		= smaps_pud_range,
 	.pmd_entry		= smaps_pte_range,
 	.hugetlb_entry		= smaps_hugetlb_range,
 };
-- 
2.28.0

