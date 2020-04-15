Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFEFC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996FD2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8Zpz7Tg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392211AbgDOAGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634554AbgDOAFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:05:01 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7376C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:05:01 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 188so659272pgj.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ESsKmnN/8XjLZGFCRgaE4t6oba6cTfi788uzFnxL0dM=;
        b=B8Zpz7TgZ1vEk8R/IpXo/21kD7KbRuD+XLLWXecF+QlLac8VLY2jSNWWBUXQwDhEdH
         lqqcgClcDh2UJeu8UR4B8dAEiRwzdwUJ3wq/Rdc814Jt8PsyHkUwIDPC7Bu5ApdVzgqc
         Pfl+mVhUnQpuYKHQMNXiUmkRnL3+OostdVxdmsYR4y63MEzRq0S8Lm5sLkP6zs7m1C1U
         UX+ZNvmkNypoZBKFiH0Aye9M5y+wEYwVZoPbv0T2HxR4RLDnIEWF8JOGjBmzOvlV0Fo2
         pK+8Q2H/XmRMQijHm6TF5DygcosQAubi/LPQYJiy0xpzyz7fsMTUpSyFBu/D8p45eevb
         mDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ESsKmnN/8XjLZGFCRgaE4t6oba6cTfi788uzFnxL0dM=;
        b=eFpb2rElusuFoHUg9emmoMQ7PrN0STaoidzSLDbHOlsKNMIH2DE5q3Ick4cJdzv2GE
         HObiX6ybUcouHJGkmhOYrAw3EHiyMjcPZgPrPo04cwnOamLCtGdV674xMad0+vMbauyB
         8rtUKPooQUw7Elux11dV5UraGTa/zjFYIFg8r9SE0HXaKwDBAX4FTsDU1+FrMP6vGuRn
         fYWmnQwSJCrR2vzcW8jCcrroXx1yxqdTzW0Y5Pxt+sPal23z7D/a/t143nytS22iOx6P
         IjKuoFPjRDIUIFvm30IngxOIFeOWGLRehW33obrigNrGWYmHayvnrfU5+O+ndxBwGern
         CYpQ==
X-Gm-Message-State: AGi0PuZaytiV4f0HT8n4j+c+oyQJZaP6y3TMInh0QSv9jA/6uGrunktu
        4bAWGhHIKt9qrGPK87+ZSILI8A==
X-Google-Smtp-Source: APiQypKpwtllReFLyE2xu1cCo0pm7Ljw/fcrwwCvtindDxqER/rQzn6+x2HPLd5dFwKyTkquVr7vCQ==
X-Received: by 2002:a63:d904:: with SMTP id r4mr24446955pgg.323.1586909101065;
        Tue, 14 Apr 2020 17:05:01 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 128sm1061161pfx.187.2020.04.14.17.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:05:00 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:04:59 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Jon Grimm <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [patch 5/7] dma-pool: add pool sizes to debugfs
In-Reply-To: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2004141704050.68516@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic DMA pools can dynamically expand based on non-blocking
allocations that need to use it.

Export the sizes of each of these pools, in bytes, through debugfs for
measurement.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/pool.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index cf052314d9e4..3e22022c933b 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2020 Google LLC
  */
+#include <linux/debugfs.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/dma-contiguous.h>
@@ -15,6 +16,11 @@
 static struct gen_pool *atomic_pool_dma __ro_after_init;
 static struct gen_pool *atomic_pool_dma32 __ro_after_init;
 static struct gen_pool *atomic_pool_kernel __ro_after_init;
+#ifdef CONFIG_DEBUG_FS
+static unsigned long pool_size_dma;
+static unsigned long pool_size_dma32;
+static unsigned long pool_size_kernel;
+#endif
 
 #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
 static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
@@ -29,6 +35,38 @@ static int __init early_coherent_pool(char *p)
 }
 early_param("coherent_pool", early_coherent_pool);
 
+#ifdef CONFIG_DEBUG_FS
+static void __init dma_atomic_pool_debugfs_init(void)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir("dma_pools", NULL);
+	if (IS_ERR_OR_NULL(root))
+		return;
+
+	debugfs_create_ulong("pool_size_dma", 0400, root, &pool_size_dma);
+	debugfs_create_ulong("pool_size_dma32", 0400, root, &pool_size_dma32);
+	debugfs_create_ulong("pool_size_kernel", 0400, root, &pool_size_kernel);
+}
+
+static void dma_atomic_pool_size_add(gfp_t gfp, size_t size)
+{
+	if (gfp & __GFP_DMA)
+		pool_size_dma += size;
+	else if (gfp & __GFP_DMA32)
+		pool_size_dma32 += size;
+	else
+		pool_size_kernel += size;
+}
+#else
+static inline void dma_atomic_pool_debugfs_init(void)
+{
+}
+static inline void dma_atomic_pool_size_add(gfp_t gfp, size_t size)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 			      gfp_t gfp)
 {
@@ -76,6 +114,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	if (ret)
 		goto encrypt_mapping;
 
+	dma_atomic_pool_size_add(gfp, pool_size);
 	return 0;
 
 encrypt_mapping:
@@ -160,6 +199,8 @@ static int __init dma_atomic_pool_init(void)
 		if (!atomic_pool_dma32)
 			ret = -ENOMEM;
 	}
+
+	dma_atomic_pool_debugfs_init();
 	return ret;
 }
 postcore_initcall(dma_atomic_pool_init);
