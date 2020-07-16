Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D83BC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC922071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgGPDwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:52:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726776AbgGPDwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:52:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3485F2FA021D15DE2CCB;
        Thu, 16 Jul 2020 11:52:03 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 16 Jul 2020
 11:51:59 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <nico@fluxnic.net>, <davem@davemloft.net>, <kuba@kernel.org>,
        <mst@redhat.com>, <hkallweit1@gmail.com>, <snelson@pensando.io>,
        <elfring@users.sourceforge.net>, <dmitry.torokhov@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wanghai26@huawei.com>
Subject: [PATCH] net: smc91x: Fix possible memory leak in smc_drv_probe()
Date:   Thu, 16 Jul 2020 11:50:38 +0800
Message-ID: <20200716035038.19207-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If try_toggle_control_gpio() failed in smc_drv_probe(), free_netdev(ndev)
should be called to free the ndev created earlier. Otherwise, a memleak
will occur.

Fixes: 7d2911c43815 ("net: smc91x: Fix gpios for device tree based booting")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/smsc/smc91x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 90410f9d3b1a..1c4fea9c3ec4 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -2274,7 +2274,7 @@ static int smc_drv_probe(struct platform_device *pdev)
 		ret = try_toggle_control_gpio(&pdev->dev, &lp->power_gpio,
 					      "power", 0, 0, 100);
 		if (ret)
-			return ret;
+			goto out_free_netdev;
 
 		/*
 		 * Optional reset GPIO configured? Minimum 100 ns reset needed
@@ -2283,7 +2283,7 @@ static int smc_drv_probe(struct platform_device *pdev)
 		ret = try_toggle_control_gpio(&pdev->dev, &lp->reset_gpio,
 					      "reset", 0, 0, 100);
 		if (ret)
-			return ret;
+			goto out_free_netdev;
 
 		/*
 		 * Need to wait for optional EEPROM to load, max 750 us according
-- 
2.17.1

