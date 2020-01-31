Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D622C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB81B215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gijDdNhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgAaM4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:56:20 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39046 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbgAaM4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q4E39gWihzu+lIedcU2GGQL0DwGBBTGpotUpwCrekG0=; b=gijDdNhwx0ahvyqqnoFgAwTs4f
        MzFxNGcBZ0dyybAbU1SknjtOuMiXb1NtDqwp8mZGUAs6+KqPJPXor6OREGptpbgh72lnluc+bQFzS
        vDJRhIONq4U3eI9wUi3625ottotc5XBDee6TE7nOAf8BMr1TvMW7izn7BwalMWjTPb1XAC7xl9l/g
        jD8a4zVXepk01IXSU4Dap4n7sK/Xr1Kz3q2vgeJpX4qBVYgNUxs5R//xkNhrYIH7ZVLRomk0nWaM1
        tuwTRBnGyvCEUCHkU43/OahAJQCvNJkoYlS4DwcoJ+L5A6Wepdr18v1DvVYDPQbCc08b4pK8aq0Cw
        ovy3arRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixVq7-0003gI-Op; Fri, 31 Jan 2020 12:56:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E03F30603C;
        Fri, 31 Jan 2020 13:54:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E6C6B2B4C4272; Fri, 31 Jan 2020 13:56:00 +0100 (CET)
Message-Id: <20200131125403.654652162@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 13:45:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH -v2 04/10] m68k,mm: Move the pointer table allocator to motorola.c
References: <20200131124531.623136425@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the Motorola MMU makes use of this allocator, it is a waste of
.text to include it for Sun3/ColdFire. Also, this is going to avoid
build issues when we're going to make it more Motorola specific.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/mm/memory.c   |  102 ------------------------------------------------
 arch/m68k/mm/motorola.c |  102 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 102 deletions(-)

--- a/arch/m68k/mm/memory.c
+++ b/arch/m68k/mm/memory.c
@@ -22,108 +22,6 @@
 #include <asm/machdep.h>
 
 
-/* ++andreas: {get,free}_pointer_table rewritten to use unused fields from
-   struct page instead of separately kmalloced struct.  Stolen from
-   arch/sparc/mm/srmmu.c ... */
-
-typedef struct list_head ptable_desc;
-static LIST_HEAD(ptable_list);
-
-#define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(page)->lru))
-#define PD_PAGE(ptable) (list_entry(ptable, struct page, lru))
-#define PD_MARKBITS(dp) (*(unsigned char *)&PD_PAGE(dp)->index)
-
-#define PTABLE_SIZE (PTRS_PER_PMD * sizeof(pmd_t))
-
-void __init init_pointer_table(unsigned long ptable)
-{
-	ptable_desc *dp;
-	unsigned long page = ptable & PAGE_MASK;
-	unsigned char mask = 1 << ((ptable - page)/PTABLE_SIZE);
-
-	dp = PD_PTABLE(page);
-	if (!(PD_MARKBITS(dp) & mask)) {
-		PD_MARKBITS(dp) = 0xff;
-		list_add(dp, &ptable_list);
-	}
-
-	PD_MARKBITS(dp) &= ~mask;
-	pr_debug("init_pointer_table: %lx, %x\n", ptable, PD_MARKBITS(dp));
-
-	/* unreserve the page so it's possible to free that page */
-	__ClearPageReserved(PD_PAGE(dp));
-	init_page_count(PD_PAGE(dp));
-
-	return;
-}
-
-pmd_t *get_pointer_table (void)
-{
-	ptable_desc *dp = ptable_list.next;
-	unsigned char mask = PD_MARKBITS (dp);
-	unsigned char tmp;
-	unsigned int off;
-
-	/*
-	 * For a pointer table for a user process address space, a
-	 * table is taken from a page allocated for the purpose.  Each
-	 * page can hold 8 pointer tables.  The page is remapped in
-	 * virtual address space to be noncacheable.
-	 */
-	if (mask == 0) {
-		void *page;
-		ptable_desc *new;
-
-		if (!(page = (void *)get_zeroed_page(GFP_KERNEL)))
-			return NULL;
-
-		mmu_page_ctor(page);
-
-		new = PD_PTABLE(page);
-		PD_MARKBITS(new) = 0xfe;
-		list_add_tail(new, dp);
-
-		return (pmd_t *)page;
-	}
-
-	for (tmp = 1, off = 0; (mask & tmp) == 0; tmp <<= 1, off += PTABLE_SIZE)
-		;
-	PD_MARKBITS(dp) = mask & ~tmp;
-	if (!PD_MARKBITS(dp)) {
-		/* move to end of list */
-		list_move_tail(dp, &ptable_list);
-	}
-	return (pmd_t *) (page_address(PD_PAGE(dp)) + off);
-}
-
-int free_pointer_table (pmd_t *ptable)
-{
-	ptable_desc *dp;
-	unsigned long page = (unsigned long)ptable & PAGE_MASK;
-	unsigned char mask = 1 << (((unsigned long)ptable - page)/PTABLE_SIZE);
-
-	dp = PD_PTABLE(page);
-	if (PD_MARKBITS (dp) & mask)
-		panic ("table already free!");
-
-	PD_MARKBITS (dp) |= mask;
-
-	if (PD_MARKBITS(dp) == 0xff) {
-		/* all tables in page are free, free page */
-		list_del(dp);
-		mmu_page_dtor((void *)page);
-		free_page (page);
-		return 1;
-	} else if (ptable_list.next != dp) {
-		/*
-		 * move this descriptor to the front of the list, since
-		 * it has one or more free tables.
-		 */
-		list_move(dp, &ptable_list);
-	}
-	return 0;
-}
-
 /* invalidate page in both caches */
 static inline void clear040(unsigned long paddr)
 {
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -67,6 +67,108 @@ void mmu_page_dtor(void *page)
 	cache_page(page);
 }
 
