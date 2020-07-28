Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51451C43459
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F63E21775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m77qbqdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgG1FCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 01:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbgG1FCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 01:02:11 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE9BC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:02:11 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f9so4669822pju.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+0aK6m9rWhTUh9NQHuLCLcSCwFfKLzAvMTtTISrPDx0=;
        b=m77qbqdhTD0E1bLRKfPDGv58JgzSBQs2xDbEI08fmn9k+ra7oqpVqLSw11WKfChmS+
         YbrOYiTSd4Y4hEM0JS20tSnA1FmOw+qA86jaD0pqHvH1N5gLKhGx1Id/4yvYD3DTYMhL
         ZsGLkejhGYAPRXUzWCBU0hjohFASwu7vVgV2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0aK6m9rWhTUh9NQHuLCLcSCwFfKLzAvMTtTISrPDx0=;
        b=KqYiaJmR+KfvP0rQdQIx87SctRjurECU/nZPX9PkETYd1R7Wxw1huPoaQSqi1GP9ti
         UeJADB2Hamy7olY+8Sbsotxbpyd1AxLyL6QuKiOChtTy+mms0EZuTM5hfzqesglKMb8n
         eF/vGa55lRIs4hsIbg1Bu2EXY6ntPtgFm5Nj17c+XQKfES6qbVK1dkyxkBPDkPOMNCz/
         x9P12Om+4GJLtavWd7gqoIbEqeZM2PG3WP9mvmrCzLK/Eg/gy+nGIG2cHlziuEnOZQ3s
         sW2xOFwRa8aCojm9NLSJmkM1yJANoDKYTlEUS5LHda9Vl3NrTGZg71kVsTRNYBHjGlXa
         bJYQ==
X-Gm-Message-State: AOAM5332YS9frKaU1pxDe0YZX9RfplA3dRVLVzGxG11+QfdvMjm4QmOK
        9DRX7qyrHXcExxybFAk0/+XJig==
X-Google-Smtp-Source: ABdhPJzN1pKQb6oBFHEMYPW//iObjVmACECXo3ugP6g8XF/nmNxnwkwsj1jucGWODCgOBSR0BwtoxA==
X-Received: by 2002:a17:90a:fc98:: with SMTP id ci24mr2680781pjb.101.1595912530863;
        Mon, 27 Jul 2020 22:02:10 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id p9sm1414962pja.4.2020.07.27.22.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 22:02:10 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     robh+dt@kernel.org, frowand.list@gmail.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     treding@nvidia.com, gregkh@linuxfoundation.org,
        saravanak@google.com, suzuki.poulose@arm.com,
        dan.j.williams@intel.com, heikki.krogerus@linux.intel.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        drinkcat@chromium.org, tfiga@chromium.org, tientzu@chromium.org
Subject: [RFC v2 5/5] of: Add plumbing for restricted DMA pool
Date:   Tue, 28 Jul 2020 13:01:40 +0800
Message-Id: <20200728050140.996974-6-tientzu@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728050140.996974-1-tientzu@chromium.org>
References: <20200728050140.996974-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device is not behind an IOMMU, we look up the device node and set
up the restricted DMA when the restricted-dma property is presented.
One can specify two reserved-memory nodes in the device tree. One with
shared-dma-pool to handle the coherent DMA buffer allocation, and
another one with device-swiotlb-pool for regular DMA to/from system
memory, which would be subject to bouncing.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/of/address.c    | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/of/device.c     |  3 +++
 drivers/of/of_private.h |  6 ++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 381dc9be7b22..1285f914481f 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -8,6 +8,7 @@
 #include <linux/logic_pio.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/sizes.h>
@@ -1009,6 +1010,44 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 	return ret;
 }
 
+int of_dma_set_restricted_buffer(struct device *dev)
+{
+	int length, size, ret, i;
+	u32 idx[2];
+
+	if (!dev || !dev->of_node)
+		return -EINVAL;
+
+	if (!of_get_property(dev->of_node, "restricted-dma", &length))
+		return 0;
+
+	size = length / sizeof(idx[0]);
+	if (size > ARRAY_SIZE(idx)) {
+		dev_err(dev,
+			"restricted-dma expected less than or equal to %d indexs, but got %d\n",
+			ARRAY_SIZE(idx), size);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32_array(dev->of_node, "restricted-dma", idx,
+					 size);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < size; i++) {
+		ret = of_reserved_mem_device_init_by_idx(dev, dev->of_node,
+							 idx[i]);
+		if (ret) {
+			dev_err(dev,
+				"of_reserved_mem_device_init_by_idx() failed with %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * of_dma_is_coherent - Check if device is coherent
  * @np:	device node
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 27203bfd0b22..83d6cf8a8256 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -169,6 +169,9 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 
 	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
 
+	if (!iommu)
+		return of_dma_set_restricted_buffer(dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure);
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index edc682249c00..f2e3adfb7d85 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -160,12 +160,18 @@ extern int of_bus_n_size_cells(struct device_node *np);
 #ifdef CONFIG_OF_ADDRESS
 extern int of_dma_get_range(struct device_node *np, u64 *dma_addr,
 			    u64 *paddr, u64 *size);
+extern int of_dma_set_restricted_buffer(struct device *dev);
 #else
 static inline int of_dma_get_range(struct device_node *np, u64 *dma_addr,
 				   u64 *paddr, u64 *size)
 {
 	return -ENODEV;
 }
+
+static inline int of_dma_get_restricted_buffer(struct device *dev)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* _LINUX_OF_PRIVATE_H */
-- 
2.28.0.rc0.142.g3c755180ce-goog

