Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A580C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9C120801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgDJGep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 02:34:45 -0400
Received: from inva021.nxp.com ([92.121.34.21]:44808 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgDJGep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:34:45 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6CB302007A2;
        Fri, 10 Apr 2020 08:34:44 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 71A572007A4;
        Fri, 10 Apr 2020 08:34:40 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 16A70402D5;
        Fri, 10 Apr 2020 14:34:34 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] arm64: imx: Select TPM driver by default
Date:   Fri, 10 Apr 2020 14:26:48 +0800
Message-Id: <1586500008-4418-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586500008-4418-1-git-send-email-Anson.Huang@nxp.com>
References: <1586500008-4418-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select CLKSRC_IMX_TPM for ARCH_MXC by default.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 55d70cf..3e9011c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -169,6 +169,7 @@ config ARCH_MXC
 	bool "ARMv8 based NXP i.MX SoC family"
 	select ARM64_ERRATUM_843419
 	select ARM64_ERRATUM_845719 if COMPAT
+	select CLKSRC_IMX_TPM
 	select IMX_GPCV2
 	select IMX_GPCV2_PM_DOMAINS
 	select PM
-- 
2.7.4

