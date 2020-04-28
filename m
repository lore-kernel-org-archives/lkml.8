Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9391DC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A1B21835
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OqSmLHbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgD1Tox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728392AbgD1Tow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:44:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B6C03C1AB;
        Tue, 28 Apr 2020 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mmyTjSbJYQT19h+SSwsn2alKEzL4pRfFj3gXPGGOohs=; b=OqSmLHbudpXM8xgCNaG6O6ox90
        yQDAbSGzjOpH8T7sm/U/yRXs1ByPwe6ZMACLgLSqU/aNQqJR8NVvLI3Ae4kC4EXO2m84MGnS/9GBm
        NrEEHOLdyXMoRHBg4CKtnNAS1pVGqqaZNfwqVXO0imN1zlRKj9A00yNxHQSi4AW6aSbNo+3C0aqW3
        NsWQATiJyBU3vUIXBtfIbj1bSI79cQpVYPBU2sLaK1vIA5s/coVOHjfef1CyMe2n4jtmfx8aXO6Ck
        Ss0icyHuPUGhkN01lqiveXPfF98eSNYKiiJcIag1briN8yZ6pGYpsmqoa7T/O4tMguz9e1YHVxQT1
        mGTspBVg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTW9y-0005uU-UU; Tue, 28 Apr 2020 19:44:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 2/7] mm: Move pt_mm within struct page
Date:   Tue, 28 Apr 2020 12:44:44 -0700
Message-Id: <20200428194449.22615-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428194449.22615-1-willy@infradead.org>
References: <20200428194449.22615-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Instead of a per-arch word within struct page, use a formerly reserved
word.  This word is shared with page->mapping, so it must be cleared
before being freed as it is checked in free_pages().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/x86/mm/pgtable.c    | 1 +
 include/linux/mm_types.h | 7 ++-----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 7bd2c3a52297..f5f46737aea0 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -95,6 +95,7 @@ static inline void pgd_list_del(pgd_t *pgd)
 	struct page *page = virt_to_page(pgd);
 
 	list_del(&page->lru);
+	page->pt_mm = NULL;
 }
 
 #define UNSHARED_PTRS_PER_PGD				\
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9bb34e2cd5a5..7efa12f4626f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -149,11 +149,8 @@ struct page {
 					pgtable_t pmd_huge_pte;
 				};
 			};
-			unsigned long _pt_pad_2;	/* mapping */
-			union {
-				struct mm_struct *pt_mm; /* x86 pgds only */
-				atomic_t pt_frag_refcount; /* powerpc */
-			};
+			struct mm_struct *pt_mm;
+			atomic_t pt_frag_refcount; /* powerpc */
 #if ALLOC_SPLIT_PTLOCKS
 			spinlock_t *ptl;
 #else
-- 
2.26.2

