Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BFDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CEDF20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgHZNEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730058AbgHZNEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:04:47 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66AAC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:04:46 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id LD4l230064C55Sk01D4lxL; Wed, 26 Aug 2020 15:04:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kAv6b-0008ES-2r; Wed, 26 Aug 2020 15:04:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kAv6b-0006g6-0c; Wed, 26 Aug 2020 15:04:45 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: mm: Remove superfluous memblock_alloc*() casts
Date:   Wed, 26 Aug 2020 15:04:44 +0200
Message-Id: <20200826130444.25618-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return type of memblock_alloc*() is a void pointer, so there is no
need to cast it to "void *" or some other pointer type, before assigning
it to a pointer variable.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/mm/mcfmmu.c   | 2 +-
 arch/m68k/mm/motorola.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 2b9cb4a622811390..eac9dde65193443e 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -42,7 +42,7 @@ void __init paging_init(void)
 	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 	int i;
 
-	empty_zero_page = (void *) memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	if (!empty_zero_page)
 		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
 		      __func__, PAGE_SIZE, PAGE_SIZE);
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index a9bdde54ca350197..3a653f0a4188d4af 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -227,7 +227,7 @@ static pte_t * __init kernel_page_table(void)
 	pte_t *pte_table = last_pte_table;
 
 	if (PAGE_ALIGNED(last_pte_table)) {
-		pte_table = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
+		pte_table = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
 		if (!pte_table) {
 			panic("%s: Failed to allocate %lu bytes align=%lx\n",
 					__func__, PAGE_SIZE, PAGE_SIZE);
@@ -275,8 +275,7 @@ static pmd_t * __init kernel_ptr_table(void)
 
 	last_pmd_table += PTRS_PER_PMD;
 	if (PAGE_ALIGNED(last_pmd_table)) {
-		last_pmd_table = (pmd_t *)memblock_alloc_low(PAGE_SIZE,
-							   PAGE_SIZE);
+		last_pmd_table = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
 		if (!last_pmd_table)
 			panic("%s: Failed to allocate %lu bytes align=%lx\n",
 			      __func__, PAGE_SIZE, PAGE_SIZE);
-- 
2.17.1

