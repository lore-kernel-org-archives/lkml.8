Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0B8C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8866E20787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648929;
	bh=2zWWHWL2zBtHld4HulssVb7uft3/L0eJ7Xv6VFhcNSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VDBO7kEKbmHhTLD3XvDyhmIIUFDedNDHP5ZDifdDFXgOpFrMuWmdbo4B8IFlkJVES
	 ALZq1xL2X2YDXnfhdVhMjO24F9hk7ZmJR1OL7FRcFjE5GviWrN9ss0wTZiHZPhkdJ+
	 6H7+xgfFZWPj51Puo1XS0dcrcv31SdseUX5UHX4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgDKXss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbgDKXEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:04:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56A052173E;
        Sat, 11 Apr 2020 23:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646272;
        bh=2zWWHWL2zBtHld4HulssVb7uft3/L0eJ7Xv6VFhcNSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpGK0GjKNNUqd3OE0SdQTfLRp4hDZtOjP+RtFv/hsk3TyUH0NmJ67R7yGI21C5qFs
         YNy2bdi0pHuNirI+mAdkOkS/a9ABa/KQndFqlvOioEVko1D0B9Pl51TJqlvVe5zLg/
         W3FaG3ibFKMLPs644+IiQ9zmC+sqCJ1c45UbrJKM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Leung <martin.leung@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 036/149] drm/amd/display: writing stereo polarity register if swapped
Date:   Sat, 11 Apr 2020 19:01:53 -0400
Message-Id: <20200411230347.22371-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Leung <martin.leung@amd.com>

[ Upstream commit e592e85f3378246dd66b861fa60ef803d8cece6b ]

[why]
on some displays that prefer swapped polarity we were seeing L/R images
swapped because OTG_STEREO_SYNC_OUTPUT_POLARITY would always be mapped
to 0

[how]
fix initial dal3 implementation to properly update the polarity field
according to the crtc_stereo_flags (same as
OTG_STEREO_EYE_FLAG_POLARITY)

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index a9a43b397db99..f39c94d68fb25 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -1195,7 +1195,7 @@ static void optc1_enable_stereo(struct timing_generator *optc,
 			REG_UPDATE_3(OTG_STEREO_CONTROL,
 				OTG_STEREO_EN, stereo_en,
 				OTG_STEREO_SYNC_OUTPUT_LINE_NUM, 0,
-				OTG_STEREO_SYNC_OUTPUT_POLARITY, 0);
+				OTG_STEREO_SYNC_OUTPUT_POLARITY, flags->RIGHT_EYE_POLARITY == 0 ? 0 : 1);
 
 		if (flags->PROGRAM_POLARITY)
 			REG_UPDATE(OTG_STEREO_CONTROL,
-- 
2.20.1

