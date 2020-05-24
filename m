Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB795C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 18:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A963C20787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 18:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5H9vvT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387976AbgEXSig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 14:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbgEXSif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 14:38:35 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E3FC061A0E;
        Sun, 24 May 2020 11:38:35 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a4so9311932lfh.12;
        Sun, 24 May 2020 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pYT9f0p49OrTiOELlvubWq1vIb7g6shIaYTIu0Gm+zg=;
        b=u5H9vvT5k8scDsx+POyU0shZVifa4FherTo/OapzZoNXp7Zidf7P3c5Od5c4Dd0L7Y
         bRuxN1Mn0dqnL60ncB6+6EE8cGHbaCU7mxDPTJrC5O8UuCosT0HE4RAt44nUkkHTzEb+
         iHThTWg3wd3gv/PMdzJdBL8ceQNRY2iCj6/p2+I+uxggEsD3jgP5OgU50yk3Qw+YCwlc
         vQpStpZNdyvOs0zE8QRpRaIpUUf/Y0fPgaXbyO6mrwKGKLf+cGfx0GhMLt9Eqc0ggWZA
         ZbQvFottb8EhvzKXW9E9DcTzIWIIoiaDn/ge5gjp3UXCyGYesfaCzjJmfxpEaqiUHj4X
         W/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pYT9f0p49OrTiOELlvubWq1vIb7g6shIaYTIu0Gm+zg=;
        b=R4OxF7raSN7YOz8YU+c9jIvBNXIPC4Ck6w6cqXZRS1YrGCnS/Eu7fty/M/xjh3tPBp
         AYN+ayli+YTTsGCeZwNARxIEBGbNfNuxLL4aVMDz5rD6OiX//4otvBOs6Ez7D5M6NJj/
         kUCexg4ZlT0ch1/3S8mXlNVxgf67fXxD7qtrx/lloG4cllDToyLgE3kokZlHc/wOwl+X
         hbU9awKjNXi6mNXPj56sHNX3WXVHra4OECSkQxGgf+YJJR3jToT6GzmOUzgawwngG5Ic
         5A8JHXBmvTwSalcvnlPtVQZM1YXr8XKUiUxJfyRpfRm6GMa3vqCd7cXupjh93fcBxSS0
         HjtQ==
X-Gm-Message-State: AOAM531S2edKp28NwnOdmu2G2CYu0ieBR0tNTSAkeBqphpSbVD2gAkN9
        3dqc3fVgsu3w7CQM20yam0CkUTai
X-Google-Smtp-Source: ABdhPJzUNqnOTqln023qni+m9VSVMUUYbEvwMh/SkJCeg0imawJKLvbeaV3mZRh2K0yxoCmHRIUK7w==
X-Received: by 2002:a19:be11:: with SMTP id o17mr12401587lff.187.1590345513713;
        Sun, 24 May 2020 11:38:33 -0700 (PDT)
Received: from localhost.localdomain (ppp91-76-17-204.pppoe.mtu-net.ru. [91.76.17.204])
        by smtp.gmail.com with ESMTPSA id w25sm4079428lfn.42.2020.05.24.11.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 11:38:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] iommu/tegra-smmu: Add missing locks around mapping operations
Date:   Sun, 24 May 2020 21:37:55 +0300
Message-Id: <20200524183755.3774-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mapping operations of the Tegra SMMU driver are subjected to a race
condition issues because SMMU Address Space isn't allocated and freed
atomically, while it should be. This patch makes the mapping operations
atomic, it fixes an accidentally released Host1x Address Space problem
which happens while running multiple graphics tests in parallel on
Tegra30, i.e. by having multiple threads racing with each other in the
Host1x's submission and completion code paths, performing IOVA mappings
and unmappings in parallel.

Cc: <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 43 +++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 7426b7666e2b..4f956a797838 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/dma-mapping.h>
 
 #include <soc/tegra/ahb.h>
@@ -49,6 +50,7 @@ struct tegra_smmu_as {
 	struct iommu_domain domain;
 	struct tegra_smmu *smmu;
 	unsigned int use_count;
+	spinlock_t lock;
 	u32 *count;
 	struct page **pts;
 	struct page *pd;
@@ -308,6 +310,8 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
+	spin_lock_init(&as->lock);
+
 	/* setup aperture */
 	as->domain.geometry.aperture_start = 0;
 	as->domain.geometry.aperture_end = 0xffffffff;
@@ -578,7 +582,7 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		struct page *page;
 		dma_addr_t dma;
 
-		page = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
+		page = alloc_page(GFP_ATOMIC | __GFP_DMA | __GFP_ZERO);
 		if (!page)
 			return NULL;
 
@@ -655,8 +659,9 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
 	smmu_flush(smmu);
 }
 
-static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static int
+tegra_smmu_map_locked(struct iommu_domain *domain, unsigned long iova,
+		      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
@@ -685,8 +690,9 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	return 0;
 }
 
-static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
-			       size_t size, struct iommu_iotlb_gather *gather)
+static size_t
+tegra_smmu_unmap_locked(struct iommu_domain *domain, unsigned long iova,
+			size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
@@ -702,6 +708,33 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return size;
 }
 
+static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&as->lock, flags);
+	ret = tegra_smmu_map_locked(domain, iova, paddr, size, prot, gfp);
+	spin_unlock_irqrestore(&as->lock, flags);
+
+	return ret;
+}
+
+static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+			       size_t size, struct iommu_iotlb_gather *gather)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&as->lock, flags);
+	size = tegra_smmu_unmap_locked(domain, iova, size, gather);
+	spin_unlock_irqrestore(&as->lock, flags);
+
+	return size;
+}
+
 static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
-- 
2.26.0

