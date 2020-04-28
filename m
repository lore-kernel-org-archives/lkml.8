Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D74C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEC9206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099829;
	bh=7Ui6ieL8UndMe7wdLp5Q7fxB6CMGCFtvQzYTT7O0X9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zg5XRl7yDvIajo13yv2pzJW3VQmgh3aD7G7YCGPFqtH3OkPtYPnv3+6x2pj9amVfn
	 mTu0x+AWNOxlat1SgnWIwVdFhBrnUHCOJkohVX7nPC1lSLkTQ6nEvW7fRhZb4BNqWT
	 t+KIY5aX0TGDOR6HHt+VXkoTAmLHAnrCtt11WJqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgD1SiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbgD1SiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:38:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D03FF20730;
        Tue, 28 Apr 2020 18:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099097;
        bh=7Ui6ieL8UndMe7wdLp5Q7fxB6CMGCFtvQzYTT7O0X9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pWGkkPrWwytuKjYHexzHmTk3y/7UMWqyXt/zUeCOahqApPJPANa2fzVIDtx3CQkA+
         MRuoT2ceaMge8Np+U+AFwr8a45G3e1Mo7Cn1NwQSgoE5xLvIDg1+V/23vOPDgSBu62
         FKIUPocMU1LFZhXzlzDh3wAmpn5GDKfWmAGzFFR8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 038/168] drm/amd/display: Calculate scaling ratios on every medium/full update
Date:   Tue, 28 Apr 2020 20:23:32 +0200
Message-Id: <20200428182236.541152957@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 3bae20137cae6c03f58f96c0bc9f3d46f0bc17d4 ]

[Why]
If a plane isn't being actively enabled or disabled then DC won't
always recalculate scaling rects and ratios for the primary plane.

This results in only a partial or corrupted rect being displayed on
the screen instead of scaling to fit the screen.

[How]
Add back the logic to recalculate the scaling rects into
dc_commit_updates_for_stream since this is the expected place to
do it in DC.

This was previously removed a few years ago to fix an underscan issue
but underscan is still functional now with this change - and it should
be, since this is only updating to the latest plane state getting passed
in.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 89bd0ba3db1df..71c574d1e8be2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2154,7 +2154,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	enum surface_update_type update_type;
 	struct dc_state *context;
 	struct dc_context *dc_ctx = dc->ctx;
-	int i;
+	int i, j;
 
 	stream_status = dc_stream_get_status(stream);
 	context = dc->current_state;
@@ -2192,6 +2192,17 @@ void dc_commit_updates_for_stream(struct dc *dc,
 
 		copy_surface_update_to_plane(surface, &srf_updates[i]);
 
+		if (update_type >= UPDATE_TYPE_MED) {
+			for (j = 0; j < dc->res_pool->pipe_count; j++) {
+				struct pipe_ctx *pipe_ctx =
+					&context->res_ctx.pipe_ctx[j];
+
+				if (pipe_ctx->plane_state != surface)
+					continue;
+
+				resource_build_scaling_params(pipe_ctx);
+			}
+		}
 	}
 
 	copy_stream_update_to_stream(dc, context, stream, stream_update);
-- 
2.20.1



