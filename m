Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD507C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B282F20705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVt8Dwh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbgEDSPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730722AbgEDR7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:59:13 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3497C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:59:12 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h6so88398qvz.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIcOiZ/oPstJ19Kfdf6vLqJLoLSUMaJLmWxn/KilYeo=;
        b=NVt8Dwh4+CTyP1vo2RSASr1fPyWYfMxcIzj+ZPt5qqtg5YrS2p+IKWrWj42OcUyh+5
         OzO1UvF03v5eU3rMG3Lpl7aJBApAulWfu0cozycioqpalvngqKk3NQ7wlTTXwmZfjTEV
         zLbsv3kUjst2El8qwm0HxHz0Gb15uuskdtfIQ3rtbgx8OYSZ8+ZPPsrXOlJKyVCFs3qH
         ue4WgIbWDEjUMtMVYkBdJ4qDcHUzE1APvKcUZenGeFa71p/zHB3pr2dYuoGsOk9MF/QB
         gL/LzWdnjgcA026ni4Tur2igitqX6bbHMR9yEc2hwI6tvgYzNhZJb4JHW8WmIihR3Qsu
         dZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIcOiZ/oPstJ19Kfdf6vLqJLoLSUMaJLmWxn/KilYeo=;
        b=hfLMAyU39B15WH67MqkQBvChp2AxJ1FYipu+asJw9m/OO/boppglO1sBQv4IfSZ8C/
         z3V8JnpbfF+8fxraVvBqQOWM3iRdgXFZScKFKmxVygNz6k5+k1+fAM3c+n/pbuouDVE/
         BPBXYmfIFv+cfc3WJaPJ3Fzud9q6u0nbhMf5KvixWmUgG0TqUsAeWR/hl+fpiQ73Hcbo
         kUeTbvQSKW+9yYPBOu46tAXfu5nO6t9x8iaijneJEaaPNCfKtXuCxl//RzdKFoLkSojw
         s/+3m3FVSiN8wXZsD9okoOjgQpCN6beNaaF3BCEBMaXui0Ebgpg1HE4K3/u2QNzSJtjY
         hSXA==
X-Gm-Message-State: AGi0PuYPf9P6yWTSXgiw7QCdrUFNwVF5z97GY5XmjRAqAdBOs1YfNFcO
        FmKEghHVqP4MKwvTSpIehcEMdQ==
X-Google-Smtp-Source: APiQypKwlFzf3a5OW4qNpEvJrr8gPZ9dkd0M9EM8AjzM6n1GJsuVm8Mc14EGeBeLg0ARGw3GoPVGPg==
X-Received: by 2002:a0c:da87:: with SMTP id z7mr269986qvj.141.1588615151983;
        Mon, 04 May 2020 10:59:11 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id h19sm11271088qtk.78.2020.05.04.10.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:59:11 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/4] net: ipa: define IMEM memory region for IPA
Date:   Mon,  4 May 2020 12:58:58 -0500
Message-Id: <20200504175859.22606-4-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504175859.22606-1-elder@linaro.org>
References: <20200504175859.22606-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a region of IMEM memory available for use by IPA in the
platform configuration data.  Initialize it from ipa_mem_init().
The memory must be mapped for access through an SMMU.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa.h             |  5 ++
 drivers/net/ipa/ipa_data-sc7180.c |  2 +
 drivers/net/ipa/ipa_data-sdm845.c |  2 +
 drivers/net/ipa/ipa_data.h        |  6 ++-
 drivers/net/ipa/ipa_mem.c         | 84 +++++++++++++++++++++++++++++++
 5 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa.h b/drivers/net/ipa/ipa.h
index 23fb29889e5a..32f6dfafdb05 100644
--- a/drivers/net/ipa/ipa.h
+++ b/drivers/net/ipa/ipa.h
@@ -47,6 +47,8 @@ struct ipa_interrupt;
  * @mem_offset:		Offset from @mem_virt used for access to IPA memory
  * @mem_size:		Total size (bytes) of memory at @mem_virt
  * @mem:		Array of IPA-local memory region descriptors
+ * @imem_iova:		I/O virtual address of IPA region in IMEM
+ * @imem_size;		Size of IMEM region
  * @zero_addr:		DMA address of preallocated zero-filled memory
  * @zero_virt:		Virtual address of preallocated zero-filled memory
  * @zero_size:		Size (bytes) of preallocated zero-filled memory
