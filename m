Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44C7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 03:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DA820786
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 03:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgC3Drk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 23:47:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728490AbgC3Drk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 23:47:40 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C57E679C1DE8EAB66BBA;
        Mon, 30 Mar 2020 11:47:35 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 11:47:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kishon@ti.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <nkristam@nvidia.com>, <vidyas@nvidia.com>,
        <tglx@linutronix.de>, <yuehaibing@huawei.com>,
        <clabbe@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH -next] phy: tegra: Add missing USB_SUPPORT dependency
Date:   Mon, 30 Mar 2020 11:46:46 +0800
Message-ID: <20200330034646.30572-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When USB_SUPPORT is not set, we got this warnings:

WARNING: unmet direct dependencies detected for USB_PHY
  Depends on [n]: USB_SUPPORT [=n]
  Selected by [y]:
  - PHY_TEGRA_XUSB [=y] && ARCH_TEGRA [=y]

WARNING: unmet direct dependencies detected for USB_CONN_GPIO
  Depends on [n]: USB_SUPPORT [=n] && GPIOLIB [=y]
  Selected by [y]:
  - PHY_TEGRA_XUSB [=y] && ARCH_TEGRA [=y]

Fix by adding USB_SUPPORT as a dependency.

Fixes: 23babe30fb45d ("phy: tegra: xusb: Add usb-phy support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/phy/tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
index a208aca4ba7b..bb86d09a173b 100644
--- a/drivers/phy/tegra/Kconfig
+++ b/drivers/phy/tegra/Kconfig
@@ -2,6 +2,7 @@
 config PHY_TEGRA_XUSB
 	tristate "NVIDIA Tegra XUSB pad controller driver"
 	depends on ARCH_TEGRA
+	depends on USB_SUPPORT
 	select USB_CONN_GPIO
 	select USB_PHY
 	help
-- 
2.17.1


