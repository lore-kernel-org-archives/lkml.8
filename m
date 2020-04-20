Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22716C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0584620735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgDTNag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728077AbgDTNaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:30:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69642C061A0C;
        Mon, 20 Apr 2020 06:30:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jQWVI-0005M2-TI; Mon, 20 Apr 2020 15:30:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7ABFC1C007F;
        Mon, 20 Apr 2020 15:30:28 +0200 (CEST)
Date:   Mon, 20 Apr 2020 13:30:28 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Move pgprot2cachemode out of line
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200408152745.1565832-3-hch@lst.de>
References: <20200408152745.1565832-3-hch@lst.de>
MIME-Version: 1.0
Message-ID: <158738942809.28353.13983068811778486058.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     7fa3e10f0f3646108a1018004d0f571c3222dc9f
Gitweb:        https://git.kernel.org/tip/7fa3e10f0f3646108a1018004d0f571c3222dc9f
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Wed, 08 Apr 2020 17:27:43 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Apr 2020 12:39:17 +02:00

x86/mm: Move pgprot2cachemode out of line

This helper is only used by x86 low-level MM code.  Also remove the
entirely pointless __pte2cachemode_tbl export as that symbol can be
marked static now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200408152745.1565832-3-hch@lst.de
---
 arch/x86/include/asm/memtype.h       |  1 +
 arch/x86/include/asm/pgtable_types.h | 10 ----------
 arch/x86/mm/init.c                   | 13 +++++++++++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/memtype.h b/arch/x86/include/asm/memtype.h
index 1e4e99b..9ca760e 100644
--- a/arch/x86/include/asm/memtype.h
+++ b/arch/x86/include/asm/memtype.h
@@ -25,5 +25,6 @@ extern void memtype_free_io(resource_size_t start, resource_size_t end);
 extern bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn);
 
 bool x86_has_pat_wp(void);
+enum page_cache_mode pgprot2cachemode(pgprot_t pgprot);
 
 #endif /* _ASM_X86_MEMTYPE_H */
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b6606fe..75fe903 100644
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
index 6005f83..4a55d68 100644
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
