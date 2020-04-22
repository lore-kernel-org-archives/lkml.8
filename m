Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C049C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6815A2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551112;
	bh=uC9JFgoKOhfTK98rPb7jgE0oqaQzBDX/tz1p1CqrX0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JT3WRyXbAaShqTWvg1WrYMAjVNKsz+37LhxtwG9uRXhYDhcbAjk9atEWWjPSAGLqZ
	 cOTlafksulFnnOCGp/arrt+3aSAR0vuHGT8GdfI9ZGWQVB2fh1+PJbeyS8eUtTbzz4
	 y+E1/g9KsIJu5lXHmYQJARjohoLhDe8B4NjxjnXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgDVKZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730470AbgDVKYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:24:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0B92076B;
        Wed, 22 Apr 2020 10:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551094;
        bh=uC9JFgoKOhfTK98rPb7jgE0oqaQzBDX/tz1p1CqrX0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2OQPEHpxxNbdKGVB5n2ZBYqLHJ2C40TAzvKoZ7cPvxi00vD+NRXvJeedIfJq4m+I
         c1pVuRfRjWD0Tdl12iSQn3SWHfw/y88BTX7bTy1t8+ECKoJImOIkMPIrcuaJ3PJWMF
         d6IGRVejub2VovpG9Bm5S6gQ7GG5KveX1l4pQ8Vc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 097/166] drm/amd/display: Dont try hdcp1.4 when content_type is set to type1
Date:   Wed, 22 Apr 2020 11:57:04 +0200
Message-Id: <20200422095059.405487984@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[ Upstream commit c2850c125d919efbb3a9ab46410d23912934f585 ]

[Why]
When content type property is set to 1. We should enable hdcp2.2 and if we cant
then stop. Currently the way it works in DC is that if we fail hdcp2, we will
try hdcp1 after.

[How]
Use link config to force disable hdcp1.4 when type1 is set.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 0acd3409dd6ce..3abeff7722e3d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -113,10 +113,13 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 
 		if (enable_encryption) {
 			display->adjust.disable = 0;
-			if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0)
+			if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0) {
+				hdcp_w->link.adjust.hdcp1.disable = 0;
 				hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
-			else if (content_type == DRM_MODE_HDCP_CONTENT_TYPE1)
+			} else if (content_type == DRM_MODE_HDCP_CONTENT_TYPE1) {
+				hdcp_w->link.adjust.hdcp1.disable = 1;
 				hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_1;
+			}
 
 			schedule_delayed_work(&hdcp_w->property_validate_dwork,
 					      msecs_to_jiffies(DRM_HDCP_CHECK_PERIOD_MS));
@@ -334,6 +337,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->dp.rev = aconnector->dc_link->dpcd_caps.dpcd_rev.raw;
 	display->adjust.disable = 1;
 	link->adjust.auth_delay = 2;
+	link->adjust.hdcp1.disable = 0;
 
 	hdcp_update_display(hdcp_work, link_index, aconnector, DRM_MODE_HDCP_CONTENT_TYPE0, false);
 }
-- 
2.20.1



