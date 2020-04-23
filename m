Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7828BC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7592074F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgDWM0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgDWM0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:26:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C6BC08E859;
        Thu, 23 Apr 2020 05:26:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRawD-0005GT-Pq; Thu, 23 Apr 2020 14:26:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 68F581C0244;
        Thu, 23 Apr 2020 14:26:41 +0200 (CEST)
Date:   Thu, 23 Apr 2020 12:26:41 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Cleanup pgprot_4k_2_large() and pgprot_large_2_4k()
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200408152745.1565832-4-hch@lst.de>
References: <20200408152745.1565832-4-hch@lst.de>
MIME-Version: 1.0
Message-ID: <158764480102.28353.2171209150662834670.tip-bot2@tip-bot2>
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

Commit-ID:     d073569363d9f076a568ce8c31250d332ccf33ce
Gitweb:        https://git.kernel.org/tip/d073569363d9f076a568ce8c31250d332ccf33ce
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Wed, 08 Apr 2020 17:27:44 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 23 Apr 2020 11:31:52 +02:00

x86/mm: Cleanup pgprot_4k_2_large() and pgprot_large_2_4k()

Make use of lower level helpers that operate on the raw protection
values to make the code a little easier to understand, and to also
avoid extra conversions in a few callers.

[ Qian: Fix a wrongly placed bracket in the original submission.
  Reported and fixed by Qian Cai <cai@lca.pw>. Details in second
  Link: below. ]

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200408152745.1565832-4-hch@lst.de
Link: https://lkml.kernel.org/r/1ED37D02-125F-4919-861A-371981581D9E@lca.pw
---
 arch/x86/include/asm/pgtable_types.h | 26 +++++++++++++-------------
 arch/x86/mm/init_64.c                |  2 +-
 arch/x86/mm/pgtable.c                |  8 ++------
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 75fe903..a3b78d8 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -488,24 +488,24 @@ static inline pgprot_t cachemode2pgprot(enum page_cache_mode pcm)
 {
 	return __pgprot(cachemode2protval(pcm));
 }
-static inline pgprot_t pgprot_4k_2_large(pgprot_t pgprot)
+static inline unsigned long protval_4k_2_large(unsigned long val)
 {
-	pgprotval_t val = pgprot_val(pgprot);
-	pgprot_t new;
-
-	pgprot_val(new) = (val & ~(_PAGE_PAT | _PAGE_PAT_LARGE)) |
+	return (val & ~(_PAGE_PAT | _PAGE_PAT_LARGE)) |
 		((val & _PAGE_PAT) << (_PAGE_BIT_PAT_LARGE - _PAGE_BIT_PAT));
-	return new;
+}
+static inline pgprot_t pgprot_4k_2_large(pgprot_t pgprot)
+{
+	return __pgprot(protval_4k_2_large(pgprot_val(pgprot)));
+}
+static inline unsigned long protval_large_2_4k(unsigned long val)
+{
+	return (val & ~(_PAGE_PAT | _PAGE_PAT_LARGE)) |
+		((val & _PAGE_PAT_LARGE) >>
+		 (_PAGE_BIT_PAT_LARGE - _PAGE_BIT_PAT));
 }
 static inline pgprot_t pgprot_large_2_4k(pgprot_t pgprot)
 {
-	pgprotval_t val = pgprot_val(pgprot);
-	pgprot_t new;
-
-	pgprot_val(new) = (val & ~(_PAGE_PAT | _PAGE_PAT_LARGE)) |
-			  ((val & _PAGE_PAT_LARGE) >>
-			   (_PAGE_BIT_PAT_LARGE - _PAGE_BIT_PAT));
-	return new;
+	return __pgprot(protval_large_2_4k(pgprot_val(pgprot)));
 }
 
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3b289c2..9a497ba 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -367,7 +367,7 @@ static void __init __init_extra_mapping(unsigned long phys, unsigned long size,
 	pgprot_t prot;
 
 	pgprot_val(prot) = pgprot_val(PAGE_KERNEL_LARGE) |
-		pgprot_val(pgprot_4k_2_large(cachemode2pgprot(cache)));
+		protval_4k_2_large(cachemode2protval(cache));
 	BUG_ON((phys & ~PMD_MASK) || (size & ~PMD_MASK));
 	for (; size; phys += PMD_SIZE, size -= PMD_SIZE) {
 		pgd = pgd_offset_k((unsigned long)__va(phys));
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 7bd2c3a..c54d1d0 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -706,11 +706,9 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 	if (pud_present(*pud) && !pud_huge(*pud))
 		return 0;
 
-	prot = pgprot_4k_2_large(prot);
-
 	set_pte((pte_t *)pud, pfn_pte(
 		(u64)addr >> PAGE_SHIFT,
-		__pgprot(pgprot_val(prot) | _PAGE_PSE)));
+		__pgprot(protval_4k_2_large(pgprot_val(prot)) | _PAGE_PSE)));
 
 	return 1;
 }
@@ -738,11 +736,9 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 	if (pmd_present(*pmd) && !pmd_huge(*pmd))
 		return 0;
 
-	prot = pgprot_4k_2_large(prot);
-
 	set_pte((pte_t *)pmd, pfn_pte(
 		(u64)addr >> PAGE_SHIFT,
-		__pgprot(pgprot_val(prot) | _PAGE_PSE)));
+		__pgprot(protval_4k_2_large(pgprot_val(prot)) | _PAGE_PSE)));
 
 	return 1;
 }