+/* ++andreas: {get,free}_pointer_table rewritten to use unused fields from
+   struct page instead of separately kmalloced struct.  Stolen from
+   arch/sparc/mm/srmmu.c ... */
+
+typedef struct list_head ptable_desc;
+static LIST_HEAD(ptable_list);
+
+#define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(page)->lru))
+#define PD_PAGE(ptable) (list_entry(ptable, struct page, lru))
+#define PD_MARKBITS(dp) (*(unsigned char *)&PD_PAGE(dp)->index)
+
+#define PTABLE_SIZE (PTRS_PER_PMD * sizeof(pmd_t))
+
+void __init init_pointer_table(unsigned long ptable)
+{
+	ptable_desc *dp;
+	unsigned long page = ptable & PAGE_MASK;
+	unsigned char mask = 1 << ((ptable - page)/PTABLE_SIZE);
+
+	dp = PD_PTABLE(page);
+	if (!(PD_MARKBITS(dp) & mask)) {
+		PD_MARKBITS(dp) = 0xff;
+		list_add(dp, &ptable_list);
+	}
+
+	PD_MARKBITS(dp) &= ~mask;
+	pr_debug("init_pointer_table: %lx, %x\n", ptable, PD_MARKBITS(dp));
+
+	/* unreserve the page so it's possible to free that page */
+	__ClearPageReserved(PD_PAGE(dp));
+	init_page_count(PD_PAGE(dp));
+
+	return;
+}
+
+pmd_t *get_pointer_table (void)
+{
+	ptable_desc *dp = ptable_list.next;
+	unsigned char mask = PD_MARKBITS (dp);
+	unsigned char tmp;
+	unsigned int off;
+
+	/*
+	 * For a pointer table for a user process address space, a
+	 * table is taken from a page allocated for the purpose.  Each
+	 * page can hold 8 pointer tables.  The page is remapped in
+	 * virtual address space to be noncacheable.
+	 */
+	if (mask == 0) {
+		void *page;
+		ptable_desc *new;
+
+		if (!(page = (void *)get_zeroed_page(GFP_KERNEL)))
+			return NULL;
+
+		mmu_page_ctor(page);
+
+		new = PD_PTABLE(page);
+		PD_MARKBITS(new) = 0xfe;
+		list_add_tail(new, dp);
+
+		return (pmd_t *)page;
+	}
+
+	for (tmp = 1, off = 0; (mask & tmp) == 0; tmp <<= 1, off += PTABLE_SIZE)
+		;
+	PD_MARKBITS(dp) = mask & ~tmp;
+	if (!PD_MARKBITS(dp)) {
+		/* move to end of list */
+		list_move_tail(dp, &ptable_list);
+	}
+	return (pmd_t *) (page_address(PD_PAGE(dp)) + off);
+}
+
+int free_pointer_table (pmd_t *ptable)
+{
+	ptable_desc *dp;
+	unsigned long page = (unsigned long)ptable & PAGE_MASK;
+	unsigned char mask = 1 << (((unsigned long)ptable - page)/PTABLE_SIZE);
+
+	dp = PD_PTABLE(page);
+	if (PD_MARKBITS (dp) & mask)
+		panic ("table already free!");
+
+	PD_MARKBITS (dp) |= mask;
+
+	if (PD_MARKBITS(dp) == 0xff) {
+		/* all tables in page are free, free page */
+		list_del(dp);
+		mmu_page_dtor((void *)page);
+		free_page (page);
+		return 1;
+	} else if (ptable_list.next != dp) {
+		/*
+		 * move this descriptor to the front of the list, since
+		 * it has one or more free tables.
+		 */
+		list_move(dp, &ptable_list);
+	}
+	return 0;
+}
+
 /* size of memory already mapped in head.S */
 extern __initdata unsigned long m68k_init_mapped_size;
 


