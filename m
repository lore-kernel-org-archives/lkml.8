Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63613C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B71A20753
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ELwZJspD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgDHP1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:27:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgDHP1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description;
        bh=8nJWSG9FGLTV/LSsPhlrBxYCcjYTd9Q8QHp0p+Dc/PE=; b=ELwZJspDRDvGdtx7PT85EPT+YV
        yxhk4+ibY6HrrZGiqfqwdsUZa6cZF5kpAqbjsD31KrX85b1+AtGYAuLww7Tst3RzdUs9x6VNbeXrZ
        M01xAh0VzlMOC+Fy/v5kkb57oupdX+fA+fix84dpECbl81ORgNzfPJsInEIL9fWIy+Nl3WvwJjfKB
        5J4uy4Tk1WEMBYsKhX6BwzlE3UY6BzFaAEmVOZhnGLsH3KGJcNChPa9AAkCCcNnaZcbRWj1RiCwSD
        tEdd719wJIoPBnrvLAexH11vybo1JchL5GHGZS1kQKd+7wvgCW8Z+A1X4NbO9fBHlBwMxJ80sx2ZU
        oaN9pcjQ==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMCcI-0007yx-A7; Wed, 08 Apr 2020 15:27:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] x86/mm: Add a x86_has_pat_wp helper
Date:   Wed,  8 Apr 2020 17:27:42 +0200
Message-Id: <20200408152745.1565832-2-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408152745.1565832-1-hch@lst.de>
References: <20200408152745.1565832-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract the ioremap code away from the caching mode internals.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/memtype.h | 2 ++
 arch/x86/mm/init.c             | 6 ++++++
 arch/x86/mm/ioremap.c          | 8 ++------
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/memtype.h b/arch/x86/include/asm/memtype.h
index 9c2447b3555d..1e4e99b40711 100644
--- a/arch/x86/include/asm/memtype.h
+++ b/arch/x86/include/asm/memtype.h
@@ -24,4 +24,6 @@ extern void memtype_free_io(resource_size_t start, resource_size_t end);
 
 extern bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn);
 
+bool x86_has_pat_wp(void);
+
 #endif /* _ASM_X86_MEMTYPE_H */
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index e7bb483557c9..83e5780768ad 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -71,6 +71,12 @@ uint8_t __pte2cachemode_tbl[8] = {
 };
 EXPORT_SYMBOL(__pte2cachemode_tbl);
 
+/* Check that the write-protect PAT entry is set for write-protect */
+bool x86_has_pat_wp(void)
+{
+	return __pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] == _PAGE_CACHE_MODE_WP;
+}
+
 static unsigned long __initdata pgt_buf_start;
 static unsigned long __initdata pgt_buf_end;
 static unsigned long __initdata pgt_buf_top;
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 18c637c0dc6f..41536f523a5f 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -778,10 +778,8 @@ void __init *early_memremap_encrypted(resource_size_t phys_addr,
 void __init *early_memremap_encrypted_wp(resource_size_t phys_addr,
 					 unsigned long size)
 {
-	/* Be sure the write-protect PAT entry is set for write-protect */
-	if (__pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] != _PAGE_CACHE_MODE_WP)
+	if (!x86_has_pat_wp())
 		return NULL;
-
 	return early_memremap_prot(phys_addr, size, __PAGE_KERNEL_ENC_WP);
 }
 
@@ -799,10 +797,8 @@ void __init *early_memremap_decrypted(resource_size_t phys_addr,
 void __init *early_memremap_decrypted_wp(resource_size_t phys_addr,
 					 unsigned long size)
 {
-	/* Be sure the write-protect PAT entry is set for write-protect */
-	if (__pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] != _PAGE_CACHE_MODE_WP)
+	if (!x86_has_pat_wp())
 		return NULL;
-
 	return early_memremap_prot(phys_addr, size, __PAGE_KERNEL_NOENC_WP);
 }
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
-- 
2.25.1

