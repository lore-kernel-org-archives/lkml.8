Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E041C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C708207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597650669;
	bh=85lPGrCLwvRTJq/O/2q3um9Agh51fUJDSP4KusDSmGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mgda5A0yF+YrEePBIiRoJchxMlNcXwXgk4tQnRpp3eEmv2jyY/ZcEsZyln+AQ3CV2
	 AGoBn0pnMAnZhYupcm++7AKGMyzrq9JoyuOLqoqyAiJ7map36+nmY+zpG9PFqCX6lU
	 yCeu9WIW7JtD1OFhxFu6JVBlOjxZMTAXkK6qFnBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgHQHvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgHQHuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:22 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27AD8221E2;
        Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=85lPGrCLwvRTJq/O/2q3um9Agh51fUJDSP4KusDSmGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wX5lDi8M/3gvXmo+bB9cz2VpwZqZ6ZqiUr/cyd6G4MzLXO+fxtBcXQxEBe/Eot4rM
         54UlfbNJcwTV/p1vGaMHNGJGixMkKLM/vSa+7KdkJkZwBShKNABit4GYTFpGFWs8RA
         kJFEXzN5a1EiIMZcL4tbSJkbVoxr1ihBySBCRjAs=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuM-00BfcG-8n; Mon, 17 Aug 2020 09:50:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 09/16] iommu: hisi_smmu_lpae: use the right code to get domain-priv data
Date:   Mon, 17 Aug 2020 09:50:08 +0200
Message-Id: <e7fc0440f55a82bee764940d2ed5e4c7821c11a4.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The downstream code needed to use a priv data within the
domain struct. Change it to work like other iommu drivers:
use dev_iommu_priv_get() and dev_iommu_priv_set() instead.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi_smmu.h      | 17 ++++++++--
 drivers/staging/hikey9xx/hisi_smmu_lpae.c | 38 +++++++++++++----------
 2 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi_smmu.h b/drivers/staging/hikey9xx/hisi_smmu.h
index b2d32ec6cb84..290f2e11c3be 100644
--- a/drivers/staging/hikey9xx/hisi_smmu.h
+++ b/drivers/staging/hikey9xx/hisi_smmu.h
@@ -94,7 +94,7 @@ struct hisi_smmu_device_lpae {
 	struct iommu_device iommu;
 };
 
