Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B5EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 03:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B95A20756
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 03:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgFPDWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 23:22:36 -0400
Received: from foss.arm.com ([217.140.110.172]:58440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgFPDWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 23:22:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 781801FB;
        Mon, 15 Jun 2020 20:22:35 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.80.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 72B943F6CF;
        Mon, 15 Jun 2020 20:22:33 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm/mm: Drop [PTE|PMD]_TYPE_FAULT
Date:   Tue, 16 Jun 2020 08:52:04 +0530
Message-Id: <1592277724-2721-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop these unused symbols i.e PTE_TYPE_FAULT and PMD_TYPE_FAULT.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Allison Randal <allison@lohutok.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Applies on 5.8-rc1. Just found by code inspection and built tested for
arm platform.

 arch/arm/include/asm/pgtable-2level-hwdef.h | 2 --
 arch/arm/include/asm/pgtable-3level-hwdef.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level-hwdef.h b/arch/arm/include/asm/pgtable-2level-hwdef.h
index 556937e1790e..b10d6e1aee33 100644
--- a/arch/arm/include/asm/pgtable-2level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-2level-hwdef.h
@@ -14,7 +14,6 @@
  *   - common
  */
 #define PMD_TYPE_MASK		(_AT(pmdval_t, 3) << 0)
-#define PMD_TYPE_FAULT		(_AT(pmdval_t, 0) << 0)
 #define PMD_TYPE_TABLE		(_AT(pmdval_t, 1) << 0)
 #define PMD_TYPE_SECT		(_AT(pmdval_t, 2) << 0)
 #define PMD_PXNTABLE		(_AT(pmdval_t, 1) << 2)     /* v7 */
@@ -56,7 +55,6 @@
  *   - common
  */
 #define PTE_TYPE_MASK		(_AT(pteval_t, 3) << 0)
-#define PTE_TYPE_FAULT		(_AT(pteval_t, 0) << 0)
 #define PTE_TYPE_LARGE		(_AT(pteval_t, 1) << 0)
 #define PTE_TYPE_SMALL		(_AT(pteval_t, 2) << 0)
 #define PTE_TYPE_EXT		(_AT(pteval_t, 3) << 0)		/* v5 */
diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
index 2f35b4eddaa8..43aa8f61eac1 100644
--- a/arch/arm/include/asm/pgtable-3level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
@@ -15,7 +15,6 @@
  *   - common
  */
 #define PMD_TYPE_MASK		(_AT(pmdval_t, 3) << 0)
-#define PMD_TYPE_FAULT		(_AT(pmdval_t, 0) << 0)
 #define PMD_TYPE_TABLE		(_AT(pmdval_t, 3) << 0)
 #define PMD_TYPE_SECT		(_AT(pmdval_t, 1) << 0)
 #define PMD_TABLE_BIT		(_AT(pmdval_t, 1) << 1)
@@ -56,7 +55,6 @@
  * + Level 3 descriptor (PTE)
  */
 #define PTE_TYPE_MASK		(_AT(pteval_t, 3) << 0)
-#define PTE_TYPE_FAULT		(_AT(pteval_t, 0) << 0)
 #define PTE_TYPE_PAGE		(_AT(pteval_t, 3) << 0)
 #define PTE_TABLE_BIT		(_AT(pteval_t, 1) << 1)
 #define PTE_BUFFERABLE		(_AT(pteval_t, 1) << 2)		/* AttrIndx[0] */
-- 
2.20.1

