Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7629C433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8190720823
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591657609;
	bh=3oEk9mUz7kFZ8N7UDTVPNCIcRQV9ynzwPxO6yqrMMG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pa4JjMqo2paL6YHahZU+k8IgD7I5/gTj/rvdpsEH8zX84U0lb1ZcQxVJCNrcdiTw3
	 TG4l9UZzietuDuBtgMDKmY0E5VPWk6rVa3b33JIffHFUMHthwZsgcpVuMPc9mbGTDc
	 EfXtoV2hv/cIvbBJTP+QGyiohLOzpRtynKJ0A4Jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgFHXGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgFHXG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:06:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63C72207C3;
        Mon,  8 Jun 2020 23:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657589;
        bh=3oEk9mUz7kFZ8N7UDTVPNCIcRQV9ynzwPxO6yqrMMG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1G6T/3h0cD1CgsrG2CMDTkYYVJVjhUACx6N789p9wA671H2++M7S+HTvfCazI2kF
         Zovdjvb7GLvVnULP/uoaJB/w4Wu1lEaMotGRGHz4EfviOp+jUWaX4mJVJgdW997M5O
         GfsYCKdEb4X/BH6sIZIiaqmTIcBAV594Ln4ayxgU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Eric Bernstein <Eric.Bernstein@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 017/274] drm/amd/display: fix virtual signal dsc setup
Date:   Mon,  8 Jun 2020 19:01:50 -0400
Message-Id: <20200608230607.3361041-17-sashal@kernel.org>
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

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[ Upstream commit d5bef51f084fccafa984b114ff74a01a64a0e2e3 ]

This prevents dpcd access on virtual links.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 51e0ee6e7695..6590f51caefa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -400,7 +400,7 @@ static bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	bool result = false;
 
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
+	if (dc_is_virtual_signal(stream->signal) || IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		result = true;
 	else
 		result = dm_helpers_dp_write_dsc_enable(dc->ctx, stream, enable);
-- 
2.25.1

