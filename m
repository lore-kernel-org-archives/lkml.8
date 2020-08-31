Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5970C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF1D21531
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888241;
	bh=eJeG5xJT/gGRtkMyOdssQU+oYgX6r/G8jIetuUHAuMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NEMRO5+8sREIwti/uVSfsHBGkbUqPq1aSwITUUF+EHCB/bgdbVmuCf/DoCPBKRItJ
	 Dw4VaVO32PWDMzfqslTkW+m56Gd4UZgSzdle/IwwV8JWu3sFGBI2kv1uRzVd7ZCpqI
	 ljIpPfaxXGSOnzgYg8r3WV9UtMkO4zC1iJaHgGlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgHaPhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbgHaPa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:30:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CCAC206F0;
        Mon, 31 Aug 2020 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887829;
        bh=eJeG5xJT/gGRtkMyOdssQU+oYgX6r/G8jIetuUHAuMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o7k1zZ9I44A2czb4neETM+s+9zWYaPaAVg+d0W0BeLScyajEGXUu8qv9jtFFntA3K
         WFNtORpDvAibxUpjEtfrpC6Us6acXz85O72IXJfdjjR8KArrX71eYmqXddJP90NCMO
         uLV+FWpjBln3nSwBy33NhfDE8Gy1Ox3sWtxsbNuk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaehyun Chung <jaehyun.chung@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.8 36/42] drm/amd/display: Revert HDCP disable sequence change
Date:   Mon, 31 Aug 2020 11:29:28 -0400
Message-Id: <20200831152934.1023912-36-sashal@kernel.org>
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

From: Jaehyun Chung <jaehyun.chung@amd.com>

[ Upstream commit b61f05622ace5b9498ae279cdfd1c9f0c1ce3f75 ]

[Why]
Revert HDCP disable sequence change that blanks stream before
disabling HDCP. PSP and HW teams are currently investigating the
root cause of why HDCP cannot be disabled before stream blank,
which is expected to work without issues.

Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 31aa31c280ee6..bdddb46727b1f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3265,10 +3265,10 @@ void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
 		core_link_set_avmute(pipe_ctx, true);
 	}
 
-	dc->hwss.blank_stream(pipe_ctx);
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 	update_psp_stream_config(pipe_ctx, true);
 #endif
+	dc->hwss.blank_stream(pipe_ctx);
 
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		deallocate_mst_payload(pipe_ctx);
-- 
2.25.1

