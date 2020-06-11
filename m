Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D18C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3807620829
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdRQWIST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgFKTUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgFKTUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:20:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1A6C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:20:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so2775835pjv.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0RWHH5fLF59Um6Y5l8fqB4Uo2eJszov0rE1UzYFPSzI=;
        b=JdRQWISTkKmhO8vUDE4vizFpUg804f1yUuzpg9VXBOYxGIyGbiL0XFdu0GZ+GvlSXT
         PrAd9RYV1ky0p+RrYgxGIxbun8jtjtOeLjr+umGxdeUqbsBPMNd5KjsGMbN+DB7VPvBy
         VqCLY10ISyV7J0igBjPB7QYIqKjqNHx+xK60voGz1sLBHrNIe+YkEo8Xdvq7WMAI7OnI
         yArx81zMkQGM8m7uR0qqEFh7j3Xe9OMF223woYvkRZlJQjzHWRWfbL7A3z7X0yYdWR57
         /D/Uwaqwn/YZLRdlwSH1/t110UayyKpuU/YmyxMlsuuMUeCE6Pw1Jblkh+Xil+j5Y4o2
         uMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0RWHH5fLF59Um6Y5l8fqB4Uo2eJszov0rE1UzYFPSzI=;
        b=cwoOMWiUBwbZc+E3WdTyGwd5Q9ha7udlq/v/RF8tT7bBwCa1ydTKzj0fzoGjWiilbN
         2nV4YFTw8NEaLkJjH9R/NbADXUKj2jGepcnM3/k28H1+v4/n7/pSNvV5CVxDawkV9K5F
         orh9Q9LNH8a7R0qui5mjPhfVOZbGR9AkEhW4VKf3Hod5N9mMha4pXIMOLvowsQPorP73
         cBOW+/Mk/QLeVaVhqaLAieGnoYddTszOyczxiWjZesW0j3cnsrsUh4iAPvvxgTZIHP1g
         e2b7MdpDUQj4uhACZPhHdBD7lU415RGoMdXYsvX95OgUsF9AlH9vvtBysqn3moyh7lWq
         Triw==
X-Gm-Message-State: AOAM531sM4s+yxZj3KZVemFZbQ6bj6Vh1eNw3RamN/EGsQjQ8/wz8ZOp
        S+T9ntLgZHQxYeJgnpMVnasZXw==
X-Google-Smtp-Source: ABdhPJzvCw22dYLwxKcxQJKZqi3ugu6ayMxQGnkNzW9CE2wSsE0O83786LzlNuvg9IOoKYMmSyFAnw==
X-Received: by 2002:a17:90b:3690:: with SMTP id mj16mr9472674pjb.104.1591903229097;
        Thu, 11 Jun 2020 12:20:29 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id bv16sm3380989pjb.46.2020.06.11.12.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:20:28 -0700 (PDT)
Date:   Thu, 11 Jun 2020 12:20:28 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Thomas Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [patch for-5.8 1/4] dma-direct: always align allocation size in
 dma_direct_alloc_pages()
In-Reply-To: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2006111218570.153880@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_alloc_contiguous() does size >> PAGE_SHIFT and set_memory_decrypted()
works at page granularity.  It's necessary to page align the allocation
size in dma_direct_alloc_pages() for consistent behavior.

This also fixes an issue when arch_dma_prep_coherent() is called on an
unaligned allocation size for dma_alloc_need_uncached() when
CONFIG_DMA_DIRECT_REMAP is disabled but CONFIG_ARCH_HAS_DMA_SET_UNCACHED
is enabled.

Cc: stable@vger.kernel.org
Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/direct.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -112,11 +112,12 @@ static inline bool dma_should_free_from_pool(struct device *dev,
 struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		gfp_t gfp, unsigned long attrs)
 {
-	size_t alloc_size = PAGE_ALIGN(size);
 	int node = dev_to_node(dev);
 	struct page *page = NULL;
 	u64 phys_limit;
 
+	VM_BUG_ON(!PAGE_ALIGNED(size));
+
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
 
@@ -124,14 +125,14 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	gfp &= ~__GFP_ZERO;
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_limit);
-	page = dma_alloc_contiguous(dev, alloc_size, gfp);
+	page = dma_alloc_contiguous(dev, size, gfp);
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
-		dma_free_contiguous(dev, page, alloc_size);
+		dma_free_contiguous(dev, page, size);
 		page = NULL;
 	}
 again:
 	if (!page)
-		page = alloc_pages_node(node, gfp, get_order(alloc_size));
+		page = alloc_pages_node(node, gfp, get_order(size));
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		dma_free_contiguous(dev, page, size);
 		page = NULL;
@@ -158,8 +159,10 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 
+	size = PAGE_ALIGN(size);
+
 	if (dma_should_alloc_from_pool(dev, gfp, attrs)) {
-		ret = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page, gfp);
+		ret = dma_alloc_from_pool(dev, size, &page, gfp);
 		if (!ret)
 			return NULL;
 		goto done;
@@ -183,10 +186,10 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	     dma_alloc_need_uncached(dev, attrs)) ||
 	    (IS_ENABLED(CONFIG_DMA_REMAP) && PageHighMem(page))) {
 		/* remove any dirty cache lines on the kernel alias */
-		arch_dma_prep_coherent(page, PAGE_ALIGN(size));
+		arch_dma_prep_coherent(page, size);
 
 		/* create a coherent mapping */
-		ret = dma_common_contiguous_remap(page, PAGE_ALIGN(size),
+		ret = dma_common_contiguous_remap(page, size,
 				dma_pgprot(dev, PAGE_KERNEL, attrs),
 				__builtin_return_address(0));
 		if (!ret)
