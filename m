Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7E0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3610F204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgEUP1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:27:03 -0400
Received: from foss.arm.com ([217.140.110.172]:48924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730027AbgEUPXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:23:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE95B1042;
        Thu, 21 May 2020 08:23:17 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F5253F305;
        Thu, 21 May 2020 08:23:16 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Jan Beulich <jbeulich@suse.com>
Cc:     Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/2] x86: mm: ptdump: Calculate effective permissions correctly
Date:   Thu, 21 May 2020 16:23:07 +0100
Message-Id: <20200521152308.33096-2-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521152308.33096-1-steven.price@arm.com>
References: <20200521152308.33096-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By switching the x86 page table dump code to use the generic code the
effective permissions are no longer calculated correctly because the
note_page() function is only called for *leaf* entries. To calculate the
actual effective permissions it is necessary to observe the full
hierarchy of the page tree.

Introduce a new callback for ptdump which is called for every entry and
can therefore update the prot_levels array correctly. note_page() can
then simply access the appropriate element in the array.

Reported-by: Jan Beulich <jbeulich@suse.com>
Fixes: 2ae27137b2db ("x86: mm: convert dump_pagetables to use walk_page_range")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/x86/mm/dump_pagetables.c | 31 +++++++++++++++++++------------
 include/linux/ptdump.h        |  1 +
 mm/ptdump.c                   | 17 ++++++++++++++++-
 3 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 69309cd56fdf..199bbb7fbd79 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -249,10 +249,22 @@ static void note_wx(struct pg_state *st, unsigned long addr)
 		  (void *)st->start_address);
 }
 
-static inline pgprotval_t effective_prot(pgprotval_t prot1, pgprotval_t prot2)
+static void effective_prot(struct ptdump_state *pt_st, int level, u64 val)
 {
-	return (prot1 & prot2 & (_PAGE_USER | _PAGE_RW)) |
-	       ((prot1 | prot2) & _PAGE_NX);
+	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
+	pgprotval_t prot = val & PTE_FLAGS_MASK;
+	pgprotval_t effective;
+
+	if (level > 0) {
+		pgprotval_t higher_prot = st->prot_levels[level - 1];
+
+		effective = (higher_prot & prot & (_PAGE_USER | _PAGE_RW)) |
+			    ((higher_prot | prot) & _PAGE_NX);
+	} else {
+		effective = prot;
+	}
+
+	st->prot_levels[level] = effective;
 }
 
 /*
@@ -270,16 +282,10 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 	struct seq_file *m = st->seq;
 
 	new_prot = val & PTE_FLAGS_MASK;
+	new_eff = st->prot_levels[level];
 
-	if (level > 0) {
-		new_eff = effective_prot(st->prot_levels[level - 1],
-					 new_prot);
-	} else {
-		new_eff = new_prot;
-	}
-
-	if (level >= 0)
-		st->prot_levels[level] = new_eff;
+	if (!val)
+		new_eff = 0;
 
 	/*
 	 * If we have a "break" in the series, we need to flush the state that
@@ -374,6 +380,7 @@ static void ptdump_walk_pgd_level_core(struct seq_file *m,
 	struct pg_state st = {
 		.ptdump = {
 			.note_page	= note_page,
+			.effective_prot = effective_prot,
 			.range		= ptdump_ranges
 		},
 		.level = -1,
diff --git a/include/linux/ptdump.h b/include/linux/ptdump.h
index a67065c403c3..ac01502763bf 100644
--- a/include/linux/ptdump.h
+++ b/include/linux/ptdump.h
@@ -14,6 +14,7 @@ struct ptdump_state {
 	/* level is 0:PGD to 4:PTE, or -1 if unknown */
 	void (*note_page)(struct ptdump_state *st, unsigned long addr,
 			  int level, unsigned long val);
+	void (*effective_prot)(struct ptdump_state *st, int level, u64 val);
 	const struct ptdump_range *range;
 };
 
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 26208d0d03b7..f4ce916f5602 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -36,6 +36,9 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 		return note_kasan_page_table(walk, addr);
 #endif
 
+	if (st->effective_prot)
+		st->effective_prot(st, 0, pgd_val(val));
+
 	if (pgd_leaf(val))
 		st->note_page(st, addr, 0, pgd_val(val));
 
@@ -53,6 +56,9 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 		return note_kasan_page_table(walk, addr);
 #endif
 
+	if (st->effective_prot)
+		st->effective_prot(st, 1, p4d_val(val));
+
 	if (p4d_leaf(val))
 		st->note_page(st, addr, 1, p4d_val(val));
 
@@ -70,6 +76,9 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 		return note_kasan_page_table(walk, addr);
 #endif
 
+	if (st->effective_prot)
+		st->effective_prot(st, 2, pud_val(val));
+
 	if (pud_leaf(val))
 		st->note_page(st, addr, 2, pud_val(val));
 
@@ -87,6 +96,8 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
 		return note_kasan_page_table(walk, addr);
 #endif
 
+	if (st->effective_prot)
+		st->effective_prot(st, 3, pmd_val(val));
 	if (pmd_leaf(val))
 		st->note_page(st, addr, 3, pmd_val(val));
 
@@ -97,8 +108,12 @@ static int ptdump_pte_entry(pte_t *pte, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
 	struct ptdump_state *st = walk->private;
+	pte_t val = READ_ONCE(*pte);
+
+	if (st->effective_prot)
+		st->effective_prot(st, 4, pte_val(val));
 
-	st->note_page(st, addr, 4, pte_val(READ_ONCE(*pte)));
+	st->note_page(st, addr, 4, pte_val(val));
 
 	return 0;
 }
-- 
2.20.1

