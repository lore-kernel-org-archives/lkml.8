Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781EFC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35BA82076D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Lcg6e/Dj";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="gOQerc4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgIJGFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:05:51 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:53016
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728617AbgIJGFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599717911;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=8aYBJyZG/tinKAweATWIriZSqX7vdJP9zCTtlHAcLSA=;
        b=Lcg6e/Dj72yrU0r4QxAVr5n0ECCw/tP2stjFzVqaWheuJjubdmn8zOq56lMcATVa
        t5sl8L0YPGcFqediX2Ahurdf5iTNpFf3YJVU1jax0Yur18iS16sa0dBZ2dL0dR7EtgX
        mmsoCpxC2Z6CVdj8f1X5IGYbHPT5SGFhXZvtDGBk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599717911;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=8aYBJyZG/tinKAweATWIriZSqX7vdJP9zCTtlHAcLSA=;
        b=gOQerc4Sn+Q+y9FlB2vO/vYmsskvaQ+BYK4uvP9y7QG5V+PTjaWDZi2uTxGaxWQo
        YzD8rKO+2IOQAFdw4o18YX6r1GLPpOk1rLmi0x0wLk2VPhbAktnZtDQWgus9p5RMbMi
        C5rxQWwcChMTVTp2qxf2jQkiu1fnRJfw5+WUaxfs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06DEAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH] arm64/mm: add fallback option to allocate virtually contiguous memory
Date:   Thu, 10 Sep 2020 06:05:11 +0000
Message-ID: <01010174769e2cc4-79f26633-9a7d-48d5-a13b-af8c8486975e-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2020.09.10-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When section mappings are enabled, we allocate vmemmap pages from physically
continuous memory of size PMD_SZIE using vmemmap_alloc_block_buf(). Section
mappings are good to reduce TLB pressure. But when system is highly fragmented
and memory blocks are being hot-added at runtime, its possible that such
physically continuous memory allocations can fail. Rather than failing the
memory hot-add procedure, add a fallback option to allocate vmemmap pages from
discontinuous pages using vmemmap_populate_basepages().

Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Price <steven.price@arm.com>
---
 arch/arm64/mm/mmu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 75df62f..a46c7d4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1100,6 +1100,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	p4d_t *p4dp;
 	pud_t *pudp;
 	pmd_t *pmdp;
+	int ret = 0;
 
 	do {
 		next = pmd_addr_end(addr, end);
@@ -1121,15 +1122,23 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 			void *p = NULL;
 
 			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
-			if (!p)
-				return -ENOMEM;
+			if (!p) {
+#ifdef CONFIG_MEMORY_HOTPLUG
+				vmemmap_free(start, end, altmap);
+#endif
+				ret = -ENOMEM;
+				break;
+			}
 
 			pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
 		} else
 			vmemmap_verify((pte_t *)pmdp, node, addr, next);
 	} while (addr = next, addr != end);
 
-	return 0;
+	if (ret)
+		return vmemmap_populate_basepages(start, end, node, altmap);
+	else
+		return ret;
 }
 #endif	/* !ARM64_SWAPPER_USES_SECTION_MAPS */
 void vmemmap_free(unsigned long start, unsigned long end,
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

