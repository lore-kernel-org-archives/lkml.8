Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5848EC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4159F2078C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgDUCfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:35:34 -0400
Received: from foss.arm.com ([217.140.110.172]:56876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgDUCfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:35:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5657C14;
        Mon, 20 Apr 2020 19:35:32 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 102F73F73D;
        Mon, 20 Apr 2020 19:35:29 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH V17 1/2] x86/mm: Define mm_p4d_folded()
Date:   Tue, 21 Apr 2020 08:04:54 +0530
Message-Id: <1587436495-22033-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587436495-22033-1-git-send-email-anshuman.khandual@arm.com>
References: <1587436495-22033-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This just defines mm_p4d_folded() to check whether P4D page table level is
folded at runtime.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/x86/include/asm/pgtable_64.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index df1373415f11..8d03ffd43794 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -53,6 +53,12 @@ static inline void sync_initial_page_table(void) { }
 
 struct mm_struct;
 
+#define mm_p4d_folded mm_p4d_folded
+static inline bool mm_p4d_folded(struct mm_struct *mm)
+{
+	return !pgtable_l5_enabled();
+}
+
 void set_pte_vaddr_p4d(p4d_t *p4d_page, unsigned long vaddr, pte_t new_pte);
 void set_pte_vaddr_pud(pud_t *pud_page, unsigned long vaddr, pte_t new_pte);
 
-- 
2.20.1

