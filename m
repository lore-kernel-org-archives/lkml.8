Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1352C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB4F207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888223;
	bh=fT+Gl91n+3w+s/Fj+AVwPmeQvf8Pt8+tmLBCik5m63s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aTGBngDmB28HtEladuU5S+EWnMlY+Rsk+LIa//bU/8ewXKSNXKawNMJ/c9Po1+sBK
	 nM3709aQ2ECei534vGhLD+7+PIvCwt3sgFlUoOovmN957R6Z5BI0hNdDBKWgzid2Na
	 ZKad/rsyrGBuXqnBT7d1/g8D9b9XZLPEZAH6LuiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgHaPhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728661AbgHaPac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:30:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 047D8214D8;
        Mon, 31 Aug 2020 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887832;
        bh=fT+Gl91n+3w+s/Fj+AVwPmeQvf8Pt8+tmLBCik5m63s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbuBf1gTQpvKxmyBrV+3qFgBJoArJzSYAyxyZSQArBZH77bI36mvJVm1KSAS91Qs8
         9/2k1yrbzKcvFe1ZdIyjxAPTWWSo1lx9MTirID4mmf0VtgBGDukw1Rve2tnrHRcwRU
         8gfRiJQJUbylSy4kBT7+6FrX1dF0c01wXeE4oV5o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brandon Syu <Brandon.Syu@amd.com>,
        Josip Pavic <Josip.Pavic@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.8 38/42] drm/amd/display: Keep current gain when ABM disable immediately
Date:   Mon, 31 Aug 2020 11:29:30 -0400
Message-Id: <20200831152934.1023912-38-sashal@kernel.org>
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

From: Brandon Syu <Brandon.Syu@amd.com>

[ Upstream commit cba4b52e431e5de3d8012281cfe194f1c39a9052 ]

[Why]
When system enters s3/s0i3, backlight PWM would set user level.

[How]
ABM disable function add keep current gain to avoid it.

Signed-off-by: Brandon Syu <Brandon.Syu@amd.com>
Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc_stream.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 49aad691e687e..ccac2315a903a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -222,7 +222,7 @@ struct dc_stream_state {
 	union stream_update_flags update_flags;
 };
 
-#define ABM_LEVEL_IMMEDIATE_DISABLE 0xFFFFFFFF
+#define ABM_LEVEL_IMMEDIATE_DISABLE 255
 
 struct dc_stream_update {
 	struct dc_stream_state *stream;
-- 
2.25.1

