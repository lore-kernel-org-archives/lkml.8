Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85042C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD4720736
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgCWIq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:46:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40603 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgCWIq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:46:57 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGIjL-0002Aw-ML; Mon, 23 Mar 2020 09:46:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 428271C0470;
        Mon, 23 Mar 2020 09:46:43 +0100 (CET)
Date:   Mon, 23 Mar 2020 08:46:42 -0000
From:   "tip-bot2 for Anshuman Khandual" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Drop pud_mknotpresent()
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Borislav Petkov <bp@suse.de>, Baoquan He <bhe@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1584925542-13034-1-git-send-email-anshuman.khandual@arm.com>
References: <1584925542-13034-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Message-ID: <158495320286.28353.18108219786340349995.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     31a9122058bc5f042cb04bcdb8cd9e6c77fdae8d
Gitweb:        https://git.kernel.org/tip/31a9122058bc5f042cb04bcdb8cd9e6c77fdae8d
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Mon, 23 Mar 2020 06:35:42 +05:30
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 23 Mar 2020 09:11:48 +01:00

x86/mm: Drop pud_mknotpresent()

There is an inconsistency between PMD and PUD-based THP page table helpers
like the following, as pud_present() does not test for _PAGE_PSE.

pmd_present(pmd_mknotpresent(pmd)) : True
pud_present(pud_mknotpresent(pud)) : False

Drop pud_mknotpresent() as there are no current users. If/when needed
back later, pud_present() will also have to be fixed to accommodate
_PAGE_PSE.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Baoquan He <bhe@redhat.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lkml.kernel.org/r/1584925542-13034-1-git-send-email-anshuman.khandual@arm.com
---
 arch/x86/include/asm/pgtable.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7e11866..d74dc56 100644
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
