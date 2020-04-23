Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C35C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACAB2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgDWM0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726797AbgDWM0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:26:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C6AC08ED7D;
        Thu, 23 Apr 2020 05:26:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRawD-0005GD-Ac; Thu, 23 Apr 2020 14:26:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E836B1C0450;
        Thu, 23 Apr 2020 14:26:40 +0200 (CEST)
Date:   Thu, 23 Apr 2020 12:26:40 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Unexport __cachemode2pte_tbl
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200408152745.1565832-5-hch@lst.de>
References: <20200408152745.1565832-5-hch@lst.de>
MIME-Version: 1.0
Message-ID: <158764480048.28353.9341195388795247710.tip-bot2@tip-bot2>
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

Commit-ID:     de17a37896e1ad9e17ebd5274a50c33e18c9cb90
Gitweb:        https://git.kernel.org/tip/de17a37896e1ad9e17ebd5274a50c33e18c9cb90
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Wed, 08 Apr 2020 17:27:45 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 23 Apr 2020 11:34:31 +02:00

x86/mm: Unexport __cachemode2pte_tbl

Exporting the raw data for a table is generally a bad idea. Move
cachemode2protval() out of line given that it isn't really used in the
fast path, and then mark __cachemode2pte_tbl static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200408152745.1565832-5-hch@lst.de
---
 arch/x86/include/asm/pgtable_types.h | 14 ++------------
 arch/x86/mm/init.c                   | 11 +++++++++--
 arch/x86/mm/pat/set_memory.c         |  5 +++++
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index a3b78d8..567abdb 100644
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
index 4a55d68..71720dd 100644
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
index 59eca6a..a28f0c3 100644
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
 
