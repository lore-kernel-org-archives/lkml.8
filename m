Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF45CC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8362C20772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597650671;
	bh=fmYTNRmOukXTEcCF9oMdnQKxhH25ltseKK1ahgmXuZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0qD5ZIwWkiCcrH9Ch+PTCU1sqouNR52bGirUu6m14TQGXDIEUNypemteYQmsYwj9m
	 DWIr00gsDOqhtY/XB2/aMqt2cU5V0XpCK2/B0cPJ0dL9LKS5t1y8T5USK2RwPmD/4q
	 gYzFazgoPMlaMKkWecVFJT4nFu8+caHMQN0roHzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgHQHvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgHQHuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:22 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 280032224D;
        Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=fmYTNRmOukXTEcCF9oMdnQKxhH25ltseKK1ahgmXuZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yczP2SXEQ3j5hP+o97vBgh4a7KoBpsg/cAn38KbJElcEehR69+q6rCSvNzIv952QZ
         VeLpi3Qv+LDAtlgnnyFKLsannxxsFGSmdhWVGxF7HAAckXcXtu9rhoqul0tj/7rmNs
         pv4MEJsOc9upJD5shKL3L0glYjDFwBcpqwjGbRzs=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuM-00BfcJ-9y; Mon, 17 Aug 2020 09:50:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 10/16] iommu: hisi_smmu_lpae: convert it to probe_device
Date:   Mon, 17 Aug 2020 09:50:09 +0200
Message-Id: <4e0e8de1f472590b5ee3a45a79cd1c8948aa0479.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The add_device()/remove_device() was removed on Kernel 5.8.

Convert the driver to use probe_device/release_device.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi_smmu_lpae.c | 31 +++++------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi_smmu_lpae.c b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
index 1fe57c10e745..c8c7e8e3dde2 100644
--- a/drivers/staging/hikey9xx/hisi_smmu_lpae.c
+++ b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
@@ -529,33 +529,14 @@ static bool hisi_smmu_capable(enum iommu_cap cap)
 	return false;
 }
 
-static int hisi_smmu_add_device(struct device *dev)
+static struct iommu_device *hisi_smmu_probe_device(struct device *dev)
 {
-	struct hisi_smmu_device_lpae *iommu = hisi_smmu_dev;
-	struct iommu_group *group;
-
-	if (iommu)
-		iommu_device_link(&iommu->iommu, dev);
-	else
-		return -ENODEV;
-
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
-
-	iommu_group_put(group);
-
-	return 0;
+	return &hisi_smmu_dev->iommu;
 }
 
-static void hisi_smmu_remove_device(struct device *dev)
+static void hisi_smmu_release_device(struct device *dev)
 {
-	struct hisi_smmu_device_lpae *iommu = hisi_smmu_dev;
-
-	if (iommu)
-		iommu_device_unlink(&iommu->iommu, dev);
-
-	iommu_group_remove_device(dev);
+	/* As just one SMMU is possible, nothing to do here */
 }
 
 static struct iommu_ops hisi_smmu_ops = {
@@ -567,8 +548,8 @@ static struct iommu_ops hisi_smmu_ops = {
 	.map		= hisi_smmu_map_lpae,
 	.unmap		= hisi_smmu_unmap_lpae,
 	.iova_to_phys	= hisi_smmu_iova_to_phys_lpae,
-	.add_device	= hisi_smmu_add_device,
-	.remove_device	= hisi_smmu_remove_device,
+	.probe_device	= hisi_smmu_probe_device,
+	.release_device	= hisi_smmu_release_device,
 	.device_group	= generic_device_group,
 	.pgsize_bitmap	= SMMU_PAGE_SIZE,
 };
-- 
2.26.2

