Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AAFC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E09920787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648811;
	bh=K7zwUITdBLR4r8jCBQwmIbnYlFoD5S4Q3pLZJNuKCbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eHKMm0eWreW9St5TJPgtt2SP+d4O2Vyh90Nh4OpIsNtzc1Z7J2nIa5PoIHZ8diYu0
	 NbP9dl1Fz1JWqb7PK3yWiXSyS8QsfNa9IowVTWPY3KMppC9YUXPm49sn+M9vT4Xmus
	 SC2hXC7mU9T1Ji0fofKmu/7hUDVkmLdI0v4LDJeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgDKXqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgDKXFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:05:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64D4120787;
        Sat, 11 Apr 2020 23:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646311;
        bh=K7zwUITdBLR4r8jCBQwmIbnYlFoD5S4Q3pLZJNuKCbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zy+ii8ndF9GnVLIideKVWiLoJXvHmWRWUysDem2hyVvK6Rit8cC7TBCewnTuFp3bE
         NCdGcsDB1+1xFKLpRcbLihaGdvAVu6Fz9IN9yg2zVUJT6bLF4pVINDhv9aucMsxCuD
         GAPrpcfCZjkWIHPMRSf7u8paPQ1ailMIXP6p32eU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Leung <martin.leung@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 068/149] drm/amd/display: always apply T7/T9 delay logic
Date:   Sat, 11 Apr 2020 19:02:25 -0400
Message-Id: <20200411230347.22371-68-sashal@kernel.org>
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

[ Upstream commit cb8348fec250e517b5facb4cab3125ddc597f9aa ]

[why]
before we exit early in edp_reciever_ready if we detect that panel
is not edp or below rev 1.2. This will skip the backlight/t7 delay panel
patch.

[how]
edit logic to ensure panel patch is applied regardless of edp rev.

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 56 ++++++++++---------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index ddb8550457672..58634f191a55d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -153,18 +153,19 @@ bool edp_receiver_ready_T9(struct dc_link *link)
 	unsigned char edpRev = 0;
 	enum dc_status result = DC_OK;
 	result = core_link_read_dpcd(link, DP_EDP_DPCD_REV, &edpRev, sizeof(edpRev));
-	if (edpRev < DP_EDP_12)
-		return true;
-	/* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
-	do {
-		sinkstatus = 1;
-		result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
-		if (sinkstatus == 0)
-			break;
-		if (result != DC_OK)
-			break;
-		udelay(100); //MAx T9
-	} while (++tries < 50);
+
+     /* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
+	if (result == DC_OK && edpRev >= DP_EDP_12) {
+		do {
+			sinkstatus = 1;
+			result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
+			if (sinkstatus == 0)
+				break;
+			if (result != DC_OK)
+				break;
+			udelay(100); //MAx T9
+		} while (++tries < 50);
+	}
 
 	if (link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off > 0)
 		udelay(link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off * 1000);
@@ -183,21 +184,22 @@ bool edp_receiver_ready_T7(struct dc_link *link)
 	unsigned long long time_taken_in_ns = 0;
 
 	result = core_link_read_dpcd(link, DP_EDP_DPCD_REV, &edpRev, sizeof(edpRev));
-	if (result == DC_OK && edpRev < DP_EDP_12)
-		return true;
-	/* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
-	enter_timestamp = dm_get_timestamp(link->ctx);
-	do {
-		sinkstatus = 0;
-		result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
-		if (sinkstatus == 1)
-			break;
-		if (result != DC_OK)
-			break;
-		udelay(25);
-		finish_timestamp = dm_get_timestamp(link->ctx);
-		time_taken_in_ns = dm_get_elapse_time_in_ns(link->ctx, finish_timestamp, enter_timestamp);
-	} while (time_taken_in_ns < 50 * 1000000); //MAx T7 is 50ms
+
+	if (result == DC_OK && edpRev >= DP_EDP_12) {
+		/* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
+		enter_timestamp = dm_get_timestamp(link->ctx);
+		do {
+			sinkstatus = 0;
+			result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
+			if (sinkstatus == 1)
+				break;
+			if (result != DC_OK)
+				break;
+			udelay(25);
+			finish_timestamp = dm_get_timestamp(link->ctx);
+			time_taken_in_ns = dm_get_elapse_time_in_ns(link->ctx, finish_timestamp, enter_timestamp);
+		} while (time_taken_in_ns < 50 * 1000000); //MAx T7 is 50ms
+	}
 
 	if (link->local_sink->edid_caps.panel_patch.extra_t7_ms > 0)
 		udelay(link->local_sink->edid_caps.panel_patch.extra_t7_ms * 1000);
-- 
2.20.1

