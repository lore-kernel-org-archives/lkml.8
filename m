Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3D3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB3F207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590080650;
	bh=Hq8G/n1aTE0RbeAZXasbY8Sy3Jzb3ZkNEOp6LANBSIw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uCySjZVkp8WvOLs2kQqTNWqTQYRhLK5Mue1Av0np+HdZIXCsbjx0TjkJSO0sKSh+r
	 hm1Xhphyi0EwpRzQc6yTfkIAtoyzo1oEa8q0fxQlx6KENoyPdAXmG6hBLiT4suAWqx
	 mdA0coWnBrv1b7/00lWx/0WhOLkBwg1wDu0Mor00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgEUREJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730288AbgEUREH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:04:07 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 022AA207F7;
        Thu, 21 May 2020 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590080646;
        bh=Hq8G/n1aTE0RbeAZXasbY8Sy3Jzb3ZkNEOp6LANBSIw=;
        h=From:To:Cc:Subject:Date:From;
        b=0Le+xT4gTl4liBmnVzcMWErxSLdTnCCRS9fmY9icqejD6O+fG/AGexgDKZYqQWYRR
         24CHEok0mNKrN8MjnoEE9OwFCql7J9bqzmJh9ymb7bA4B0s6WldT5fSbWL72gAUr0L
         oAkEgfrxUPJuhfvTYipHS6Eg/Lch5Drx2ZfzTYyM=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        Liang Jin J <liang.j.jin@ericsson.com>
Subject: [PATCH 1/2] spi: dw: add reset control
Date:   Thu, 21 May 2020 12:03:58 -0500
Message-Id: <20200521170359.20430-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mechanism to get the reset control and deassert it in order to bring
the IP out of reset.

Signed-off-by: Liang Jin J <liang.j.jin@ericsson.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 384a3ab6dc2d..5c813e15ed89 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -20,6 +20,7 @@
 #include <linux/acpi.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 
 #include "spi-dw.h"
 
@@ -30,6 +31,7 @@ struct dw_spi_mmio {
 	struct clk     *clk;
 	struct clk     *pclk;
 	void           *priv;
+	struct reset_control	*rstc;
 };
 
 #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
@@ -145,6 +147,10 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	if (!dwsmmio)
 		return -ENOMEM;
 
+	dwsmmio->rstc = devm_reset_control_get_exclusive(&pdev->dev, "spi");
+	if (!IS_ERR(dwsmmio->rstc))
+		reset_control_deassert(dwsmmio->rstc);
+
 	dws = &dwsmmio->dws;
 
 	/* Get basic io resource and map it */
@@ -220,6 +226,9 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 	clk_disable_unprepare(dwsmmio->pclk);
 	clk_disable_unprepare(dwsmmio->clk);
 
+	if (dwsmmio->rstc)
+		reset_control_assert(dwsmmio->rstc);
+
 	return 0;
 }
 
-- 
2.17.1

