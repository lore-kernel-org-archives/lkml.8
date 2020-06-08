Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C56C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E041D20737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664219;
	bh=56mqz//yRO8dwLkzCXAUJh+8sRp/R6L45fiWOsiVU5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q0oIK9o4WdorhcvlLtebshQiTi+90lhtecSxK1BY3Q4ZT0nZmCQF4Fo0w3PkV7vl+
	 iQAsBCuY2xwO5FxTR3+MMzuk8VkEsFySv1bIIWPc/bmrF+2X6u4y629HS2QH7nSo2g
	 aZXWW+Eg6NaVFN6ropOB9zoMmQOwZ4wu+hn65XBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbgFIA46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbgFHXI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:08:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AADB420890;
        Mon,  8 Jun 2020 23:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657737;
        bh=56mqz//yRO8dwLkzCXAUJh+8sRp/R6L45fiWOsiVU5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DYpRls70DT4exOyzW+8GaI0GVzFWbv2pKHTt5a+m25+SLHp8YsO8cPVyYD5c3s8gB
         Jh0BSj/JxBiZpizdeZlrg6zphDUI7DWpI28QbJScrGjoI3P2rrPNjLvqjb8swpnHVu
         i2vE6sLJ8XephzYekPp7lc47qIbxi/4kXbh1f/LY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sung Lee <sung.lee@amd.com>, Yongqiang Sun <yongqiang.sun@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 127/274] drm/amd/display: Do not disable pipe split if mode is not supported
Date:   Mon,  8 Jun 2020 19:03:40 -0400
Message-Id: <20200608230607.3361041-127-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sung Lee <sung.lee@amd.com>

[ Upstream commit 1dfedb39d38f813357885e19badd1971c17f79a7 ]

[WHY]
If mode is not supported, pipe split should not be disabled.
This may cause more modes to fail.

[HOW]
Check for mode support before disabling pipe split.

This commit was previously reverted as it was thought to
have problems, but those issues have been resolved.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index e4348e3b6389..2719cdecc1cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2597,19 +2597,24 @@ int dcn20_validate_apply_pipe_split_flags(
 
 	/* Avoid split loop looks for lowest voltage level that allows most unsplit pipes possible */
 	if (avoid_split) {
+		int max_mpc_comb = context->bw_ctx.dml.vba.maxMpcComb;
+
 		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 			if (!context->res_ctx.pipe_ctx[i].stream)
 				continue;
 
 			for (vlevel_split = vlevel; vlevel <= context->bw_ctx.dml.soc.num_states; vlevel++)
-				if (context->bw_ctx.dml.vba.NoOfDPP[vlevel][0][pipe_idx] == 1)
+				if (context->bw_ctx.dml.vba.NoOfDPP[vlevel][0][pipe_idx] == 1 &&
+						context->bw_ctx.dml.vba.ModeSupport[vlevel][0])
 					break;
 			/* Impossible to not split this pipe */
 			if (vlevel > context->bw_ctx.dml.soc.num_states)
 				vlevel = vlevel_split;
+			else
+				max_mpc_comb = 0;
 			pipe_idx++;
 		}
-		context->bw_ctx.dml.vba.maxMpcComb = 0;
+		context->bw_ctx.dml.vba.maxMpcComb = max_mpc_comb;
 	}
 
 	/* Split loop sets which pipe should be split based on dml outputs and dc flags */
-- 
2.25.1

