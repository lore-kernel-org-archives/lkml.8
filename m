Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F41FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E333F20729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595873937;
	bh=L7kgXHcekqZf2IryLiKt/traKmj/q6/VLRF9Bs5pskY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xE7cn/KTht8o+NKDoojUnSw0waIz3GvwrD+IWU2lUXH3ivy9gHrwMcnl7ZeBmcgcS
	 Zsljq2Cx/TcV8eeGLXqgbaIKLe5nL8cXGX7+F2rmnQQSQPUFyg4aGdHPu+uGHzh/+i
	 nVltdUcIaw/CXqQWefrtnlcMLlj61yZphgezZq+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgG0SS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbgG0SS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:18:56 -0400
Received: from localhost.localdomain (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5499E20714;
        Mon, 27 Jul 2020 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595873936;
        bh=L7kgXHcekqZf2IryLiKt/traKmj/q6/VLRF9Bs5pskY=;
        h=From:To:Cc:Subject:Date:From;
        b=PSnojvmSKIwM02wMMkRwKtZZN0wpzkCOWmR0oZdZKpEHkQWFX8WnS/PLeOv2Ydap9
         HHpxod0260OBbrLKE/JZGT3otmVipg4MFE2E+rck2H/21WAFeaA4pjduN91lfWYtRK
         g2lsk60sVEYW0zMk9BTkB9oy3BRyLrvUcUPHvpdU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] iommu: mtk: Drop of_match_ptr to fix -Wunused-const-variable
Date:   Mon, 27 Jul 2020 20:18:42 +0200
Message-Id: <20200727181842.8441-1-krzk@kernel.org>
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
index 59e5a62a34db..cdfd9f8be190 100644
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

