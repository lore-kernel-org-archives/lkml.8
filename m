Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905E4C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6031520409
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845909;
	bh=b7xbu10NILajY7iOF6KfhKRif8igXrRPpdUliF2ksx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NboqWtgyZOnzVBWky7vxDGnsT10k9rF/WkwvJSL1rHFlH2CHiJWrp1TkB4uIKdjaf
	 5aDyWVHNQWtpMV8HfcyQf6gBQn5WhXkvJ7it0zjiRgQeTiWQ35XCRXr0g96Xgf7Dj8
	 tSGPGchuVDTEbLjhEU/2BLif5nC9qVTx/5cP89O4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgCJNLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729636AbgCJNLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:11:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EBA624692;
        Tue, 10 Mar 2020 13:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845903;
        bh=b7xbu10NILajY7iOF6KfhKRif8igXrRPpdUliF2ksx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OW2dgSqDOGSWGEzqSYyze5Sn1qTktMmt2/LSiarT5qLJnPQTk42v5+Szpa4jqzBCo
         1Cc4LT0OTuKkJvsZuo/mM2p2uilH6s865vHM01hYBDTSAPm6QBV9yNHP7TR3NFVNgv
         2jrdpPg1M0NfRFw5WHVq2hZM3pkvncdeTpetwyFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harigovindan P <harigovi@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 16/86] drm/msm/dsi: save pll state before dsi host is powered off
Date:   Tue, 10 Mar 2020 13:44:40 +0100
Message-Id: <20200310124531.665464778@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124530.808338541@linuxfoundation.org>
References: <20200310124530.808338541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harigovindan P <harigovi@codeaurora.org>

[ Upstream commit a1028dcfd0dd97884072288d0c8ed7f30399b528 ]

Save pll state before dsi host is powered off. Without this change
some register values gets resetted.

Signed-off-by: Harigovindan P <harigovi@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 5 +++++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index bd66d2aac41f7..b01762a7778ae 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -471,6 +471,7 @@ static void dsi_mgr_bridge_post_disable(struct drm_bridge *bridge)
 	struct msm_dsi *msm_dsi1 = dsi_mgr_get_dsi(DSI_1);
 	struct mipi_dsi_host *host = msm_dsi->host;
 	struct drm_panel *panel = msm_dsi->panel;
+	struct msm_dsi_pll *src_pll;
 	bool is_dual_dsi = IS_DUAL_DSI();
 	int ret;
 
@@ -511,6 +512,10 @@ static void dsi_mgr_bridge_post_disable(struct drm_bridge *bridge)
 								id, ret);
 	}
 
+	/* Save PLL status if it is a clock source */
+	src_pll = msm_dsi_phy_get_pll(msm_dsi->phy);
+	msm_dsi_pll_save_state(src_pll);
+
 	ret = msm_dsi_host_power_off(host);
 	if (ret)
 		pr_err("%s: host %d power off failed,%d\n", __func__, id, ret);
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 9a9fa0c75a131..c630871de7c5b 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -726,10 +726,6 @@ void msm_dsi_phy_disable(struct msm_dsi_phy *phy)
 	if (!phy || !phy->cfg->ops.disable)
 		return;
 
-	/* Save PLL status if it is a clock source */
-	if (phy->usecase != MSM_DSI_PHY_SLAVE)
-		msm_dsi_pll_save_state(phy->pll);
-
 	phy->cfg->ops.disable(phy);
 
 	dsi_phy_regulator_disable(phy);
-- 
2.20.1



