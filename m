Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6145C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AD92082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgBXXI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:08:58 -0500
Received: from inva021.nxp.com ([92.121.34.21]:43530 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbgBXXId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:08:33 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E039A210045;
        Tue, 25 Feb 2020 00:08:32 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A9BD721004B;
        Tue, 25 Feb 2020 00:08:32 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 38A4740A85;
        Mon, 24 Feb 2020 16:08:32 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 13/15] arm64: defconfig: Enable RTC devices for QorIQ boards
Date:   Mon, 24 Feb 2020 17:08:08 -0600
Message-Id: <1582585690-463-14-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
References: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables the RTC devices used on QorIQ reference boards supported in
mainline kernel.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f0d75bbaac80..b092adecf724 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -692,11 +692,14 @@ CONFIG_LEDS_TRIGGER_PANIC=y
 CONFIG_EDAC=y
 CONFIG_EDAC_GHES=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=m
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
+CONFIG_RTC_DRV_PCF85363=m
 CONFIG_RTC_DRV_RX8581=m
 CONFIG_RTC_DRV_S5M=y
 CONFIG_RTC_DRV_DS3232=y
+CONFIG_RTC_DRV_PCF2127=m
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_CROS_EC=y
 CONFIG_RTC_DRV_S3C=y
-- 
2.17.1

