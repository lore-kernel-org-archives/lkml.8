Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A29C38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777FE2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgBXXJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:09:31 -0500
Received: from inva021.nxp.com ([92.121.34.21]:43456 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgBXXIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:08:31 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E79D2210038;
        Tue, 25 Feb 2020 00:08:30 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B0EB3210041;
        Tue, 25 Feb 2020 00:08:30 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 0448640A63;
        Mon, 24 Feb 2020 16:08:29 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 04/15] arm64: defconfig: Enable QorIQ DPAA2 drivers
Date:   Mon, 24 Feb 2020 17:07:59 -0600
Message-Id: <1582585690-463-5-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
References: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables drivers for NXP DPAA2 framework, related Ethernet and crypto
device which can be found on QorIQ SoCs like LS1088a, LS2088a and
LX2160a.

The framework and ethernet drivers are enabled as built-in to boot
from network without an initramfs.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 54ac7c1558d8..9eaf0993cca5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -209,6 +209,7 @@ CONFIG_FW_LOADER_USER_HELPER=y
 CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
 CONFIG_HISILICON_LPC=y
 CONFIG_SIMPLE_PM_BUS=y
+CONFIG_FSL_MC_BUS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_RAW_NAND=y
@@ -265,6 +266,7 @@ CONFIG_THUNDER_NIC_PF=y
 CONFIG_FEC=y
 CONFIG_FSL_FMAN=y
 CONFIG_FSL_DPAA_ETH=y
+CONFIG_FSL_DPAA2_ETH=y
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
@@ -758,6 +760,7 @@ CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_OWL_PM_DOMAINS=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_FSL_DPAA=y
+CONFIG_FSL_MC_DPIO=y
 CONFIG_IMX_SCU_SOC=y
 CONFIG_QCOM_AOSS_QMP=y
 CONFIG_QCOM_GENI_SE=y
@@ -885,6 +888,7 @@ CONFIG_CRYPTO_ANSI_CPRNG=y
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_DEV_SUN8I_CE=m
 CONFIG_CRYPTO_DEV_FSL_CAAM=m
+CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=m
 CONFIG_CRYPTO_DEV_QCOM_RNG=m
 CONFIG_CRYPTO_DEV_HISI_ZIP=m
 CONFIG_CMA_SIZE_MBYTES=32
-- 
2.17.1

