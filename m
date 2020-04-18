Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3AEC3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E01AC22250
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587218984;
	bh=t+ZPscPzbyfoTQHlhnzdFV0Ms4DnznSLNomF0dIU/q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NfwjWCwWksZddmYwnij2heOeInnfwkmKy2iORSrOCmA5Z3M5oPVOCnNH/IVyUKxmT
	 y/HDhPWCXRP0RNDY/5ru+53heQnhwktUo3UpyMWqbsOJutioDKte7pwjs4tAfgehBf
	 SSk6AiwuSQz9UCV4MMw+McNvttogzGRvvRjMTzYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgDROJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgDROJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:09:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8966C22264;
        Sat, 18 Apr 2020 14:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587218977;
        bh=t+ZPscPzbyfoTQHlhnzdFV0Ms4DnznSLNomF0dIU/q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNOpOwh21cNpoqE8mlZgZwlPEpugpnJXu/TnAQFSec9ehhL+VpUdlY0b1kuj2iTyl
         /9x16LcXozkIUjKvRxxEZJ59nJw9tSG2/dOwEcra/V9l/f+6UtUHVLJkOx4lOX4O6H
         UUeFpwhc2/9y6UGnP13xUuI/g34N/vZ1XYa+1g90=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Isabel Zhang <isabel.zhang@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 22/75] drm/amd/display: Update stream adjust in dc_stream_adjust_vmin_vmax
Date:   Sat, 18 Apr 2020 10:08:17 -0400
Message-Id: <20200418140910.8280-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isabel Zhang <isabel.zhang@amd.com>

[ Upstream commit 346d8a0a3c91888a412c2735d69daa09c00f0203 ]

[Why]
After v_total_min and max are updated in vrr structure, the changes are
not reflected in stream adjust. When these values are read from stream
adjust it does not reflect the actual state of the system.

[How]
Set stream adjust values equal to vrr adjust values after vrr adjust
values are updated.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8904a85186aab..7fdbb47e8c259 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -283,6 +283,8 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	int i = 0;
 	bool ret = false;
 
+	stream->adjust = *adjust;
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
-- 
2.20.1

