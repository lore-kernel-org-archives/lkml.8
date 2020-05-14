Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17B2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B450020675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483373;
	bh=FpJAmaIbXfW+zhkboocQed7po9iRsV2lzX9DK4liwkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TA+7CXKQewbZd6dtCcceToEMbrUudl98Yj10XUKfHrF5127xLu2oI75ZRrfTzq87S
	 jmH0yKAWv9fAw3p+BXgNZNOKN+hltDYqHenO06bEUf2ybmd16/IMv1KYXB2HtuKeJC
	 U4plOoo5y9IF8gyIP6FE1VLACAqkvnqCu210/7GQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgENTJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbgENSws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:52:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AFED2065F;
        Thu, 14 May 2020 18:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482367;
        bh=FpJAmaIbXfW+zhkboocQed7po9iRsV2lzX9DK4liwkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBgg7eSyfBLZcQW1BIRmjA6UiW1oz+cWp3SQDVx7M2GY89mo/L/YpXuqblWdlT6ZB
         2/nL1t9MVAnW5Fnsb0BDCgmXvVZRuP4OjGgGpSIdNbZhRo7t1zMbnNcbiMjw4NjOnV
         aFlOfh4lWq92GTjY/JyRarXrHOkqe2/bDS3KNfpc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 46/62] drm/amd/display: Prevent dpcd reads with passive dongles
Date:   Thu, 14 May 2020 14:51:31 -0400
Message-Id: <20200514185147.19716-46-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185147.19716-1-sashal@kernel.org>
References: <20200514185147.19716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[ Upstream commit e6142dd511425cb827b5db869f489eb81f5f994d ]

[why]
During hotplug, a DP port may be connected to the sink through
passive adapter which does not support DPCD reads. Issuing reads
without checking for this condition will result in errors

[how]
Ensure the link is in aux_mode before initiating operation that result
in a DPCD read.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8136a58deb393..f98c42150b4f3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1941,17 +1941,22 @@ amdgpu_dm_update_connector_after_detect(struct amdgpu_dm_connector *aconnector)
 		dc_sink_retain(aconnector->dc_sink);
 		if (sink->dc_edid.length == 0) {
 			aconnector->edid = NULL;
-			drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
+			if (aconnector->dc_link->aux_mode) {
+				drm_dp_cec_unset_edid(
+					&aconnector->dm_dp_aux.aux);
+			}
 		} else {
 			aconnector->edid =
-				(struct edid *) sink->dc_edid.raw_edid;
-
+				(struct edid *)sink->dc_edid.raw_edid;
 
 			drm_connector_update_edid_property(connector,
-					aconnector->edid);
-			drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,
-					    aconnector->edid);
+							   aconnector->edid);
+
+			if (aconnector->dc_link->aux_mode)
+				drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,
+						    aconnector->edid);
 		}
+
 		amdgpu_dm_update_freesync_caps(connector, aconnector->edid);
 
 	} else {
-- 
2.20.1

