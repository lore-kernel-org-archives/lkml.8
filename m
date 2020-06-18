Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF59C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868D02075E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j3bi4iLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbgFRPZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgFRPZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:25:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B89C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0BWKHLb/czL3HfDkyPQ/l70JHQlX7HmWK3YRfweIKwc=; b=j3bi4iLefY89bOCygQK+/UtFMU
        iwObx1gvW2qJ5avInfE9vP7ExhY+l+DJdttbnP0iZ5hdGbczX3cQzceKcmQ/KHZwoLrlEEdgMFovZ
        HtUhDPNzeda7rRk/Ec2pgorrs0cOUC7YORBqRN+RJxYiV4gTgqRWNwCC7pGZDbIpA1j8gpcSUzLfL
        p9j7ou2LF/sBXkHC3U+oaaMUxK+SM6/0Q2TA9oOp8EFHy9TZsdS7Qu2XNNG0memqIlYwe0+3efnAm
        jXySKW2u0GOiLoTajSfV/28UzaY09XClb8kAkC5C742txomTrbnJqeQMx5HvsRZlN+c0SysJIt6hx
        6XSPak9g==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlwPh-0002vR-7z; Thu, 18 Jun 2020 15:25:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     rientjes@google.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] dma-mapping: DMA_COHERENT_POOL should select GENERIC_ALLOCATOR
Date:   Thu, 18 Jun 2020 17:25:06 +0200
Message-Id: <20200618152506.116057-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma coherent pool code needs genalloc.  Move the select over
from DMA_REMAP, which doesn't actually need it.

Fixes: dbed452a078d ("dma-pool: decouple DMA_REMAP from DMA_COHERENT_POOL")
Reported-by: kernel test robot <lkp@intel.com>
---
 kernel/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index a0ce3c1494fdd2..6ad16b7c96526c 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -74,12 +74,12 @@ config DMA_NONCOHERENT_MMAP
 	bool
 
 config DMA_COHERENT_POOL
+	select GENERIC_ALLOCATOR
 	bool
 
 config DMA_REMAP
 	bool
 	depends on MMU
-	select GENERIC_ALLOCATOR
 	select DMA_NONCOHERENT_MMAP
 
 config DMA_DIRECT_REMAP
-- 
2.26.2

