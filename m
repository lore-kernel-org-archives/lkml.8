Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E827C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D93C2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgCXGRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:17:52 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:64471 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725869AbgCXGRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:17:52 -0400
X-Greylist: delayed 1665 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Mar 2020 02:17:50 EDT
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 02O5nfuB025125
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:49:41 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 02O5nWci025103;
        Tue, 24 Mar 2020 13:49:32 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 24 Mar 2020
 13:49:52 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <guoren@kernel.org>,
        <akpm@linux-foundation.org>, <rppt@linux.ibm.com>,
        <nickhu@andestech.com>, <mark.rutland@arm.com>,
        <nylon7@andestech.com>, <alankao@andestech.com>,
        <alexios.zavras@intel.com>, <tglx@linutronix.de>,
        <npiggin@gmail.com>, <anup@brainfault.org>, <zong.li@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] riscv: mm: synchronize MMU after page table update
Date:   Tue, 24 Mar 2020 13:49:45 +0800
Message-ID: <20200324054945.26733-1-nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 02O5nWci025103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit bf587caae305 ("riscv: mm: synchronize MMU after pte change")

For those riscv implementations whose TLB cannot synchronize with dcache,
an SFENCE.VMA is necessary after page table update.
This patch fixed two functions:

1. pgd_alloc
During fork, a parent process prepares pgd for its child and updates satp
later, but they may not run on the same core. Adding a remote SFENCE.VMA to
invalidate TLB in other cores is needed. Thus use flush_tlb_all() instead
of local_flush_tlb_all() here.
Similar approaches can be found in arm and csky.

2. __set_fixmap
Add a SFENCE.VMA after fixmap pte update.
Similar approaches can be found in arm and sh.

Signed-off-by: Nick Hu <nickhu@andestech.com>
Signed-off-by: Nylon Chen <nylon7@andestech.com>
Cc: Alan Kao <alankao@andestech.com>
---
 arch/riscv/include/asm/pgalloc.h | 1 +
 arch/riscv/mm/init.c             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 3f601ee8233f..071468fa14b7 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -51,6 +51,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 		memcpy(pgd + USER_PTRS_PER_PGD,
 			init_mm.pgd + USER_PTRS_PER_PGD,
 			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+		flush_tlb_all();
 	}
 	return pgd;
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fab855963c73..a7f329503ed0 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -203,8 +203,8 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 		set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
 	} else {
 		pte_clear(&init_mm, addr, ptep);
-		local_flush_tlb_page(addr);
 	}
+	local_flush_tlb_page(addr);
 }
 
 static pte_t *__init get_pte_virt(phys_addr_t pa)
-- 
2.17.0

