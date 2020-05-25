Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B192BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D4C2075F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgLthuD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390350AbgEYT4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 15:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388737AbgEYT4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 15:56:55 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E423CC061A0E;
        Mon, 25 May 2020 12:56:54 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 82so11072430lfh.2;
        Mon, 25 May 2020 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RfuCHKTNwaWG0c1gzxYwDnFHu5cJwWR/Dhzr/q0GiRw=;
        b=lgLthuD3Ld85JCIhPPZXcc8lF1lDUPUO+ueiGkF5X/sPrWlsszmqCWXWampG6miusl
         2srBFOe/fjJeFzZmwUgt11DY8EbMcLLXXrdQ1G6zKKGZ27Z2pSTMSd4fc5JRHQJOVFDf
         59dDsbf+UBIgFc7MFm6J756ZyXChxi2jkBRBu3VQ9Lee8bqOSih4bu9PbojTTjFSC/A7
         iejiNvUCmFneoMP+Iyf+QH08DCm1Rul7fHjltQQBFeqPE4lruc3ybApD/n2TX21mMc5V
         6JfHsyESU+9A3DlDrryCvFL8zZLvJrZvEB+eSMpyQNWE+fiwvlDqqdv7rQtksK3zrkaR
         hdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RfuCHKTNwaWG0c1gzxYwDnFHu5cJwWR/Dhzr/q0GiRw=;
        b=H44WCMk5qff/uNGs8VYKy6UmC+7sv4oNHM8FdpzX2hCPSUOtSJfuOiIIB4d5716veB
         CnAyDSpbGUTawicPZYiSLtIlFJ6gxHZAxJJzZsN8T2KIfqajqBQIc7aFmgfBlfXvv0C3
         eYBazea9EJeWHfs/fdnUhtDF89POt/1CyQaLLMBMY5joB1k7EHSwHYe32rIbfJ+5tCvM
         vWmRcVYccwD0I4uYO3iARwccmmIJX+7TfXOwk4KkKUevWWUfmVBxC41QG+ucKQQPh1/5
         syqgIRqqhwjJKvb74Mb4ffPXPe0pIdumRspyADB+ieRACrw3SFCrgtq2uFL76hCBm030
         bFcw==
X-Gm-Message-State: AOAM532KIkviL9fEe32h6RS6ucVQP74nKwQ2ugr160qqENL2F0el9Nxl
        vHFT9GZg73NzJzc0h/NYBMQ=
X-Google-Smtp-Source: ABdhPJx9UAHgWJ2dxnysys+OcIQSSLPgoqP+qo2oC8iiHOzMR+KSp1wVnhO5Hq7jBtEyUsruf78VQg==
X-Received: by 2002:a05:6512:3e7:: with SMTP id n7mr15253609lfq.118.1590436613238;
        Mon, 25 May 2020 12:56:53 -0700 (PDT)
Received: from localhost.localdomain (ppp91-76-17-204.pppoe.mtu-net.ru. [91.76.17.204])
        by smtp.gmail.com with ESMTPSA id u4sm2889969lfl.18.2020.05.25.12.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 12:56:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/tegra-smmu: Add missing locks around mapping operations
Date:   Mon, 25 May 2020 22:54:37 +0300
Message-Id: <20200525195437.14341-1-digetx@gmail.com>
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

Changelog:

v2: - Now using mutex instead of spinlock.

    - The _locked postfix is replaced with the underscores prefix.

 drivers/iommu/tegra-smmu.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 7426b7666e2b..9cf06acb00ce 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -49,6 +49,7 @@ struct tegra_smmu_as {
 	struct iommu_domain domain;
 	struct tegra_smmu *smmu;
 	unsigned int use_count;
+	struct mutex lock;
 	u32 *count;
 	struct page **pts;
 	struct page *pd;
@@ -308,6 +309,8 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
+	mutex_init(&as->lock);
+
 	/* setup aperture */
 	as->domain.geometry.aperture_start = 0;
 	as->domain.geometry.aperture_end = 0xffffffff;
@@ -655,8 +658,9 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
 	smmu_flush(smmu);
 }
 
-static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static int
+__tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
+		 phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
@@ -685,8 +689,9 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	return 0;
 }
 
-static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
-			       size_t size, struct iommu_iotlb_gather *gather)
+static size_t
+__tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+		   size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
@@ -702,6 +707,31 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return size;
 }
 
+static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+	int ret;
+
+	mutex_lock(&as->lock);
+	ret = __tegra_smmu_map(domain, iova, paddr, size, prot, gfp);
+	mutex_unlock(&as->lock);
+
+	return ret;
+}
+
+static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+			       size_t size, struct iommu_iotlb_gather *gather)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+
+	mutex_lock(&as->lock);
+	size = __tegra_smmu_unmap(domain, iova, size, gather);
+	mutex_unlock(&as->lock);
+
+	return size;
+}
+
 static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
-- 
2.26.0

