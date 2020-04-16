Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD30EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A775E206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EXaA9+eR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbgDPPAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394880AbgDPPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:00:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C967AC061A10;
        Thu, 16 Apr 2020 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hWBzE7+Ma89SOv/SxY3UdWgMQO5IxVxE22FLaZEKh/I=; b=EXaA9+eRyWt82XO6H/fAi+TXM7
        42GfDdJphJS7tU+jTcFL2GWdylSdSzJNVlQOFBzWTri9AdHisjnCTLyGv8sPrER4Fh2PhRiTYgLf+
        jvLEaYgI2usLE7uqmRvbEfULml/efY8Tg9cEhY4Jg6RMsgOyL9fHllVp0fIlodEGVE5ZJXSVd3TI7
        sR5vVyp2ebc0U6u/RnE67gHxwyAolyXCjAIVgZeIsDjyXd6gAbE1AjalmwibKg3REJ/6hfdQ8QDzS
        X4bNHYUCqTXL5DveNGOBgP63pCwf2TY2vDZfFOj9yoz740te8DNyOcwunKhAydsu2/79wvaCEJkBC
        0sg5eYnQ==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP607-0002HD-MT; Thu, 16 Apr 2020 15:00:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 4/7] MIPS: merge __ioremap_mode into ioremap_prot
Date:   Thu, 16 Apr 2020 17:00:08 +0200
Message-Id: <20200416150011.820984-5-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416150011.820984-1-hch@lst.de>
References: <20200416150011.820984-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to have two ioremap with flags interfaces.  Merge
the historic mips __ioremap_mode into ioremap_prot which is a generic
kernel interface.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/io.h | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 7be323ed2bfd..60513250f8f8 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -156,9 +156,17 @@ static inline void *isa_bus_to_virt(unsigned long address)
 extern void __iomem * __ioremap(phys_addr_t offset, phys_addr_t size, unsigned long flags);
 extern void __iounmap(const volatile void __iomem *addr);
 
-static inline void __iomem * __ioremap_mode(phys_addr_t offset, unsigned long size,
-	unsigned long flags)
+/*
+ * ioremap_prot     -   map bus memory into CPU space
+ * @offset:    bus address of the memory
+ * @size:      size of the resource to map
+
+ * ioremap_prot gives the caller control over cache coherency attributes (CCA)
+ */
+static inline void __iomem *ioremap_prot(phys_addr_t offset,
+		unsigned long size, unsigned long prot_val)
 {
+	unsigned long flags = prot_val & _CACHE_MASK;
 	void __iomem *addr = plat_ioremap(offset, size, flags);
 
 	if (addr)
@@ -202,18 +210,6 @@ static inline void __iomem * __ioremap_mode(phys_addr_t offset, unsigned long si
 #undef __IS_LOW512
 }
 
-/*
- * ioremap_prot     -   map bus memory into CPU space
- * @offset:    bus address of the memory
- * @size:      size of the resource to map
-
- * ioremap_prot gives the caller control over cache coherency attributes (CCA)
- */
-static inline void __iomem *ioremap_prot(phys_addr_t offset,
-		unsigned long size, unsigned long prot_val) {
-	return __ioremap_mode(offset, size, prot_val & _CACHE_MASK);
-}
-
 /*
  * ioremap     -   map bus memory into CPU space
  * @offset:    bus address of the memory
@@ -226,7 +222,7 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset,
  * address.
  */
 #define ioremap(offset, size)						\
-	__ioremap_mode((offset), (size), _CACHE_UNCACHED)
+	ioremap_prot((offset), (size), _CACHE_UNCACHED)
 #define ioremap_uc		ioremap
 
 /*
@@ -245,7 +241,7 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset,
  * memory-like regions on I/O busses.
  */
 #define ioremap_cache(offset, size)					\
-	__ioremap_mode((offset), (size), _page_cachable_default)
+	ioremap_prot((offset), (size), _page_cachable_default)
 
 /*
  * ioremap_wc     -   map bus memory into CPU space
@@ -266,7 +262,7 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset,
  * _CACHE_UNCACHED option (see cpu_probe() method).
  */
 #define ioremap_wc(offset, size)					\
-	__ioremap_mode((offset), (size), boot_cpu_data.writecombine)
+	ioremap_prot((offset), (size), boot_cpu_data.writecombine)
 
 static inline void iounmap(const volatile void __iomem *addr)
 {
-- 
2.25.1

