Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B06C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42D820771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/SAbEu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgDHVVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:21:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45309 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbgDHVVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:21:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id t4so2984205plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/pdcHqDKwcC+6FzwpdnIam6pQiTAqrxIDHc9n85aJ8s=;
        b=g/SAbEu4LZtwZhA6te1rLZ4jop59d9Ytf77kYvQO1GX/6MLiTqnkAnj32sKw4mXZaV
         G/AO3x0eIncLWIYPgQ9pL6flT2CIICVynuF93qY3dUnfqy0BqS3SQDsbSCBajdELN3L5
         xahWlz0MqDoGAEkhRX7PtUAGwGdbruPzkL4FRQrDeSYbmSIIJprUZmfmkEZQOw+iUpa3
         v/EJuuUaxNvP1I+J310OfJym5nGZWHD2J37cVMNRQV0Yw6dvKH4lTP3u9JAiaMM32IJ0
         YpuZVz3IE7MW2Uq9iwRLdlDCuhVS1OZ2CvQDBbrV7Sj6VhefYAWFS8Nwb8TAfJe3E6ZX
         ACbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/pdcHqDKwcC+6FzwpdnIam6pQiTAqrxIDHc9n85aJ8s=;
        b=nGm5sYeuG1+IazryrImP70Hf+TrTQFrDcDsn2/lEh06NoXFJzNK1M59VOrXGsZ+8Rq
         T6esC1TgVbpV0HE97/PYCpO3kph+tpbNzf8Hf4QDMebFMJDpuVd5gnOXaUULTRi/lpi1
         k8kNvPBP7Gfb17wwxg7J9j2yEAQY1LqjaTfkbyySfSrG2qkCiL+TJq1OwB7qN2bw8zrl
         EjzECzn8XHPabuGye1XeI/JH1ZitQ864WTPTEnKlffUIaBPmRcgdOPYXblglNsU4JQnz
         BX37LmLYnlBmGD28cXUS/fbPJemD2b17F0JF54SOJ7FIgWTfMr8jOY8mA/LPo7KcZHxE
         WWZQ==
X-Gm-Message-State: AGi0Pua6yPVsM5O7P8Xiqmvm9JCCd/jhojp02t5px4pfxYMVg4fKDX1+
        Uf/Rx0PXet7tqwNRHafsFm9Mpg==
X-Google-Smtp-Source: APiQypI+w1rktSfBvlD9BuopTNa2b2v57j69h+rytLULylCC5sjSdzkWMc0y8l4w1v5antA+YMnviw==
X-Received: by 2002:a17:90b:4c0e:: with SMTP id na14mr7784901pjb.73.1586380870091;
        Wed, 08 Apr 2020 14:21:10 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a75sm411002pje.31.2020.04.08.14.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:21:09 -0700 (PDT)
Date:   Wed, 8 Apr 2020 14:21:08 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: [rfc v2 4/6] dma-direct: atomic allocations must come from atomic
 coherent pools
In-Reply-To: <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2004081420060.19661@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a device required unencrypted memory and the context does not allow
blocking, memory must be returned from the atomic coherent pools.

This avoids the remap when CONFIG_DMA_DIRECT_REMAP is not enabled and the
config only requires CONFIG_DMA_COHERENT_POOL.  This will be used for
CONFIG_AMD_MEM_ENCRYPT in a subsequent patch.

Keep all memory in these pools unencrypted.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/direct.c | 16 ++++++++++++++++
 kernel/dma/pool.c   | 15 +++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 70800ca64f13..44165263c185 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -124,6 +124,18 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 
+	/*
+	 * Unencrypted memory must come directly from DMA atomic pools if
+	 * blocking is not allowed.
+	 */
+	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
+	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp)) {
+		ret = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page, gfp);
+		if (!ret)
+			return NULL;
+		goto done;
+	}
+
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    dma_alloc_need_uncached(dev, attrs) &&
 	    !gfpflags_allow_blocking(gfp)) {
@@ -203,6 +215,10 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 {
 	unsigned int page_order = get_order(size);
 
+	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
+	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
+		return;
+
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
 	    !force_dma_unencrypted(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index e14c5a2da734..6685ab89cfa7 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -9,6 +9,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/init.h>
 #include <linux/genalloc.h>
+#include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
@@ -55,12 +56,20 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 
 	arch_dma_prep_coherent(page, pool_size);
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	addr = dma_common_contiguous_remap(page, pool_size,
 					   pgprot_dmacoherent(PAGE_KERNEL),
 					   __builtin_return_address(0));
 	if (!addr)
 		goto free_page;
-
+#else
+	addr = page_to_virt(page);
+#endif
+	/*
+	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
+	 * shrink so no re-encryption occurs in dma_direct_free_pages().
+	 */
+	set_memory_decrypted((unsigned long)page_to_virt(page), 1 << order);
 	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
 				pool_size, NUMA_NO_NODE);
 	if (ret)
@@ -69,8 +78,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	return 0;
 
 remove_mapping:
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
-free_page:
+#endif
+free_page: __maybe_unused
 	if (!dma_release_from_contiguous(NULL, page, 1 << order))
 		__free_pages(page, order);
 out:
