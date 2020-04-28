Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF949C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F7720575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099912;
	bh=5rg1mbDvVPgqk2qdN1TJwA1lpQ8pvGe+EL4GcEoRhmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o5L6vnT/L1lFOjMfErHgAacAMqrcz14i0Twb44pG1jgex/ZsVMsOBF/9Up+9hhRYZ
	 p1LOpZekJogG5A7QSRV4k/z0b4HJ+RsE42SSuFJwRBChchBGNbTISZ3QwajMF2fehI
	 hhy6XpTloKqnDO8EnHjVuhrddSwQtdd1WOFhVjpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgD1Sgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730387AbgD1Sgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:36:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A4152085B;
        Tue, 28 Apr 2020 18:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099000;
        bh=5rg1mbDvVPgqk2qdN1TJwA1lpQ8pvGe+EL4GcEoRhmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUF11odStdhHw88SkrjapEZ+MaR9kYCSHLPx3XE3b/yGrpMNaU7wd0ddjhHD5raoe
         ID2+cBbxRaX8Ysek4VyM1D5BT3K4ovmC9HD9ZYJ0jFgb9G0XEniNGf5u0C1td7ko8D
         Kga9PNYB7FVFQgDYGTz0mCdS9RcQktdQnOH3fcQo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yongqiang Sun <yongqiang.sun@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 044/168] drm/amd/display: Not doing optimize bandwidth if flip pending.
Date:   Tue, 28 Apr 2020 20:23:38 +0200
Message-Id: <20200428182237.448944669@linuxfoundation.org>
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

From: Yongqiang Sun <yongqiang.sun@amd.com>

[ Upstream commit 9941b8129030c9202aaf39114477a0e58c0d6ffc ]

[Why]
In some scenario like 1366x768 VSR enabled connected with a 4K monitor
and playing 4K video in clone mode, underflow will be observed due to
decrease dppclk when previouse surface scan isn't finished

[How]
In this use case, surface flip is switching between 4K and 1366x768,
1366x768 needs smaller dppclk, and when decrease the clk and previous
surface scan is for 4K and scan isn't done, underflow will happen.  Not
doing optimize bandwidth in case of flip pending.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 71c574d1e8be2..2028dc017f7a0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1182,6 +1182,26 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
 	return (result == DC_OK);
 }
 
+static bool is_flip_pending_in_pipes(struct dc *dc, struct dc_state *context)
+{
+	int i;
+	struct pipe_ctx *pipe;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->plane_state)
+			continue;
+
+		/* Must set to false to start with, due to OR in update function */
+		pipe->plane_state->status.is_flip_pending = false;
+		dc->hwss.update_pending_status(pipe);
+		if (pipe->plane_state->status.is_flip_pending)
+			return true;
+	}
+	return false;
+}
+
 bool dc_post_update_surfaces_to_stream(struct dc *dc)
 {
 	int i;
@@ -1192,6 +1212,9 @@ bool dc_post_update_surfaces_to_stream(struct dc *dc)
 
 	post_surface_trace(dc);
 
+	if (is_flip_pending_in_pipes(dc, context))
+		return true;
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		if (context->res_ctx.pipe_ctx[i].stream == NULL ||
 		    context->res_ctx.pipe_ctx[i].plane_state == NULL) {
-- 
2.20.1



