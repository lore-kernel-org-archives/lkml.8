Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE9DC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDB02051A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD1Ger (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:34:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3361 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbgD1Ger (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:34:47 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 39C9FE14DDB9C07D45B5;
        Tue, 28 Apr 2020 14:34:43 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 14:34:33 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <Peter.Chen@nxp.com>, <gregkh@linuxfoundation.org>,
        <mirq-linux@rere.qmqm.pl>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] usb: chipidea: usb2: remove unneeded semicolon
Date:   Tue, 28 Apr 2020 14:33:59 +0800
Message-ID: <20200428063359.16433-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/usb/chipidea/ci_hdrc_usb2.c:75:28-29: Unneeded semicolon

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/usb/chipidea/ci_hdrc_usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
index 93c864759135..89e1d82d739b 100644
--- a/drivers/usb/chipidea/ci_hdrc_usb2.c
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -72,7 +72,7 @@ static int ci_hdrc_usb2_probe(struct platform_device *pdev)
 
 	priv->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);;
+		return PTR_ERR(priv->clk);
 
 	ret = clk_prepare_enable(priv->clk);
 	if (ret) {
-- 
2.21.1

