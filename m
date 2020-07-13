Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3738C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB9320702
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YxAF0ZDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgGMJMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGMJMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:12:45 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3D3C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 02:12:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f16so5945807pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wW9UG9GkA5eq2tRO9SfLLrAbTAFpGwf7ilxMSntDIQU=;
        b=YxAF0ZDWNLRZbwatioa2W5wcq4CfxtsxsHlwEUn8kgIb6fCeDsCrWleQlNqOvMXiJ+
         LOoq5CKoHitDi5bruIZe80ea/NHJk8Y7SPSlkaSj1cpKaSzzyLmt4+HU5BB+/Za+6ObR
         5vstthuC8jO7QKbBxZSldp54hw1ndXzecTz5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wW9UG9GkA5eq2tRO9SfLLrAbTAFpGwf7ilxMSntDIQU=;
        b=Ap5qfE7UObrCnTBbOzKH2P6t8P5Hb9Oiw5m4YnNmY5k5tvU18zZAuc1EsCXW+eeD5v
         hLWHQ51kU6igqlmpW6+w39PhF5I6MXs6QsO/Vbx8MflHCBzgzRTsH+eesN0BE3V8yKZ3
         8+99GL4UUKD/tNVSPaH1D6d3hhkWVfMDBYl6r7sIjtuIXEvuSs6N5XdALrIxCrs0ci0F
         9paEaBIoJPHUsheiTPM1iEuAEPXk/ynYN1YMOLMlB3SbVpoTb7ubczgXdsY5b/I3E601
         FIEYf9AQJ4p8nIm55iFPwmYubOp4EHUWYYcDBppX4uHB7RB5PqRnvy1+GFGI1gvrEbAc
         0R0w==
X-Gm-Message-State: AOAM533zcTeuo9E5b3ljI+w6QmKjxWkJCYellY0Mdz4ZHxpV8XPLbB6p
        fxlD4XnBo1U7N74y3p1P9+Qh0A==
X-Google-Smtp-Source: ABdhPJzFuHMhPXzcXoFvEGJ2D3yKj+lsnp095Bn7A6IGRnnd7qXSC1PeqLmbJsZOAM2xionjMj9p8A==
X-Received: by 2002:a17:90a:ea83:: with SMTP id h3mr19821787pjz.176.1594631564912;
        Mon, 13 Jul 2020 02:12:44 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id d22sm13790576pfd.105.2020.07.13.02.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 02:12:44 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     robh+dt@kernel.org, frowand.list@gmail.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     treding@nvidia.com, gregkh@linuxfoundation.org,
        saravanak@google.com, suzuki.poulose@arm.com,
        dan.j.williams@intel.com, heikki.krogerus@linux.intel.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        tfiga@chromium.org, drinkcat@chromium.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH 2/4] dma-mapping: Add bounced DMA pool
Date:   Mon, 13 Jul 2020 17:12:09 +0800
Message-Id: <20200713091211.2183368-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200713091211.2183368-1-tientzu@chromium.org>
References: <20200713091211.2183368-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initialization function to create bounce buffer pools from
matching reserved-memory nodes in the device tree.

The bounce buffer pools provide a basic level of protection against
the DMA overwriting buffer contents at unexpected times. However, to
protect against general data leakage and system memory corruption, the
system needs to provide a way to restrict the DMA to a predefined memory
region.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/bounced.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/kernel/dma/bounced.c b/kernel/dma/bounced.c
index fcaabb5eccf2..0bfd6cf90aee 100644
--- a/kernel/dma/bounced.c
+++ b/kernel/dma/bounced.c
@@ -12,6 +12,9 @@
 #include <linux/dma-noncoherent.h>
 #include <linux/io.h>
 #include <linux/genalloc.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 
 struct dma_bounced_mem {
@@ -213,3 +216,89 @@ const struct dma_map_ops dma_bounced_ops = {
 	.max_mapping_size	= dma_bounced_max_mapping_size,
 	.get_merge_boundary	= NULL,
 };
+
+static int dma_bounced_device_init(struct reserved_mem *rmem,
+				   struct device *dev)
+{
+	struct dma_bounced_mem *mem;
+	int ret;
+
+	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	mem->virt_base =
+		devm_memremap(dev, rmem->base, rmem->size, MEMREMAP_WB);
+	if (!mem->virt_base) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	mem->size = rmem->size;
+	mem->device_base = phys_to_dma(dev, rmem->base);
+	mem->device_end = mem->device_base + rmem->size;
+
+	mem->orig_addr = kcalloc(mem->size >> PAGE_SHIFT,
+				 sizeof(*mem->orig_addr), GFP_KERNEL);
+	if (!mem->orig_addr) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	mem->pool = devm_gen_pool_create(dev, PAGE_SHIFT, NUMA_NO_NODE,
+					 "bounced DMA");
+	if (!mem->pool) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	ret = gen_pool_add_virt(mem->pool, (unsigned long)mem->virt_base,
+				rmem->base, rmem->size, NUMA_NO_NODE);
+	if (ret)
+		goto error;
+
+	dev->dma_bounced_mem = mem;
+	set_dma_ops(dev, &dma_bounced_ops);
+
+	return 0;
+
+error:
+	kfree(mem);
+
+	return ret;
+}
+
+static void dma_bounced_device_release(struct reserved_mem *rmem,
+				       struct device *dev)
+{
+	struct dma_bounced_mem *mem = dev->dma_bounced_mem;
+
+	set_dma_ops(dev, NULL);
+	dev->dma_bounced_mem = NULL;
+
+	kfree(mem->orig_addr);
+	kfree(mem);
+}
+
+static const struct reserved_mem_ops rmem_dma_bounced_ops = {
+	.device_init	= dma_bounced_device_init,
+	.device_release	= dma_bounced_device_release,
+};
+
+static int __init dma_bounced_setup(struct reserved_mem *rmem)
+{
+	unsigned long node = rmem->fdt_node;
+
+	if (of_get_flat_dt_prop(node, "reusable", NULL) ||
+	    of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
+	    of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
+	    of_get_flat_dt_prop(node, "no-map", NULL))
+		return -EINVAL;
+
+	rmem->ops = &rmem_dma_bounced_ops;
+	pr_info("Reserved memory: created DMA bounced memory pool at %pa, size %ld MiB\n",
+		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+	return 0;
+}
+
+RESERVEDMEM_OF_DECLARE(dma, "bounced-dma-pool", dma_bounced_setup);
-- 
2.27.0.383.g050319c2ae-goog

