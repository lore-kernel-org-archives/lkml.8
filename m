Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EDCC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3113420801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgDJGeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 02:34:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:44782 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDJGeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:34:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A2442007B2;
        Fri, 10 Apr 2020 08:34:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 50C282007A2;
        Fri, 10 Apr 2020 08:34:39 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E884C402AE;
        Fri, 10 Apr 2020 14:34:33 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] clocksource: Add support for i.MX TPM driver with ARM64
Date:   Fri, 10 Apr 2020 14:26:47 +0800
Message-Id: <1586500008-4418-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows building and compile-testing the i.MX TPM driver for ARM64.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f2142e6..e9e7fe1 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -617,7 +617,7 @@ config CLKSRC_IMX_GPT
 
 config CLKSRC_IMX_TPM
 	bool "Clocksource using i.MX TPM" if COMPILE_TEST
-	depends on ARM && CLKDEV_LOOKUP
+	depends on (ARM || ARM64) && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	help
 	  Enable this option to use IMX Timer/PWM Module (TPM) timer as
-- 
2.7.4

