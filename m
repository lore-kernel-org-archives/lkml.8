Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF3CC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FFB9208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="fJZJ0A0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgEGUrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGUrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:47:00 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C93C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 13:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BOPvhULF3Vi20Px15Vghj/sDxm5k9HzIyVTMiezd0g8=; b=fJZJ0A0UmxWMdezzeGRRELCqNp
        mssH61P0EAUiest7OITWPVbrCnw1BdFHg0O9E3SyVnNbnRIq/SQ3bzSP+4mex0MdhmtiSJeqV5F3P
        U1FJP/TgcpoaoqHdYsmFQEKuHJDQEH0Rcdc2bMsAPBgwTCbLDMdks/5wFtWZ8V+CDb/c=;
Received: from p200300ccff2da2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2d:a200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jWnPl-0001ss-O3; Thu, 07 May 2020 22:46:42 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1jWnPk-00089w-ML; Thu, 07 May 2020 22:46:40 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        aford173@gmail.com, oleksandr.suvorov@toradex.com,
        u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: imx_v6_v7_defconfig: extend RN5T618 PMIC family support
Date:   Thu,  7 May 2020 22:43:39 +0200
Message-Id: <20200507204339.31253-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are new drivers for functionality of that family
(RTC and ADC), so enable them, since they are used by
various i.MX6 boards.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 5a20d12d62bd..87e6400c436b 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -395,6 +395,7 @@ CONFIG_RTC_DRV_DA9063=y
 CONFIG_RTC_DRV_MC13XXX=y
 CONFIG_RTC_DRV_MXC=y
 CONFIG_RTC_DRV_MXC_V2=y
+CONFIG_RTC_DRV_RC5T619=y
 CONFIG_RTC_DRV_SNVS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_EDMA=y
@@ -408,6 +409,7 @@ CONFIG_COMMON_CLK_PWM=y
 CONFIG_IIO=y
 CONFIG_MMA8452=y
 CONFIG_IMX7D_ADC=y
+CONFIG_RN5T618_ADC=y
 CONFIG_VF610_ADC=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_MAG3110=y
-- 
2.20.1

