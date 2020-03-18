Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D8BC5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 05:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AF32076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 05:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCRFBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 01:01:43 -0400
Received: from foss.arm.com ([217.140.110.172]:45564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgCRFBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 01:01:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C26D1FB;
        Tue, 17 Mar 2020 22:01:42 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D0353F67D;
        Tue, 17 Mar 2020 22:01:38 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: Make pud_present() check _PAGE_PROTNONE and _PAGE_PSE as well
Date:   Wed, 18 Mar 2020 10:31:19 +0530
Message-Id: <1584507679-11976-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pud_present() should also check _PAGE_PROTNONE and _PAGE_PSE bits like in
case pmd_present(). This makes a PUD entry test positive for pud_present()
after getting invalidated with pud_mknotpresent(), hence standardizing the
semantics with PMD helpers.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Even though pud_mknotpresent() is not used any where currently, there is
a discrepancy between PMD and PUD.

WARN_ON(!pud_present(pud_mknotpresent(pud_mkhuge(pud)))) -> Fail
WARN_ON(!pmd_present(pmd_mknotpresent(pmd_mkhuge(pmd)))) -> Pass

Though pud_mknotpresent() currently clears _PAGE_PROTNONE, pud_present()
does not check it. This change fixes both inconsistencies.

This has been build and boot tested on x86.

 arch/x86/include/asm/pgtable.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7e118660bbd9..8adf1d00b506 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -857,7 +857,13 @@ static inline int pud_none(pud_t pud)
 
 static inline int pud_present(pud_t pud)
 {
-	return pud_flags(pud) & _PAGE_PRESENT;
+	/*
+	 * Checking for _PAGE_PSE is needed too because
+	 * split_huge_page will temporarily clear the present bit (but
+	 * the _PAGE_PSE flag will remain set at all times while the
+	 * _PAGE_PRESENT bit is clear).
+	 */
+	return pud_flags(pud) & (_PAGE_PRESENT | _PAGE_PROTNONE | _PAGE_PSE);
 }
 
 static inline unsigned long pud_page_vaddr(pud_t pud)
-- 
2.17.1

