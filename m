Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548DBC38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EB72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgBXXIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:08:35 -0500
Received: from inva020.nxp.com ([92.121.34.13]:44944 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgBXXIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:08:32 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F5A41B0793;
        Tue, 25 Feb 2020 00:08:31 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E80471A4BAF;
        Tue, 25 Feb 2020 00:08:30 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 71DCF40A85;
        Mon, 24 Feb 2020 16:08:30 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 06/15] arm64: defconfig: Enable NXP/FSL SPI controller drivers
Date:   Mon, 24 Feb 2020 17:08:01 -0600
Message-Id: <1582585690-463-7-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
References: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables SPI controller drivers used in various NXP/FSL SoCs.

Enabled as built-in to load RFS from SPI flash without requiring
initramfs.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7390c8f3838d..e97ef8b944b8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -398,8 +398,11 @@ CONFIG_SPI=y
 CONFIG_SPI_ARMADA_3700=y
 CONFIG_SPI_BCM2835=m
 CONFIG_SPI_BCM2835AUX=m
+CONFIG_SPI_FSL_LPSPI=y
+CONFIG_SPI_FSL_QUADSPI=y
 CONFIG_SPI_NXP_FLEXSPI=y
 CONFIG_SPI_IMX=m
+CONFIG_SPI_FSL_DSPI=y
 CONFIG_SPI_MESON_SPICC=m
 CONFIG_SPI_MESON_SPIFC=m
 CONFIG_SPI_ORION=y
-- 
2.17.1

