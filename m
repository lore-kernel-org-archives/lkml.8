Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0FDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925102072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597650647;
	bh=aOqe67Ab7mCdBShD0RbNNBOyk2umSo+76aqyfRxuQmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KGM+DOBDmwGdlSnJnCt6yMyMDWTxjnABvm7eUVevuv+tVDZ3Y/NbxRDR0RmL/y2dv
	 JOSHMnqe4ACYAYEDELXFgvsHSkza4/GSfW+51APkmM8sfxWUnNQFXqf6zdvpDxJ8jY
	 vWcsjcW7E2fwx5PY8jFbgIolej1Z/Od/qU5Yw5mU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgHQHup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgHQHuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:24 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34E2622B47;
        Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=aOqe67Ab7mCdBShD0RbNNBOyk2umSo+76aqyfRxuQmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4mJqRdwW1eYxHRrsJHwyyIEkiXPXPfJbWLs/oHfCGTiz65RPcMxasL9mmI47paXO
         blBSoMSRLPdpcw28Vv3N2/bGrGE9QzGj3jBYfnUqrYbOMNMqJiyJtJa93kAsttJehc
         PT+BDQSpG70WK4HfdeMBs8fnnwMQ7nAMzybLB43o=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuM-00BfcN-C5; Mon, 17 Aug 2020 09:50:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 12/16] iommu: hisi_smmu_lpae: cleanup printk macros
Date:   Mon, 17 Aug 2020 09:50:11 +0200
Message-Id: <cdf4b4783d9ff2b55b1fa2bed66df3e7750260dd.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Whenever possible, use dev_foo() instead of pr_foo();
- Replace dbg() macro by either pr_debug() or dev_dbg();
- Fix some warnings due to different integer types.
- add debug at hisi_smmu_domain_alloc_lpae() to allow checking
  what domains were mapped.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi_smmu.h      |  9 +--
 drivers/staging/hikey9xx/hisi_smmu_lpae.c | 72 ++++++++++++-----------
 2 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi_smmu.h b/drivers/staging/hikey9xx/hisi_smmu.h
index 290f2e11c3be..8724806bc507 100644
--- a/drivers/staging/hikey9xx/hisi_smmu.h
+++ b/drivers/staging/hikey9xx/hisi_smmu.h
@@ -3,13 +3,6 @@
 #ifndef HISI_SMMU_H
 #define HISI_SMMU_H
 
-/*#define IOMMU_DEBUG*/
-#ifdef IOMMU_DEBUG
-#define dbg(format, arg...)  printk(KERN_ERR "[iommu]" format, ##arg)
-#else
-#define dbg(format, arg...)
-#endif
-
 #define SMMU_PHY_PTRS_PER_PTE (256)
 /*#define SMMU_PHY_PTRS_PER_PGD (4096)*/
 #define SMMU_PTRS_PER_PGD     (4)
@@ -163,7 +156,7 @@ static inline void smmu_set_pgd_lpae(smmu_pgd_t *pgdp, u64 pgd)
 /*fill the pmd entry, pgd value must be 64bit */
 static inline void smmu_set_pmd_lpae(smmu_pgd_t *pmdp, u64 pmd)
 {
-	dbg("smmu_set_pmd_lpae: pmd = 0x%lx\n", pmd);
+	pr_debug("smmu_set_pmd_lpae: pmd = 0x%llx\n", pmd);
 	*pmdp = pmd;
 	dsb(ishst);
 	isb();
diff --git a/drivers/staging/hikey9xx/hisi_smmu_lpae.c b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
index c8c7e8e3dde2..33aba006d6a1 100644
--- a/drivers/staging/hikey9xx/hisi_smmu_lpae.c
+++ b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
@@ -36,7 +36,7 @@ static pgtable_t smmu_pgd_to_pte_lpae(unsigned int ppte_table)
 	unsigned long page_table_addr;
 
 	if (!ppte_table) {
-		dbg("error: the pointer of pte_table is NULL\n");
+		pr_debug("error: the pointer of pte_table is NULL\n");
 		return NULL;
 	}
 	page_table_addr = (unsigned long)ppte_table;
@@ -49,14 +49,15 @@ static pgtable_t smmu_pmd_to_pte_lpae(unsigned long ppte_table)
 	struct page *table = NULL;
 
 	if (!ppte_table) {
-		dbg("error: the pointer of pte_table is NULL\n");
+		pr_debug("error: the pointer of pte_table is NULL\n");
 		return NULL;
 	}
 	table = phys_to_page(ppte_table);
 	return table;
 }
 
