Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9A7C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 04:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFC220768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 04:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCRErc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 00:47:32 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:61426 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgCRErc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 00:47:32 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.227])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 29CE3261AA3;
        Wed, 18 Mar 2020 12:47:26 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     Guo Ren <guoren@kernel.org>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Wang Wenhu <wenhu.wang@vivo.com>, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, trivial@kernel.org
Subject: [PATCH] csky: delete redundant micro io_remap_pfn_range
Date:   Tue, 17 Mar 2020 21:47:01 -0700
Message-Id: <20200318044702.104793-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VKTUJLS0tKT0NMTEhKQllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kyo6Hhw4Szg0HjQiLhATH0MD
        ATYwFEpVSlVKTkNPTktNQ09DTUNMVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlMWVdZCAFZQUpCQkw3Bg++
X-HM-Tid: 0a70ebf7bd369375kuws29ce3261aa3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same definition exists in "include/asm-generic/pgtable.h",
which is included just below the lines to be deleted.

#ifndef io_remap_pfn_range
#define io_remap_pfn_range remap_pfn_range
#endif

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
 arch/csky/include/asm/pgtable.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 9b7764cb7645..bde812a785c8 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -306,9 +306,6 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_pfn_range(vma, vaddr, pfn, size, prot) \
-	remap_pfn_range(vma, vaddr, pfn, size, prot)
-
 #include <asm-generic/pgtable.h>
 
 #endif /* __ASM_CSKY_PGTABLE_H */
-- 
2.17.1

