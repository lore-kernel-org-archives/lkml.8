Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FA7C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1615E20725
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEHB6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 21:58:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbgEHB6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 21:58:50 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 060F5FEA8977781F3749;
        Fri,  8 May 2020 09:58:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 09:58:38 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <joro@8bytes.org>, <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH -next] iommu: remove set but not used variable 'data'
Date:   Fri, 8 May 2020 10:02:31 +0800
Message-ID: <20200508020231.143664-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/iommu/mtk_iommu_v1.c:467:25:
warning: variable ‘data’ set but not used [-Wunused-but-set-variable]
  struct mtk_iommu_data *data;

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/iommu/mtk_iommu_v1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 7bdd74c7cb9f..36cc1d9667a2 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -464,12 +464,11 @@ static void mtk_iommu_probe_finalize(struct device *dev)
 static void mtk_iommu_release_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct mtk_iommu_data *data;
 
 	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
 		return;
 
-	data = dev_iommu_priv_get(dev);
+	dev_iommu_priv_get(dev);
 	iommu_fwspec_free(dev);
 }
 
-- 
2.20.1

