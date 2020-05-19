Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3CCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1AE62075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgESFtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:49:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23928 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbgESFs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:48:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49R4gq0YK8z9txm2;
        Tue, 19 May 2020 07:48:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sq7jOFmQdcqe; Tue, 19 May 2020 07:48:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49R4gp63Lkz9txm1;
        Tue, 19 May 2020 07:48:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ED6C38B767;
        Tue, 19 May 2020 07:48:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kzjqcpwa776K; Tue, 19 May 2020 07:48:55 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 161968B7A7;
        Tue, 19 May 2020 07:48:55 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E0C4C65A4A; Tue, 19 May 2020 05:48:54 +0000 (UTC)
Message-Id: <a53b2a0ffd042a8d85464bf90d55bc5b970e00a1.1589866984.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589866984.git.christophe.leroy@csgroup.eu>
References: <cover.1589866984.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 12/45] powerpc/ptdump: Properly handle non standard page
 size
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 19 May 2020 05:48:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to properly display information regardless of the page size,
it is necessary to take into account real page size.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Fixes: cabe8138b23c ("powerpc: dump as a single line areas mapping a single physical page.")
Cc: stable@vger.kernel.org
---
v3: Fixed sizes which were shifted one level (went unoticed on PPC32 as PMD and PUD level don't exist)
---
 arch/powerpc/mm/ptdump/ptdump.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 1f97668853e3..98d82dcf6f0b 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -60,6 +60,7 @@ struct pg_state {
 	unsigned long start_address;
 	unsigned long start_pa;
 	unsigned long last_pa;
+	unsigned long page_size;
 	unsigned int level;
 	u64 current_flags;
 	bool check_wx;
@@ -168,9 +169,9 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 #endif
 
 	pt_dump_seq_printf(st->seq, REG "-" REG " ", st->start_address, addr - 1);
-	if (st->start_pa == st->last_pa && st->start_address + PAGE_SIZE != addr) {
+	if (st->start_pa == st->last_pa && st->start_address + st->page_size != addr) {
 		pt_dump_seq_printf(st->seq, "[" REG "]", st->start_pa);
-		delta = PAGE_SIZE >> 10;
+		delta = st->page_size >> 10;
 	} else {
 		pt_dump_seq_printf(st->seq, " " REG " ", st->start_pa);
 		delta = (addr - st->start_address) >> 10;
@@ -195,7 +196,7 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 }
 
 static void note_page(struct pg_state *st, unsigned long addr,
-	       unsigned int level, u64 val)
+	       unsigned int level, u64 val, unsigned long page_size)
 {
 	u64 flag = val & pg_level[level].mask;
 	u64 pa = val & PTE_RPN_MASK;
@@ -207,6 +208,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
 		st->start_address = addr;
 		st->start_pa = pa;
 		st->last_pa = pa;
+		st->page_size = page_size;
 		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
 	/*
 	 * Dump the section of virtual memory when:
@@ -218,7 +220,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
 	 */
 	} else if (flag != st->current_flags || level != st->level ||
 		   addr >= st->marker[1].start_address ||
-		   (pa != st->last_pa + PAGE_SIZE &&
+		   (pa != st->last_pa + st->page_size &&
 		    (pa != st->start_pa || st->start_pa != st->last_pa))) {
 
 		/* Check the PTE flags */
@@ -246,6 +248,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
 		st->start_address = addr;
 		st->start_pa = pa;
 		st->last_pa = pa;
+		st->page_size = page_size;
 		st->current_flags = flag;
 		st->level = level;
 	} else {
@@ -261,7 +264,7 @@ static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
 
 	for (i = 0; i < PTRS_PER_PTE; i++, pte++) {
 		addr = start + i * PAGE_SIZE;
-		note_page(st, addr, 4, pte_val(*pte));
+		note_page(st, addr, 4, pte_val(*pte), PAGE_SIZE);
 
 	}
 }
@@ -278,7 +281,7 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
 			/* pmd exists */
 			walk_pte(st, pmd, addr);
 		else
-			note_page(st, addr, 3, pmd_val(*pmd));
+			note_page(st, addr, 3, pmd_val(*pmd), PMD_SIZE);
 	}
 }
 
@@ -294,7 +297,7 @@ static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
 			/* pud exists */
 			walk_pmd(st, pud, addr);
 		else
-			note_page(st, addr, 2, pud_val(*pud));
+			note_page(st, addr, 2, pud_val(*pud), PUD_SIZE);
 	}
 }
 
@@ -313,7 +316,7 @@ static void walk_pagetables(struct pg_state *st)
 			/* pgd exists */
 			walk_pud(st, pgd, addr);
 		else
-			note_page(st, addr, 1, pgd_val(*pgd));
+			note_page(st, addr, 1, pgd_val(*pgd), PGDIR_SIZE);
 	}
 }
 
@@ -368,7 +371,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 
 	/* Traverse kernel page tables */
 	walk_pagetables(&st);
-	note_page(&st, 0, 0, 0);
+	note_page(&st, 0, 0, 0, 0);
 	return 0;
 }
 
-- 
2.25.0

