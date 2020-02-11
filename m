Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5D0C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5907020848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgBKRPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:15:05 -0500
Received: from muru.com ([72.249.23.125]:54722 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbgBKRPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:15:05 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 1916E80D4;
        Tue, 11 Feb 2020 17:15:49 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: cpcap: Fix compile if MFD_CORE is not selected
Date:   Tue, 11 Feb 2020 09:15:02 -0800
Message-Id: <20200211171502.41576-1-tony@atomide.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If only cpcap mfd driver is selected we will get:

ERROR: "devm_mfd_add_devices" [drivers/mfd/motorola-cpcap.ko] undefined!

This is because Kconfig is missing select for MFD_CORE.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -893,6 +893,7 @@ config MFD_CPCAP
 	tristate "Support for Motorola CPCAP"
 	depends on SPI
 	depends on OF || COMPILE_TEST
+	select MFD_CORE
 	select REGMAP_SPI
 	select REGMAP_IRQ
 	help
-- 
2.25.0
