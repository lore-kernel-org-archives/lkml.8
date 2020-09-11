Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC8BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48622075A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRvaasQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgIKHTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgIKHS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:18:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA44AC061756;
        Fri, 11 Sep 2020 00:18:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o20so6587179pfp.11;
        Fri, 11 Sep 2020 00:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IT/Av6WkMGnwscYg5rCYcAHZEDtZ2ZLSfy2TWZBlkOI=;
        b=XRvaasQLXfZi4L/MubCaNLsVOzGgVMgXoHQLOZDXqqE8Z7q9DzDMD312rJuB/cfLBD
         uDkfacySRZUMsBz5WjIVPt/yryNfy6aeldQpBVkEMJNozVVNlYyzXB+FTubsYkKw/3XZ
         n4ze00UNfGHelIaYnuYjcsgqb90jjmVtf48EMm24h3+V9ICn+n8MwW4GSIix4YBFnF6D
         cFLxB1dTA1AboS8W66H0l92LX6AR8NyBFtbpMae1zLfGiEGQRqSs0WFhBGeYyxZpA+7Y
         5tEzLQFlYJBrWeyv+8ICSsew8Vtg0Z3GPzpAPDx7Tebxmi/ANscB4rVUv4G6S8fGZcTA
         TrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IT/Av6WkMGnwscYg5rCYcAHZEDtZ2ZLSfy2TWZBlkOI=;
        b=BvaE6B9fMGPHLJz4JViPz2mqB3qKK4JodoBLQGOp3hJjCp9ZgdfwV5gQubVoHLzhIV
         QPX2IavB6gJS6URTcZtNqFNGklkt7EQzY9k45hP9oc69vMY/LbbGzVRkcO8eDFwHfBPR
         Sfdg33dmEFuq5OJv8Wa22WWlMNvm72UvtOS2AflMFqjNM25l0oVOH/isz/DFJmJMu8hQ
         bmO51UhtIVt1kZxka7F35PPaFFwczrG+xGLWtunolIXkbv3miJloOs8m+f80cs6ucL7Y
         3zhxUfhPUdY0aYIiSL1NKII79ULtrtlJuNRiJ5Z/Ex9jkZJ50OIqDSi4JXLE7OwX+v5Q
         JQ7w==
X-Gm-Message-State: AOAM533u3PNRdqCWvFPzn7Kv0mOi2AgESvYlBZkcYh+gEGAvDCk/SGt1
        3h/e3N6qm4MfYR9TTfsyb3E=
X-Google-Smtp-Source: ABdhPJyEI6r0AcSE7Kuaf3mASRla3Lliv+I9mZhI5bV7w6vYeD4EbDgqQzjAVldY4rOnokzlfiJzQw==
X-Received: by 2002:a17:902:7fc7:: with SMTP id t7mr709678plb.159.1599808739278;
        Fri, 11 Sep 2020 00:18:59 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 131sm1264692pfc.20.2020.09.11.00.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 00:18:58 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     joro@8bytes.org, thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-tegra@vger.kernel.org, jonathanh@nvidia.com,
        vdumpa@nvidia.com
Subject: [PATCH 1/3] iommu/tegra-smmu: Do not use PAGE_SHIFT and PAGE_MASK
Date:   Fri, 11 Sep 2020 00:16:41 -0700
Message-Id: <20200911071643.17212-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911071643.17212-1-nicoleotsuka@gmail.com>
References: <20200911071643.17212-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PAGE_SHIFT and PAGE_MASK are defined corresponding to the page size
for CPU virtual addresses, which means PAGE_SHIFT could be a number
other than 12, but tegra-smmu maintains fixed 4KB IOVA pages and has
fixed [21:12] bit range for PTE entries.

So this patch replaces all PAGE_SHIFT/PAGE_MASK references with the
macros defined with SMMU_PTE_SHIFT.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 046add7acb61..789d21c01b77 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -130,6 +130,11 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 #define SMMU_PDE_SHIFT 22
 #define SMMU_PTE_SHIFT 12
 
+#define SMMU_PAGE_MASK		(~(SMMU_SIZE_PT-1))
+#define SMMU_OFFSET_IN_PAGE(x)	((unsigned long)(x) & ~SMMU_PAGE_MASK)
+#define SMMU_PFN_PHYS(x)	((phys_addr_t)(x) << SMMU_PTE_SHIFT)
+#define SMMU_PHYS_PFN(x)	((unsigned long)((x) >> SMMU_PTE_SHIFT))
+
 #define SMMU_PD_READABLE	(1 << 31)
 #define SMMU_PD_WRITABLE	(1 << 30)
 #define SMMU_PD_NONSECURE	(1 << 29)
@@ -644,7 +649,7 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
 			       u32 *pte, dma_addr_t pte_dma, u32 val)
 {
 	struct tegra_smmu *smmu = as->smmu;
-	unsigned long offset = offset_in_page(pte);
+	unsigned long offset = SMMU_OFFSET_IN_PAGE(pte);
 
 	*pte = val;
 
@@ -726,7 +731,7 @@ __tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 		pte_attrs |= SMMU_PTE_WRITABLE;
 
 	tegra_smmu_set_pte(as, iova, pte, pte_dma,
-			   __phys_to_pfn(paddr) | pte_attrs);
+			   SMMU_PHYS_PFN(paddr) | pte_attrs);
 
 	return 0;
 }
@@ -790,7 +795,7 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 
 	pfn = *pte & as->smmu->pfn_mask;
 
-	return PFN_PHYS(pfn);
+	return SMMU_PFN_PHYS(pfn);
 }
 
 static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
@@ -1108,7 +1113,8 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	smmu->dev = dev;
 	smmu->mc = mc;
 
-	smmu->pfn_mask = BIT_MASK(mc->soc->num_address_bits - PAGE_SHIFT) - 1;
+	smmu->pfn_mask =
+		BIT_MASK(mc->soc->num_address_bits - SMMU_PTE_SHIFT) - 1;
 	dev_dbg(dev, "address bits: %u, PFN mask: %#lx\n",
 		mc->soc->num_address_bits, smmu->pfn_mask);
 	smmu->tlb_mask = (smmu->soc->num_tlb_lines << 1) - 1;
-- 
2.17.1

