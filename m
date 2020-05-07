Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D1CC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DF92073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588862198;
	bh=9TQ8eH1qNM1RYSKmIofJoLlaKrOcwsV2rTGyt/yiM/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aKL8WoHLDGZXXWlp2y1Br57YsUPBw+c4fmbHC4IL4orEyroin3REghggywJw8nKra
	 IagDotFArwReL3CFUYK/DhtxO9q0ahzJRjIkzT9dsYDSDAYsoSwVn0nKYAn74Et7cJ
	 kEFoR1pSLrW89NRNOB2QeHfG5oTnKWD6d4aU1tBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgEGOgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbgEGO2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:28:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7498020A8B;
        Thu,  7 May 2020 14:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588861692;
        bh=9TQ8eH1qNM1RYSKmIofJoLlaKrOcwsV2rTGyt/yiM/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cr3HjRyLpy0blMsT1rvmnMWMt+l7COz/FkCKdipR5wQGebKJvBjUM5lhik4qlsLGC
         Oa0P1puje2A9DNdKjlx7Byv/E1xJiFn5gGlevj99qmzKTF0NkELN1RAA8KGA2TEqn+
         iOaGm8Le4kTMla/mjIkEyNuUb2YTQxSNLU3oPcTM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 36/50] drm/amd/display: Defer cursor update around VUPDATE for all ASIC
Date:   Thu,  7 May 2020 10:27:12 -0400
Message-Id: <20200507142726.25751-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142726.25751-1-sashal@kernel.org>
References: <20200507142726.25751-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit fdfd2a858590d318cfee483bd1c73e00f77533af ]

[Why]
Fixes the following scenario:

- Flip has been prepared sometime during the frame, update pending
- Cursor update happens right when VUPDATE would happen
- OPTC lock acquired, VUPDATE is blocked until next frame
- Flip is delayed potentially infinitely

With the igt@kms_cursor_legacy cursor-vs-flip-legacy test we can
observe nearly *13* frames of delay for some flips on Navi.

[How]
Apply the Raven workaround generically. When close enough to VUPDATE
block cursor updates from occurring from the dc_stream_set_cursor_*
helpers.

This could perhaps be a little smarter by checking if there were
pending updates or flips earlier in the frame on the HUBP side before
applying the delay, but this should be fine for now.

This fixes the kms_cursor_legacy test.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 6ddbb00ed37a5..8c20e9e907b2f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -239,24 +239,24 @@ static void delay_cursor_until_vupdate(struct pipe_ctx *pipe_ctx, struct dc *dc)
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	unsigned int us_per_line;
 
-	if (stream->ctx->asic_id.chip_family == FAMILY_RV &&
-			ASICREV_IS_RAVEN(stream->ctx->asic_id.hw_internal_rev)) {
+	if (!dc->hwss.get_vupdate_offset_from_vsync)
+		return;
 
-		vupdate_line = dc->hwss.get_vupdate_offset_from_vsync(pipe_ctx);
-		if (!dc_stream_get_crtc_position(dc, &stream, 1, &vpos, &nvpos))
-			return;
+	vupdate_line = dc->hwss.get_vupdate_offset_from_vsync(pipe_ctx);
+	if (!dc_stream_get_crtc_position(dc, &stream, 1, &vpos, &nvpos))
+		return;
 
-		if (vpos >= vupdate_line)
-			return;
+	if (vpos >= vupdate_line)
+		return;
 
-		us_per_line = stream->timing.h_total * 10000 / stream->timing.pix_clk_100hz;
-		lines_to_vupdate = vupdate_line - vpos;
-		us_to_vupdate = lines_to_vupdate * us_per_line;
+	us_per_line =
+		stream->timing.h_total * 10000 / stream->timing.pix_clk_100hz;
+	lines_to_vupdate = vupdate_line - vpos;
+	us_to_vupdate = lines_to_vupdate * us_per_line;
 
-		/* 70 us is a conservative estimate of cursor update time*/
-		if (us_to_vupdate < 70)
-			udelay(us_to_vupdate);
-	}
+	/* 70 us is a conservative estimate of cursor update time*/
+	if (us_to_vupdate < 70)
+		udelay(us_to_vupdate);
 #endif
 }
 
-- 
2.20.1

