Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E960AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FDE20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520811;
	bh=xNxWuxJz2HZvdmUmAa0zl9AQCLtbYo9SEzWFm3xSK0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q2e5pHRaQx4dCAO/In30nEkjGGZydNr5VeSnSL/yLg2YLPQmLamv5yf/aag+o+RIj
	 OfKo5NVI0WU7D2DhF9MnfEH/O3y8Lp4RUA4WOi1JX4S809/4XZws3DJ+y4YSA7BSYm
	 oaxShjPNnlOPZ+78QqUpTCJOafRv6kn53vyfsMWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392135AbgEZTMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392124AbgEZTMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:12:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6272E208A7;
        Tue, 26 May 2020 19:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520366;
        bh=xNxWuxJz2HZvdmUmAa0zl9AQCLtbYo9SEzWFm3xSK0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cE7RAXkE3ZtkbRsg38ukl8J4eLjHmQSw2/6mwWklnJs5/nKdcM927MC/CRnQ9oWYl
         jUsUMdOOBqGKvU9Dvxk0nzNqiMZGD/XYauzJo5auZ6R270D2n08fPc5Lp/EYuQTLAq
         O0u+8TbldDykeb1P31rpXXgRMnqAlYIpLzojHpZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 051/126] drm/amd/display: Prevent dpcd reads with passive dongles
Date:   Tue, 26 May 2020 20:53:08 +0200
Message-Id: <20200526183942.332706715@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 5e27a67fbc58..0cd11d3d4cf4 100644
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
2.25.1



