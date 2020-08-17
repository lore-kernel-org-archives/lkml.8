Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2455C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7517F2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597650690;
	bh=9rVRnfdHuh2duUuMaNM8qY59mJH954NFLvyCvlD6FKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zUoYmUicwMC7gW7Fd8EZWoTijYRpTOIZ2XTna8IlOeUOVY7kRTd6vocYdwuK6+urZ
	 9VHLFesMr0HNuerLb5s5yfwkKx1VQdfGigMWlFr5GLg+z5TA33g/2xFSCzVaYt6X9j
	 o+7k94KA3n0eMiQJVXtW9eiuiE8Q3EMU8gvDEbQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgHQHv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgHQHuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:20 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2F10207FF;
        Mon, 17 Aug 2020 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=9rVRnfdHuh2duUuMaNM8qY59mJH954NFLvyCvlD6FKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYc0scDVdbDSS4WWpo3huWSIdSoBko9+r4RTaFI5bAbu6GkMGQRqKi32Xny5dJUCd
         lmVrfcS4a3hfQCtO16DdTPnuUbhzjkUO+4sVLgJ/XZt9/QWs8e8cHfcI/SmYmjqAIh
         hJ4XFsUQPH8lyIyi8rGEvJAC98kBbxS6aNLT/y+c=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuM-00Bfc0-07; Mon, 17 Aug 2020 09:50:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 04/16] iommu: hisi_smmu_lpae: rebase it to work with upstream
Date:   Mon, 17 Aug 2020 09:50:03 +0200
Message-Id: <01f0e50095605755d105d5cbc3fc0ac7850e5906.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, this driver OOPSes. It turns that this driver
needs to be updated in order to work with the current
iommu kAPI.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi_smmu.h      |  2 +
 drivers/staging/hikey9xx/hisi_smmu_lpae.c | 81 ++++++++++++++++++++---
 2 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi_smmu.h b/drivers/staging/hikey9xx/hisi_smmu.h
