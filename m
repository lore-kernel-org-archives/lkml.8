Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDA4C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68ABE217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgBNGM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:12:29 -0500
Received: from inva020.nxp.com ([92.121.34.13]:50826 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgBNGM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:12:29 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B7C781A4732;
        Fri, 14 Feb 2020 07:12:26 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 48D3E1A0226;
        Fri, 14 Feb 2020 07:12:20 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9C5214029B;
        Fri, 14 Feb 2020 14:12:12 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        kstewart@linuxfoundation.org, rfontana@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] ARM: imx: Remove unused includes on mach-imx6q.c
Date:   Fri, 14 Feb 2020 14:06:46 +0800
Message-Id: <1581660406-24463-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many includes are NOT used on mach-imx6q.c now, remove them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- linux/of.h can also be removed.
---
 arch/arm/mach-imx/mach-imx6q.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index edd26e0..284bce1 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -5,29 +5,16 @@
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
-#include <linux/of.h>
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

