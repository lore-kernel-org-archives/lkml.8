Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9A4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A8B20672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgF3DWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:22:18 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:59682 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728898AbgF3DWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:22:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U175HJB_1593487325;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U175HJB_1593487325)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Jun 2020 11:22:05 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/mm: calculate the proper boundary in register_page_bootmem_memmap()
Date:   Tue, 30 Jun 2020 11:22:04 +0800
Message-Id: <20200630032204.45639-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be proper to jump to end boundary of the proper level instead
of always jump to the end boundary of a PAGE.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
CC: Baoquan He <bhe@redhat.com>
CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/init_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index f902fbd17f27..45eddb755eaa 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1536,21 +1536,21 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 
 		pgd = pgd_offset_k(addr);
 		if (pgd_none(*pgd)) {
-			next = (addr + PAGE_SIZE) & PAGE_MASK;
+			next = pgd_addr_end(addr, end);
 			continue;
 		}
 		get_page_bootmem(section_nr, pgd_page(*pgd), MIX_SECTION_INFO);
 
 		p4d = p4d_offset(pgd, addr);
 		if (p4d_none(*p4d)) {
-			next = (addr + PAGE_SIZE) & PAGE_MASK;
+			next = p4d_addr_end(addr, end);
 			continue;
 		}
 		get_page_bootmem(section_nr, p4d_page(*p4d), MIX_SECTION_INFO);
 
 		pud = pud_offset(p4d, addr);
 		if (pud_none(*pud)) {
-			next = (addr + PAGE_SIZE) & PAGE_MASK;
+			next = pud_addr_end(addr, end);
 			continue;
 		}
 		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
-- 
2.20.1 (Apple Git-117)