index 4637244dba6b..bd3ee53735bd 100644
--- a/drivers/staging/hikey9xx/hisi_smmu.h
+++ b/drivers/staging/hikey9xx/hisi_smmu.h
@@ -89,6 +89,8 @@ struct hisi_smmu_device_lpae {
 	unsigned long      va_pgtable_addr;
 	phys_addr_t        smmu_phy_pgtable_addr;
 	smmu_pgd_t         *smmu_pgd;
+
+	struct iommu_device iommu;
 };
 
 struct hisi_map_tile_position_lpae {
diff --git a/drivers/staging/hikey9xx/hisi_smmu_lpae.c b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
index b411ca97f2c2..5acde3ddbd99 100644
--- a/drivers/staging/hikey9xx/hisi_smmu_lpae.c
+++ b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
@@ -724,30 +724,73 @@ static size_t hisi_smmu_unmap_tile_lpae(struct iommu_domain *domain,
 	return hisi_smmu_unmap_lpae(domain, iova, size, NULL);
 }
 
+static bool hisi_smmu_capable(enum iommu_cap cap)
+{
+	return false;
+}
+
+static int hisi_smmu_add_device(struct device *dev)
+{
+	struct hisi_smmu_device_lpae *iommu = hisi_smmu_dev;
+	struct iommu_group *group;
+
+	if (iommu)
+		iommu_device_link(&iommu->iommu, dev);
+	else
+		return -ENODEV;
+
+	group = iommu_group_get_for_dev(dev);
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+
+	iommu_group_put(group);
+
+	return 0;
+}
+
+static void hisi_smmu_remove_device(struct device *dev)
+{
+	struct hisi_smmu_device_lpae *iommu = hisi_smmu_dev;
+
+	if (iommu)
+		iommu_device_unlink(&iommu->iommu, dev);
+
+	iommu_group_remove_device(dev);
+}
+
 static struct iommu_ops hisi_smmu_ops = {
+	.capable	= hisi_smmu_capable,
 	.domain_alloc	= hisi_smmu_domain_alloc_lpae,
 	.domain_free	= hisi_smmu_domain_free_lpae,
+	.attach_dev	= hisi_attach_dev_lpae,
+	.detach_dev	= hisi_detach_dev_lpae,
 	.map		= hisi_smmu_map_lpae,
 	.unmap		= hisi_smmu_unmap_lpae,
-	.attach_dev = hisi_attach_dev_lpae,
-	.detach_dev = hisi_detach_dev_lpae,
 	.iova_to_phys	= hisi_smmu_iova_to_phys_lpae,
+	.add_device	= hisi_smmu_add_device,
+	.remove_device	= hisi_smmu_remove_device,
+	.device_group	= generic_device_group,
 	.pgsize_bitmap	= SMMU_PAGE_SIZE,
-	.map_tile = hisi_smmu_map_tile_lpae,
-	.unmap_tile = hisi_smmu_unmap_tile_lpae,
+	.map_tile	= hisi_smmu_map_tile_lpae,
+	.unmap_tile	= hisi_smmu_unmap_tile_lpae,
 };
 
 static int hisi_smmu_probe_lpae(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	int ret;
 
 	dbg("enter %s\n", __func__);
 	hisi_smmu_dev = devm_kzalloc(dev,
 			sizeof(struct hisi_smmu_device_lpae), GFP_KERNEL);
 
-	hisi_smmu_dev->smmu_pgd = devm_kzalloc(dev, SZ_64, GFP_KERNEL | __GFP_DMA);
-	if (!hisi_smmu_dev)
+	hisi_smmu_dev->smmu_pgd = devm_kzalloc(dev, SZ_64,
+					       GFP_KERNEL | __GFP_DMA);
+	if (!hisi_smmu_dev) {
+		ret = -ENOMEM;
 		goto smmu_device_error;
+	}
+
 	hisi_smmu_dev->dev = dev;
 	INIT_LIST_HEAD(&hisi_smmu_dev->domain_list);
 	spin_lock_init(&hisi_smmu_dev->lock);
@@ -756,18 +799,39 @@ static int hisi_smmu_probe_lpae(struct platform_device *pdev)
 
 	hisi_smmu_dev->smmu_phy_pgtable_addr =
 		virt_to_phys(hisi_smmu_dev->smmu_pgd);
-	printk(KERN_ERR "%s, smmu_phy_pgtable_addr is = %llx\n", __func__, hisi_smmu_dev->smmu_phy_pgtable_addr);
+	dev_info(&pdev->dev, "%s, smmu_phy_pgtable_addr is = 0x%llx\n",
+		 __func__, hisi_smmu_dev->smmu_phy_pgtable_addr);
 
 	hisi_smmu_dev->va_pgtable_addr = (unsigned long)(hisi_smmu_dev->smmu_pgd);
+
+	ret = iommu_device_sysfs_add(&hisi_smmu_dev->iommu, NULL, NULL,
+				    "hisi-iommu");
+	if (ret)
+		goto fail_register;
+
+	iommu_device_set_ops(&hisi_smmu_dev->iommu, &hisi_smmu_ops);
+
+	ret = iommu_device_register(&hisi_smmu_dev->iommu);
+	if (ret) {
+		dev_info(&pdev->dev, "Could not register hisi-smmu\n");
+		goto fail_register;
+	}
+
 	bus_set_iommu(&platform_bus_type, &hisi_smmu_ops);
 	return 0;
 
+fail_register:
+	iommu_device_sysfs_remove(&hisi_smmu_dev->iommu);
+
 smmu_device_error:
-	return -ENOMEM;
+	return ret;
 }
 
 static int hisi_smmu_remove_lpae(struct platform_device *pdev)
 {
+	iommu_device_unregister(&hisi_smmu_dev->iommu);
+	iommu_device_sysfs_remove(&hisi_smmu_dev->iommu);
+
 	return 0;
 }
 
@@ -779,7 +843,6 @@ MODULE_DEVICE_TABLE(of, hisi_smmu_of_match_lpae);
 
 static struct platform_driver hisi_smmu_driver_lpae = {
 	.driver	= {
-		.owner		= THIS_MODULE,
 		.name		= "hisi-smmu-lpae",
 		.of_match_table	= of_match_ptr(hisi_smmu_of_match_lpae),
 	},
-- 
2.26.2