@@ -88,6 +90,9 @@ struct ipa {
 	u32 mem_size;
 	const struct ipa_mem *mem;
 
+	unsigned long imem_iova;
+	size_t imem_size;
+
 	dma_addr_t zero_addr;
 	void *zero_virt;
 	size_t zero_size;
diff --git a/drivers/net/ipa/ipa_data-sc7180.c b/drivers/net/ipa/ipa_data-sc7180.c
index f97e7e4e61c1..e9007d151c68 100644
--- a/drivers/net/ipa/ipa_data-sc7180.c
+++ b/drivers/net/ipa/ipa_data-sc7180.c
@@ -299,6 +299,8 @@ static const struct ipa_mem ipa_mem_local_data[] = {
 static struct ipa_mem_data ipa_mem_data = {
 	.local_count	= ARRAY_SIZE(ipa_mem_local_data),
 	.local		= ipa_mem_local_data,
+	.imem_addr	= 0x146a8000,
+	.imem_size	= 0x00002000,
 };
 
 /* Configuration data for the SC7180 SoC. */
diff --git a/drivers/net/ipa/ipa_data-sdm845.c b/drivers/net/ipa/ipa_data-sdm845.c
index c55507e94559..c0e207085550 100644
--- a/drivers/net/ipa/ipa_data-sdm845.c
+++ b/drivers/net/ipa/ipa_data-sdm845.c
@@ -321,6 +321,8 @@ static const struct ipa_mem ipa_mem_local_data[] = {
 static struct ipa_mem_data ipa_mem_data = {
 	.local_count	= ARRAY_SIZE(ipa_mem_local_data),
 	.local		= ipa_mem_local_data,
+	.imem_addr	= 0x146bd000,
+	.imem_size	= 0x00002000,
 };
 
 /* Configuration data for the SDM845 SoC. */
diff --git a/drivers/net/ipa/ipa_data.h b/drivers/net/ipa/ipa_data.h
index 51d8e5a6f23a..69957af56ccd 100644
--- a/drivers/net/ipa/ipa_data.h
+++ b/drivers/net/ipa/ipa_data.h
@@ -245,13 +245,17 @@ struct ipa_resource_data {
 };
 
 /**
- * struct ipa_mem - IPA-local memory region description
+ * struct ipa_mem - description of IPA memory regions
  * @local_count:	number of regions defined in the local[] array
  * @local:		array of IPA-local memory region descriptors
+ * @imem_addr:		physical address of IPA region within IMEM
+ * @imem_size:		size in bytes of IPA IMEM region
  */
 struct ipa_mem_data {
 	u32 local_count;
 	const struct ipa_mem *local;
+	u32 imem_addr;
+	u32 imem_size;
 };
 
 /**
diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
index fb4de2a12796..3c0916597fe1 100644
--- a/drivers/net/ipa/ipa_mem.c
+++ b/drivers/net/ipa/ipa_mem.c
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/dma-mapping.h>
+#include <linux/iommu.h>
 #include <linux/io.h>
 
 #include "ipa.h"
@@ -266,6 +267,79 @@ int ipa_mem_zero_modem(struct ipa *ipa)
 	return 0;
 }
 
+/**
+ * ipa_imem_init() - Initialize IMEM memory used by the IPA
+ * @ipa:	IPA pointer
+ * @addr:	Physical address of the IPA region in IMEM
+ * @size:	Size (bytes) of the IPA region in IMEM
+ *
+ * IMEM is a block of shared memory separate from system DRAM, and
+ * a portion of this memory is available for the IPA to use.  The
+ * modem accesses this memory directly, but the IPA accesses it
+ * via the IOMMU, using the AP's credentials.
+ *
+ * If this region exists (size > 0) we map it for read/write access
+ * through the IOMMU using the IPA device.
+ *
+ * Note: @addr and @size are not guaranteed to be page-aligned.
+ */
+static int ipa_imem_init(struct ipa *ipa, unsigned long addr, size_t size)
+{
+	struct device *dev = &ipa->pdev->dev;
+	struct iommu_domain *domain;
+	unsigned long iova;
+	phys_addr_t phys;
+	int ret;
+
+	if (!size)
+		return 0;	/* IMEM memory not used */
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain) {
+		dev_err(dev, "no IOMMU domain found for IMEM\n");
+		return -EINVAL;
+	}
+
+	/* Align the address down and the size up to page boundaries */
+	phys = addr & PAGE_MASK;
+	size = PAGE_ALIGN(size + addr - phys);
+	iova = phys;	/* We just want a direct mapping */
+
+	ret = iommu_map(domain, iova, phys, size, IOMMU_READ | IOMMU_WRITE);
+	if (ret)
+		return ret;
+
+	ipa->imem_iova = iova;
+	ipa->imem_size = size;
+
+	return 0;
+}
+
+static void ipa_imem_exit(struct ipa *ipa)
+{
+	struct iommu_domain *domain;
+	struct device *dev;
+
+	if (!ipa->imem_size)
+		return;
+
+	dev = &ipa->pdev->dev;
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain) {
+		size_t size;
+
+		size = iommu_unmap(domain, ipa->imem_iova, ipa->imem_size);
+		if (size != ipa->imem_size)
+			dev_warn(dev, "unmapped %zu IMEM bytes, expected %lu\n",
+				 size, ipa->imem_size);
+	} else {
+		dev_err(dev, "couldn't get IPA IOMMU domain for IMEM\n");
+	}
+
+	ipa->imem_size = 0;
+	ipa->imem_iova = 0;
+}
+
 /* Perform memory region-related initialization */
 int ipa_mem_init(struct ipa *ipa, const struct ipa_mem_data *mem_data)
 {
@@ -305,11 +379,21 @@ int ipa_mem_init(struct ipa *ipa, const struct ipa_mem_data *mem_data)
 	/* The ipa->mem[] array is indexed by enum ipa_mem_id values */
 	ipa->mem = mem_data->local;
 
+	ret = ipa_imem_init(ipa, mem_data->imem_addr, mem_data->imem_size);
+	if (ret)
+		goto err_unmap;
+
 	return 0;
+
+err_unmap:
+	memunmap(ipa->mem_virt);
+
+	return ret;
 }
 
 /* Inverse of ipa_mem_init() */
 void ipa_mem_exit(struct ipa *ipa)
 {
+	ipa_imem_exit(ipa);
 	memunmap(ipa->mem_virt);
 }
-- 
2.20.1

