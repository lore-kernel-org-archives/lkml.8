Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748DBC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4ED2080C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EYSCCd5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgF0E4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 00:56:01 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17432 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgF0E4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 00:56:00 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef6d1530000>; Fri, 26 Jun 2020 21:55:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 21:55:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 26 Jun 2020 21:55:59 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 27 Jun
 2020 04:55:59 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 27 Jun 2020 04:55:59 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef6d15a0002>; Fri, 26 Jun 2020 21:55:59 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>,
        <nwartikar@nvidia.com>, <swarren@nvidia.com>,
        <nicoleotsuka@gmail.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v4 19/23] arm64: defconfig: Build AHUB component drivers
Date:   Sat, 27 Jun 2020 10:23:41 +0530
Message-ID: <1593233625-14961-20-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593233747; bh=/i+ed5mPBfVaUqyUj3+1/fx3OWwW7uet1M6ECtkpFd8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=EYSCCd5Dqa7S35j9fhFuRMP2N1IyBc70BSyTYLYtSXxRrMEweJWL7Tfql73TcHnm0
         de2B/hs6cBnCHWd4MCQUiKY1oshL+7edHuVE7wpcoVnwHHLXQ2xMK0lSq+GYptSFam
         buNVXBzZhtrHnWaI0tmbcM+1+KVQlauwSYQrnRCSNFADM/KEPWbm4JNgYpV3qSYIzB
         nHlThssQcScxGVnPKZNDAS2WDw85bbTw0qYXPHaq3JI9Fbn9WxVUXwBOmzHVIsTEAz
         SN87bJYkwpsE9DSJ7ylHOrUqaf3tu9dHaQCxWHppJiZz9K5AsffrtDMuNpDTHxEm6K
         WDSJ+IfzomChA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables following configs:
 +CONFIG_TEGRA_ACONNECT=m
 +CONFIG_SND_SOC_TEGRA=m
 +CONFIG_SND_SOC_TEGRA210_AHUB=m
 +CONFIG_SND_SOC_TEGRA210_DMIC=m
 +CONFIG_SND_SOC_TEGRA210_I2S=m
 +CONFIG_SND_SOC_TEGRA186_DSPK=m
 +CONFIG_SND_SOC_TEGRA210_ADMAIF=m

This patch helps to register AHUB and its clients (I2S, DMIC, DSPK, ADMAIF)
with ASoC core. Since AHUB is child of ACONNECT, config TEGRA_ACONNECT is
enabled as well.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ae76fae..a8c0f77 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -218,6 +218,7 @@ CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
 CONFIG_HISILICON_LPC=y
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_FSL_MC_BUS=y
+CONFIG_TEGRA_ACONNECT=m
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -664,6 +665,12 @@ CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SUN4I_SPDIF=m
+CONFIG_SND_SOC_TEGRA=m
+CONFIG_SND_SOC_TEGRA210_AHUB=m
+CONFIG_SND_SOC_TEGRA210_DMIC=m
+CONFIG_SND_SOC_TEGRA210_I2S=m
+CONFIG_SND_SOC_TEGRA186_DSPK=m
+CONFIG_SND_SOC_TEGRA210_ADMAIF=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
-- 
2.7.4

