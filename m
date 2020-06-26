Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428CAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F812082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fnSEtiDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgFZIIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgFZIHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:07:48 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925F7C08C5DB;
        Fri, 26 Jun 2020 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tYiJ8awb7HQY8NHNAGR9Uf0rHCnZXmo9pJDwUfvh/fs=; b=fnSEtiDiNyCEjAcimZExM8sEZ5
        9QXDgocjRQ/BrfOU7dvbSPqXWfRAk6nuj33ZkvnstwIxxHMQbO1cdiqwnNC1EUnrp1xc1pEoFNEFs
        c9uazgMfbEoRzMsCJJa8FGMHtghnrTZaBVddoQS2ZwHfjdIAjIGiMPSWbKKEIpiNIf+RAMNAQi1+w
        xkh5gDjuyWksPGzdryj3QteiBGalJgpo7k8aXgTsENnDu5W5u7aNRFB11mfzad26K0i0r/i5xnSEM
        euu6b0ZazuH1i/Nvz3otvf3qAObMfaYpksVDiopQketkYpwunw30g1bML5loU/hdHaPZpsZViPzvZ
        5Q47yjcQ==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojOM-0007tK-SX; Fri, 26 Jun 2020 08:07:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] sh: move ioremap_fixed details out of <asm/io.h>
Date:   Fri, 26 Jun 2020 10:07:11 +0200
Message-Id: <20200626080717.1999041-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626080717.1999041-1-hch@lst.de>
References: <20200626080717.1999041-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap_fixed is an internal implementation detail and should not be
exposed to drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/io.h   | 16 ----------------
 arch/sh/mm/init.c          |  1 +
 arch/sh/mm/ioremap.c       |  1 +
 arch/sh/mm/ioremap.h       | 23 +++++++++++++++++++++++
 arch/sh/mm/ioremap_fixed.c |  1 +
 5 files changed, 26 insertions(+), 16 deletions(-)
 create mode 100644 arch/sh/mm/ioremap.h

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 1fd06ef6a19454..357a7e0c86d682 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -346,22 +346,6 @@ ioremap_prot(phys_addr_t offset, unsigned long size, unsigned long flags)
 }
 #endif
 
-#ifdef CONFIG_IOREMAP_FIXED
-extern void __iomem *ioremap_fixed(phys_addr_t, unsigned long, pgprot_t);
-extern int iounmap_fixed(void __iomem *);
-extern void ioremap_fixed_init(void);
-#else
-static inline void __iomem *
-ioremap_fixed(phys_addr_t phys_addr, unsigned long size, pgprot_t prot)
-{
-	BUG();
-	return NULL;
-}
-
-static inline void ioremap_fixed_init(void) { }
-static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
-#endif
-
 #define ioremap_uc	ioremap
 
 /*
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index a70ba0fdd0b382..da7ea48f9439e2 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/cache.h>
 #include <linux/sizes.h>
+#include "ioremap.h"
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index f6d02246d665bd..d9ec85b6bb2130 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -24,6 +24,7 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu.h>
+#include "ioremap.h"
 
 /*
  * Remap an arbitrary physical address space into the kernel virtual
diff --git a/arch/sh/mm/ioremap.h b/arch/sh/mm/ioremap.h
new file mode 100644
index 00000000000000..f2544e721a3526
--- /dev/null
+++ b/arch/sh/mm/ioremap.h
@@ -0,0 +1,23 @@
+#ifndef _SH_MM_IORMEMAP_H
+#define _SH_MM_IORMEMAP_H 1
+
+#ifdef CONFIG_IOREMAP_FIXED
+void __iomem *ioremap_fixed(phys_addr_t, unsigned long, pgprot_t);
+int iounmap_fixed(void __iomem *);
+void ioremap_fixed_init(void);
+#else
+static inline void __iomem *
+ioremap_fixed(phys_addr_t phys_addr, unsigned long size, pgprot_t prot)
+{
+	BUG();
+	return NULL;
+}
+static inline void ioremap_fixed_init(void)
+{
+}
+static inline int iounmap_fixed(void __iomem *addr)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_IOREMAP_FIXED */
+#endif /* _SH_MM_IORMEMAP_H */
diff --git a/arch/sh/mm/ioremap_fixed.c b/arch/sh/mm/ioremap_fixed.c
index 07e744d75fa01b..1914b79d1c530b 100644
--- a/arch/sh/mm/ioremap_fixed.c
+++ b/arch/sh/mm/ioremap_fixed.c
@@ -24,6 +24,7 @@
 #include <asm/tlbflush.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
+#include "ioremap.h"
 
 struct ioremap_map {
 	void __iomem *addr;
-- 
2.26.2

