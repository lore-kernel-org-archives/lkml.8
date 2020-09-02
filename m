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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36656C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008FB206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="K2KV2DVW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YPWKC0BX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgIBSHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42743 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727945AbgIBSGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 277195C0144;
        Wed,  2 Sep 2020 14:06:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=9wI5eSYIGtV+C
        JbXh5SLtYPlAilzT8nVnNMnj6skQGo=; b=K2KV2DVWtRcdX3QiWB3+l4EPkOlif
        7hjYtzHbMVjwAb6fUCN65GC1CLfMKL2VCq5F88xbuX4BVVQd4qsWZ/aGyjp6jpPf
        EKk/7dk+++Htiu9n1t7TUXcntIGgQEUIqTj3qD1ZQqKgsDJVORxcGKCuwnx0b3Ir
        Y0K7kJjqoOwC9XlMZccZVFqQkWVay+9k9xGaMfIOAp2m3hONQtSHGifldo+NETEO
        If3C4rsQeW4V9GdTp4OVhRgXLKBlKR4PnMxA/4lG40KuWx5x1TAWtOgct9dwr46v
        8havT3dmN9Nd567Yo9Ex2dUOLyRft4Wji4GWs0PU8JWTz5Rby8DpfM5fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=9wI5eSYIGtV+CJbXh5SLtYPlAilzT8nVnNMnj6skQGo=; b=YPWKC0BX
        l4CP15MFklKrY6Uf2JRlHyi/6ltWioVeafteVm7XVZu43P+jd222Cns+lSDQgV7L
        Uq7Vd+G/DzmS2lZi4+5UIjbCnuS6FyP7HmcdRTkObHxjlMxcPU2R4X80vn10WUbM
        MmBQXVnDdTbK3CCOEwD+vFfYoYkF9n34cH9Psm1xIq0loXqBoTuysISFfh09URN4
        /hA/U8RR7M0sil9DVccoSq86cF0sDKJdbkdMKIvG3rXgFEIS9b5ZOJLag6Se338N
        gd5ZDzNbFGP5Xg6MS692bceOgFvlRpUuVAuVuofVXfVXp63Y2BVh6XGBJ8sACqmq
        oNdImj6sgGn/ew==
X-ME-Sender: <xms:Kd9PX1dTEp2LhMJjpIsRjxRIDMUnfDjUQB0yk62iKsAxviF8QOVEFA>
    <xme:Kd9PXzPC1-UI04TrhD6jR2_cBh5QQekSgNHVa9RitF7Ywdz2vZ7kvKna9rK25K44-
    XjnDfO5Ayz2rskM6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:Kd9PX-jZu-0TzyZZJbG7Q_D0YfFvwCZ6nrqLiotUY272A45OKR7g7Q>
    <xmx:Kd9PX--jhVWplrjZhUOY2AKUypgPynzjtyqdLSdW1T3gOdeiBmWgNQ>
    <xmx:Kd9PXxtLxxkOlON4Sr_OiDo8m9QLQ4QBPHDGQHJBT9ImKPDUHCx-xA>
    <xmx:Kt9PXy8_0hxouAhPic-YJx2y7HhGjT3XDDjVefSZwNCUCP-SNRYCSA>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5C90030600B7;
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
Subject: [RFC PATCH 11/16] mm: thp: 1GB THP follow_p*d_page() support.
Date:   Wed,  2 Sep 2020 14:06:23 -0400
Message-Id: <20200902180628.4052244-12-zi.yan@sent.com>
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

Add follow_page support for 1GB THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 11 +++++++
 mm/gup.c                | 60 ++++++++++++++++++++++++++++++++-
 mm/huge_memory.c        | 73 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 589e5af5a1c2..c7bc40c4a5e2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -20,6 +20,10 @@ extern int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 extern void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud);
 extern int do_huge_pud_anonymous_page(struct vm_fault *vmf);
 extern vm_fault_t do_huge_pud_wp_page(struct vm_fault *vmf, pud_t orig_pud);
+extern struct page *follow_trans_huge_pud(struct vm_area_struct *vma,
+					  unsigned long addr,
+					  pud_t *pud,
+					  unsigned int flags);
 #else
 static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 {
@@ -32,6 +36,13 @@ extern vm_fault_t do_huge_pud_wp_page(struct vm_fault *vmf, pud_t orig_pud)
 {
 	return VM_FAULT_FALLBACK;
 }
+struct page *follow_trans_huge_pud(struct vm_area_struct *vma,
+					  unsigned long addr,
+					  pud_t *pud,
+					  unsigned int flags)
+{
+	return NULL;
+}
 #endif
 
 extern vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd);
