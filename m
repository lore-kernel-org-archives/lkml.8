Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86046C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC4820787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgGVKBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:01:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728856AbgGVKBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:01:18 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D0338A8C739ECFBC6438;
        Wed, 22 Jul 2020 18:01:14 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 22 Jul 2020 18:01:02 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] dmaengine: acpi: Put the CSRT table after using it
Date:   Wed, 22 Jul 2020 17:54:21 +0800
Message-ID: <1595411661-15936-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_get_table() should be coupled with acpi_put_table() if
the mapped table is not used at runtime to release the table
mapping, put the CSRT table buf after using it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/dma/acpi-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 8a05db3..dcbcb71 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -135,11 +135,13 @@ static void acpi_dma_parse_csrt(struct acpi_device *adev, struct acpi_dma *adma)
 		if (ret < 0) {
 			dev_warn(&adev->dev,
 				 "error in parsing resource group\n");
-			return;
+			break;
 		}
 
 		grp = (struct acpi_csrt_group *)((void *)grp + grp->length);
 	}
+
+	acpi_put_table((struct acpi_table_header *)csrt);
 }
 
 /**
-- 
1.7.12.4

