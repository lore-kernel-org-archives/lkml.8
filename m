Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E506C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B74320758
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHSSYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:24:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:44006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHSSYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:24:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF93BAC85;
        Wed, 19 Aug 2020 18:25:12 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, hch@lst.de,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC] arm64: mm: Do not use both DMA zones when 30-bit address space unavailable
Date:   Wed, 19 Aug 2020 20:24:33 +0200
Message-Id: <20200819182434.28196-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no benefit in splitting the 32-bit address space into two
distinct DMA zones when the 30-bit address space isn't even available on
a device. If that is the case, default to one big ZONE_DMA spanning the
whole 32-bit address space.

This will help reduce some of the issues we've seen with big crash
kernel allocations.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Whith this patch, on a 8GB RPi4 the setup looks like this:

	DMA      [mem 0x0000000000000000-0x000000003fffffff]
	DMA32    [mem 0x0000000040000000-0x00000000ffffffff]
	Normal   [mem 0x0000000100000000-0x00000001ffffffff]

And stock 8GB virtme/qemu:

	DMA      [mem 0x0000000040000000-0x00000000ffffffff]
	DMA32    empty
	Normal   [mem 0x0000000100000000-0x000000023fffffff]

 arch/arm64/mm/init.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index b6881d61b818..857a62611d7a 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -183,13 +183,20 @@ static void __init reserve_elfcorehdr(void)
 
 /*
  * Return the maximum physical address for a zone with a given address size
- * limit. It currently assumes that for memory starting above 4G, 32-bit
- * devices will use a DMA offset.
+ * limit or zero if memory starts from an address higher than the zone targeted.
+ * It currently assumes that for memory starting above 4G, 32-bit devices will
+ * use a DMA offset.
  */
 static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
 {
-	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, zone_bits);
-	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
+	phys_addr_t base = memblock_start_of_DRAM();
+	phys_addr_t offset = base & GENMASK_ULL(63, 32);
+	s64 zone_size = (1ULL << zone_bits) - (base & DMA_BIT_MASK(32));
+
+	if (zone_size <= 0)
+		return 0;
+
+	return min(base + zone_size + offset, memblock_end_of_DRAM());
 }
 
 static void __init zone_sizes_init(unsigned long min, unsigned long max)
@@ -390,6 +397,20 @@ void __init arm64_memblock_init(void)
 	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
 		zone_dma_bits = ARM64_ZONE_DMA_BITS;
 		arm64_dma_phys_limit = max_zone_phys(ARM64_ZONE_DMA_BITS);
+
+		/*
+		 * We don't want to split the 32 bit address space into two DMA
+		 * zones when the target lower physical address range doesn't
+		 * exist. For example, if memory starts at 0x80000000 it's
+		 * pointless to create a ZONE_DMA distinct of ZONE_DMA32 as
+		 * there's no way to access the 30-bit address space. If that's
+		 * the case just expand ZONE_DMA to cover the whole 32-bit
+		 * address space.
+		 */
+		if (!arm64_dma_phys_limit) {
+			zone_dma_bits = 32;
+			arm64_dma_phys_limit = max_zone_phys(32);
+		}
 	}
 
 	if (IS_ENABLED(CONFIG_ZONE_DMA32))
-- 
2.28.0

