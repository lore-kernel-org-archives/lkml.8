Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4699EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0AC2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948202;
	bh=SigPQRGWvtPjEXyreRGfyr8fEmPoalFz2X9U0FSRtEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kbzoFJwjXbB8u4yN192bkNXwMG4018r9S0/gjwTMGpB+BxDrENEo6GdJ5CnFo4toy
	 9mXb7xMWmF1IRNHLqlzDPDlspARDW2NTR2hEXkLwrqrQVhiSUGNKIrB/wWMGjS1bze
	 EpJgxs5LTMdAQFpJQoL9F2zIwoSDru5x9Uztl7vQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbgFWUJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388311AbgFWUJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:09:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EA7B206C3;
        Tue, 23 Jun 2020 20:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942943;
        bh=SigPQRGWvtPjEXyreRGfyr8fEmPoalFz2X9U0FSRtEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pHg8tgrlYuvM384iExddmMqeMf/YDCyyxLz2LnYJZTN45/WiBqT+C66DJQk8H/uVt
         CrOOHdavzuxOVlveGP7WuBD0CWvEopqzxylQbmQWSaDrhiVj62asIwkwhLGv7c3Sx1
         rYoDQfA8xouesvVewVN4NMnDC0eanXaJMFnC9ezQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Roger Quadros <rogerq@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 196/477] phy: ti: j721e-wiz: Fix some error return code in wiz_probe()
Date:   Tue, 23 Jun 2020 21:53:13 +0200
Message-Id: <20200623195416.849454492@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit e2ae8bca494481a9f38fcd1d52943ac04e654745 ]

Fix to return negative error code from some error handling
cases instead of 0, as done elsewhere in this function.

Fixes: 091876cc355d ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Roger Quadros <rogerq@ti.com>
Link: https://lore.kernel.org/r/20200507054109.110849-1-weiyongjun1@huawei.com
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/ti/phy-j721e-wiz.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 7b51045df7836..c8e4ff341cefa 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -794,8 +794,10 @@ static int wiz_probe(struct platform_device *pdev)
 	}
 
 	base = devm_ioremap(dev, res.start, resource_size(&res));
-	if (!base)
+	if (!base) {
+		ret = -ENOMEM;
 		goto err_addr_to_resource;
+	}
 
 	regmap = devm_regmap_init_mmio(dev, base, &wiz_regmap_config);
 	if (IS_ERR(regmap)) {
@@ -812,6 +814,7 @@ static int wiz_probe(struct platform_device *pdev)
 
 	if (num_lanes > WIZ_MAX_LANES) {
 		dev_err(dev, "Cannot support %d lanes\n", num_lanes);
+		ret = -ENODEV;
 		goto err_addr_to_resource;
 	}
 
@@ -897,6 +900,7 @@ static int wiz_probe(struct platform_device *pdev)
 	serdes_pdev = of_platform_device_create(child_node, NULL, dev);
 	if (!serdes_pdev) {
 		dev_WARN(dev, "Unable to create SERDES platform device\n");
+		ret = -ENOMEM;
 		goto err_pdev_create;
 	}
 	wiz->serdes_pdev = serdes_pdev;
-- 
2.25.1



