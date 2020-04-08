Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2D4C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D828C2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jY68PtHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgDHP2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:28:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgDHP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description;
        bh=1vJ4KODD1Wr5g+Nz62xPqEGrImj0j+de2XTseRI48F4=; b=jY68PtHqZhSO/zyAj//c0GgMNI
        TbnujAwoqI+pZhW6P0LfJNmGOC3CuRhwTLFYejmx+7cZ4bWe0HPIlsxVWXbO7exIOSZmYe2vVfZhd
        tFr7te8jkX2v71191h1jdLZ02/e7sEhi4Qx1rVL1Hjkq7a6vLHZl5QPH43J+kGN8wKd8RgKK9fFvS
        ezUCCqSn2jruVfz2z0m0fAVAEpm+++4l/XgBKhICdQNMvDZzglEtrmAexnvDeDlDXnMKV3pOWxESg
        Yil0IojlERb5LarveeMBcNI9j618fJOEj8GZblZ6YfaUCBmEbTigJVW7LzoyXbYFLDeB7M96D7jEv
        fwN7hbyA==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMCcR-00080M-32; Wed, 08 Apr 2020 15:27:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] x86/mm: Unexport __cachemode2pte_tbl
Date:   Wed,  8 Apr 2020 17:27:45 +0200
Message-Id: <20200408152745.1565832-5-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408152745.1565832-1-hch@lst.de>
References: <20200408152745.1565832-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exporting the raw data for a table is generally a bad idea.  Move
cachemode2protval out of line given that it isn't really used in the
fast path, and then mark __cachemode2pte_tbl static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/pgtable_types.h | 14 ++------------
 arch/x86/mm/init.c                   | 11 +++++++++--
 arch/x86/mm/pat/set_memory.c         |  5 +++++
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index a3b78d84b26a..567abdbd64d3 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -467,8 +467,6 @@ static inline pteval_t pte_flags(pte_t pte)
 	return native_pte_val(pte) & PTE_FLAGS_MASK;
 }
 
-extern uint16_t __cachemode2pte_tbl[_PAGE_CACHE_MODE_NUM];
-
 #define __pte2cm_idx(cb)				\
 	((((cb) >> (_PAGE_BIT_PAT - 2)) & 4) |		\
 	 (((cb) >> (_PAGE_BIT_PCD - 1)) & 2) |		\
@@ -478,16 +476,8 @@ extern uint16_t __cachemode2pte_tbl[_PAGE_CACHE_MODE_NUM];
 	 (((i) & 2) << (_PAGE_BIT_PCD - 1)) |		\
 	 (((i) & 1) << _PAGE_BIT_PWT))
 
-static inline unsigned long cachemode2protval(enum page_cache_mode pcm)
-{
-	if (likely(pcm == 0))
-		return 0;
-	return __cachemode2pte_tbl[pcm];
-}
-static inline pgprot_t cachemode2pgprot(enum page_cache_mode pcm)
-{
-	return __pgprot(cachemode2protval(pcm));
-}
+unsigned long cachemode2protval(enum page_cache_mode pcm);
+
 static inline unsigned long protval_4k_2_large(unsigned long val)
 {
 	return (val & ~(_PAGE_PAT | _PAGE_PAT_LARGE)) |
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 8482ee51b225..4a8d0d67e729 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -49,7 +49,7 @@
  *   Index into __pte2cachemode_tbl[] are the caching attribute bits of the pte
  *   (_PAGE_PWT, _PAGE_PCD, _PAGE_PAT) at index bit positions 0, 1, 2.
  */
-uint16_t __cachemode2pte_tbl[_PAGE_CACHE_MODE_NUM] = {
+static uint16_t __cachemode2pte_tbl[_PAGE_CACHE_MODE_NUM] = {
 	[_PAGE_CACHE_MODE_WB      ]	= 0         | 0        ,
 	[_PAGE_CACHE_MODE_WC      ]	= 0         | _PAGE_PCD,
 	[_PAGE_CACHE_MODE_UC_MINUS]	= 0         | _PAGE_PCD,
@@ -57,7 +57,14 @@ uint16_t __cachemode2pte_tbl[_PAGE_CACHE_MODE_NUM] = {
 	[_PAGE_CACHE_MODE_WT      ]	= 0         | _PAGE_PCD,
 	[_PAGE_CACHE_MODE_WP      ]	= 0         | _PAGE_PCD,
 };
-EXPORT_SYMBOL(__cachemode2pte_tbl);
+
+unsigned long cachemode2protval(enum page_cache_mode pcm)
+{
+	if (likely(pcm == 0))
+		return 0;
+	return __cachemode2pte_tbl[pcm];
+}
+EXPORT_SYMBOL(cachemode2protval);
 
 static uint8_t __pte2cachemode_tbl[8] = {
 	[__pte2cm_idx( 0        | 0         | 0        )] = _PAGE_CACHE_MODE_WB,
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 6d5424069e2b..b8ee3f4e8202 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -68,6 +68,11 @@ static DEFINE_SPINLOCK(cpa_lock);
 #define CPA_PAGES_ARRAY 4
 #define CPA_NO_CHECK_ALIAS 8 /* Do not search for aliases */
 
+static inline pgprot_t cachemode2pgprot(enum page_cache_mode pcm)
+{
+	return __pgprot(cachemode2protval(pcm));
+}
+
 #ifdef CONFIG_PROC_FS
 static unsigned long direct_pages_count[PG_LEVEL_NUM];
 
-- 
2.25.1

