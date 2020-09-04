Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0F1C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD5FE2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgIDLjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbgIDLjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:39:10 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B161C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:39:09 -0700 (PDT)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de [84.154.221.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id DDBCD249;
        Fri,  4 Sep 2020 13:39:07 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] iommu/sun50i: Fix set-but-not-used variable warning
Date:   Fri,  4 Sep 2020 13:39:06 +0200
Message-Id: <20200904113906.3906-1-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Fix the following warning the the SUN50I driver:

   drivers/iommu/sun50i-iommu.c: In function 'sun50i_iommu_irq':
   drivers/iommu/sun50i-iommu.c:890:14: warning: variable 'iova' set but not used [-Wunused-but-set-variable]
     890 |  phys_addr_t iova;
         |              ^~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/sun50i-iommu.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 3b1bf2fb94f5..ea6db1341916 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -881,7 +881,6 @@ static phys_addr_t sun50i_iommu_handle_perm_irq(struct sun50i_iommu *iommu)
 static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 {
 	struct sun50i_iommu *iommu = dev_id;
-	phys_addr_t iova;
 	u32 status;
 
 	spin_lock(&iommu->iommu_lock);
@@ -893,15 +892,15 @@ static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 	}
 
 	if (status & IOMMU_INT_INVALID_L2PG)
-		iova = sun50i_iommu_handle_pt_irq(iommu,
-						  IOMMU_INT_ERR_ADDR_L2_REG,
-						  IOMMU_L2PG_INT_REG);
+		sun50i_iommu_handle_pt_irq(iommu,
+					    IOMMU_INT_ERR_ADDR_L2_REG,
+					    IOMMU_L2PG_INT_REG);
 	else if (status & IOMMU_INT_INVALID_L1PG)
-		iova = sun50i_iommu_handle_pt_irq(iommu,
-						  IOMMU_INT_ERR_ADDR_L1_REG,
-						  IOMMU_L1PG_INT_REG);
+		sun50i_iommu_handle_pt_irq(iommu,
+					   IOMMU_INT_ERR_ADDR_L1_REG,
+					   IOMMU_L1PG_INT_REG);
 	else
-		iova = sun50i_iommu_handle_perm_irq(iommu);
+		sun50i_iommu_handle_perm_irq(iommu);
 
 	iommu_write(iommu, IOMMU_INT_CLR_REG, status);
 
-- 
2.26.2

