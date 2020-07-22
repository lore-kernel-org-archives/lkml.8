Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC21EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D102320771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbgGVXuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:50:18 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:45130 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgGVXuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:50:17 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 613BF2A2A8; Wed, 22 Jul 2020 19:50:16 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <f54e99e9bd1e25ad70a6a1d7a7ec9ab2b4e50d68.1595460351.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k: Correct some typos in comments
Date:   Thu, 23 Jul 2020 09:25:51 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/kernel/head.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
index a54788458ca36..08eff92875144 100644
--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -57,7 +57,7 @@
  * Of course, readability is a subjective issue, so it will never be
  * argued that that goal was accomplished.  It was merely a goal.
  * A key way to help make code more readable is to give good
- * documentation.  So, the first thing you will find is exaustive
+ * documentation.  So, the first thing you will find is exhaustive
  * write-ups on the structure of the file, and the features of the
  * functional subroutines.
  *
@@ -1304,7 +1304,7 @@ L(mmu_fixup_done):
  * mmu_engage
  *
  * This chunk of code performs the gruesome task of engaging the MMU.
- * The reason its gruesome is because when the MMU becomes engaged it
+ * The reason it's gruesome is because when the MMU becomes engaged it
  * maps logical addresses to physical addresses.  The Program Counter
  * register is then passed through the MMU before the next instruction
  * is fetched (the instruction following the engage MMU instruction).
@@ -1369,7 +1369,7 @@ L(mmu_fixup_done):
 /*
  * After this point no new memory is allocated and
  * the start of available memory is stored in availmem.
- * (The bootmem allocator requires now the physicall address.)
+ * (The bootmem allocator requires now the physical address.)
  */
 
 	movel	L(memory_start),availmem
@@ -1547,7 +1547,7 @@ func_return	get_bi_record
  *	seven bits of the logical address (LA) are used as an
  *	index into the "root table."  Each entry in the root
  *	table has a bit which specifies if it's a valid pointer to a
- *	pointer table.  Each entry defines a 32KMeg range of memory.
+ *	pointer table.  Each entry defines a 32Meg range of memory.
  *	If an entry is invalid then that logical range of 32M is
  *	invalid and references to that range of memory (when the MMU
  *	is enabled) will fault.  If the entry is valid, then it does
@@ -1584,7 +1584,7 @@ func_return	get_bi_record
  *		bits 17..12 - index into the Page Table
  *		bits 11..0  - offset into a particular 4K page
  *
- *	The algorithms which follows do one thing: they abstract
+ *	The algorithms which follow do one thing: they abstract
  *	the MMU hardware.  For example, there are three kinds of
  *	cache settings that are relevant.  Either, memory is
  *	being mapped in which case it is either Kernel Code (or
@@ -2082,7 +2082,7 @@ func_return	mmu_map_tt
  *	mmu_map
  *
  *	This routine will map a range of memory using a pointer
- *	table and allocating the pages on the fly from the kernel.
+ *	table and allocate the pages on the fly from the kernel.
  *	The pointer table does not have to be already linked into
  *	the root table, this routine will do that if necessary.
  *
@@ -2528,7 +2528,7 @@ func_start	mmu_get_root_table_entry,%d0/%a1
 
 	/* Find the start of free memory, get_bi_record does this for us,
 	 * as the bootinfo structure is located directly behind the kernel
-	 * and and we simply search for the last entry.
+	 * we simply search for the last entry.
 	 */
 	get_bi_record	BI_LAST
 	addw	#PAGESIZE-1,%a0
@@ -2654,7 +2654,7 @@ func_start	mmu_get_page_table_entry,%d0/%a1
 	jne	2f
 
 	/* If the page table entry doesn't exist, we allocate a complete new
-	 * page and use it as one continues big page table which can cover
+	 * page and use it as one continuous big page table which can cover
 	 * 4MB of memory, nearly almost all mappings have that alignment.
 	 */
 	get_new_page
-- 
2.26.2

