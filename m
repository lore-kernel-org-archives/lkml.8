Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C225FC2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953CC2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tjsu90MW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgDHP14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:27:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgDHP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description;
        bh=OoL3xfc4ZyM4+fjf1W+JBORLUxTwPT7YqdnTagKomoI=; b=tjsu90MWgGgNc5oTFox6Y/O6u5
        WOHoIVqi/4cHMemAemUTDjFVp4tiZtrwJJW96ZFGXhCpYs78aSRY+s559DR3gEjhHQYMEBv3/AEPz
        ZBZZlsYlt4zv3bzh89rIcWGW3CGye8ILbX0BBs3K4rWn/PMOY3OfQRyrBWCGstIZsWhxBcnH39M97
        GIjFDy67JkpJnEo1a88LcsaHOZ4W4/n1fu9L6s8164BkRUQtB38KLQG6TOQxBMrRNbFyztcxMRhwK
        OUsyH80Or28HUPjxHuKe8QloPC2b+kHCfmexQUgPGCThQiKnQR9MtVXCsZrKRYfyrQ4LST4CrzH0O
        r98vlQ1Q==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMCcL-0007zC-Fj; Wed, 08 Apr 2020 15:27:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] x86/mm: Move pgprot2cachemode out of line
Date:   Wed,  8 Apr 2020 17:27:43 +0200
Message-Id: <20200408152745.1565832-3-hch@lst.de>
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

This helper is only used by x86 low-level MM code.  Also remove the
entirely pointless __pte2cachemode_tbl export as that symbol can be
marked static now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/memtype.h       |  1 +
 arch/x86/include/asm/pgtable_types.h | 10 ----------
 arch/x86/mm/init.c                   | 13 +++++++++++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/memtype.h b/arch/x86/include/asm/memtype.h
index 1e4e99b40711..9ca760e430b9 100644
--- a/arch/x86/include/asm/memtype.h
+++ b/arch/x86/include/asm/memtype.h
@@ -25,5 +25,6 @@ extern void memtype_free_io(resource_size_t start, resource_size_t end);
 extern bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn);
 
 bool x86_has_pat_wp(void);
+enum page_cache_mode pgprot2cachemode(pgprot_t pgprot);
 
 #endif /* _ASM_X86_MEMTYPE_H */
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b6606fe6cfdf..75fe903124f8 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -468,7 +468,6 @@ static inline pteval_t pte_flags(pte_t pte)
 }
 
 extern uint16_t __cachemode2pte_tbl[_PAGE_CACHE_MODE_NUM];
-extern uint8_t __pte2cachemode_tbl[8];
 
 #define __pte2cm_idx(cb)				\
 	((((cb) >> (_PAGE_BIT_PAT - 2)) & 4) |		\
@@ -489,15 +488,6 @@ static inline pgprot_t cachemode2pgprot(enum page_cache_mode pcm)
 {
 	return __pgprot(cachemode2protval(pcm));
 }
-static inline enum page_cache_mode pgprot2cachemode(pgprot_t pgprot)
-{
-	unsigned long masked;
-
-	masked = pgprot_val(pgprot) & _PAGE_CACHE_MASK;
-	if (likely(masked == 0))
-		return 0;
-	return __pte2cachemode_tbl[__pte2cm_idx(masked)];
-}
 static inline pgprot_t pgprot_4k_2_large(pgprot_t pgprot)
 {
 	pgprotval_t val = pgprot_val(pgprot);
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 83e5780768ad..8482ee51b225 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -59,7 +59,7 @@ uint16_t __cachemode2pte_tbl[_PAGE_CACHE_MODE_NUM] = {
 };
 EXPORT_SYMBOL(__cachemode2pte_tbl);
 
-uint8_t __pte2cachemode_tbl[8] = {
+static uint8_t __pte2cachemode_tbl[8] = {
 	[__pte2cm_idx( 0        | 0         | 0        )] = _PAGE_CACHE_MODE_WB,
 	[__pte2cm_idx(_PAGE_PWT | 0         | 0        )] = _PAGE_CACHE_MODE_UC_MINUS,
 	[__pte2cm_idx( 0        | _PAGE_PCD | 0        )] = _PAGE_CACHE_MODE_UC_MINUS,
@@ -69,7 +69,6 @@ uint8_t __pte2cachemode_tbl[8] = {
 	[__pte2cm_idx(0         | _PAGE_PCD | _PAGE_PAT)] = _PAGE_CACHE_MODE_UC_MINUS,
 	[__pte2cm_idx(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)] = _PAGE_CACHE_MODE_UC,
 };
-EXPORT_SYMBOL(__pte2cachemode_tbl);
 
 /* Check that the write-protect PAT entry is set for write-protect */
 bool x86_has_pat_wp(void)
@@ -77,6 +76,16 @@ bool x86_has_pat_wp(void)
 	return __pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] == _PAGE_CACHE_MODE_WP;
 }
 
+enum page_cache_mode pgprot2cachemode(pgprot_t pgprot)
+{
+	unsigned long masked;
+
+	masked = pgprot_val(pgprot) & _PAGE_CACHE_MASK;
+	if (likely(masked == 0))
+		return 0;
+	return __pte2cachemode_tbl[__pte2cm_idx(masked)];
+}
+
 static unsigned long __initdata pgt_buf_start;
 static unsigned long __initdata pgt_buf_end;
 static unsigned long __initdata pgt_buf_top;
-- 
2.25.1

