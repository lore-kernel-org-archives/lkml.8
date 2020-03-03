Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783E4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45535246D9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203925;
	bh=zBcaWmOWFsefY4orvoW3vKI4XM4VDFpW+rPtM3jGBuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yy+fxvb7a9mEKdkqF6X6fswF6qgwreKMK5hUtseWRvOQo246JCRPQ7q6lljTHiIms
	 qEvPof6xmANkhWqj/6E6T2RrQyCR6+tyf1MR7f3pj85tqUnlTZLkYXDHABdgkxXtqV
	 PErSR1g3qlJ2Mz6YWs0Th+BSeXqnyLckJYEk+rw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgCCCwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:52:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgCCCuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:50:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ED742468D;
        Tue,  3 Mar 2020 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203811;
        bh=zBcaWmOWFsefY4orvoW3vKI4XM4VDFpW+rPtM3jGBuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZfhWXtVHtU5f98yCCYAjOHmQEkoCb1fmWVilzIh5VeeALbdFXuAD6gkEDHtIfOd/
         4nn+btDuVy5HSftD7zJfp75M1H0Cc8aFJh+71e1Sl1OVVvtIOotP95LIXsY8cDkUoE
         LuDOVs6yB75+kL1CCAXtznDwxdi6QbByTKdv0OXY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harigovindan P <harigovi@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 06/13] drm/msm/dsi: save pll state before dsi host is powered off
Date:   Mon,  2 Mar 2020 21:49:55 -0500
Message-Id: <20200303025002.10600-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303025002.10600-1-sashal@kernel.org>
References: <20200303025002.10600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 10d49d43c17eb..d46b9e75a8473 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -438,6 +438,7 @@ static void dsi_mgr_bridge_post_disable(struct drm_bridge *bridge)
 	struct msm_dsi *msm_dsi1 = dsi_mgr_get_dsi(DSI_1);
 	struct mipi_dsi_host *host = msm_dsi->host;
 	struct drm_panel *panel = msm_dsi->panel;
+	struct msm_dsi_pll *src_pll;
 	bool is_dual_dsi = IS_DUAL_DSI();
 	int ret;
 
@@ -471,6 +472,10 @@ static void dsi_mgr_bridge_post_disable(struct drm_bridge *bridge)
 								id, ret);
 	}
 
+	/* Save PLL status if it is a clock source */
+	src_pll = msm_dsi_phy_get_pll(msm_dsi->phy);
+	msm_dsi_pll_save_state(src_pll);
+
 	ret = msm_dsi_host_power_off(host);
 	if (ret)
 		pr_err("%s: host %d power off failed,%d\n", __func__, id, ret);
-- 
2.20.1