-struct iommu_domain_data {
+struct hisi_smmu_domain_data {
 	unsigned int     iova_start;
 	unsigned int     iova_size;
 	phys_addr_t      phy_pgd_base;
@@ -102,13 +102,24 @@ struct iommu_domain_data {
 	struct list_head list;
 };
 
+struct hisi_smmu_domain {
+	struct iommu_domain		domain;
+	struct hisi_smmu_domain_data	*iommu_info;
+};
+
+static struct  hisi_smmu_domain_data *to_smmu(struct iommu_domain *dom)
+{
+	struct hisi_smmu_domain *hisi_dom;
+
+	hisi_dom = container_of(dom, struct hisi_smmu_domain, domain);
+	return hisi_dom->iommu_info;
+}
+
 struct hisi_map_tile_position_lpae {
 	struct scatterlist *sg;
 	unsigned long offset;
 };
 
-extern struct hisi_smmu_device_lpae *hisi_smmu_dev;
-
 static inline unsigned int smmu_pgd_none_lpae(smmu_pgd_t pgd)
 {
 	return !(pgd ? pgd : 0);
diff --git a/drivers/staging/hikey9xx/hisi_smmu_lpae.c b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
index a55b5a35b339..1fe57c10e745 100644
--- a/drivers/staging/hikey9xx/hisi_smmu_lpae.c
+++ b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
@@ -28,7 +28,7 @@
 #include <linux/bitops.h>
 #include "hisi_smmu.h"
 
-struct hisi_smmu_device_lpae *hisi_smmu_dev;
+static struct hisi_smmu_device_lpae *hisi_smmu_dev;
 
 /* transfer 64bit pte table pointer to struct page */
 static pgtable_t smmu_pgd_to_pte_lpae(unsigned int ppte_table)
@@ -57,7 +57,7 @@ static pgtable_t smmu_pmd_to_pte_lpae(unsigned long ppte_table)
 }
 
 static int get_domain_data_lpae(struct device_node *np,
-				struct iommu_domain_data *data)
+				struct hisi_smmu_domain_data *data)
 {
 	unsigned long long align;
 	struct device_node *node = NULL;
@@ -103,14 +103,16 @@ static int get_domain_data_lpae(struct device_node *np,
 static struct iommu_domain
 *hisi_smmu_domain_alloc_lpae(unsigned int iommu_domain_type)
 {
-	struct iommu_domain *domain;
+	struct hisi_smmu_domain *hisi_dom;
 
 	if (iommu_domain_type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
-	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	hisi_dom = kzalloc(sizeof(*hisi_dom), GFP_KERNEL);
 
-	return domain;
+	pr_debug("%s: domain allocated\n", __func__);
+
+	return &hisi_dom->domain;
 }
 
 static void hisi_smmu_flush_pgtable_lpae(void *addr, size_t size)
@@ -336,13 +338,13 @@ static int hisi_smmu_map_lpae(struct iommu_domain *domain,
 			      gfp_t gfp)
 {
 	unsigned long max_iova;
-	struct iommu_domain_data *data;
+	struct hisi_smmu_domain_data *data;
 
 	if (!domain) {
 		dbg("domain is null\n");
 		return -ENODEV;
 	}
-	data = domain->priv;
+	data = to_smmu(domain);
 	max_iova = data->iova_start + data->iova_size;
 	if (iova < data->iova_start) {
 		dbg("iova failed: iova = 0x%lx, start = 0x%8x\n",
@@ -429,13 +431,13 @@ static size_t hisi_smmu_unmap_lpae(struct iommu_domain *domain,
 {
 	unsigned long max_iova;
 	unsigned int ret;
-	struct iommu_domain_data *data;
+	struct hisi_smmu_domain_data *data;
 
 	if (!domain) {
 		dbg("domain is null\n");
 		return -ENODEV;
 	}
-	data = domain->priv;
+	data = to_smmu(domain);
 	/*calculate the max io virtual address */
 	max_iova = data->iova_start + data->iova_size;
 	/*check the iova */
@@ -490,28 +492,32 @@ static int hisi_attach_dev_lpae(struct iommu_domain *domain, struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	int ret = 0;
-	struct iommu_domain_data *iommu_info = NULL;
+	struct hisi_smmu_domain_data *iommu_info = NULL;
+	struct hisi_smmu_domain *hisi_dom;
 
 	iommu_info = kzalloc(sizeof(*iommu_info), GFP_KERNEL);
 	if (!iommu_info) {
-		dbg("alloc iommu_domain_data fail\n");
+		dbg("alloc hisi_smmu_domain_data fail\n");
 		return -EINVAL;
 	}
 	list_add(&iommu_info->list, &hisi_smmu_dev->domain_list);
-	domain->priv = iommu_info;
-	ret = get_domain_data_lpae(np, domain->priv);
+
+	hisi_dom = container_of(domain, struct hisi_smmu_domain, domain);
+	hisi_dom->iommu_info = iommu_info;
+	dev_iommu_priv_set(dev, iommu_info);
+	ret = get_domain_data_lpae(np, iommu_info);
 	return ret;
 }
 
 static void hisi_detach_dev_lpae(struct iommu_domain *domain,
 				 struct device *dev)
 {
-	struct iommu_domain_data *data;
+	struct hisi_smmu_domain_data *data;
 
-	data = (struct iommu_domain_data *)domain->priv;
+	data = dev_iommu_priv_get(dev);
 	if (data) {
 		list_del(&data->list);
-		domain->priv = NULL;
+		dev_iommu_priv_set(dev, NULL);
 		kfree(data);
 	} else {
 		dbg("%s:error! data entry has been delected\n", __func__);
-- 
2.26.2

