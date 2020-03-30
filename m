Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01269C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA89A20748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgC3Lx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:53:57 -0400
Received: from out28-52.mail.aliyun.com ([115.124.28.52]:59618 "EHLO
        out28-52.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgC3Lx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:53:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.03929106|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0110356-0.000277475-0.988687;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03308;MF=hanchuanhua@fishsemi.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.H7e-2Ko_1585569212;
Received: from localhost.localdomain(mailfrom:hanchuanhua@fishsemi.com fp:SMTPD_---.H7e-2Ko_1585569212)
          by smtp.aliyun-inc.com(10.147.44.118);
          Mon, 30 Mar 2020 19:53:46 +0800
From:   Chuanhua Han <hanchuanhua@fishsemi.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, peterx@redhat.com,
        shihpo.hung@sifive.com, ebiederm@xmission.com, schwab@suse.de,
        tglx@linutronix.de, Anup.Patel@wdc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuanhua Han <hanchuanhua@fishsemi.com>
Subject: [PATCH] riscv: mm: Remove the copy operation of pmd
Date:   Mon, 30 Mar 2020 19:53:19 +0800
Message-Id: <20200330115319.1507-1-hanchuanhua@fishsemi.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all processes share the kernel address space,
we only need to copy pgd in case of a vmalloc page
fault exception, the other levels of page tables are
shared, so the operation of copying pmd is unnecessary.

Signed-off-by: Chuanhua Han <hanchuanhua@fishsemi.com>
---
 arch/riscv/mm/fault.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index be84e32adc4c..24f4ebfd2df8 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -208,9 +208,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 vmalloc_fault:
 	{
 		pgd_t *pgd, *pgd_k;
-		pud_t *pud, *pud_k;
-		p4d_t *p4d, *p4d_k;
-		pmd_t *pmd, *pmd_k;
+		pud_t *pud_k;
+		p4d_t *p4d_k;
+		pmd_t *pmd_k;
 		pte_t *pte_k;
 		int index;
 
@@ -234,12 +234,10 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 			goto no_context;
 		set_pgd(pgd, *pgd_k);
 
-		p4d = p4d_offset(pgd, addr);
 		p4d_k = p4d_offset(pgd_k, addr);
 		if (!p4d_present(*p4d_k))
 			goto no_context;
 
-		pud = pud_offset(p4d, addr);
 		pud_k = pud_offset(p4d_k, addr);
 		if (!pud_present(*pud_k))
 			goto no_context;
@@ -248,11 +246,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		 * Since the vmalloc area is global, it is unnecessary
 		 * to copy individual PTEs
 		 */
-		pmd = pmd_offset(pud, addr);
 		pmd_k = pmd_offset(pud_k, addr);
 		if (!pmd_present(*pmd_k))
 			goto no_context;
-		set_pmd(pmd, *pmd_k);
 
 		/*
 		 * Make sure the actual PTE exists as well to
-- 
2.17.1

