Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C082C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E1B2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dc8HNhuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgGMJMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGMJMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:12:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84F4C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 02:12:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g67so5759253pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2pjchSlwME4GrTpEw7XTrDCwU1gG4HJg02FXR22Hkas=;
        b=Dc8HNhuThCDkktDS6B+WjGZyK0LdkXIxeRs+uY86mwkgQgeDrNeZBcgHv+dr/VgE8i
         99LjcelPnCB6GxqIqDnK+19HuhjUyqsLTqBZV76hoWI+PhdoeFHI4rolEPvfQ03OsjQj
         T0K19kPY3cx28Xa3O40GxC3+syA37DHUIx4xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2pjchSlwME4GrTpEw7XTrDCwU1gG4HJg02FXR22Hkas=;
        b=oMyIyUPoCnBHAQtg8Hix5uPn1Ud0HJlVtsk2UCy5kC7RrPfDQjlOZidGRtyr1HjpRR
         vUcZvIRxEhGGrDU8kwGrhM6Z7S1V5jY0564dgaG3XC5zBY4RVfDmUrRdtUoB8+YGRtiX
         9/yXjJHVO4oLkY9u2ZbEiE9lhBVlBgwYrDCH0PF5XesvbGaQpR7usiLjVxFxlez8SQ3y
         UIUSXSJbd3DJZ5MTAh6WqcnD4+ur8tH3PcYyT4yf8za5rLqD6Q6UY+azdmWdiwKzZFPv
         MHeKQAkQEEfyEnUiP3Li+EuU1MU18Xi6H12X6q4oCDIpPrWNoGYotoZ8isa1FhB+Zira
         WrQg==
X-Gm-Message-State: AOAM531tYxoN5kjKiDE2nT3JHdZiNxIZy0yJUHg7TiP0q4Xrs8mEvyvE
        bHn4/NP5DbVs3AsVOFkW+pFnfA==
X-Google-Smtp-Source: ABdhPJzCBz1wXNm6srY4fV+QTPs1p1GBdSr9wd1N0xPtsZeiUu/632nKu46kLsgjWtntLiQYzALTzw==
X-Received: by 2002:a63:140a:: with SMTP id u10mr71073813pgl.238.1594631574223;
        Mon, 13 Jul 2020 02:12:54 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id kk6sm10887305pjb.1.2020.07.13.02.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 02:12:53 -0700 (PDT)
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
Subject: [PATCH 4/4] of: Add plumbing for bounced DMA pool
Date:   Mon, 13 Jul 2020 17:12:11 +0800
Message-Id: <20200713091211.2183368-5-tientzu@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200713091211.2183368-1-tientzu@chromium.org>
References: <20200713091211.2183368-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device is not behind an IOMMU, we look up the device node and set
up the bounced DMA when the bounced-dma property is presented. One can
specify two reserved-memory nodes in the device tree. One with
shared-dma-pool to handle the coherent DMA buffer allocation, and
another one with bounced-dma-pool for regular DMA to/from system memory,
which would be subject to bouncing.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/of/address.c    | 37 +++++++++++++++++++++++++++++++++++++
 drivers/of/device.c     |  3 +++
 drivers/of/of_private.h |  6 ++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 8eea3f6e29a4..a767b80f8862 100644
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
@@ -1009,6 +1010,42 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 	return ret;
 }
 
+int of_dma_set_bounce_buffer(struct device *dev)
+{
+	int length, size, ret, i;
+	u32 idx[2];
+
+	if (!dev || !dev->of_node)
+		return -EINVAL;
+
+	if (!of_get_property(dev->of_node, "bounced-dma", &length))
+		return 0;
+
+	size = length / sizeof(idx[0]);
+	if (size > ARRAY_SIZE(idx)) {
+		dev_err(dev,
+			"bounced-dma expected less than or equal to 2 indexs, but got %d\n",
+			size);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32_array(dev->of_node, "bounced-dma", idx,
+					 size);
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
index 27203bfd0b22..238beef48a50 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -169,6 +169,9 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 
 	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
 
+	if (!iommu)
+		return of_dma_set_bounce_buffer(dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure);
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index edc682249c00..3d1b8cca1519 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -160,12 +160,18 @@ extern int of_bus_n_size_cells(struct device_node *np);
 #ifdef CONFIG_OF_ADDRESS
 extern int of_dma_get_range(struct device_node *np, u64 *dma_addr,
 			    u64 *paddr, u64 *size);
+extern int of_dma_set_bounce_buffer(struct device *dev);
 #else
 static inline int of_dma_get_range(struct device_node *np, u64 *dma_addr,
 				   u64 *paddr, u64 *size)
 {
 	return -ENODEV;
 }
+
+static inline int of_dma_get_bounce_buffer(struct device *dev)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* _LINUX_OF_PRIVATE_H */
-- 
2.27.0.383.g050319c2ae-goog

