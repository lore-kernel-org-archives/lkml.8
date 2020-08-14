Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA23C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA5F20774
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faTDxKkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgHNQXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgHNQXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:23:09 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA4DC061384;
        Fri, 14 Aug 2020 09:23:09 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i80so5083450lfi.13;
        Fri, 14 Aug 2020 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XUom1+N8VJF984pWSuHb/mTQ8k7XQqK3c1GXB5JLrs=;
        b=faTDxKkzEvzVfjje1Z55vXJsrvhO0hFBHdcT5Ih7idzEgEh4TTk7+M3nWvv7GVMmib
         wSctTzmweNycw0D4wGGCytA/5j2IQaYcu5deIMNFcs9Asa9AT9CSE9Tr1Ylj+EMYdmfo
         y9iJ6UJUJ74yd8avbXuUWecvZj30MAdXs81cjzDeWoAZPFNVMen/JGEbPQHBVnRio8pr
         RM9GALxhjZLq8h411eAzEiQNwHwNzhuG1guE4Zj8IVWLLpeFGZQ3UD3eS/Y81JgmQyrE
         ugNLHnQMJFaFjQI64FQEuXCKHRNNLp5qMXS4l2WlpYIqXlZV8Sw4LdQUVNUWSMLckDvT
         eDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XUom1+N8VJF984pWSuHb/mTQ8k7XQqK3c1GXB5JLrs=;
        b=c6IdHfQbsLvFN4RutFOdADrf/b+PeXc9u4+xbX/tC8ooFgANGTBvDsw8gr3fDyiyox
         +hm6ObglNov0yBNimJNGlTrUkCfKmrOtDZtid51WfzquniL6JZ1sblR8rIfJ1/L8tf1b
         AFtlptlj4HN3/4JpXPynu99AnJ2i2cCI1v9D3GzfIVAjTT/IcsOdkrdfBfsezqkBtHLL
         lg9X+OdZOOt17hqr715SQp2uH4IPB9XVv8MqfXhSD0xJXsSvOwdvO2Xq/0mU11WjxPjz
         VeooGYwyWemqortBgBqFAorwA1BIeQO+v8yj6/MbjxY9GuZBjM+fDQ6Vr8wRMWddMBvp
         TiWA==
X-Gm-Message-State: AOAM533+Px4mCY5AloKJIkLqWh7RComV6wnP3+7ERitYnXZQNlwMbYB2
        1OYA2SEwD4RPgqC8D5MJv8E=
X-Google-Smtp-Source: ABdhPJxmowXg0NDxMUTsjwWOYeEN/ouIAg/BQuR2y27kS5zC+cBqFm2eDK4gW0JuFeMHGisvMYxWVg==
X-Received: by 2002:ac2:58c6:: with SMTP id u6mr1574772lfo.105.1597422187536;
        Fri, 14 Aug 2020 09:23:07 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id v14sm1846577ljk.10.2020.08.14.09.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 09:23:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3] iommu/tegra-smmu: Add missing locks around mapping operations
Date:   Fri, 14 Aug 2020 19:22:52 +0300
Message-Id: <20200814162252.31965-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
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

v3: - No changes. Resending for visibility, please apply.

v2: - Now using mutex instead of spinlock.

    - The _locked postfix is replaced with the underscores prefix.


 drivers/iommu/tegra-smmu.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 124c8848ab7e..4315b6381354 100644
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
2.27.0

