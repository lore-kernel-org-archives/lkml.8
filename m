Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE05C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA0C20663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgCXHD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:03:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbgCXHD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:03:57 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 47ECCC2AEB2ADCE16AD7;
        Tue, 24 Mar 2020 15:03:49 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 24 Mar 2020
 15:03:42 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peng.ma@nxp.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] rtc: fsl-ftm-alarm: remove set but not used variable 'np'
Date:   Tue, 24 Mar 2020 15:03:36 +0800
Message-ID: <20200324070336.59972-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/rtc/rtc-fsl-ftm-alarm.c: In function 'ftm_rtc_probe':
drivers/rtc/rtc-fsl-ftm-alarm.c:246:22: warning: unused variable 'np' [-Wunused-variable]
  struct device_node *np = pdev->dev.of_node;
                      ^~
commit cd49b579e705 ("rtc: fsl-ftm-alarm: enable acpi support")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-fsl-ftm-alarm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-fsl-ftm-alarm.c b/drivers/rtc/rtc-fsl-ftm-alarm.c
index c572044ff06e..0f4142b35f38 100644
--- a/drivers/rtc/rtc-fsl-ftm-alarm.c
+++ b/drivers/rtc/rtc-fsl-ftm-alarm.c
@@ -243,7 +243,6 @@ static const struct rtc_class_ops ftm_rtc_ops = {
 
 static int ftm_rtc_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	int irq;
 	int ret;
 	struct ftm_rtc *rtc;
-- 
2.17.1


