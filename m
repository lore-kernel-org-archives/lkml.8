Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882DDC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0AA2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIAD5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:57:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgIAD5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:57:49 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A0B688FBE95676C350EE;
        Tue,  1 Sep 2020 11:57:47 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 11:57:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mchehab+huawei@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: spmi: hisi-spmi-controller: Use proper format in call to dev_err()
Date:   Tue, 1 Sep 2020 11:57:22 +0800
Message-ID: <20200901035722.9324-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct format string for a size_t argument should be %zu.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/hikey9xx/hisi-spmi-controller.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
index 66a0b296e06f..34c690da09e3 100644
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
@@ -121,7 +121,7 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
 
 	if (bc > SPMI_CONTROLLER_MAX_TRANS_BYTES) {
 		dev_err(&ctrl->dev,
-			"spmi_controller supports 1..%d bytes per trans, but:%ld requested\n",
+			"spmi_controller supports 1..%d bytes per trans, but:%zu requested\n",
 			SPMI_CONTROLLER_MAX_TRANS_BYTES, bc);
 		return  -EINVAL;
 	}
@@ -175,7 +175,7 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
 	spin_unlock_irqrestore(&spmi_controller->lock, flags);
 	if (rc)
 		dev_err(&ctrl->dev,
-			"spmi read wait timeout op:0x%x slave_id:%d slave_addr:0x%x bc:%ld\n",
+			"spmi read wait timeout op:0x%x slave_id:%d slave_addr:0x%x bc:%zu\n",
 			opc, slave_id, slave_addr, bc + 1);
 	else
 		dev_dbg(&ctrl->dev, "%s: id:%d slave_addr:0x%x, read value: %*ph\n",
@@ -197,7 +197,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
 
 	if (bc > SPMI_CONTROLLER_MAX_TRANS_BYTES) {
 		dev_err(&ctrl->dev,
-			"spmi_controller supports 1..%d bytes per trans, but:%ld requested\n",
+			"spmi_controller supports 1..%d bytes per trans, but:%zu requested\n",
 			SPMI_CONTROLLER_MAX_TRANS_BYTES, bc);
 		return  -EINVAL;
 	}
@@ -251,7 +251,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
 	spin_unlock_irqrestore(&spmi_controller->lock, flags);
 
 	if (rc)
-		dev_err(&ctrl->dev, "spmi write wait timeout op:0x%x slave_id:%d slave_addr:0x%x bc:%ld\n",
+		dev_err(&ctrl->dev, "spmi write wait timeout op:0x%x slave_id:%d slave_addr:0x%x bc:%zu\n",
 			opc, slave_id, slave_addr, bc);
 	else
 		dev_dbg(&ctrl->dev, "%s: id:%d slave_addr:0x%x, wrote value: %*ph\n",
-- 
2.17.1


