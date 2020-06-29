Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D772DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E18206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466246;
	bh=xrtSI1ftxfMwU5aR7cVF6dYNr3U91GCqJPVY8cd1ylg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H52IKVfrzUnLKSqIKc8/fRcLjk/2/35ggKeifk8nYCDNR381h7IyYei/usfB6nqZK
	 m1Ngm2vcdNGMXhVSMJg56eX7sHpSwcDuWZWkdDWNLPcm6AjSNXNUIQ9ExKTcKglcYJ
	 H4FWbFX6Dmd3dsjXJENoqddNbSzobSU9ZA4HDV2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgF2Vap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbgF2SlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:21 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA6362336E;
        Mon, 29 Jun 2020 14:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593442253;
        bh=xrtSI1ftxfMwU5aR7cVF6dYNr3U91GCqJPVY8cd1ylg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O4Iw5qdfUvqJE5VPKHUW495X+vQfhfCU6Z1RprpA0rJduvsSv+Y4rAu0Dg0cBkpbR
         7OYVyt/tG7c8r0kZ/ryyxZztyTT9f7B5q3ID1pRw9SXNkKVAHFikeWztv4nUE7gKIv
         LUR6Hn5oIYvzycelZW+KNgdlL5fziBEAz5ux3FiI=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/4] phy: ti-pipe3: remove set but unused variable
Date:   Mon, 29 Jun 2020 20:20:10 +0530
Message-Id: <20200629145010.122675-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629145010.122675-1-vkoul@kernel.org>
References: <20200629145010.122675-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ti_pipe3_power_on() sets variable 'ret' but never uses it, so remove it.

drivers/phy/ti/phy-ti-pipe3.c:340:6: warning: variable ‘ret’ set but not
used [-Wunused-but-set-variable]

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/ti/phy-ti-pipe3.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index a87946589eb7..e9332c90f75f 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -337,7 +337,6 @@ static int ti_pipe3_power_on(struct phy *x)
 {
 	u32 val;
 	u32 mask;
-	int ret;
 	unsigned long rate;
 	struct ti_pipe3 *phy = phy_get_drvdata(x);
 	bool rx_pending = false;
@@ -355,8 +354,8 @@ static int ti_pipe3_power_on(struct phy *x)
 	rate = rate / 1000000;
 	mask = OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_MASK;
 	val = rate << OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_SHIFT;
-	ret = regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
-				 mask, val);
+	regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
+			   mask, val);
 	/*
 	 * For PCIe, TX and RX must be powered on simultaneously.
 	 * For USB and SATA, TX must be powered on before RX
-- 
2.26.2

