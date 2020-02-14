Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638D2C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BC12187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgBNFwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 00:52:06 -0500
Received: from inva021.nxp.com ([92.121.34.21]:52750 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgBNFwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 00:52:06 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B478206040;
        Fri, 14 Feb 2020 06:52:04 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3937420126E;
        Fri, 14 Feb 2020 06:51:58 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8B00B402CF;
        Fri, 14 Feb 2020 13:51:50 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        kstewart@linuxfoundation.org, rfontana@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: imx: Remove unused includes on mach-imx6q.c
Date:   Fri, 14 Feb 2020 13:46:24 +0800
Message-Id: <1581659184-14996-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many includes are NOT used on mach-imx6q.c now, remove them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/mach-imx6q.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index edd26e0..bb2886c 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -5,29 +5,17 @@
  */
 
 #include <linux/clk.h>
-#include <linux/clkdev.h>
-#include <linux/cpu.h>
-#include <linux/delay.h>
-#include <linux/export.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/pm_opp.h>
 #include <linux/pci.h>
 #include <linux/phy.h>
-#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/micrel_phy.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/system_misc.h>
 
 #include "common.h"
 #include "cpuidle.h"
-- 
2.7.4

