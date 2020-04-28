Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6296AC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386092085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100237;
	bh=Nc7RsPd8Y5ByX3ptQZ5fohyeTqewNhMV0zhtHF5N9OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hkWcPoLsFVSKBfeD9NhEKMD1CWBrrolFKUHA+FJEyKXyZ+kBf6rki/bn9HjgYp11e
	 jbWrsEFU0XNu4XrkA9OqPqD3gu3pmghWBBighgZTotzMnbo7o3eVOuvXV+qb/eb2Wo
	 wmukPcQHWZnxC9uwI+It1zcJpsWXdmR5I20JIi6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgD1San (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbgD1Sah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:30:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FA1A217D8;
        Tue, 28 Apr 2020 18:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098636;
        bh=Nc7RsPd8Y5ByX3ptQZ5fohyeTqewNhMV0zhtHF5N9OI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pf/zihKXiKhU0kAcpoe0yP5TJkyBd7pTZ62CxwN8yFxZdiWb8mnYD64C5amlAm2Th
         iYlG0yEVIKNm8rlkf0HWkukMMG0hFFTsIzIUotWmGyz9V6c9OV8bWYGluhup+XUImX
         p1Pr0OO+g9y5fLJs3CAjcXjUHEEklGRvF3xkIQbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yongqiang Sun <yongqiang.sun@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 032/131] drm/amd/display: Not doing optimize bandwidth if flip pending.
Date:   Tue, 28 Apr 2020 20:24:04 +0200
Message-Id: <20200428182229.176565753@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
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
index 2b2efe443c36d..b64ad9e1f0c38 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -996,6 +996,26 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
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
@@ -1003,6 +1023,9 @@ bool dc_post_update_surfaces_to_stream(struct dc *dc)
 
 	post_surface_trace(dc);
 
+	if (is_flip_pending_in_pipes(dc, context))
+		return true;
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		if (context->res_ctx.pipe_ctx[i].stream == NULL ||
 		    context->res_ctx.pipe_ctx[i].plane_state == NULL) {
-- 
2.20.1



