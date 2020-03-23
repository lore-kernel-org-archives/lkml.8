Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D24C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8ED206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgCWBGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 21:06:17 -0400
Received: from foss.arm.com ([217.140.110.172]:43424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbgCWBGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 21:06:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 471491FB;
        Sun, 22 Mar 2020 18:06:16 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3E6F3F52E;
        Sun, 22 Mar 2020 18:06:11 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     jhubbard@nvidia.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/memory: Drop pud_mknotpresent()
Date:   Mon, 23 Mar 2020 06:35:42 +0530
Message-Id: <1584925542-13034-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an inconsistency between PMD and PUD based THP page table helpers
like the following, as pud_present() does not test for _PAGE_PSE.

pmd_present(pmd_mknotpresent(pmd)) : True
pud_present(pud_mknotpresent(pud)) : False

This drops pud_mknotpresent() as there are no current users. If/when needed
back later, pud_present() will also have to fixed to accommodate _PAGE_PSE.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This has been build and boot tested on x86.

Changes in V2:

- Dropped pud_mknotpresent() instead per Kirill

Changes in V1: (https://patchwork.kernel.org/patch/11444529/)

 arch/x86/include/asm/pgtable.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7e118660bbd9..d74dc560e3ab 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -595,12 +595,6 @@ static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 		      __pgprot(pmd_flags(pmd) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
 }
 
-static inline pud_t pud_mknotpresent(pud_t pud)
-{
-	return pfn_pud(pud_pfn(pud),
-	      __pgprot(pud_flags(pud) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
-}
-
 static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
-- 
2.17.1

