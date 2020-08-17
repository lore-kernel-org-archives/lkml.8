Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC82C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79AF2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgHQJUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:20:42 -0400
Received: from foss.arm.com ([217.140.110.172]:51654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbgHQJUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:20:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82C211063;
        Mon, 17 Aug 2020 02:20:38 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.65.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2C4A3F6CF;
        Mon, 17 Aug 2020 02:20:34 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64/mm: Enable THP migration
Date:   Mon, 17 Aug 2020 14:49:44 +0530
Message-Id: <1597655984-15428-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597655984-15428-1-git-send-email-anshuman.khandual@arm.com>
References: <1597655984-15428-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain page migration situations, a THP page can be migrated without
being split into it's constituent subpages. This saves time required to
split a THP and put it back together when required. But it also saves an
wider address range translation covered by a single TLB entry, reducing
future page fault costs.

A previous patch changed platform THP helpers per generic memory semantics,
clearing the path for THP migration support. This adds two more THP helpers
required to create PMD migration swap entries. Now just enable HP migration
via ARCH_ENABLE_THP_MIGRATION.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig               | 4 ++++
 arch/arm64/include/asm/pgtable.h | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..e21b94061780 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1876,6 +1876,10 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	def_bool y
 	depends on HUGETLB_PAGE && MIGRATION
 
+config ARCH_ENABLE_THP_MIGRATION
+	def_bool y
+	depends on TRANSPARENT_HUGEPAGE
+
 menu "Power management options"
 
 source "kernel/power/Kconfig"
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7aa69cace784..c54334bca4e2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -875,6 +875,11 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
 
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+#define __pmd_to_swp_entry(pmd)		((swp_entry_t) { pmd_val(pmd) })
+#define __swp_entry_to_pmd(swp)		__pmd((swp).val)
+#endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
+
 /*
  * Ensure that there are not more swap files than can be encoded in the kernel
  * PTEs.
-- 
2.20.1

