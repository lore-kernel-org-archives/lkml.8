Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8415C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF00206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425175;
	bh=g9RnykzEodxfWrp1WVCnoI0ktr7vw50NZU8MMja7NyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rI06d9GBC2nGUWuPX2wbBB204mNjZariKkmE1ggpYaOr/n/oL5hAn4+yNbKC7RThv
	 PRPscJOpECaZcAtPTbS59UpoO5mVh0Qad2NE89k1s81LGcIRV/Onrz7tsVm9PLx4Lj
	 P53R+P9XzcX3WWwRRMJi9mQAoVZLQK/9UHg0EAjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgBWCcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:32:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:52208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbgBWCXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:23:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB9C12071E;
        Sun, 23 Feb 2020 02:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424581;
        bh=g9RnykzEodxfWrp1WVCnoI0ktr7vw50NZU8MMja7NyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y87Rya1TBP8S+RjeFfC3SGQCfK39VR1RgAA1Tt21Ml30Bl442zkklGXEIv/EyTdQM
         1K63s7SzIyVrBor025ZJi5ttsHzNfMq4OWVMq4XC8y+I3a5t2qg+qJ9DSCw1XU8TxB
         6TxhnTLzYeEWHbF9o89jOluvmM6XJ0kmm+fC3xQw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sung Lee <sung.lee@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 21/50] drm/amd/display: Do not set optimized_require to false after plane disable
Date:   Sat, 22 Feb 2020 21:22:06 -0500
Message-Id: <20200223022235.1404-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022235.1404-1-sashal@kernel.org>
References: <20200223022235.1404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sung Lee <sung.lee@amd.com>

[ Upstream commit df36f6cf23ada812930afa8ee76681d4ad307c61 ]

[WHY]
The optimized_require flag is needed to set watermarks and clocks lower
in certain conditions. This flag is set to true and then set to false
while programming front end in dcn20.

[HOW]
Do not set the flag to false while disabling plane.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 937a8ba811603..e933f6a369f92 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -493,7 +493,6 @@ static void dcn20_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	dpp->funcs->dpp_dppclk_control(dpp, false, false);
 
 	hubp->power_gated = true;
-	dc->optimized_required = false; /* We're powering off, no need to optimize */
 
 	dc->hwss.plane_atomic_power_down(dc,
 			pipe_ctx->plane_res.dpp,
-- 
2.20.1

