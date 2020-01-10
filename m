Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3129C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD852087F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgAJB3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:29:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9145 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730567AbgAJB3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 20:29:54 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 555C6DF5A7A1F72B1F34;
        Fri, 10 Jan 2020 09:29:52 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 10 Jan 2020 09:29:43 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jyri Sarha <jsarha@ti.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] phy: ti: j721e-wiz: Fix return value check in wiz_probe()
Date:   Fri, 10 Jan 2020 01:25:33 +0000
Message-ID: <20200110012533.33143-1-weiyongjun1@huawei.com>
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

In case of error, the function devm_ioremap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: b46f531313a4 ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index b86ebdd68302..b9654ec89662 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -762,7 +762,7 @@ static int wiz_probe(struct platform_device *pdev)
 	}
 
 	base = devm_ioremap(dev, res.start, resource_size(&res));
-	if (IS_ERR(base))
+	if (!base)
 		goto err_addr_to_resource;
 
 	regmap = devm_regmap_init_mmio(dev, base, &wiz_regmap_config);



