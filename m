Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B23C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25ACD2177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="b7Hw0Unl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgHDGpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:45:13 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:43355 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbgHDGpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:45:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596523511; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=9I+2fbpSXUFTiHD9lLljbO/ir26qO7xMDZYv1p85L6U=; b=b7Hw0UnlyssIQaJVzVp+2ApyKJMG3/BInp1VroR9trdXbgQJLlpG9yAYixYuqlbNOFoeDvMS
 J7rqkDNRAuy/f1U41ei9vsdJaGARhMxLOH82mZdFZVHQ1C5F409F0RdY+Ff1rOUYqsgVOL6y
 pfNgXv52oOqaAlB5rVXBAfVglAg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-east-1.postgun.com with SMTP id
 5f2903f214acd1952be7299d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 06:45:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 44160C4339C; Tue,  4 Aug 2020 06:45:04 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91954C4339C;
        Tue,  4 Aug 2020 06:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91954C4339C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 2/2] drm/msm/mdp5: Remove unused downstream bus scaling apis
Date:   Tue,  4 Aug 2020 12:14:43 +0530
Message-Id: <5e836765699bfeb74495eaca37c1da26daab66dc.1596523010.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1596523009.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1596523009.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM bus scaling has moved on to use interconnect framework
and downstream bus scaling apis are not present anymore.
Remove them as they are nop anyways in the current code,
no functional change.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 .../gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  | 24 -------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c  | 68 -------------------
 2 files changed, 92 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
index eeef41fcd4e1..ff2c1d583c79 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c
@@ -14,27 +14,6 @@ static struct mdp5_kms *get_kms(struct drm_encoder *encoder)
 	return to_mdp5_kms(to_mdp_kms(priv->kms));
 }
 
-#ifdef DOWNSTREAM_CONFIG_MSM_BUS_SCALING
-#include <mach/board.h>
-#include <linux/msm-bus.h>
-#include <linux/msm-bus-board.h>
-
-static void bs_set(struct mdp5_encoder *mdp5_cmd_enc, int idx)
-{
-	if (mdp5_cmd_enc->bsc) {
-		DBG("set bus scaling: %d", idx);
-		/* HACK: scaling down, and then immediately back up
-		 * seems to leave things broken (underflow).. so
-		 * never disable:
-		 */
-		idx = 1;
-		msm_bus_scale_client_update_request(mdp5_cmd_enc->bsc, idx);
-	}
-}
-#else
-static void bs_set(struct mdp5_encoder *mdp5_cmd_enc, int idx) {}
-#endif
-
 #define VSYNC_CLK_RATE 19200000
 static int pingpong_tearcheck_setup(struct drm_encoder *encoder,
 				    struct drm_display_mode *mode)
@@ -146,8 +125,6 @@ void mdp5_cmd_encoder_disable(struct drm_encoder *encoder)
 	mdp5_ctl_set_encoder_state(ctl, pipeline, false);
 	mdp5_ctl_commit(ctl, pipeline, mdp_ctl_flush_mask_encoder(intf), true);
 
-	bs_set(mdp5_cmd_enc, 0);
-
 	mdp5_cmd_enc->enabled = false;
 }
 
@@ -161,7 +138,6 @@ void mdp5_cmd_encoder_enable(struct drm_encoder *encoder)
 	if (WARN_ON(mdp5_cmd_enc->enabled))
 		return;
 
-	bs_set(mdp5_cmd_enc, 1);
 	if (pingpong_tearcheck_enable(encoder))
 		return;
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
index f48827283c2b..79d67c495780 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
@@ -16,72 +16,9 @@ static struct mdp5_kms *get_kms(struct drm_encoder *encoder)
 	return to_mdp5_kms(to_mdp_kms(priv->kms));
 }
 
