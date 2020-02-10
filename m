Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9F6C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BDF20661
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgBJPIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:08:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42424 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728116AbgBJPIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:08:46 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ED30849FC6CB5CD2F0C2;
        Mon, 10 Feb 2020 23:08:42 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 10 Feb 2020
 23:08:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Bhawanpreet.Lakha@amd.com>, <Anthony.Koo@amd.com>,
        <aric.cyr@amd.com>, <Dmytro.Laktyushkin@amd.com>,
        <Eric.Yang2@amd.com>, <yongqiang.sun@amd.com>,
        <martin.leung@amd.com>, <charlene.liu@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [RFC PATCH -next] drm/amd/display: Remove set but not unused variable 'stream_status'
Date:   Mon, 10 Feb 2020 23:08:26 +0800
Message-ID: <20200210150826.35200-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:
 In function dcn10_post_unlock_program_front_end:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2623:29:
 warning: variable stream_status set but not used [-Wunused-but-set-variable]

commit bbf5f6c3f83b ("drm/amd/display: Split program front end part that occur outside lock")
involved this unused variable.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 42fcfee..b2ed0fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2610,7 +2610,7 @@ void dcn10_post_unlock_program_front_end(
 		struct dc *dc,
 		struct dc_state *context)
 {
-	int i, j;
+	int i;
 
 	DC_LOGGER_INIT(dc->ctx->logger);
 
@@ -2620,14 +2620,8 @@ void dcn10_post_unlock_program_front_end(
 		if (!pipe_ctx->top_pipe &&
 			!pipe_ctx->prev_odm_pipe &&
 			pipe_ctx->stream) {
-			struct dc_stream_status *stream_status = NULL;
 			struct timing_generator *tg = pipe_ctx->stream_res.tg;
 
-			for (j = 0; j < context->stream_count; j++) {
-				if (pipe_ctx->stream == context->streams[j])
-					stream_status = &context->stream_status[j];
-			}
-
 			if (context->stream_status[i].plane_count == 0)
 				false_optc_underflow_wa(dc, pipe_ctx->stream, tg);
 		}
-- 
2.7.4


