Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C493C3B19F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9948246E2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696908;
	bh=0WYT4szMb7DP/YdPdxU6t2Y/fi4579HGwYwbNDVFFZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zd3JnHrDBEbUjCm5tSqiKiis7uCM53bS14JJa/50+TVztoiyoavsEYLHW/yMLptcv
	 7/eQZ+ejHfRahM4hDparQd2veW8ViNmtLOS9Q+Cs6atwpUAgNHc4H3nWbQ98VXjNEQ
	 7zfhBXtRZIRXpCYcnkCILE3zXG18NtTk9AI5xCZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404088AbgBNQPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404016AbgBNQOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:14:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D93246C9;
        Fri, 14 Feb 2020 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696864;
        bh=0WYT4szMb7DP/YdPdxU6t2Y/fi4579HGwYwbNDVFFZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/IQ+rQfV+dOYvMBuWbvUnQCPngVROmbfmoPmFI796XhZx8k4zhW9k432Va1zv6+L
         GHquBqgWCmbacP/Oe30Cz1DpkUcq6Gu39IzTS/kytjPN27H5tspBRz6WKixrjIqCUa
         +mc2OAXBul8obSD6o/+lXI7phvDCoOgJe4xfOoZ4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 123/252] pinctrl: sh-pfc: r8a7778: Fix duplicate SDSELF_B and SD1_CLK_B
Date:   Fri, 14 Feb 2020 11:09:38 -0500
Message-Id: <20200214161147.15842-123-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 805f635703b2562b5ddd822c62fc9124087e5dd5 ]

The FN_SDSELF_B and FN_SD1_CLK_B enum IDs are used twice, which means
one set of users must be wrong.  Replace them by the correct enum IDs.

Fixes: 87f8c988636db0d4 ("sh-pfc: Add r8a7778 pinmux support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20191218194812.12741-2-geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index 00d61d1752496..c60fce1225b02 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -2325,7 +2325,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_ATAG0_A,	0,		FN_REMOCON_B,	0,
 		/* IP0_11_8 [4] */
 		FN_SD1_DAT2_A,	FN_MMC_D2,	0,		FN_BS,
-		FN_ATADIR0_A,	0,		FN_SDSELF_B,	0,
+		FN_ATADIR0_A,	0,		FN_SDSELF_A,	0,
 		FN_PWM4_B,	0,		0,		0,
 		0,		0,		0,		0,
 		/* IP0_7_5 [3] */
@@ -2367,7 +2367,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_TS_SDAT0_A,	0,		0,		0,
 		0,		0,		0,		0,
 		/* IP1_10_8 [3] */
-		FN_SD1_CLK_B,	FN_MMC_D6,	0,		FN_A24,
+		FN_SD1_CD_A,	FN_MMC_D6,	0,		FN_A24,
 		FN_DREQ1_A,	0,		FN_HRX0_B,	FN_TS_SPSYNC0_A,
 		/* IP1_7_5 [3] */
 		FN_A23,		FN_HTX0_B,	FN_TX2_B,	FN_DACK2_A,
-- 
2.20.1

