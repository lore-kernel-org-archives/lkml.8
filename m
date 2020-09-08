Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F5CC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DD3207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qtB2arh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbgIHQv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732036AbgIHQsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:48:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB147C061786;
        Tue,  8 Sep 2020 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IQrZo4aJNvIdGgzUh8cZgzH0FUyElPFQii/JEvXGgtk=; b=qtB2arh/HjoxfST21M5t0r8PEZ
        zS+je+XGSNwe7BlpD2U3bSjxFADL+LPHiufNuapJUkQHyDF29RqylSCg/g2qTIxPW57m4VDtJNbLl
        5tH6Jg19Byds6WyYSOFSnI2ASAtASepawkX88SxkM0r3kzYUXQGd0iBds3cZWgxqsePyGHfYdaLNF
        zI1FmO6f/YhubYBzOSiM/VvGKJXcclr4H1ZjNzjjb/WcENm5VcYivfOOEa+Z7F4rxt19Khq+DwI1z
        beqDLdt5iShfyysR22GEFJrvkAPoDmXUYhzsBvG2Mbnd2wZsuMIxbu2nh7rssQWpx5A4TGf7WQJ6Z
        QuYMq6tw==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFgmn-0001RB-FQ; Tue, 08 Sep 2020 16:48:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        iommu@lists.linux-foundation.org
Cc:     Tomasz Figa <tfiga@chromium.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH 02/12] MIPS/jazzdma: remove the unused vdma_remap function
Date:   Tue,  8 Sep 2020 18:47:48 +0200
Message-Id: <20200908164758.3177341-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908164758.3177341-1-hch@lst.de>
References: <20200908164758.3177341-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/include/asm/jazzdma.h |  2 -
 arch/mips/jazz/jazzdma.c        | 70 ---------------------------------
 2 files changed, 72 deletions(-)

diff --git a/arch/mips/include/asm/jazzdma.h b/arch/mips/include/asm/jazzdma.h
index d13f940022d5f9..c831da7fa89803 100644
--- a/arch/mips/include/asm/jazzdma.h
+++ b/arch/mips/include/asm/jazzdma.h
@@ -10,8 +10,6 @@
  */
 extern unsigned long vdma_alloc(unsigned long paddr, unsigned long size);
 extern int vdma_free(unsigned long laddr);
-extern int vdma_remap(unsigned long laddr, unsigned long paddr,
-		      unsigned long size);
 extern unsigned long vdma_phys2log(unsigned long paddr);
 extern unsigned long vdma_log2phys(unsigned long laddr);
 extern void vdma_stats(void);		/* for debugging only */
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index 014773f0bfcd74..fe40dbed04c1d6 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -209,76 +209,6 @@ int vdma_free(unsigned long laddr)
 
 EXPORT_SYMBOL(vdma_free);
 
-/*
- * Map certain page(s) to another physical address.
- * Caller must have allocated the page(s) before.
- */
-int vdma_remap(unsigned long laddr, unsigned long paddr, unsigned long size)
-{
-	int first, pages;
-
-	if (laddr > 0xffffff) {
-		if (vdma_debug)
-			printk
-			    ("vdma_map: Invalid logical address: %08lx\n",
-			     laddr);
-		return -EINVAL; /* invalid logical address */
-	}
-	if (paddr > 0x1fffffff) {
-		if (vdma_debug)
-			printk
-			    ("vdma_map: Invalid physical address: %08lx\n",
-			     paddr);
-		return -EINVAL; /* invalid physical address */
-	}
-
-	pages = (((paddr & (VDMA_PAGESIZE - 1)) + size) >> 12) + 1;
-	first = laddr >> 12;
-	if (vdma_debug)
-		printk("vdma_remap: first=%x, pages=%x\n", first, pages);
-	if (first + pages > VDMA_PGTBL_ENTRIES) {
-		if (vdma_debug)
-			printk("vdma_alloc: Invalid size: %08lx\n", size);
-		return -EINVAL;
-	}
-
-	paddr &= ~(VDMA_PAGESIZE - 1);
-	while (pages > 0 && first < VDMA_PGTBL_ENTRIES) {
-		if (pgtbl[first].owner != laddr) {
-			if (vdma_debug)
-				printk("Trying to remap other's pages.\n");
-			return -EPERM;	/* not owner */
-		}
-		pgtbl[first].frame = paddr;
-		paddr += VDMA_PAGESIZE;
-		first++;
-		pages--;
-	}
-
-	/*
-	 * Update translation table
-	 */
-	r4030_write_reg32(JAZZ_R4030_TRSTBL_INV, 0);
-
-	if (vdma_debug > 2) {
-		int i;
-		pages = (((paddr & (VDMA_PAGESIZE - 1)) + size) >> 12) + 1;
-		first = laddr >> 12;
-		printk("LADDR: ");
-		for (i = first; i < first + pages; i++)
-			printk("%08x ", i << 12);
-		printk("\nPADDR: ");
-		for (i = first; i < first + pages; i++)
-			printk("%08x ", pgtbl[i].frame);
-		printk("\nOWNER: ");
-		for (i = first; i < first + pages; i++)
-			printk("%08x ", pgtbl[i].owner);
-		printk("\n");
-	}
-
-	return 0;
-}
-
 /*
  * Translate a physical address to a logical address.
  * This will return the logical address of the first
-- 
2.28.0

