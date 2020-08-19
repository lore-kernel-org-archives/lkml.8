Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75273C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511622083B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597859637;
	bh=Y40zcl6Aa+tnubG5R7qR1BzVZ4xKAB+1WB0FfN3Cq0I=;
	h=From:To:Subject:Date:List-ID:From;
	b=FT7LB6+qhchZqD7Vil+vFMWAsBRrJiW5aG/iCFS2gekz1P3w173i+AIR4NqnK3I8q
	 QG/Vs3mpk11N+DhOc2JMYPcEjIj7kh1q6jZLTaYYxgNUtCs8+vunQ1i0axTNHJ+B5y
	 oMuEBdOVL9qKY9HQS3yqzAGTukOY2eUx9vL8Eg5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgHSRxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHSRxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:53:54 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA86C2067C;
        Wed, 19 Aug 2020 17:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597859634;
        bh=Y40zcl6Aa+tnubG5R7qR1BzVZ4xKAB+1WB0FfN3Cq0I=;
        h=From:To:Subject:Date:From;
        b=PEqUZu6jpSf9ZeO2OvihxUl35QmsAxLdAX4itWA+lSRluzHJjQ3diY7h40y6L3jzT
         F1a3FrFMfF9K3OwVP9inEfCrvRm3x0ZoaWGVw0NjFi6vx48zdVGalp0BDz2GwYM3WT
         aO83p+aQZTcEBc3WzjZH3Fm2qhpyX7A93W8WspzI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [RESEND PATCH 1/5] iommu: mtk: Drop of_match_ptr to fix -Wunused-const-variable
Date:   Wed, 19 Aug 2020 19:53:41 +0200
Message-Id: <20200819175345.20833-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_device_id is included unconditionally by of.h header and used
in the driver as well.  Remove of_match_ptr to fix W=1 compile test
warning with !CONFIG_OF:

    drivers/iommu/mtk_iommu.c:833:34: warning: 'mtk_iommu_of_ids' defined but not used [-Wunused-const-variable=]
      833 | static const struct of_device_id mtk_iommu_of_ids[] = {

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iommu/mtk_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 785b228d39a6..b99c2b4b48ca 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -843,7 +843,7 @@ static struct platform_driver mtk_iommu_driver = {
 	.remove	= mtk_iommu_remove,
 	.driver	= {
 		.name = "mtk-iommu",
-		.of_match_table = of_match_ptr(mtk_iommu_of_ids),
+		.of_match_table = mtk_iommu_of_ids,
 		.pm = &mtk_iommu_pm_ops,
 	}
 };
-- 
2.17.1

