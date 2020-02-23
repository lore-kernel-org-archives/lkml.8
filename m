Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010E2C35669
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5E120659
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425419;
	bh=h326O0kpeMI5X0FsCoPQhAf7UBcRPRc+4W84GVod7kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wT6CPZEvvE4b3a2GWZQ7qGn6Q+bl2xk1Jlm8pPBukOvdgeQFtlCrzmP3xvYyl1ZZU
	 QZcyPJqdzbBHNpyR1bObJh0iP3DoNJ23HibHgCgaUG7yR1Kbj+JR1iYcR6wERLriSh
	 7nUI91Zq8y0j/3knLLqBO1f0iu4S1sxT/BzQiv1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgBWCg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgBWCVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:21:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ECEC20707;
        Sun, 23 Feb 2020 02:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424510;
        bh=h326O0kpeMI5X0FsCoPQhAf7UBcRPRc+4W84GVod7kA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lku9fMTzyTi73cV/Ub5k0K1Ti0RCx7GxCwOmkrVjqsqWcHAqyBiFFY7tR7npbkiFq
         1QLtg9/P4pUy4unFNmDZR4iNEvA2kDWCT/w2Pug0vFRJK1CNh2ZRda677rbdKAkpzx
         fk4t+nc9Gamtvr6oHmpA7TBIkMIOu0ACNfMFqsxA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yongqiang Sun <yongqiang.sun@amd.com>,
        Eric Yang <eric.yang2@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 25/58] drm/amd/display: Limit minimum DPPCLK to 100MHz.
Date:   Sat, 22 Feb 2020 21:20:46 -0500
Message-Id: <20200223022119.707-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022119.707-1-sashal@kernel.org>
References: <20200223022119.707-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Sun <yongqiang.sun@amd.com>

[ Upstream commit 6c81917a0485ee2a1be0dc23321ac10ecfd9578b ]

[Why]
Underflow is observed when plug in a 4K@60 monitor with
1366x768 eDP due to DPPCLK is too low.

[How]
Limit minimum DPPCLK to 100MHz.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 35c55e54eac01..619b1a18b0441 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -149,6 +149,12 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 		rn_vbios_smu_set_min_deep_sleep_dcfclk(clk_mgr, clk_mgr_base->clks.dcfclk_deep_sleep_khz);
 	}
 
+	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
+	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
+		if (new_clocks->dppclk_khz < 100000)
+			new_clocks->dppclk_khz = 100000;
+	}
+
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
 			dpp_clock_lowered = true;
-- 
2.20.1

