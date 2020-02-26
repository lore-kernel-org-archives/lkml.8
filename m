Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC48C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8929B2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgBZEWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:22:54 -0500
Received: from inva021.nxp.com ([92.121.34.21]:33014 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgBZEWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:22:54 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B3F1216284;
        Wed, 26 Feb 2020 05:22:52 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 34CF2216279;
        Wed, 26 Feb 2020 05:22:45 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8380F40246;
        Wed, 26 Feb 2020 12:22:36 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, allison@lohutok.net,
        tglx@linutronix.de, andrew.smirnov@gmail.com,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        info@metux.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: imx: Remove unnecessary blank lines
Date:   Wed, 26 Feb 2020 12:16:57 +0800
Message-Id: <1582690617-27989-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank lines for cleanup.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/anatop.c      | 1 -
 arch/arm/mach-imx/gpc.c         | 1 -
 arch/arm/mach-imx/mach-imx6ul.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index ea4a596..d841bed 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -89,7 +89,6 @@ void imx_anatop_post_resume(void)
 
 	if (cpu_is_imx6sl())
 		imx_anatop_disconnect_high_snvs(false);
-
 }
 
 void __init imx_init_revision_from_anatop(void)
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index fb3cba8..ebc4339 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -111,7 +111,6 @@ void imx_gpc_mask_all(void)
 		gpc_saved_imrs[i] = readl_relaxed(reg_imr1 + i * 4);
 		writel_relaxed(~0, reg_imr1 + i * 4);
 	}
-
 }
 
 void imx_gpc_restore_all(void)
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 311f5e4..3b0e16c 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -25,7 +25,6 @@ static void __init imx6ul_enet_clk_init(void)
 				   IMX6UL_GPR1_ENET_CLK_OUTPUT);
 	else
 		pr_err("failed to find fsl,imx6ul-iomux-gpr regmap\n");
-
 }
 
 static int ksz8081_phy_fixup(struct phy_device *dev)
-- 
2.7.4

