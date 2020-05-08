Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BEBC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9D4208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgEHNgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:36:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726885AbgEHNgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:36:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EEA78221682FAA1CE929;
        Fri,  8 May 2020 21:36:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 21:36:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] iommu/amd: Remove set but not used variable 'iommu'
Date:   Fri, 8 May 2020 13:40:36 +0000
Message-ID: <20200508134036.116569-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/iommu/amd_iommu.c: In function 'amd_iommu_uninit_device':
drivers/iommu/amd_iommu.c:422:20: warning:
 variable 'iommu' set but not used [-Wunused-but-set-variable]

commit dce8d6964ebd ("iommu/amd: Convert to probe/release_device() call-backs")
involved this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iommu/amd_iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index fef3689ee535..2b8eb58d2bea 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -419,15 +419,12 @@ static void iommu_ignore_device(struct device *dev)
 static void amd_iommu_uninit_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu;
 	int devid;
 
 	devid = get_device_id(dev);
 	if (devid < 0)
 		return;
 
-	iommu = amd_iommu_rlookup_table[devid];
-
 	dev_data = search_dev_data(devid);
 	if (!dev_data)
 		return;



