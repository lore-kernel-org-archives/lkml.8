Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0A0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8B2246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RA+paHxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgCBAF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 19:05:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40688 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgCBAF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 19:05:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id t24so4496334pgj.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 16:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=n2z26x3A40N8extJFoFR/1kjizwIJ2psa4vNOP6D4IU=;
        b=RA+paHxh3lsDtcCFaWrHYBqPiCWIW0WA5M85Temkt10PhSH7s8uSgbzK2jSCkY0/Ey
         65+HTUWwpzLIbNV5d8f9mANOlLt8GBZHN4f0PK1lB57I7rrlZB4osmoQVzS/RAWolHcF
         aoPWKzGp/2tJPRbhNf5i1nIcaWo8w184BOcH1BFWBwxmp4Ngf9yLyVWc7eNcBhRmFsx8
         fbpx4uab0LQ8K2X6DRTpHF8YQyKCB77cKqAfc7yyzMArYe8twJNOFXTKJTunU8Uhrmot
         Dk0zitSoME6hyWL4qH+fI3kexaY2qur98n6s5vS80dmxOPpwnF005AQyRlzI/R5hRS1w
         eEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=n2z26x3A40N8extJFoFR/1kjizwIJ2psa4vNOP6D4IU=;
        b=f8YRHQll4ZaaJBQegi71K/jhpvjicZGvgbxPYMm2QeectKuDy+CfkdCXkl9kOTGLrD
         yyoLUevDJcB+FUnvY4G5Bso3/M8nGQmNr1B/bsMNax2464EZFCSWBjBxCR56RaLoXfhU
         3OMuhAgrh2LDoshwLD/4lQEmBIJr5GCCwuqEhLbPN1nhBKp9BV0KqjeaTn/fjXrjEYdF
         Wne3UJW0wY/lXeT9KyjV8/qAcSIjD5jh2oKnbSv/0JJaqhcFCfp78y1XW4EMzLDgaA1z
         ZzPAUcdouwscOEpJ2Wy/b16YQZNqCn7OnD80BJViBnL4CIuNNTxk1KAsLaT9rUKlJ7li
         0q1g==
X-Gm-Message-State: APjAAAUX+heRl+0FgvQJp2aoSXvSQwqZoKjaz10RSyelA4493vDGOocH
        XXmsaCpECzoOyFGKDx7PzbhfEw==
X-Google-Smtp-Source: APXvYqxzPvDKCutVwEF1pxEZuHkuvxtWhOYoY/LdE4IDi6GaBassCc+r6MwCxVVrfuMAN2HVaGRc3w==
X-Received: by 2002:a63:fc56:: with SMTP id r22mr16298681pgk.147.1583107524304;
        Sun, 01 Mar 2020 16:05:24 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q13sm18195897pgh.30.2020.03.01.16.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 16:05:23 -0800 (PST)
Date:   Sun, 1 Mar 2020 16:05:23 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        baekhw@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: [rfc 5/6] dma-direct: atomic allocations must come from unencrypted
 pools
In-Reply-To: <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2003011538040.213582@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When AMD memory encryption is enabled, all non-blocking DMA allocations
must originate from the atomic pools depending on the device and the gfp
mask of the allocation.

Keep all memory in these pools unencrypted.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/x86/Kconfig    | 1 +
 kernel/dma/direct.c | 9 ++++-----
 kernel/dma/remap.c  | 2 ++
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1523,6 +1523,7 @@ config X86_CPA_STATISTICS
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
+	select DMA_DIRECT_REMAP
 	select DYNAMIC_PHYSICAL_MASK
 	select ARCH_USE_MEMREMAP_PROT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -125,7 +125,6 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	void *ret;
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    dma_alloc_need_uncached(dev, attrs) &&
 	    !gfpflags_allow_blocking(gfp)) {
 		ret = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page, gfp);
 		if (!ret)
@@ -202,6 +201,10 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 {
 	unsigned int page_order = get_order(size);
 
+	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
+		return;
+
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
 	    !force_dma_unencrypted(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
@@ -209,10 +212,6 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		return;
 	}
 
-	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
-		return;
-
 	if (force_dma_unencrypted(dev))
 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
 
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -8,6 +8,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/init.h>
 #include <linux/genalloc.h>
+#include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
@@ -141,6 +142,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	if (!addr)
 		goto free_page;
 
+	set_memory_decrypted((unsigned long)page_to_virt(page), nr_pages);
 	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
 				pool_size, NUMA_NO_NODE);
 	if (ret)
