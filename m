Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF3CC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F60F2078E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgCZQiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:38:07 -0400
Received: from mail5.windriver.com ([192.103.53.11]:44462 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbgCZQiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:38:07 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 02QGaa7Q007557
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 26 Mar 2020 09:36:46 -0700
Received: from ala-lpggp5.wrs.com (147.11.105.121) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Mar 2020
 09:36:25 -0700
Received: by ala-lpggp5.wrs.com (Postfix, from userid 16756)    id DC23C201EA;
 Thu, 26 Mar 2020 09:36:25 -0700 (PDT)
From:   Li Wang <li.wang@windriver.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <li.wang@windriver.com>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: mmu: no write cache for O_SYNC flag
Date:   Thu, 26 Mar 2020 09:36:25 -0700
Message-ID: <20200326163625.30714-1-li.wang@windriver.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reproduce steps:
1.
disable CONFIG_STRICT_DEVMEM in linux kernel
2.
Process A gets a Physical Address of global variable by
"/proc/self/pagemap".
3.
Process B writes a value to the same Physical Address by mmap():
fd=open("/dev/mem",O_SYNC);
Virtual Address=mmap(fd);

problem symptom:
after Process B write a value to the Physical Address,
Process A of the value of global variable does not change.
They both W/R the same Physical Address.

technical reason:
Process B writing the Physical Address is by the Virtual Address,
and the Virtual Address comes from "/dev/mem" and mmap().
In arm64 arch, the Virtual Address has write cache.
So, maybe the value is not written into Physical Address.

fix reason:
giving write cache flag in arm64 is in phys_mem_access_prot():
=====
arch/arm64/mm/mmu.c
phys_mem_access_prot()
{
  if (!pfn_valid(pfn))
    return pgprot_noncached(vma_prot);
  else if (file->f_flags & O_SYNC)
    return pgprot_writecombine(vma_prot);
  return vma_prot;
}
====
the other arch and the share function drivers/char/mem.c of phys_mem_access_prot()
does not add write cache flag.
So, removing the flag to fix the issue

Signed-off-by: Li Wang <li.wang@windriver.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 128f70852bf3..d7083965ca17 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -81,8 +81,6 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 {
 	if (!pfn_valid(pfn))
 		return pgprot_noncached(vma_prot);
-	else if (file->f_flags & O_SYNC)
-		return pgprot_writecombine(vma_prot);
 	return vma_prot;
 }
 EXPORT_SYMBOL(phys_mem_access_prot);
-- 
2.24.1