-static int get_domain_data_lpae(struct device_node *np,
+static int get_domain_data_lpae(struct device *dev,
+				struct device_node *np,
 				struct hisi_smmu_domain_data *data)
 {
 	unsigned long long align;
@@ -70,18 +71,18 @@ static int get_domain_data_lpae(struct device_node *np,
 
 	node = of_find_node_by_name(np, "iommu_info");
 	if (!node) {
-		dbg("find iommu_info node error\n");
+		dev_dbg(dev, "find iommu_info node error\n");
 		return -ENODEV;
 	}
 	ret = of_property_read_u32(node, "start-addr",
 				   &data->iova_start);
 	if (ret) {
-		dbg("read iova start address error\n");
+		dev_dbg(dev, "read iova start address error\n");
 		goto read_error;
 	}
 	ret = of_property_read_u32(node, "size", &data->iova_size);
 	if (ret) {
-		dbg("read iova size error\n");
+		dev_dbg(dev, "read iova size error\n");
 		goto read_error;
 	}
 	ret = of_property_read_u64(node, "iova-align", &align);
@@ -90,7 +91,7 @@ static int get_domain_data_lpae(struct device_node *np,
 	else
 		data->iova_align = SZ_256K;
 
-	pr_err("%s:start_addr 0x%x, size 0x%x align 0x%lx\n",
+	pr_err("%s: start_addr 0x%x, size 0x%x align 0x%lx\n",
 	       __func__, data->iova_start,
 		data->iova_size, data->iova_align);
 
@@ -105,8 +106,11 @@ static struct iommu_domain
 {
 	struct hisi_smmu_domain *hisi_dom;
 
-	if (iommu_domain_type != IOMMU_DOMAIN_UNMANAGED)
+	if (iommu_domain_type != IOMMU_DOMAIN_UNMANAGED) {
+		pr_debug("%s: expecting an IOMMU_DOMAIN_UNMANAGED domain\n",
+			 __func__);
 		return NULL;
+	}
 
 	hisi_dom = kzalloc(sizeof(*hisi_dom), GFP_KERNEL);
 
@@ -125,7 +129,7 @@ static void hisi_smmu_free_ptes_lpae(smmu_pgd_t pmd)
 	pgtable_t table = smmu_pgd_to_pte_lpae(pmd);
 
 	if (!table) {
-		dbg("pte table is null\n");
+		pr_debug("pte table is null\n");
 		return;
 	}
 	__free_page(table);
@@ -137,7 +141,7 @@ static void hisi_smmu_free_pmds_lpae(smmu_pgd_t pgd)
 	pgtable_t table = smmu_pmd_to_pte_lpae(pgd);
 
 	if (!table) {
-		dbg("pte table is null\n");
+		pr_debug("pte table is null\n");
 		return;
 	}
 	__free_page(table);
@@ -193,7 +197,7 @@ static int hisi_smmu_alloc_init_pte_lpae(smmu_pmd_t *ppmd,
 	table = alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_DMA);
 	spin_lock_irqsave(&hisi_smmu_dev->lock, *flags);
 	if (!table) {
-		dbg("%s: alloc page fail\n", __func__);
+		pr_debug("%s: alloc page fail\n", __func__);
 		return -ENOMEM;
 	}
 
@@ -266,7 +270,7 @@ static int hisi_smmu_alloc_init_pmd_lpae(smmu_pgd_t *ppgd,
 	table = alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_DMA);
 	spin_lock_irqsave(&hisi_smmu_dev->lock, *flags);
 	if (!table) {
-		dbg("%s: alloc page fail\n", __func__);
+		pr_debug("%s: alloc page fail\n", __func__);
 		return -ENOMEM;
 	}
 
@@ -309,7 +313,7 @@ int hisi_smmu_handle_mapping_lpae(struct iommu_domain *domain,
 	smmu_pgd_t *pgd = (smmu_pgd_t *)hisi_smmu_dev->va_pgtable_addr;
 
 	if (!pgd) {
-		dbg("pgd is null\n");
+		pr_debug("pgd is null\n");
 		return -EINVAL;
 	}
 	iova = ALIGN(iova, SMMU_PAGE_SIZE);
@@ -341,24 +345,24 @@ static int hisi_smmu_map_lpae(struct iommu_domain *domain,
 	struct hisi_smmu_domain_data *data;
 
 	if (!domain) {
-		dbg("domain is null\n");
+		pr_debug("domain is null\n");
 		return -ENODEV;
 	}
 	data = to_smmu(domain);
 	max_iova = data->iova_start + data->iova_size;
 	if (iova < data->iova_start) {
-		dbg("iova failed: iova = 0x%lx, start = 0x%8x\n",
-		    iova, data->iova_start);
+		pr_debug("iova failed: iova = 0x%lx, start = 0x%8x\n",
+			 iova, data->iova_start);
 		goto error;
 	}
 	if ((iova + size) > max_iova) {
-		dbg("iova out of domain range, iova+size=0x%lx, end=0x%lx\n",
-		    iova + size, max_iova);
+		pr_debug("iova out of domain range, iova+size=0x%lx, end=0x%lx\n",
+			 iova + size, max_iova);
 		goto error;
 	}
 	return hisi_smmu_handle_mapping_lpae(domain, iova, paddr, size, prot);
 error:
-	dbg("iova is not in this range\n");
+	pr_debug("iova is not in this range\n");
 	return -EINVAL;
 }
 
@@ -392,7 +396,7 @@ static unsigned int hisi_smmu_clear_pmd_lpae(smmu_pgd_t *pgdp,
 		next = smmu_pmd_addr_end_lpae(iova, end);
 		hisi_smmu_clear_pte_lpae(ppmd, iova, next);
 		iova = next;
-		dbg("%s: iova=0x%lx, end=0x%lx\n", __func__, iova, end);
+		pr_debug("%s: iova=0x%x, end=0x%x\n", __func__, iova, end);
 	} while (ppmd++, iova < end);
 
 	return size;
@@ -411,14 +415,14 @@ unsigned int hisi_smmu_handle_unmapping_lpae(struct iommu_domain *domain,
 	size = SMMU_PAGE_ALIGN(size);
 	pgdp = (smmu_pgd_t *)hisi_smmu_dev->va_pgtable_addr;
 	end = iova + size;
-	dbg("%s:end=0x%x\n", __func__, end);
+	pr_debug("%s: end=0x%x\n", __func__, end);
 	pgdp += smmu_pgd_index(iova);
 	spin_lock_irqsave(&hisi_smmu_dev->lock, flags);
 	do {
 		next = smmu_pgd_addr_end_lpae(iova, end);
 		unmap_size += hisi_smmu_clear_pmd_lpae(pgdp, iova, next);
 		iova = next;
-		dbg("%s: pgdp=%p, iova=0x%lx\n", __func__, pgdp, iova);
+		pr_debug("%s: pgdp=%p, iova=0x%lx\n", __func__, pgdp, iova);
 	} while (pgdp++, iova < end);
 
 	spin_unlock_irqrestore(&hisi_smmu_dev->lock, flags);
@@ -434,7 +438,7 @@ static size_t hisi_smmu_unmap_lpae(struct iommu_domain *domain,
 	struct hisi_smmu_domain_data *data;
 
 	if (!domain) {
-		dbg("domain is null\n");
+		pr_debug("domain is null\n");
 		return -ENODEV;
 	}
 	data = to_smmu(domain);
@@ -444,20 +448,20 @@ static size_t hisi_smmu_unmap_lpae(struct iommu_domain *domain,
 	if (iova < data->iova_start)
 		goto error;
 	if ((iova + size) > max_iova) {
-		dbg("iova out of domain range, iova+size=0x%lx, end=0x%lx\n",
-		    iova + size, max_iova);
+		pr_debug("iova out of domain range, iova+size=0x%lx, end=0x%lx\n",
+			 iova + size, max_iova);
 		goto error;
 	}
 	/*unmapping the range of iova*/
 	ret = hisi_smmu_handle_unmapping_lpae(domain, iova, size);
 	if (ret == size) {
-		dbg("%s:unmap size:0x%x\n", __func__, (unsigned int)size);
+		pr_debug("%s: unmap size:0x%x\n", __func__, (unsigned int)size);
 		return size;
 	} else {
 		return 0;
 	}
 error:
-	dbg("%s:the range of io address is wrong\n", __func__);
+	pr_debug("%s: the range of io address is wrong\n", __func__);
 	return -EINVAL;
 }
 
@@ -496,16 +500,15 @@ static int hisi_attach_dev_lpae(struct iommu_domain *domain, struct device *dev)
 	struct hisi_smmu_domain *hisi_dom;
 
 	iommu_info = kzalloc(sizeof(*iommu_info), GFP_KERNEL);
-	if (!iommu_info) {
-		dbg("alloc hisi_smmu_domain_data fail\n");
+	if (!iommu_info)
 		return -EINVAL;
-	}
+
 	list_add(&iommu_info->list, &hisi_smmu_dev->domain_list);
 
 	hisi_dom = container_of(domain, struct hisi_smmu_domain, domain);
 	hisi_dom->iommu_info = iommu_info;
 	dev_iommu_priv_set(dev, iommu_info);
-	ret = get_domain_data_lpae(np, iommu_info);
+	ret = get_domain_data_lpae(dev, np, iommu_info);
 	return ret;
 }
 
@@ -520,7 +523,7 @@ static void hisi_detach_dev_lpae(struct iommu_domain *domain,
 		dev_iommu_priv_set(dev, NULL);
 		kfree(data);
 	} else {
-		dbg("%s:error! data entry has been delected\n", __func__);
+		dev_dbg(dev, "error! domain priv struct is NULL\n");
 	}
 }
 
@@ -559,7 +562,7 @@ static int hisi_smmu_probe_lpae(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	dbg("enter %s\n", __func__);
+	dev_dbg(dev, "%s:\n", __func__);
 	hisi_smmu_dev = devm_kzalloc(dev,
 				     sizeof(struct hisi_smmu_device_lpae),
 				     GFP_KERNEL);
@@ -573,10 +576,11 @@ static int hisi_smmu_probe_lpae(struct platform_device *pdev)
 	INIT_LIST_HEAD(&hisi_smmu_dev->domain_list);
 	spin_lock_init(&hisi_smmu_dev->lock);
 
-	hisi_smmu_dev->smmu_pgd =  (smmu_pgd_t *)(ALIGN((unsigned long)(hisi_smmu_dev->smmu_pgd), SZ_32));
+	hisi_smmu_dev->smmu_pgd = (smmu_pgd_t *)(ALIGN((unsigned long)(hisi_smmu_dev->smmu_pgd), SZ_32));
 
 	hisi_smmu_dev->smmu_phy_pgtable_addr =
 		virt_to_phys(hisi_smmu_dev->smmu_pgd);
+
 	dev_info(&pdev->dev, "%s, smmu_phy_pgtable_addr is = 0x%llx\n",
 		 __func__, hisi_smmu_dev->smmu_phy_pgtable_addr);
 
-- 
2.26.2

