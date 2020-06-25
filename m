Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085B7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E228C206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405005AbgFYNJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404867AbgFYNIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:08:44 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EF3C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:08:44 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5E1104CB; Thu, 25 Jun 2020 15:08:39 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        intel-gfx@lists.freedesktop.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 08/13] iommu/mediatek: Do no use dev->archdata.iommu
Date:   Thu, 25 Jun 2020 15:08:31 +0200
Message-Id: <20200625130836.1916-9-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200625130836.1916-1-joro@8bytes.org>
References: <20200625130836.1916-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The iommu private pointer is already used in the Mediatek IOMMU v1
driver, so move the dma_iommu_mapping pointer into 'struct
mtk_iommu_data' and do not use dev->archdata.iommu anymore.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/mtk_iommu.h    |  2 ++
 drivers/iommu/mtk_iommu_v1.c | 10 ++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index ea949a324e33..1682406e98dc 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -62,6 +62,8 @@ struct mtk_iommu_data {
 	struct iommu_device		iommu;
 	const struct mtk_iommu_plat_data *plat_data;
 
+	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
+
 	struct list_head		list;
 	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
 };
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index c9d79cff4d17..82ddfe9170d4 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -269,7 +269,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	int ret;
 
 	/* Only allow the domain created internally. */
-	mtk_mapping = data->dev->archdata.iommu;
+	mtk_mapping = data->mapping;
 	if (mtk_mapping->domain != domain)
 		return 0;
 
@@ -369,7 +369,6 @@ static int mtk_iommu_create_mapping(struct device *dev,
 	struct mtk_iommu_data *data;
 	struct platform_device *m4updev;
 	struct dma_iommu_mapping *mtk_mapping;
-	struct device *m4udev;
 	int ret;
 
 	if (args->args_count != 1) {
@@ -401,8 +400,7 @@ static int mtk_iommu_create_mapping(struct device *dev,
 		return ret;
 
 	data = dev_iommu_priv_get(dev);
-	m4udev = data->dev;
-	mtk_mapping = m4udev->archdata.iommu;
+	mtk_mapping = data->mapping;
 	if (!mtk_mapping) {
 		/* MTK iommu support 4GB iova address space. */
 		mtk_mapping = arm_iommu_create_mapping(&platform_bus_type,
@@ -410,7 +408,7 @@ static int mtk_iommu_create_mapping(struct device *dev,
 		if (IS_ERR(mtk_mapping))
 			return PTR_ERR(mtk_mapping);
 
-		m4udev->archdata.iommu = mtk_mapping;
+		data->mapping = mtk_mapping;
 	}
 
 	return 0;
@@ -459,7 +457,7 @@ static void mtk_iommu_probe_finalize(struct device *dev)
 	int err;
 
 	data        = dev_iommu_priv_get(dev);
-	mtk_mapping = data->dev->archdata.iommu;
+	mtk_mapping = data->mapping;
 
 	err = arm_iommu_attach_device(dev, mtk_mapping);
 	if (err)
-- 
2.27.0

