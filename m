Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9FEC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4702173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vb0wY5RB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgEAHkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 03:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgEAHkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 03:40:07 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421E6C035495
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 00:40:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u22so3396562plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pbJ0rXWHkCLJRyK9vXiUuFPqdQtHbtzqJkW11UYQ0Gg=;
        b=vb0wY5RB7Avh9W40PInSuMIMfqVVX8c5gNx4ovRY8kJyxvZpFLdww15R4N6GP0BdJO
         kgrgqAzooQ68Q9h97J83Z4uygdncUlx9LUQNXlDR83RSSuYlXcMHM61ShwEckSNa/w7j
         zGeH7KfIJLwO4jcDE+hc8uyeYhlVyv3TJoSE5JPRSbPgtGRPc13KO8L6QoWmL398HqVa
         3w+KMqQFA5upozNshMJzy7mU+yY6mts1x0PnRbUfUkevtqmFalyAtIiDrHPV6U79ju0B
         RGvaj1qzRpkf+1dHg8hx94nkYH28ELKWwg+2aR17hsgwFDSTrgW0H37OI6J/sl2XNoQk
         7nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pbJ0rXWHkCLJRyK9vXiUuFPqdQtHbtzqJkW11UYQ0Gg=;
        b=DXDtl1mf+ewYrxHm6iyKuqq7qAU4K4BemjKHVZ2cgtIEAAIUycu5e1ZipICfGWC6un
         WRwXyCmeFV93MIPyL+imEwQe0YCkMqMpBESinabPSHzK729HuYM4Q1DsAaV+SfDB5WFB
         IqW1yZc4zip4D4mLiglxaUJV62qPCwUk/ltCNKjuBzzPbgpthhv3/3V+HDZiO+/FEAYZ
         /XQczK4BC1zugKbVzJ6ZOH9BjHiy8Mld7kimzf46Ypl6VV1OF9KBhGT8/faeeIDESj6J
         gPs1MhZiISkz9BsCtwgxcZZ4vFoIYSE/EaSOqfNMgkCfsZ8tpRUnegumxtvEsq4NvTO9
         zC8A==
X-Gm-Message-State: AGi0PuZAQ9Rh2NKB0WjXFSVw01dacDBKkyhbJlVWPJGI54xSVtarfHOS
        nZPTRGTIBnS0RksxN22nZoP8NMj5C2k=
X-Google-Smtp-Source: APiQypJrHuK513hl/mWNZ3CMK5SALK94WvqJyZlw7ryX0HGGvoYccP4SvWf/0xIaXWcS+grMnsx+6Q==
X-Received: by 2002:a17:902:6b01:: with SMTP id o1mr3395641plk.64.1588318806626;
        Fri, 01 May 2020 00:40:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id w12sm1557841pfq.133.2020.05.01.00.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 00:40:06 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: [RFC][PATCH 2/4] mm: cma: Add dma_heap flag to cma structure
Date:   Fri,  1 May 2020 07:39:47 +0000
Message-Id: <20200501073949.120396-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200501073949.120396-1-john.stultz@linaro.org>
References: <20200501073949.120396-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a dma_heap flag on the cma structure,
along with accessors to set and read the flag.

This is then used to process and store the "linux,cma-heap"
property documented in the previous patch.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Andrew F. Davis" <afd@ti.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 include/linux/cma.h     |  3 +++
 kernel/dma/contiguous.c |  3 +++
 mm/cma.c                | 11 +++++++++++
 mm/cma.h                |  1 +
 4 files changed, 18 insertions(+)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 6ff79fefd01f..d8b8e6ce221c 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -25,6 +25,9 @@ extern phys_addr_t cma_get_base(const struct cma *cma);
 extern unsigned long cma_get_size(const struct cma *cma);
 extern const char *cma_get_name(const struct cma *cma);
 
+extern void __init cma_enable_dma_heap(struct cma *cma, bool enabled);
+extern bool cma_dma_heap_enabled(struct cma *cma);
+
 extern int __init cma_declare_contiguous_nid(phys_addr_t base,
 			phys_addr_t size, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 8bc6f2d670f9..f667fd51daa2 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -303,6 +303,7 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	phys_addr_t mask = align - 1;
 	unsigned long node = rmem->fdt_node;
 	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
+	bool heap_exported = of_get_flat_dt_prop(node, "linux,cma-heap", NULL);
 	struct cma *cma;
 	int err;
 
@@ -332,6 +333,8 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	if (default_cma)
 		dma_contiguous_set_default(cma);
 
+	cma_enable_dma_heap(cma, heap_exported);
+
 	rmem->ops = &rmem_cma_ops;
 	rmem->priv = cma;
 
diff --git a/mm/cma.c b/mm/cma.c
index 0463ad2ce06b..ec671bd8f66e 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -55,6 +55,16 @@ const char *cma_get_name(const struct cma *cma)
 	return cma->name ? cma->name : "(undefined)";
 }
 
+void __init cma_enable_dma_heap(struct cma *cma, bool enabled)
+{
+	cma->dma_heap = enabled;
+}
+
+bool cma_dma_heap_enabled(struct cma *cma)
+{
+	return !!cma->dma_heap;
+}
+
 static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
 					     unsigned int align_order)
 {
@@ -157,6 +167,7 @@ static int __init cma_init_reserved_areas(void)
 }
 core_initcall(cma_init_reserved_areas);
 
+
 /**
  * cma_init_reserved_mem() - create custom contiguous area from reserved memory
  * @base: Base address of the reserved area
diff --git a/mm/cma.h b/mm/cma.h
index 33c0b517733c..6fe2242c724f 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -13,6 +13,7 @@ struct cma {
 	spinlock_t mem_head_lock;
 #endif
 	const char *name;
+	bool dma_heap;
 };
 
 extern struct cma cma_areas[MAX_CMA_AREAS];
-- 
2.17.1