-#ifdef DOWNSTREAM_CONFIG_MSM_BUS_SCALING
-#include <mach/board.h>
-#include <mach/msm_bus.h>
-#include <mach/msm_bus_board.h>
-#define MDP_BUS_VECTOR_ENTRY(ab_val, ib_val)		\
-	{						\
-		.src = MSM_BUS_MASTER_MDP_PORT0,	\
-		.dst = MSM_BUS_SLAVE_EBI_CH0,		\
-		.ab = (ab_val),				\
-		.ib = (ib_val),				\
-	}
-
-static struct msm_bus_vectors mdp_bus_vectors[] = {
-	MDP_BUS_VECTOR_ENTRY(0, 0),
-	MDP_BUS_VECTOR_ENTRY(2000000000, 2000000000),
-};
-static struct msm_bus_paths mdp_bus_usecases[] = { {
-		.num_paths = 1,
-		.vectors = &mdp_bus_vectors[0],
-}, {
-		.num_paths = 1,
-		.vectors = &mdp_bus_vectors[1],
-} };
-static struct msm_bus_scale_pdata mdp_bus_scale_table = {
-	.usecase = mdp_bus_usecases,
-	.num_usecases = ARRAY_SIZE(mdp_bus_usecases),
-	.name = "mdss_mdp",
-};
-
-static void bs_init(struct mdp5_encoder *mdp5_encoder)
-{
-	mdp5_encoder->bsc = msm_bus_scale_register_client(
-			&mdp_bus_scale_table);
-	DBG("bus scale client: %08x", mdp5_encoder->bsc);
-}
-
-static void bs_fini(struct mdp5_encoder *mdp5_encoder)
-{
-	if (mdp5_encoder->bsc) {
-		msm_bus_scale_unregister_client(mdp5_encoder->bsc);
-		mdp5_encoder->bsc = 0;
-	}
-}
-
-static void bs_set(struct mdp5_encoder *mdp5_encoder, int idx)
-{
-	if (mdp5_encoder->bsc) {
-		DBG("set bus scaling: %d", idx);
-		/* HACK: scaling down, and then immediately back up
-		 * seems to leave things broken (underflow).. so
-		 * never disable:
-		 */
-		idx = 1;
-		msm_bus_scale_client_update_request(mdp5_encoder->bsc, idx);
-	}
-}
-#else
-static void bs_init(struct mdp5_encoder *mdp5_encoder) {}
-static void bs_fini(struct mdp5_encoder *mdp5_encoder) {}
-static void bs_set(struct mdp5_encoder *mdp5_encoder, int idx) {}
-#endif
-
 static void mdp5_encoder_destroy(struct drm_encoder *encoder)
 {
 	struct mdp5_encoder *mdp5_encoder = to_mdp5_encoder(encoder);
-	bs_fini(mdp5_encoder);
 	drm_encoder_cleanup(encoder);
 	kfree(mdp5_encoder);
 }
@@ -222,8 +159,6 @@ static void mdp5_vid_encoder_disable(struct drm_encoder *encoder)
 	 */
 	mdp_irq_wait(&mdp5_kms->base, intf2vblank(mixer, intf));
 
-	bs_set(mdp5_encoder, 0);
-
 	mdp5_encoder->enabled = false;
 }
 
@@ -240,7 +175,6 @@ static void mdp5_vid_encoder_enable(struct drm_encoder *encoder)
 	if (WARN_ON(mdp5_encoder->enabled))
 		return;
 
-	bs_set(mdp5_encoder, 1);
 	spin_lock_irqsave(&mdp5_encoder->intf_lock, flags);
 	mdp5_write(mdp5_kms, REG_MDP5_INTF_TIMING_ENGINE_EN(intfn), 1);
 	spin_unlock_irqrestore(&mdp5_encoder->intf_lock, flags);
@@ -426,8 +360,6 @@ struct drm_encoder *mdp5_encoder_init(struct drm_device *dev,
 
 	drm_encoder_helper_add(encoder, &mdp5_encoder_helper_funcs);
 
-	bs_init(mdp5_encoder);
-
 	return encoder;
 
 fail:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

