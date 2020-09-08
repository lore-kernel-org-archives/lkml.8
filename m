Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF61C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149542087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599593301;
	bh=eJeG5xJT/gGRtkMyOdssQU+oYgX6r/G8jIetuUHAuMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pRxr3FqsERoHdy+5j0uvZIGKMucEHI96WXzuD//Z7Dothucqe4oGe1FNfFurOvIT6
	 XTUkHk7eUtjCPGrjC1Xaf3tkpqzaCydcEfQj2H44L0wU34/KQJYHVUolknrtRGdGiP
	 jXfWRbX1T6zUTZV0nHB26NTkUJneE7f3XnALRROI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbgIHT2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731063AbgIHQAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:00:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A04A2253D;
        Tue,  8 Sep 2020 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579329;
        bh=eJeG5xJT/gGRtkMyOdssQU+oYgX6r/G8jIetuUHAuMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMmu5A9auB4vDxpu8UbNtmMmUVxw9B3bI+i+DJ7cC2bRal+YkomEahSeNqAwzwlNc
         DkJK38IcCjDwQVSJQGs2BBHRldoIOy+vls+IgXPeZbj47u3s5dhmfKzSOeb71u+1I+
         Wj8aPmnAipUSJFx9XZHCcO4IhqRDqLdBBFmzOqBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaehyun Chung <jaehyun.chung@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 032/186] drm/amd/display: Revert HDCP disable sequence change
Date:   Tue,  8 Sep 2020 17:22:54 +0200
Message-Id: <20200908152243.211893881@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



