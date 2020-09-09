Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A67C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2825D21D43
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgIIExu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 00:53:50 -0400
Received: from foss.arm.com ([217.140.110.172]:37772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgIIExt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 00:53:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 947691063;
        Tue,  8 Sep 2020 21:53:48 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.71.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA1E33F68F;
        Tue,  8 Sep 2020 21:53:44 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, catalin.marinas@arm.com,
        akpm@linux-foundation.org, rcampbell@nvidia.com, ziy@nvidia.com,
        Jonathan.Cameron@Huawei.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] arm64/mm: Change THP helpers to comply with generic MM semantics
Date:   Wed,  9 Sep 2020 10:23:02 +0530
Message-Id: <1599627183-14453-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599627183-14453-1-git-send-email-anshuman.khandual@arm.com>
References: <1599627183-14453-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmd_present() and pmd_trans_huge() are expected to behave in the following
manner during various phases of a given PMD. It is derived from a previous
detailed discussion on this topic [1] and present THP documentation [2].

pmd_present(pmd):

- Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
- Returns false if pmd refers to a migration or swap entry

pmd_trans_huge(pmd):

- Returns true if pmd refers to system RAM and is a trans huge mapping

-------------------------------------------------------------------------
|	PMD states	|	pmd_present	|	pmd_trans_huge	|
-------------------------------------------------------------------------
|	Mapped		|	Yes		|	Yes		|
-------------------------------------------------------------------------
|	Splitting	|	Yes		|	Yes		|
-------------------------------------------------------------------------
|	Migration/Swap	|	No		|	No		|
-------------------------------------------------------------------------

The problem:

PMD is first invalidated with pmdp_invalidate() before it's splitting. This
invalidation clears PMD_SECT_VALID as below.

PMD Split -> pmdp_invalidate() -> pmd_mkinvalid -> Clears PMD_SECT_VALID

Once PMD_SECT_VALID gets cleared, it results in pmd_present() return false
on the PMD entry. It will need another bit apart from PMD_SECT_VALID to re-
affirm pmd_present() as true during the THP split process. To comply with
above mentioned semantics, pmd_trans_huge() should also check pmd_present()
first before testing presence of an actual transparent huge mapping.

The solution:

Ideally PMD_TYPE_SECT should have been used here instead. But it shares the
bit position with PMD_SECT_VALID which is used for THP invalidation. Hence
it will not be there for pmd_present() check after pmdp_invalidate().

A new software defined PMD_PRESENT_INVALID (bit 59) can be set on the PMD
entry during invalidation which can help pmd_present() return true and in
recognizing the fact that it still points to memory.

This bit is transient. During the split process it will be overridden by a
page table page representing normal pages in place of erstwhile huge page.
Other pmdp_invalidate() callers always write a fresh PMD value on the entry
overriding this transient PMD_PRESENT_INVALID bit, which makes it safe.

[1]: https://lkml.org/lkml/2018/10/17/231
[2]: https://www.kernel.org/doc/Documentation/vm/transhuge.txt

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h |  7 ++++++
 arch/arm64/include/asm/pgtable.h      | 34 ++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 4d867c6446c4..2df4b75fce3c 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -19,6 +19,13 @@
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
 #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
 
+/*
+ * This bit indicates that the entry is present i.e. pmd_page()
+ * still points to a valid huge page in memory even if the pmd
+ * has been invalidated.
+ */
+#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
+
 #ifndef __ASSEMBLY__
 
 #include <asm/cpufeature.h>
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index d5d3fbe73953..d8258ae8fce0 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -145,6 +145,18 @@ static inline pte_t set_pte_bit(pte_t pte, pgprot_t prot)
 	return pte;
 }
 
+static inline pmd_t clear_pmd_bit(pmd_t pmd, pgprot_t prot)
+{
+	pmd_val(pmd) &= ~pgprot_val(prot);
+	return pmd;
+}
+
+static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
+{
+	pmd_val(pmd) |= pgprot_val(prot);
+	return pmd;
+}
+
 static inline pte_t pte_wrprotect(pte_t pte)
 {
 	pte = clear_pte_bit(pte, __pgprot(PTE_WRITE));
@@ -363,15 +375,24 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif
 
+#define pmd_present_invalid(pmd)     (!!(pmd_val(pmd) & PMD_PRESENT_INVALID))
+
+static inline int pmd_present(pmd_t pmd)
+{
+	return pte_present(pmd_pte(pmd)) || pmd_present_invalid(pmd);
+}
+
 /*
  * THP definitions.
  */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	return pmd_val(pmd) && pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-#define pmd_present(pmd)	pte_present(pmd_pte(pmd))
 #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
 #define pmd_valid(pmd)		pte_valid(pmd_pte(pmd))
@@ -381,7 +402,14 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
-#define pmd_mkinvalid(pmd)	(__pmd(pmd_val(pmd) & ~PMD_SECT_VALID))
+
+static inline pmd_t pmd_mkinvalid(pmd_t pmd)
+{
+	pmd = set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
+	pmd = clear_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
+
+	return pmd;
+}
 
 #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
 
-- 
2.20.1