diff --git a/mm/gup.c b/mm/gup.c
index bd883a112724..4b32ae3c5fa2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -698,10 +698,68 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 		if (page)
 			return page;
 	}
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	if (likely(!pud_trans_huge(*pud))) {
+		if (unlikely(pud_bad(*pud)))
+			return no_page_table(vma, flags);
+		return follow_pmd_mask(vma, address, pud, flags, ctx);
+	}
+
+	ptl = pud_lock(mm, pud);
+
+	if (unlikely(!pud_trans_huge(*pud))) {
+		spin_unlock(ptl);
+		if (unlikely(pud_bad(*pud)))
+			return no_page_table(vma, flags);
+		return follow_pmd_mask(vma, address, pud, flags, ctx);
+	}
+
+	if (flags & FOLL_SPLIT) {
+		int ret;
+		pmd_t *pmd = NULL;
+
+		page = pud_page(*pud);
+		if (is_huge_zero_page(page)) {
+
+			spin_unlock(ptl);
+			ret = 0;
+			split_huge_pud(vma, pud, address);
+			pmd = pmd_offset(pud, address);
+			split_huge_pmd(vma, pmd, address);
+			if (pmd_trans_unstable(pmd))
+				ret = -EBUSY;
+		} else {
+			get_page(page);
+			spin_unlock(ptl);
+			lock_page(page);
+			ret = split_huge_pud_page(page);
+			if (!ret)
+				ret = split_huge_page(page);
+			else {
+				unlock_page(page);
+				put_page(page);
+				goto out;
+			}
+			unlock_page(page);
+			put_page(page);
+			if (pud_none(*pud))
+				return no_page_table(vma, flags);
+			pmd = pmd_offset(pud, address);
+		}
+out:
+		return ret ? ERR_PTR(ret) :
+			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+	}
+	page = follow_trans_huge_pud(vma, address, pud, flags);
+	spin_unlock(ptl);
+	ctx->page_mask = HPAGE_PUD_NR - 1;
+	return page;
+#else
 	if (unlikely(pud_bad(*pud)))
 		return no_page_table(vma, flags);
-
 	return follow_pmd_mask(vma, address, pud, flags, ctx);
+#endif
 }
 
 static struct page *follow_p4d_mask(struct vm_area_struct *vma,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 398f1b52f789..e209c2dfc5b7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1259,6 +1259,77 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 	return page;
 }
 
+/*
+ * FOLL_FORCE can write to even unwritable pmd's, but only
+ * after we've gone through a COW cycle and they are dirty.
+ */
+static inline bool can_follow_write_pud(pud_t pud, unsigned int flags)
+{
+	return pud_write(pud) ||
+	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) && pud_dirty(pud));
+}
+
+struct page *follow_trans_huge_pud(struct vm_area_struct *vma,
+				   unsigned long addr,
+				   pud_t *pud,
+				   unsigned int flags)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct page *page = NULL;
+
+	assert_spin_locked(pud_lockptr(mm, pud));
+
+	if (flags & FOLL_WRITE && !can_follow_write_pud(*pud, flags))
+		goto out;
+
+	/* Avoid dumping huge zero page */
+	if ((flags & FOLL_DUMP) && is_huge_zero_pud(*pud))
+		return ERR_PTR(-EFAULT);
+
+	/* Full NUMA hinting faults to serialise migration in fault paths */
+	/*&& pud_protnone(*pmd)*/
+	if ((flags & FOLL_NUMA))
+		goto out;
+
+	page = pud_page(*pud);
+	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
+	if (flags & FOLL_TOUCH)
+		touch_pud(vma, addr, pud, flags);
+	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
+		/*
+		 * We don't mlock() pte-mapped THPs. This way we can avoid
+		 * leaking mlocked pages into non-VM_LOCKED VMAs.
+		 *
+		 * For anon THP:
+		 *
+		 * We do the same thing as PMD-level THP.
+		 *
+		 * For file THP:
+		 *
+		 * No support yet.
+		 *
+		 */
+
+		if (PageAnon(page) && compound_mapcount(page) != 1)
+			goto skip_mlock;
+		if (PagePUDDoubleMap(page) || !page->mapping)
+			goto skip_mlock;
+		if (!trylock_page(page))
+			goto skip_mlock;
+		lru_add_drain();
+		if (page->mapping && !PagePUDDoubleMap(page))
+			mlock_vma_page(page);
+		unlock_page(page);
+	}
+skip_mlock:
+	page += (addr & ~HPAGE_PUD_MASK) >> PAGE_SHIFT;
+	VM_BUG_ON_PAGE(!PageCompound(page) && !is_zone_device_page(page), page);
+	if (flags & FOLL_GET)
+		get_page(page);
+
+out:
+	return page;
+}
 int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
 		  struct vm_area_struct *vma)
@@ -1501,7 +1572,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 		goto out;
 
 	page = pmd_page(*pmd);
-	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
+	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page) && !PMDPageInPUD(page), page);
 
 	if (!try_grab_page(page, flags))
 		return ERR_PTR(-ENOMEM);
-- 
2.28.0

