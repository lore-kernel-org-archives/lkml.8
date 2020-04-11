Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6726C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9218020787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648896;
	bh=eSQG4zjJI2NpYKdRyk6k4YozKTs/eWEKTA1IfJRxfKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mM7PN6Q4mPyznyFJbC+uDnwPAiB/2eJ0ldi2rzYj+wycFfcDFjM3vlau+EYWRUJwo
	 O8WtB0oO0bF84HWImbZLpbKSXArUVpAOFlDKnMq5zV2CQ1HBQrs7lM4UMmf9k6JLfh
	 Z/T2kU/mxZv3dxAqwt+w4A+smkFgX1ChJ6TRhS+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgDKXsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgDKXEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:04:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 022CB20CC7;
        Sat, 11 Apr 2020 23:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646286;
        bh=eSQG4zjJI2NpYKdRyk6k4YozKTs/eWEKTA1IfJRxfKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcbBOnttAsuezGXK/p8T3jt//rhJehNe+jLVokJIYe531xnf/Cfe6nrNTNwJu+ktU
         0YomcTCi7qI/OuqM6auHQgv16NXqW86eSdMHXkBBdVpTKVGByLmqSNIKOCAPXIJTBM
         mXZJQuOuHetHFMt0JfR4B+x+7hCCVSvzuOEeDYWo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 047/149] drm/amd/display: Fix HDMI repeater authentication
Date:   Sat, 11 Apr 2020 19:02:04 -0400
Message-Id: <20200411230347.22371-47-sashal@kernel.org>
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

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[ Upstream commit 63a85ff6c35d8a7aaf0fb60ddbab93530d495bf3 ]

when the rxstatus split was done the index was incorrect. This
lead to HDMI repeater authentication failure for HDCP2.X So fix it

Fixes: 302169003733 ("drm/amd/display: split rxstatus for hdmi and dp")
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index 55246711700ba..6fd68326452ce 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -34,7 +34,7 @@ static inline enum mod_hdcp_status check_receiver_id_list_ready(struct mod_hdcp
 	if (is_dp_hdcp(hdcp))
 		is_ready = HDCP_2_2_DP_RXSTATUS_READY(hdcp->auth.msg.hdcp2.rxstatus_dp) ? 1 : 0;
 	else
-		is_ready = (HDCP_2_2_HDMI_RXSTATUS_READY(hdcp->auth.msg.hdcp2.rxstatus[0]) &&
+		is_ready = (HDCP_2_2_HDMI_RXSTATUS_READY(hdcp->auth.msg.hdcp2.rxstatus[1]) &&
 				(HDCP_2_2_HDMI_RXSTATUS_MSG_SZ_HI(hdcp->auth.msg.hdcp2.rxstatus[1]) << 8 |
 						hdcp->auth.msg.hdcp2.rxstatus[0])) ? 1 : 0;
 	return is_ready ? MOD_HDCP_STATUS_SUCCESS :
@@ -67,7 +67,7 @@ static inline enum mod_hdcp_status check_reauthentication_request(
 				MOD_HDCP_STATUS_HDCP2_REAUTH_REQUEST :
 				MOD_HDCP_STATUS_SUCCESS;
 	else
-		ret = HDCP_2_2_HDMI_RXSTATUS_REAUTH_REQ(hdcp->auth.msg.hdcp2.rxstatus[0]) ?
+		ret = HDCP_2_2_HDMI_RXSTATUS_REAUTH_REQ(hdcp->auth.msg.hdcp2.rxstatus[1]) ?
 				MOD_HDCP_STATUS_HDCP2_REAUTH_REQUEST :
 				MOD_HDCP_STATUS_SUCCESS;
 	return ret;
-- 
2.20.1

