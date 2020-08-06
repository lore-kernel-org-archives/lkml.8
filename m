Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AA7C35279
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5C0204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgHFGly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 02:41:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728142AbgHFGlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 02:41:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8918BCB647739DAC66DA;
        Thu,  6 Aug 2020 14:41:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 6 Aug 2020 14:41:37 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <vigneshr@ti.com>, <jingxiangfeng@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: ufs: ti-j721e-ufs: Fix error return in ti_j721e_ufs_probe()
Date:   Thu, 6 Aug 2020 14:44:16 +0800
Message-ID: <20200806064416.64462-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return error code IS_ERR() from the error handling case instead
of 0.

Fixes: 22617e216331 ("scsi: ufs: ti-j721e-ufs: Fix unwinding of pm_runtime changes")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/scsi/ufs/ti-j721e-ufs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ti-j721e-ufs.c b/drivers/scsi/ufs/ti-j721e-ufs.c
index 46bb905b4d6a..eafe7c08b0c8 100644
--- a/drivers/scsi/ufs/ti-j721e-ufs.c
+++ b/drivers/scsi/ufs/ti-j721e-ufs.c
@@ -38,6 +38,7 @@ static int ti_j721e_ufs_probe(struct platform_device *pdev)
 	/* Select MPHY refclk frequency */
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
+		ret = IS_ERR(clk);
 		dev_err(dev, "Cannot claim MPHY clock.\n");
 		goto clk_err;
 	}
-- 
2.17.1

