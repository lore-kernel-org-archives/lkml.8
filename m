Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CD4C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93020214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257659;
	bh=g7lm6YgSyj6c2NL8Mpa/jUwJdQ2wfy+ZGEYhea2EoUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JPf+tcdISXzewCBy2KHR9W5fty4LFwG2FkiisDQLIRoZcQdyyvnnZJ71YggMJXtUE
	 kGKH5zvvu8Dy+pTevfygePYjm1fJqku09nRQSo7ZZs3eJ9arvuYPKKogCyv3hW9tPo
	 btX7Rm6yDdRQC2f8ieKXsy4tNBk2bNSECETd1Lsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgCCRri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731386AbgCCRrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:47:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10AEE20CC7;
        Tue,  3 Mar 2020 17:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257654;
        bh=g7lm6YgSyj6c2NL8Mpa/jUwJdQ2wfy+ZGEYhea2EoUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APSGNcmDLvi0Qen25fTFoBwkg78BG2JT6Kx06PSEyrlpxk5dXjHES0mWdZwT5bRce
         5MNU7IHrY+XzY1HvtlP+fcJiAFuRMlRo+3j9iSXPP6zBreFYaTfYSKIRKEjhtihhId
         J0N1UIGRhhbVbQXEUDxCrtja0jciVLdUDwSaYhIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sung Lee <sung.lee@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 045/176] drm/amd/display: Do not set optimized_require to false after plane disable
Date:   Tue,  3 Mar 2020 18:41:49 +0100
Message-Id: <20200303174309.755272091@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sung Lee <sung.lee@amd.com>

[ Upstream commit df36f6cf23ada812930afa8ee76681d4ad307c61 ]

[WHY]
The optimized_require flag is needed to set watermarks and clocks lower
in certain conditions. This flag is set to true and then set to false
while programming front end in dcn20.

[HOW]
Do not set the flag to false while disabling plane.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index ac8c18fadefce..448bc9b39942f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -493,7 +493,6 @@ static void dcn20_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	dpp->funcs->dpp_dppclk_control(dpp, false, false);
 
 	hubp->power_gated = true;
-	dc->optimized_required = false; /* We're powering off, no need to optimize */
 
 	dc->hwss.plane_atomic_power_down(dc,
 			pipe_ctx->plane_res.dpp,
-- 
2.20.1



