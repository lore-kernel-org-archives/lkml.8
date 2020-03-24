Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB4FC54FCF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E710D207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCXFXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 01:23:40 -0400
Received: from foss.arm.com ([217.140.110.172]:57602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgCXFXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 01:23:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA3067FA;
        Mon, 23 Mar 2020 22:23:38 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F2AC73F7C3;
        Mon, 23 Mar 2020 22:27:40 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     christophe.leroy@c-s.fr,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] Documentation/mm: Add descriptions for arch page table helpers
Date:   Tue, 24 Mar 2020 10:52:55 +0530
Message-Id: <1585027375-9997-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585027375-9997-1-git-send-email-anshuman.khandual@arm.com>
References: <1585027375-9997-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes existing description from the test and instead adds a specific
description file for all arch page table helpers which is in sync with the
semantics being tested via CONFIG_DEBUG_VM_PGTABLE. All future changes
either to these descriptions here or the debug test should always remain
in sync.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/vm/arch_pgtable_helpers.rst | 256 ++++++++++++++++++++++
 mm/debug_vm_pgtable.c                     |  13 +-
 2 files changed, 259 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/vm/arch_pgtable_helpers.rst

diff --git a/Documentation/vm/arch_pgtable_helpers.rst b/Documentation/vm/arch_pgtable_helpers.rst
new file mode 100644
index 000000000000..1fc8a1d8932a
--- /dev/null
+++ b/Documentation/vm/arch_pgtable_helpers.rst
@@ -0,0 +1,256 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _arch_page_table_helpers:
+
+===============================
+Architecture Page Table Helpers
+===============================
+
+Generic MM expects architectures (with MMU) to provide helpers to create, access
+and modify page table entries at various level for different memory functions.
+These page table helpers need to conform to a common semantics across platforms.
+Following tables describe the expected semantics which can also be tested during
+boot via CONFIG_DEBUG_VM_PGTABLE option. All future changes in here or the debug
+test need to be in sync.
+
+======================
+PTE Page Table Helpers
+======================
+
+--------------------------------------------------------------------------------
+| pte_same                  | Tests whether both PTE entries are the same      |
+--------------------------------------------------------------------------------
+| pte_bad                   | Tests a non-table mapped PTE                     |
+--------------------------------------------------------------------------------
+| pte_present               | Tests a valid mapped PTE                         |
+--------------------------------------------------------------------------------
+| pte_young                 | Tests a young PTE                                |
+--------------------------------------------------------------------------------
+| pte_dirty                 | Tests a dirty PTE                                |
+--------------------------------------------------------------------------------
+| pte_write                 | Tests a writable PTE                             |
+--------------------------------------------------------------------------------
+| pte_special               | Tests a special PTE                              |
+--------------------------------------------------------------------------------
+| pte_protnone              | Tests a PROT_NONE PTE                            |
+--------------------------------------------------------------------------------
+| pte_devmap                | Tests a ZONE_DEVICE mapped PTE                   |
+--------------------------------------------------------------------------------
+| pte_soft_dirty            | Tests a soft dirty PTE                           |
+--------------------------------------------------------------------------------
+| pte_swp_soft_dirty        | Tests a soft dirty swapped PTE                   |
+--------------------------------------------------------------------------------
+| pte_mkyoung               | Creates a young PTE                              |
+--------------------------------------------------------------------------------
+| pte_mkold                 | Creates an old PTE                               |
+--------------------------------------------------------------------------------
+| pte_mkdirty               | Creates a dirty PTE                              |
+--------------------------------------------------------------------------------
+| pte_mkclean               | Creates a clean PTE                              |
+--------------------------------------------------------------------------------
+| pte_mkwrite               | Creates a writable PTE                           |
+--------------------------------------------------------------------------------
+| pte_mkwrprotect           | Creates a write protected PTE                    |
+--------------------------------------------------------------------------------
+| pte_mkspecial             | Creates a special PTE                            |
+--------------------------------------------------------------------------------
+| pte_mkdevmap              | Creates a ZONE_DEVICE mapped PTE                 |
+--------------------------------------------------------------------------------
+| pte_mksoft_dirty          | Creates a soft dirty PTE                         |
+--------------------------------------------------------------------------------
+| pte_clear_soft_dirty      | Clears a soft dirty PTE                          |
+--------------------------------------------------------------------------------
+| pte_swp_mksoft_dirty      | Creates a soft dirty swapped PTE                 |
+--------------------------------------------------------------------------------
+| pte_swp_clear_soft_dirty  | Clears a soft dirty swapped PTE                  |
+--------------------------------------------------------------------------------
+| pte_mknotpresent          | Invalidates a mapped PTE                         |
+--------------------------------------------------------------------------------
+| ptep_get_and_clear        | Clears a PTE                                     |
+--------------------------------------------------------------------------------
+| ptep_get_and_clear_full   | Clears a PTE                                     |
+--------------------------------------------------------------------------------
+| ptep_test_and_clear_young | Clears young from a PTE                          |
+--------------------------------------------------------------------------------
+| ptep_set_wrprotect        | Converts into a write protected PTE              |
+--------------------------------------------------------------------------------
+| ptep_set_access_flags     | Converts into a more permissive PTE              |
+--------------------------------------------------------------------------------
+
+======================
+PMD Page Table Helpers
+======================
+
+--------------------------------------------------------------------------------
+| pmd_same                  | Tests whether both PMD entries are the same      |
+--------------------------------------------------------------------------------
+| pmd_bad                   | Tests a non-table mapped PMD                     |
+--------------------------------------------------------------------------------
+| pmd_leaf                  | Tests a leaf mapped PMD                          |
+--------------------------------------------------------------------------------
+| pmd_huge                  | Tests a HugeTLB mapped PMD                       |
+--------------------------------------------------------------------------------
+| pmd_trans_huge            | Tests a Transparent Huge Page (THP) at PMD       |
+--------------------------------------------------------------------------------
+| pmd_present               | Tests a valid mapped PMD                         |
+--------------------------------------------------------------------------------
+| pmd_young                 | Tests a young PMD                                |
+--------------------------------------------------------------------------------
+| pmd_dirty                 | Tests a dirty PMD                                |
+--------------------------------------------------------------------------------
+| pmd_write                 | Tests a writable PMD                             |
+--------------------------------------------------------------------------------
+| pmd_special               | Tests a special PMD                              |
+--------------------------------------------------------------------------------
+| pmd_protnone              | Tests a PROT_NONE PMD                            |
+--------------------------------------------------------------------------------
+| pmd_devmap                | Tests a ZONE_DEVICE mapped PMD                   |
+--------------------------------------------------------------------------------
+| pmd_soft_dirty            | Tests a soft dirty PMD                           |
+--------------------------------------------------------------------------------
+| pmd_swp_soft_dirty        | Tests a soft dirty swapped PMD                   |
+--------------------------------------------------------------------------------
+| pmd_mkyoung               | Creates a young PMD                              |
+--------------------------------------------------------------------------------
+| pmd_mkold                 | Creates an old PMD                               |
+--------------------------------------------------------------------------------
+| pmd_mkdirty               | Creates a dirty PMD                              |
+--------------------------------------------------------------------------------
+| pmd_mkclean               | Creates a clean PMD                              |
+--------------------------------------------------------------------------------
+| pmd_mkwrite               | Creates a writable PMD                           |
+--------------------------------------------------------------------------------
+| pmd_mkwrprotect           | Creates a write protected PMD                    |
+--------------------------------------------------------------------------------
+| pmd_mkspecial             | Creates a special PMD                            |
+--------------------------------------------------------------------------------
+| pmd_mkdevmap              | Creates a ZONE_DEVICE mapped PMD                 |
+--------------------------------------------------------------------------------
+| pmd_mksoft_dirty          | Creates a soft dirty PMD                         |
+--------------------------------------------------------------------------------
+| pmd_clear_soft_dirty      | Clears a soft dirty PMD                          |
+--------------------------------------------------------------------------------
+| pmd_swp_mksoft_dirty      | Creates a soft dirty swapped PMD                 |
+--------------------------------------------------------------------------------
+| pmd_swp_clear_soft_dirty  | Clears a soft dirty swapped PMD                  |
+--------------------------------------------------------------------------------
+| pmd_mknotpresent          | Invalidates a mapped PMD                         |
+--------------------------------------------------------------------------------
+| pmd_set_huge              | Creates a PMD huge mapping                       |
+--------------------------------------------------------------------------------
+| pmd_clear_huge            | Clears a PMD huge mapping                        |
+--------------------------------------------------------------------------------
+| pmdp_get_and_clear        | Clears a PMD                                     |
+--------------------------------------------------------------------------------
+| pmdp_get_and_clear_full   | Clears a PMD                                     |
+--------------------------------------------------------------------------------
+| pmdp_test_and_clear_young | Clears young from a PMD                          |
+--------------------------------------------------------------------------------
+| pmdp_set_wrprotect        | Converts into a write protected PMD              |
+--------------------------------------------------------------------------------
+| pmdp_set_access_flags     | Converts into a more permissive PMD              |
+--------------------------------------------------------------------------------
+
+======================
+PUD Page Table Helpers
+======================
+
+--------------------------------------------------------------------------------
+| pud_same                  | Tests whether both PUD entries are the same      |
+--------------------------------------------------------------------------------
+| pud_bad                   | Tests a non-table mapped PUD                     |
+--------------------------------------------------------------------------------
+| pud_leaf                  | Tests a leaf mapped PUD                          |
+--------------------------------------------------------------------------------
+| pud_huge                  | Tests a HugeTLB mapped PUD                       |
+--------------------------------------------------------------------------------
+| pud_trans_huge            | Tests a Transparent Huge Page (THP) at PUD       |
+--------------------------------------------------------------------------------
+| pud_present               | Tests a valid mapped PUD                         |
+--------------------------------------------------------------------------------
+| pud_young                 | Tests a young PUD                                |
+--------------------------------------------------------------------------------
+| pud_dirty                 | Tests a dirty PUD                                |
+--------------------------------------------------------------------------------
+| pud_write                 | Tests a writable PUD                             |
+--------------------------------------------------------------------------------
+| pud_devmap                | Tests a ZONE_DEVICE mapped PUD                   |
+--------------------------------------------------------------------------------
+| pud_mkyoung               | Creates a young PUD                              |
+--------------------------------------------------------------------------------
+| pud_mkold                 | Creates an old PUD                               |
+--------------------------------------------------------------------------------
+| pud_mkdirty               | Creates a dirty PUD                              |
+--------------------------------------------------------------------------------
+| pud_mkclean               | Creates a clean PUD                              |
+--------------------------------------------------------------------------------
+| pud_mkwrite               | Creates a writable PMD                           |
+--------------------------------------------------------------------------------
+| pud_mkwrprotect           | Creates a write protected PMD                    |
+--------------------------------------------------------------------------------
+| pud_mkdevmap              | Creates a ZONE_DEVICE mapped PMD                 |
+--------------------------------------------------------------------------------
+| pud_mknotpresent          | Invalidates a mapped PUD                         |
+--------------------------------------------------------------------------------
+| pud_set_huge              | Creates a PUD huge mapping                       |
+--------------------------------------------------------------------------------
+| pud_clear_huge            | Clears a PUD huge mapping                        |
+--------------------------------------------------------------------------------
+| pudp_get_and_clear        | Clears a PUD                                     |
+--------------------------------------------------------------------------------
+| pudp_get_and_clear_full   | Clears a PUD                                     |
+--------------------------------------------------------------------------------
+| pudp_test_and_clear_young | Clears young from a PUD                          |
+--------------------------------------------------------------------------------
+| pudp_set_wrprotect        | Converts into a write protected PUD              |
+--------------------------------------------------------------------------------
+| pudp_set_access_flags     | Converts into a more permissive PUD              |
+--------------------------------------------------------------------------------
+
+==========================
+HugeTLB Page Table Helpers
+==========================
+
+--------------------------------------------------------------------------------
+| pte_huge                  | Tests a HugeTLB                                  |
+--------------------------------------------------------------------------------
+| pte_mkhuge                | Creates a HugeTLB                                |
+--------------------------------------------------------------------------------
+| huge_pte_dirty            | Tests a dirty HugeTLB                            |
+--------------------------------------------------------------------------------
+| huge_pte_write            | Tests a writable HugeTLB                         |
+--------------------------------------------------------------------------------
+| huge_pte_mkdirty          | Creates a dirty HugeTLB                          |
+--------------------------------------------------------------------------------
+| huge_pte_mkwrite          | Creates a writable HugeTLB                       |
+--------------------------------------------------------------------------------
+| huge_pte_mkwrprotect      | Creates a write protected HugeTLB                |
+--------------------------------------------------------------------------------
+| huge_ptep_get_and_clear   | Clears a HugeTLB                                 |
+--------------------------------------------------------------------------------
+| huge_ptep_set_wrprotect   | Converts into a write protected HugeTLB          |
+--------------------------------------------------------------------------------
+| huge_ptep_set_access_flags  | Converts into a more permissive HugeTLB        |
+--------------------------------------------------------------------------------
+
+========================
+SWAP Page Table Helpers
+========================
+
+--------------------------------------------------------------------------------
+| __pte_to_swp_entry        | Creates a swapped entry (arch) from a mapepd PTE |
+--------------------------------------------------------------------------------
+| __swp_to_pte_entry        | Creates a mapped PTE from a swapped entry (arch) |
+--------------------------------------------------------------------------------
+| __pmd_to_swp_entry        | Creates a swapped entry (arch) from a mapepd PMD |
+--------------------------------------------------------------------------------
+| __swp_to_pmd_entry        | Creates a mapped PMD from a swapped entry (arch) |
+--------------------------------------------------------------------------------
+| is_migration_entry        | Tests a migration (read or write) swapped entry  |
+--------------------------------------------------------------------------------
+| is_write_migration_entry  | Tests a write migration swapped entry            |
+--------------------------------------------------------------------------------
+| make_migration_entry_read | Converts into read migration swapped entry       |
+--------------------------------------------------------------------------------
+| make_migration_entry      | Creates a migration swapped entry (read or write)|
+--------------------------------------------------------------------------------
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 87b4b495333b..7c210f99a812 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -32,16 +32,9 @@
 #include <asm/tlbflush.h>
 
 /*
- * Basic operations
- *
- * mkold(entry)			= An old and not a young entry
- * mkyoung(entry)		= A young and not an old entry
- * mkdirty(entry)		= A dirty and not a clean entry
- * mkclean(entry)		= A clean and not a dirty entry
- * mkwrite(entry)		= A write and not a write protected entry
- * wrprotect(entry)		= A write protected and not a write entry
- * pxx_bad(entry)		= A mapped and non-table entry
- * pxx_same(entry1, entry2)	= Both entries hold the exact same value
+ * Please refer Documentation/vm/arch_pgtable_helpers.rst for the semantics
+ * expectations that are being validated here. All future changes in here
+ * or the documentation need to be in sync.
  */
 #define VMFLAGS	(VM_READ|VM_WRITE|VM_EXEC)
 
-- 
2.20.1

