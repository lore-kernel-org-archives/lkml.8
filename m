Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C06EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C7E24963
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942422;
	bh=QfCTPjHy7WZEfNI4U+ak78qxUMtpTRzTtJbFMnLqnt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xpk3MpqgvD4rFoFZYiseqEovqhET6gTpWCHR/6VX+gSIS9FFAn4Mv3m7JL8sRBzly
	 JV5IVa2/nylXPeEgr3fB1enNDqkswh1S4XVWzZgdVOK4W8F2TRAgAPv/nmLn39Dg57
	 pFyq0C913WhEFYL2hecWgxdd1i+tbsPdY8l8/rKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgEHMxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbgEHMxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:53:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3F812054F;
        Fri,  8 May 2020 12:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942414;
        bh=QfCTPjHy7WZEfNI4U+ak78qxUMtpTRzTtJbFMnLqnt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1JbKGMuxUZMD+ldGqoyTN/cBIxxlggEqdsbzCVvXyz9H0skNQH3i0foNnQu5hmnt
         Nr6b+EUsWTY7nwYiwaG6PI7PxWnzXWwZr4dCu4zmY+ojK5POpZub2+ybL2Zr3da6O3
         GHP6xHt63jzytc2uQ6Dgx+BJFo7BbZJJV14XitZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.4 36/50] hexagon: clean up ioremap
Date:   Fri,  8 May 2020 14:35:42 +0200
Message-Id: <20200508123048.327630600@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123043.085296641@linuxfoundation.org>
References: <20200508123043.085296641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

commit ac32292c8552f7e8517be184e65dd09786e991f9 upstream.

Use ioremap as the main implemented function, and defined
ioremap_nocache to it as a deprecated alias.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/hexagon/include/asm/io.h       |   11 ++---------
 arch/hexagon/kernel/hexagon_ksyms.c |    2 +-
 arch/hexagon/mm/ioremap.c           |    2 +-
 3 files changed, 4 insertions(+), 11 deletions(-)

--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -171,16 +171,9 @@ static inline void writel(u32 data, vola
 #define writew_relaxed __raw_writew
 #define writel_relaxed __raw_writel
 
-/*
- * Need an mtype somewhere in here, for cache type deals?
- * This is probably too long for an inline.
- */
-void __iomem *ioremap_nocache(unsigned long phys_addr, unsigned long size);
+void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
+#define ioremap_nocache ioremap
 
-static inline void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
-{
-	return ioremap_nocache(phys_addr, size);
-}
 
 static inline void iounmap(volatile void __iomem *addr)
 {
--- a/arch/hexagon/kernel/hexagon_ksyms.c
+++ b/arch/hexagon/kernel/hexagon_ksyms.c
@@ -20,7 +20,7 @@ EXPORT_SYMBOL(__vmgetie);
 EXPORT_SYMBOL(__vmsetie);
 EXPORT_SYMBOL(__vmyield);
 EXPORT_SYMBOL(empty_zero_page);
-EXPORT_SYMBOL(ioremap_nocache);
+EXPORT_SYMBOL(ioremap);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
 
--- a/arch/hexagon/mm/ioremap.c
+++ b/arch/hexagon/mm/ioremap.c
@@ -9,7 +9,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 
-void __iomem *ioremap_nocache(unsigned long phys_addr, unsigned long size)
+void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 {
 	unsigned long last_addr, addr;
 	unsigned long offset = phys_addr & ~PAGE_MASK;


