Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7DFC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3B524125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgAWKTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:19:21 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:17853 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgAWKTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:19:21 -0500
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Jan 2020 15:48:38 +0530
Received: from kalyant-linux.qualcomm.com ([10.204.66.210])
  by ironmsg01-blr.qualcomm.com with ESMTP; 23 Jan 2020 15:48:13 +0530
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id D4CD74534; Thu, 23 Jan 2020 15:48:11 +0530 (IST)
From:   Kalyan Thota <kalyan_t@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <kalyan_t@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        dianders@chromium.org, jsanka@codeaurora.org,
        harigovi@codeaurora.org, travitej@codeaurora.org,
        nganji@codeaurora.org
Subject: [PATCH] msm:disp:dpu1: add UBWC support for display on SC7180
Date:   Thu, 23 Jan 2020 15:47:55 +0530
Message-Id: <1579774675-20235-1-git-send-email-kalyan_t@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UBWC global configuration for display on
SC7180 target.

Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 58 +++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
index 29705e7..80d3cfc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
@@ -12,6 +12,7 @@
 
 #define to_dpu_mdss(x) container_of(x, struct dpu_mdss, base)
 
+#define HW_REV				0x0
 #define HW_INTR_STATUS			0x0010
 
 /* Max BW defined in KBps */
@@ -22,6 +23,17 @@ struct dpu_irq_controller {
 	struct irq_domain *domain;
 };
 
+struct dpu_hw_cfg {
+	u32 val;
+	u32 offset;
+};
+
+struct dpu_mdss_hw_init_handler {
+	u32 hw_rev;
+	u32 hw_reg_count;
+	struct dpu_hw_cfg* hw_cfg;
+};
+
 struct dpu_mdss {
 	struct msm_mdss base;
 	void __iomem *mmio;
@@ -32,6 +44,44 @@ struct dpu_mdss {
 	u32 num_paths;
 };
 
+static struct dpu_hw_cfg hw_cfg[] = {
+    {
+	/* UBWC global settings */
+	.val = 0x1E,
+	.offset = 0x144,
+    }
+};
+
+static struct dpu_mdss_hw_init_handler cfg_handler[] = {
+    { .hw_rev = DPU_HW_VER_620,
+      .hw_reg_count = ARRAY_SIZE(hw_cfg),
+      .hw_cfg = hw_cfg
+    },
+};
+
+static void dpu_mdss_hw_init(struct dpu_mdss *dpu_mdss, u32 hw_rev)
+{
+	int i;
+	u32 count = 0;
+	struct dpu_hw_cfg *hw_cfg = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(cfg_handler); i++) {
+		if (cfg_handler[i].hw_rev == hw_rev) {
+			hw_cfg = cfg_handler[i].hw_cfg;
+			count = cfg_handler[i].hw_reg_count;
+			break;
+	    }
+	}
+
+	for (i = 0; i < count; i++ ) {
+		writel_relaxed(hw_cfg->val,
+			dpu_mdss->mmio + hw_cfg->offset);
+		hw_cfg++;
+	}
+
+    return;
+}
+
 static int dpu_mdss_parse_data_bus_icc_path(struct drm_device *dev,
 						struct dpu_mdss *dpu_mdss)
 {
@@ -174,12 +224,18 @@ static int dpu_mdss_enable(struct msm_mdss *mdss)
 	struct dpu_mdss *dpu_mdss = to_dpu_mdss(mdss);
 	struct dss_module_power *mp = &dpu_mdss->mp;
 	int ret;
+	u32 mdss_rev;
 
 	dpu_mdss_icc_request_bw(mdss);
 
 	ret = msm_dss_enable_clk(mp->clk_config, mp->num_clk, true);
-	if (ret)
+	if (ret) {
 		DPU_ERROR("clock enable failed, ret:%d\n", ret);
+		return ret;
+	}
+
+	mdss_rev = readl_relaxed(dpu_mdss->mmio + HW_REV);
+	dpu_mdss_hw_init(dpu_mdss, mdss_rev);
 
 	return ret;
 }
-- 
1.9.1

