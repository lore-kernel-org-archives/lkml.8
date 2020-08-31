Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB1DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5CD207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888190;
	bh=yszDG5DcO/d96MooGEwBMQISam8ZFz0o+yX6bch3/ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wRMSAvxdJk/hHl0b/9Mf9AK0YtDB8+iWRkDD11rpjxyMM4EU+Y2Ra+jYPrTn3zI97
	 1oIpLO8fbGRYR/gtCotxJMx0r0PfS7NMUKTJ3HtErWW/LCkvPts8cii5xw1eXQhUn7
	 JSjXYmqNmxAJgMeSKYF3QCVMHEa0yLoFPU4TePgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgHaPan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbgHaPa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:30:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 568D520936;
        Mon, 31 Aug 2020 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887825;
        bh=yszDG5DcO/d96MooGEwBMQISam8ZFz0o+yX6bch3/ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0GnsEDVox3DXHFSF5l0q8dLVCYbOxRzCnSzhJN2iNNiOXU8XKjHatuFrwtCZY6fD
         E/hbFtJLtheIO9uCT6PkrpqkDZbydH+a30EGY+xRhhUZT1LHOT8JXcMOAvEAPjob8o
         1p88aHtVRQBqtgGaNiNuqDYWQIspdt+RagYuOIo0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.8 34/42] drm/amd/display: Reject overlay plane configurations in multi-display scenarios
Date:   Mon, 31 Aug 2020 11:29:26 -0400
Message-Id: <20200831152934.1023912-34-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831152934.1023912-1-sashal@kernel.org>
References: <20200831152934.1023912-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 168f09cdadbd547c2b202246ef9a8183da725f13 ]

[Why]
These aren't stable on some platform configurations when driving
multiple displays, especially on higher resolution.

In particular the delay in asserting p-state and validating from
x86 outweights any power or performance benefit from the hardware
composition.

Under some configurations this will manifest itself as extreme stutter
or unresponsiveness especially when combined with cursor movement.

[How]
Disable these for now. Exposing overlays to userspace doesn't guarantee
that they'll be able to use them in any and all configurations and it's
part of the DRM contract to have userspace gracefully handle validation
failures when they occur.

Valdiation occurs as part of DC and this in particular affects RV, so
disable this in dcn10_global_validation.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 17d5cb422025e..8939541ad7afc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1213,6 +1213,7 @@ static enum dc_status dcn10_validate_global(struct dc *dc, struct dc_state *cont
 	bool video_large = false;
 	bool desktop_large = false;
 	bool dcc_disabled = false;
+	bool mpo_enabled = false;
 
 	for (i = 0; i < context->stream_count; i++) {
 		if (context->stream_status[i].plane_count == 0)
@@ -1221,6 +1222,9 @@ static enum dc_status dcn10_validate_global(struct dc *dc, struct dc_state *cont
 		if (context->stream_status[i].plane_count > 2)
 			return DC_FAIL_UNSUPPORTED_1;
 
+		if (context->stream_status[i].plane_count > 1)
+			mpo_enabled = true;
+
 		for (j = 0; j < context->stream_status[i].plane_count; j++) {
 			struct dc_plane_state *plane =
 				context->stream_status[i].plane_states[j];
@@ -1244,6 +1248,10 @@ static enum dc_status dcn10_validate_global(struct dc *dc, struct dc_state *cont
 		}
 	}
 
+	/* Disable MPO in multi-display configurations. */
+	if (context->stream_count > 1 && mpo_enabled)
+		return DC_FAIL_UNSUPPORTED_1;
+
 	/*
 	 * Workaround: On DCN10 there is UMC issue that causes underflow when
 	 * playing 4k video on 4k desktop with video downscaled and single channel
-- 
2.25.1

