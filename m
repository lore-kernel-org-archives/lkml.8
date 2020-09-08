Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293C1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB1162075A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uxw883jD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgIHQux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732051AbgIHQsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:48:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C393C06179A;
        Tue,  8 Sep 2020 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rHSBc/M4bEuOb9Ey0sWSjsN3haNI1yyBuzSqz9ajJzQ=; b=uxw883jDfwFTqx1kQc02sE7gz5
        T6genhEdpIBo8JlGHDRJLZO1GDNKrAaT3hBfl5H8ctRGOHxy5Z1YqDRFk+WjfvWPsdn+D8DsTPCyq
        vDvPDJ1bItTKRBJS/MqIg7Y+g0ET2HXq5KwdIxujVMlz4QZvDS7BAxR4hYzQ1/G5mvt8WnVoFDugj
        CMJfssAPg1+RF/6Eh1DefJdk2m+sdW0ZQh/oTrXkeco0dHfYJ5j/onoZm1u7SowznLxDFMRAMkPa/
        ngnL6UNUTGFCYWQfM4yvmctPYaU0E3BbqiVBxwE7Fc5RZJfgv+ZWoYjmfC2K2WKhCQkuUdqpuhNN/
        CsdNekXg==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFgn1-0001Tl-LF; Tue, 08 Sep 2020 16:48:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        iommu@lists.linux-foundation.org
Cc:     Tomasz Figa <tfiga@chromium.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH 12/12] dma-mapping: move the dma_declare_coherent_memory documentation
Date:   Tue,  8 Sep 2020 18:47:58 +0200
Message-Id: <20200908164758.3177341-13-hch@lst.de>
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

dma_declare_coherent_memory should not be in a DMA API guide aimed
at driver writers (that is consumers of the API).  Move it to a comment
near the function instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/core-api/dma-api.rst | 24 ------------------------
 kernel/dma/coherent.c              | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 3b3abbbb4b9a6f..90239348b30f6f 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -586,30 +586,6 @@ the DMA_ATTR_NON_CONSISTENT flag starting at virtual address vaddr and
 continuing on for size.  Again, you *must* observe the cache line
 boundaries when doing this.
 
-::
-
-	int
-	dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
-				    dma_addr_t device_addr, size_t size);
-
-Declare region of memory to be handed out by dma_alloc_coherent() when
-it's asked for coherent memory for this device.
-
-phys_addr is the CPU physical address to which the memory is currently
-assigned (this will be ioremapped so the CPU can access the region).
-
-device_addr is the DMA address the device needs to be programmed
-with to actually address this memory (this will be handed out as the
-dma_addr_t in dma_alloc_coherent()).
-
-size is the size of the area (must be multiples of PAGE_SIZE).
-
-As a simplification for the platforms, only *one* such region of
-memory may be declared per device.
-
-For reasons of efficiency, most platforms choose to track the declared
-region only at the granularity of a page.  For smaller allocations,
-you should use the dma_pool() API.
 
 Part III - Debug drivers use of the DMA-API
 -------------------------------------------
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 2a0c4985f38e41..f85d14bbfcbe03 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -107,6 +107,23 @@ static int dma_assign_coherent_memory(struct device *dev,
 	return 0;
 }
 
+/*
+ * Declare a region of memory to be handed out by dma_alloc_coherent() when it
+ * is asked for coherent memory for this device.  This shall only be used
+ * from platform code, usually based on the device tree description.
+ * 
+ * phys_addr is the CPU physical address to which the memory is currently
+ * assigned (this will be ioremapped so the CPU can access the region).
+ *
+ * device_addr is the DMA address the device needs to be programmed with to
+ * actually address this memory (this will be handed out as the dma_addr_t in
+ * dma_alloc_coherent()).
+ *
+ * size is the size of the area (must be a multiple of PAGE_SIZE).
+ *
+ * As a simplification for the platforms, only *one* such region of memory may
+ * be declared per device.
+ */
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 				dma_addr_t device_addr, size_t size)
 {
-- 
2.28.0

