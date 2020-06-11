Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8495BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D6DC20760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgFKM41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:56:27 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:39911 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726346AbgFKM41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:56:27 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Jun 2020 18:25:43 +0530
Received: from mkrishn-linux.qualcomm.com ([10.204.66.35])
  by ironmsg02-blr.qualcomm.com with ESMTP; 11 Jun 2020 18:25:18 +0530
Received: by mkrishn-linux.qualcomm.com (Postfix, from userid 438394)
        id 1D39A488D; Thu, 11 Jun 2020 18:25:17 +0530 (IST)
From:   Krishna Manikandan <mkrishn@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <kalyan_t@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        nganji@codeaurora.org, mka@chromium.org, john.stultz@linaro.org,
        dianders@chromium.org, abhinavk@codeaurora.org
Subject: [v1] drm/msm/dpu: request for display color blocks based on hw catalog entry
Date:   Thu, 11 Jun 2020 18:25:15 +0530
Message-Id: <1591880115-12721-1-git-send-email-mkrishn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalyan Thota <kalyan_t@codeaurora.org>

Request for color processing blocks only if they are
available in the display hw catalog and they are
sufficient in number for the selection.

Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 63976dc..9f8de77 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -521,7 +521,7 @@ static struct msm_display_topology dpu_encoder_get_topology(
 			struct dpu_kms *dpu_kms,
 			struct drm_display_mode *mode)
 {
-	struct msm_display_topology topology;
+	struct msm_display_topology topology = {0};
 	int i, intf_count = 0;
 
 	for (i = 0; i < MAX_PHYS_ENCODERS_PER_VIRTUAL; i++)
@@ -537,7 +537,8 @@ static struct msm_display_topology dpu_encoder_get_topology(
 	 * 1 LM, 1 INTF
 	 * 2 LM, 1 INTF (stream merge to support high resolution interfaces)
 	 *
-	 * Adding color blocks only to primary interface
+	 * Adding color blocks only to primary interface if available in
+	 * sufficient number
 	 */
 	if (intf_count == 2)
 		topology.num_lm = 2;
@@ -546,8 +547,11 @@ static struct msm_display_topology dpu_encoder_get_topology(
 	else
 		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
 
-	if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI)
-		topology.num_dspp = topology.num_lm;
+	if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI) {
+		if (dpu_kms->catalog->dspp &&
+			(dpu_kms->catalog->dspp_count >= topology.num_lm))
+			topology.num_dspp = topology.num_lm;
+	}
 
 	topology.num_enc = 0;
 	topology.num_intf = intf_count;
-- 
1.9.1

