Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E47FC3B19F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A16C246B9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697999;
	bh=03PPDPpty2arSgEqPEZNzWyHqTjgJZQgS8I3aSJCL2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lstPfQ71Mdk3PV3nznzp9I2QOrQJ4UvTP7NM+qP4e8cP7DkaHNHbHD6rqzrPsGjlp
	 hQgU6YUAuP4pS2qg0BhXcLm9dJOeHOClztAslsLAK0fnxlQ4LpRKEwfu2eRSdPoX3q
	 jJKGEvjKE7lITxE3MYEU5jnOKShKrJ389TVen6Yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393532AbgBNQdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:33:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406136AbgBNQZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:25:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DDB3247C6;
        Fri, 14 Feb 2020 16:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697532;
        bh=03PPDPpty2arSgEqPEZNzWyHqTjgJZQgS8I3aSJCL2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cg9Z0KGTYId0dwnMNVEnLonOXls58YsSV+2FwMDlYIuKNtzHuz7hoGC5aqTuL4TrX
         jK+ZqOe5i4SxP9YDwNJLFgumq4CfUrZ1R/hluZd6+8mWUi7keoA7FlO9uOJnbdDCmp
         vrMnMv6VfQTDy6n+sn+Yc2EDA76DEoIaY+oJbfmg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 054/100] pinctrl: sh-pfc: r8a7778: Fix duplicate SDSELF_B and SD1_CLK_B
Date:   Fri, 14 Feb 2020 11:23:38 -0500
Message-Id: <20200214162425.21071-54-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162425.21071-1-sashal@kernel.org>
References: <20200214162425.21071-1-sashal@kernel.org>
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
index bbd35dc1a0c4c..4d0ef5e9e9d84 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -2324,7 +2324,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_ATAG0_A,	0,		FN_REMOCON_B,	0,
 		/* IP0_11_8 [4] */
 		FN_SD1_DAT2_A,	FN_MMC_D2,	0,		FN_BS,
-		FN_ATADIR0_A,	0,		FN_SDSELF_B,	0,
+		FN_ATADIR0_A,	0,		FN_SDSELF_A,	0,
 		FN_PWM4_B,	0,		0,		0,
 		0,		0,		0,		0,
 		/* IP0_7_5 [3] */
@@ -2366,7 +2366,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
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

