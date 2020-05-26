Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C73C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2694D208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520369;
	bh=mRhGw7qR37r16r1P8tKnMThQNVCj3v9b08mSdxj9QVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zPRmSSzRHYNKM5UoS8x0F6sMuuR9zCfQtaWqmp3KQye0CSkQYa27tcZjN/WeWrU1W
	 nG/gTiN7LzY3CS+fhn9hrJPFmUeG7ZOQzTbZNsUzRWOqEZY3tGvlGG5Z84wL3LTzw1
	 /pT3D2yW2FWbPTg0WtoToEvejRB8QSaK81yNk3L8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392128AbgEZTMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392120AbgEZTMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:12:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D2E20888;
        Tue, 26 May 2020 19:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520364;
        bh=mRhGw7qR37r16r1P8tKnMThQNVCj3v9b08mSdxj9QVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJsRYzAHsSAyv2RkEueQuJhihezuf0K/VUdhFwZp2G2fj71q0uOz3YmReskcMFzlf
         lurQdBf3ldjlNzjIf2AzqbLLu28D7YeNKfeFF7qXx1Fz7XQ+W3iuuMQ/v80I2B8d2M
         DFGMQTSwmJ7OQdL2TJsXXjM8JdHyglUjxFJ0m5Tc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Li <roman.li@amd.com>,
        Zhan Liu <Zhan.Liu@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 050/126] drm/amd/display: fix counter in wait_for_no_pipes_pending
Date:   Tue, 26 May 2020 20:53:07 +0200
Message-Id: <20200526183942.236469362@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Li <roman.li@amd.com>

[ Upstream commit 80797dd6f1a525d1160c463d6a9f9d29af182cbb ]

[Why]
Wait counter is not being reset for each pipe.

[How]
Move counter reset into pipe loop scope.

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 188e51600070..b3987124183a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -803,11 +803,10 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 static void wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
 {
 	int i;
-	int count = 0;
-	struct pipe_ctx *pipe;
 	PERF_TRACE();
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe = &context->res_ctx.pipe_ctx[i];
+		int count = 0;
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (!pipe->plane_state)
 			continue;
-- 
2.25.1



