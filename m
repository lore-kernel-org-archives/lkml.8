Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6510C3F2D4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948DB2469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgB1PJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:09:03 -0500
Received: from 8bytes.org ([81.169.241.247]:56056 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgB1PId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:08:33 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 019CD4B7; Fri, 28 Feb 2020 16:08:28 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 03/14] iommu/tegra-gart: Remove direct access of dev->iommu_fwspec
Date:   Fri, 28 Feb 2020 16:08:09 +0100
Message-Id: <20200228150820.15340-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150820.15340-1-joro@8bytes.org>
References: <20200228150820.15340-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Use the accessor functions instead of directly dereferencing
dev->iommu_fwspec.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/tegra-gart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 3fb7ba72507d..db6559e8336f 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -247,7 +247,7 @@ static int gart_iommu_add_device(struct device *dev)
 {
 	struct iommu_group *group;
 
-	if (!dev->iommu_fwspec)
+	if (!dev_iommu_fwspec_get(dev))
 		return -ENODEV;
 
 	group = iommu_group_get_for_dev(dev);
-- 
2.17.1

