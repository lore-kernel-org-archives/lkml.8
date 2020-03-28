Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB1EC2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A999420723
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585394099;
	bh=gxsBGPQ+SZjadnosE9PH6kn6/CmHIYOSBaUfziJ2gCI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1/MEsPmKd8WH9w1PhV3AtCWUgCxjDSYkIresICPuqaPvPFwDrItmI1HNX5tqW9lN2
	 1qMQEB52caCjW8Y/vwjxNuH7UvJifdDVtilEewuntnoUAFX7yuclAETGXCfFSr31Bu
	 NaGFooY18wSacbOW5xg2dorZfRJBoxCFJqhavh24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgC1LO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgC1LO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:14:58 -0400
Received: from localhost.localdomain (89.208.247.74.16clouds.com [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D71F206E6;
        Sat, 28 Mar 2020 11:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585394097;
        bh=gxsBGPQ+SZjadnosE9PH6kn6/CmHIYOSBaUfziJ2gCI=;
        h=From:To:Cc:Subject:Date:From;
        b=MtRAG5dFfJ1sYbAWjk+gcvD/wWBxLrns5Qilq7PKUkMG22EWTNRMQYrgdN04983F4
         rB6L4qjfZYwkXCSiD9JUiWqNlf9ujeFippcq8sZtOy/ZN9JRhMtPE857HeCoTFuwvT
         7lgAte3yWb9TZFH4JUUTEE6zgX6goQ+Dbt7fxDj0=
From:   guoren@kernel.org
To:     gregkh@linuxfoundation.org, nivedita@alum.mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: Fixup cpu speculative execution to IO area
Date:   Sat, 28 Mar 2020 19:14:37 +0800
Message-Id: <20200328111437.27838-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

For the memory size ( > 512MB, < 1GB), the MSA setting is:

 - SSEG0: PHY_START        , PHY_START + 512MB
 - SSEG1: PHY_START + 512MB, PHY_START + 1GB

But the real memory is no more than 1GB, there is a gap between the
end size of memory and border of 1GB. CPU could speculatively
execute to that gap and if the gap of the bus couldn't respond to
the CPU request, then the crash will happen.

Now make the setting with:

 - SSEG0: PHY_START        , PHY_START + 512MB (no change)
 - SSEG1: Disabled (We use highmem to use the memory of 512MB~1GB)

We also deprecated zhole_szie[] settings, it's only used by arm
style CPUs. All memory gap should use Reserved setting of dts in
csky system.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/abiv1/inc/abi/entry.h |  5 +--
 arch/csky/abiv2/inc/abi/entry.h |  7 ++--
 arch/csky/kernel/head.S         |  5 +++
 arch/csky/kernel/setup.c        | 63 ++++++++-------------------------
 arch/csky/kernel/smp.c          |  3 ++
 5 files changed, 25 insertions(+), 58 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/entry.h b/arch/csky/abiv1/inc/abi/entry.h
index f35a9f3315ee..5056ebb902d1 100644
--- a/arch/csky/abiv1/inc/abi/entry.h
+++ b/arch/csky/abiv1/inc/abi/entry.h
@@ -172,10 +172,7 @@
 	addi	r6, 0xe
 	cpwcr	r6, cpcr30
 
-	lsri	r6, 28
-	addi	r6, 2
-	lsli	r6, 28
-	addi	r6, 0xe
+	movi	r6, 0
 	cpwcr	r6, cpcr31
 .endm
 
diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index 6a404393d0f4..a99aff555a0a 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -290,11 +290,8 @@
 	addi	r6, 0x1ce
 	mtcr	r6, cr<30, 15> /* Set MSA0 */
 
-	lsri	r6, 28
-	addi	r6, 2
-	lsli	r6, 28
-	addi	r6, 0x1ce
-	mtcr	r6, cr<31, 15> /* Set MSA1 */
+	movi    r6, 0
+	mtcr	r6, cr<31, 15> /* Clr MSA1 */
 
 	/* enable MMU */
 	mfcr    r6, cr18
diff --git a/arch/csky/kernel/head.S b/arch/csky/kernel/head.S
index 61989f9241c0..17ed9d250480 100644
--- a/arch/csky/kernel/head.S
+++ b/arch/csky/kernel/head.S
@@ -21,6 +21,11 @@ END(_start)
 ENTRY(_start_smp_secondary)
 	SETUP_MMU
 
+	/* copy msa1 from CPU0 */
+	lrw     r6, secondary_msa1
+	ld.w	r6, (r6, 0)
+	mtcr	r6, cr<31, 15>
+
 	/* set stack point */
 	lrw     r6, secondary_stack
 	ld.w	r6, (r6, 0)
diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 3821e55742f4..819a9a7bf786 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -24,26 +24,9 @@ struct screen_info screen_info = {
 };
 #endif
 
-phys_addr_t __init_memblock memblock_end_of_REG0(void)
-{
-	return (memblock.memory.regions[0].base +
-		memblock.memory.regions[0].size);
-}
-
-phys_addr_t __init_memblock memblock_start_of_REG1(void)
-{
-	return memblock.memory.regions[1].base;
-}
-
-size_t __init_memblock memblock_size_of_REG1(void)
-{
-	return memblock.memory.regions[1].size;
-}
-
 static void __init csky_memblock_init(void)
 {
 	unsigned long zone_size[MAX_NR_ZONES];
-	unsigned long zhole_size[MAX_NR_ZONES];
 	signed long size;
 
 	memblock_reserve(__pa(_stext), _end - _stext);
@@ -54,54 +37,36 @@ static void __init csky_memblock_init(void)
 	memblock_dump_all();
 
 	memset(zone_size, 0, sizeof(zone_size));
-	memset(zhole_size, 0, sizeof(zhole_size));
 
 	min_low_pfn = PFN_UP(memblock_start_of_DRAM());
-	max_pfn	    = PFN_DOWN(memblock_end_of_DRAM());
-
-	max_low_pfn = PFN_UP(memblock_end_of_REG0());
-	if (max_low_pfn == 0)
-		max_low_pfn = max_pfn;
+	max_low_pfn = max_pfn = PFN_DOWN(memblock_end_of_DRAM());
 
 	size = max_pfn - min_low_pfn;
 
-	if (memblock.memory.cnt > 1) {
-		zone_size[ZONE_NORMAL]  =
-			PFN_DOWN(memblock_start_of_REG1()) - min_low_pfn;
-		zhole_size[ZONE_NORMAL] =
-			PFN_DOWN(memblock_start_of_REG1()) - max_low_pfn;
+	if (size <= PFN_DOWN(SSEG_SIZE - PHYS_OFFSET_OFFSET))
+		zone_size[ZONE_NORMAL] = size;
+	else if (size < PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET)) {
+		zone_size[ZONE_NORMAL] =
+				PFN_DOWN(SSEG_SIZE - PHYS_OFFSET_OFFSET);
+		max_low_pfn = min_low_pfn + zone_size[ZONE_NORMAL];
 	} else {
-		if (size <= PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET))
-			zone_size[ZONE_NORMAL] = max_pfn - min_low_pfn;
-		else {
-			zone_size[ZONE_NORMAL] =
+		zone_size[ZONE_NORMAL] =
 				PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
-			max_low_pfn = min_low_pfn + zone_size[ZONE_NORMAL];
-		}
+		max_low_pfn = min_low_pfn + zone_size[ZONE_NORMAL];
+		write_mmu_msa1(read_mmu_msa0() + SSEG_SIZE);
 	}
 
 #ifdef CONFIG_HIGHMEM
-	size = 0;
-	if (memblock.memory.cnt > 1) {
-		size = PFN_DOWN(memblock_size_of_REG1());
-		highstart_pfn = PFN_DOWN(memblock_start_of_REG1());
-	} else {
-		size = max_pfn - min_low_pfn -
-			PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
-		highstart_pfn =  min_low_pfn +
-			PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
-	}
-
-	if (size > 0)
-		zone_size[ZONE_HIGHMEM] = size;
+	zone_size[ZONE_HIGHMEM] = max_pfn - max_low_pfn;
 
-	highend_pfn = max_pfn;
+	highstart_pfn = max_low_pfn;
+	highend_pfn   = max_pfn;
 #endif
 	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
 
 	dma_contiguous_reserve(0);
 
-	free_area_init_node(0, zone_size, min_low_pfn, zhole_size);
+	free_area_init_node(0, zone_size, min_low_pfn, NULL);
 }
 
 void __init setup_arch(char **cmdline_p)
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index df2e2174dbd0..b5c5bc3afeb5 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -159,6 +159,8 @@ volatile unsigned int secondary_hint;
 volatile unsigned int secondary_ccr;
 volatile unsigned int secondary_stack;
 
+unsigned long secondary_msa1;
+
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	unsigned long mask = 1 << cpu;
@@ -167,6 +169,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 		(unsigned int) task_stack_page(tidle) + THREAD_SIZE - 8;
 	secondary_hint = mfcr("cr31");
 	secondary_ccr  = mfcr("cr18");
+	secondary_msa1 = read_mmu_msa1();
 
 	/*
 	 * Because other CPUs are in reset status, we must flush data
-- 
2.17.0

