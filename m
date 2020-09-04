Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B472C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C994D2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgwp/mA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgIDNBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbgIDNAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:00:09 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77441C061245;
        Fri,  4 Sep 2020 06:00:09 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id ay8so5996877edb.8;
        Fri, 04 Sep 2020 06:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G9XAHY9UguV3G7jomJ5XYwGLvO68uan6NVKz952gLlo=;
        b=fgwp/mA58GAYNA2+ofJOwDzpeN5xpHm7FGQCxsRmTpFiRg2hX328bdkJpVtclMBDL7
         EuVuqJKOHRB+Ct8ZHVRtM/yI4LAIzIGVV1jJuMsMWThbs/K4R3FRsREajruyYmGfo4dQ
         3jB//KFbIHXb3JftKf1vp+x2gONESXQlMWOnmLP2ELza9oQ1A36BZWxNZlGMKz9Ufy7p
         qRC9+GQH+JTk3ey9ggNDVAOt8q5BGYTDP538/P+hx5skahkufxqPHDBue7DshC+r3SSO
         gYuB9HRTDGzRBvHu9SlhIeWKruFWeNApN6trpxe6bkWZ+QKWOd8fdFgojPFWw+Jx49EB
         ZS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G9XAHY9UguV3G7jomJ5XYwGLvO68uan6NVKz952gLlo=;
        b=hDvnu6ILqy+gaOPlz37Fe4QznNGzAAuhi3EQss0jNp2AWgGTwJFL2CH6vxvh5+TUZt
         Gr2jFLg97FKU+yebWoSmz6BPc66ENmJu6QphkhPGILXXRZe5yyOaAnGlnRvJIu//ocbD
         gZlMo9OBDBkTZVGKGrdhPfxfUNVgHwwPLvI5vjULAmkh5gsqmovVKCSn2D6xnPslbOY1
         7uZ/bSRHHgCJ2MwuubHtkOpM0xPjSJoWvXvtsV1+f+TT3gY195yxoJOlG30mCYzUt31J
         qAxvfFec2sfTCZ1iO1iO8QFHIFrCT34mZ+uCxdjstZm5CU08lzFd+T5yRPIUndtEYbk6
         dO5g==
X-Gm-Message-State: AOAM531ebwf79NMbJrnUttYPirMpxKeH8iLdhh17oOIrzeB8GqzqIai6
        nmynXLeYBsD0ko9by9A+l/M=
X-Google-Smtp-Source: ABdhPJwW0xIV+SxAIUlqnh145u1thzUzxQUReTdrcL9vZWI+gc6ajlJuqZ60q3zXkGj4A76V7oAETQ==
X-Received: by 2002:a50:f197:: with SMTP id x23mr8731973edl.367.1599224408121;
        Fri, 04 Sep 2020 06:00:08 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id v23sm5990766ejh.84.2020.09.04.06.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:00:07 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] iommu: Implement of_iommu_get_resv_regions()
Date:   Fri,  4 Sep 2020 14:59:58 +0200
Message-Id: <20200904130000.691933-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904130000.691933-1-thierry.reding@gmail.com>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

This is an implementation that IOMMU drivers can use to obtain reserved
memory regions from a device tree node. It uses the reserved-memory DT
bindings to find the regions associated with a given device. These
regions will be used to create 1:1 mappings in the IOMMU domain that
the devices will be attached to.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Hi Rob,

you had previously reviewed this patch, but I haven't included that here
because there's a new property now that you might not be okay with.

Thierry

Changes in v2:
- use "active" property to determine whether direct mapping are needed

 drivers/iommu/of_iommu.c | 49 ++++++++++++++++++++++++++++++++++++++++
 include/linux/of_iommu.h |  8 +++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e505b9130a1c..3341d27fbbba 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
@@ -245,3 +246,51 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 	return ops;
 }
+
+/**
+ * of_iommu_get_resv_regions - reserved region driver helper for device tree
+ * @dev: device for which to get reserved regions
+ * @list: reserved region list
+ *
+ * IOMMU drivers can use this to implement their .get_resv_regions() callback
+ * for memory regions attached to a device tree node. See the reserved-memory
+ * device tree bindings on how to use these:
+ *
+ *   Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+ */
+void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
+{
+	struct of_phandle_iterator it;
+	int err;
+
+	of_for_each_phandle(&it, err, dev->of_node, "memory-region", NULL, 0) {
+		struct iommu_resv_region *region;
+		struct resource res;
+
+		/*
+		 * Active memory regions are expected to be accessed by
+		 * hardware during boot and must therefore have an identity
+		 * mapping created prior to the driver taking control of the
+		 * hardware. This ensures that non-quiescent hardware doesn't
+		 * cause IOMMU faults during boot.
+		 */
+		if (!of_property_read_bool(it.node, "active"))
+			continue;
+
+		err = of_address_to_resource(it.node, 0, &res);
+		if (err < 0) {
+			dev_err(dev, "failed to parse memory region %pOF: %d\n",
+				it.node, err);
+			continue;
+		}
+
+		region = iommu_alloc_resv_region(res.start, resource_size(&res),
+						 IOMMU_READ | IOMMU_WRITE,
+						 IOMMU_RESV_DIRECT_RELAXABLE);
+		if (!region)
+			continue;
+
+		list_add_tail(&region->list, list);
+	}
+}
+EXPORT_SYMBOL(of_iommu_get_resv_regions);
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 16f4b3e87f20..8412437acaac 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -16,6 +16,9 @@ extern const struct iommu_ops *of_iommu_configure(struct device *dev,
 					struct device_node *master_np,
 					const u32 *id);
 
+extern void of_iommu_get_resv_regions(struct device *dev,
+				      struct list_head *list);
+
 #else
 
 static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
@@ -32,6 +35,11 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 	return NULL;
 }
 
+static inline void of_iommu_get_resv_regions(struct device *dev,
+					     struct list_head *list)
+{
+}
+
 #endif	/* CONFIG_OF_IOMMU */
 
 #endif /* __OF_IOMMU_H */
-- 
2.28.0

