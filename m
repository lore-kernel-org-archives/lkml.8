Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7DDC433E8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47D720767
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="p3/ImdCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgGKAuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 20:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGKAuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 20:50:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC17EC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:50:18 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 80so7086277qko.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aJYrvoM5HMTFnGdsK+fgfLYRAY3PPQKqt2v9Vxo+zlM=;
        b=p3/ImdCypAmerI1Sdkyy22/7mTL8xG6yCYPGnhTSvEKe8WCERzEXKn85xe+sVkpHB1
         ndL610lzJ+sAj58VoeXwd5pz+5akTQw12frhgD2a0KmyAdrgaN7GksGtj0jRizT1RDvB
         cErBNtyEL8dQ52bn0q3Drv+XkEl5TIXE9xsj+Yh3Cd8mEIvZsM0l4SGNqtjmdKLPV0px
         0QtYHsACq4Q20dtRvYpW1REK9MkxHgGj5yN9ptuxWuUUmlV5XkTTcNQsQzB0CSBXai8a
         SszwOneUrGtGBlf/y0nF/bxdN1me7bM5TsP8zNUX10HQo/f++C8X2/XJCG6urW51HcFW
         juBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJYrvoM5HMTFnGdsK+fgfLYRAY3PPQKqt2v9Vxo+zlM=;
        b=Ut/quriu/oZPfVnoQvZyGn31US73dAW1iK9LqFYyGBAfP83c6iSp3snTHw8LRa+Fkg
         J/6jF40s5FkpqwsibdElG/bOQqkyD6Cg37vfEIaSStEOzekRdVd8e2+VZM3BKDxQ3dhA
         tyBaKL48vDFuXmfdvIb0TG52qJMGJSsPDzDO49yfNRiBmAeCLf9rfZh/W86XVUToq1Os
         mlLZDTmb4wd/myL9DQp1xZ5dc0FAsEfVQIuoItF23hRhQ/yNjkUPbya7CNMXOBYrWlRW
         6qDvN3fCOKOffcNlv2KpMoMrT0v6KRz0+EGkVug3BGUNzeZpvDb1iH8ryI1Il4kABzaT
         fOKQ==
X-Gm-Message-State: AOAM533bBiumJI7sUN++y4qYqYKUeGGKUoGN6zA4ZpYTOLOdebKf+ulD
        ScwwApJVEam/jeinMTiM46fWVw==
X-Google-Smtp-Source: ABdhPJzdGoB0jL3WYWcgn0TBa9NTF1nk9eL1+bBsVZ26R9vwUn59YJMg6IWEHkFo3wSZ46cCWIZcnA==
X-Received: by 2002:a37:65d2:: with SMTP id z201mr46671243qkb.351.1594428617985;
        Fri, 10 Jul 2020 17:50:17 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id g20sm10427510qtc.46.2020.07.10.17.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 17:50:17 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Shubhashree Dhar <dhar@codeaurora.org>,
        Raviteja Tamatam <travitej@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/8] drm/msm/dpu: don't use INTF_INPUT_CTRL feature on sdm845
Date:   Fri, 10 Jul 2020 20:47:27 -0400
Message-Id: <20200711004752.30760-5-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200711004752.30760-1-jonathan@marek.ca>
References: <20200711004752.30760-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INTF_INPUT_CTRL feature is not available on sdm845, so don't set it.

This also adds separate feature bits for INTF (based on downstream) instead
of using CTL feature bit for it, and removes the unnecessary NULL check in
the added bind_pingpong_blk function.

Fixes: 73bfb790ac786ca55fa2786a06f59 ("msm:disp:dpu1: setup display datapath for SC7180 target")

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 20 +++++++++++--------
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    | 13 ++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c   |  9 ++-------
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index f4ccbe56a09e..1d19c377b096 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -43,6 +43,10 @@
 
 #define DSPP_SC7180_MASK BIT(DPU_DSPP_PCC)
 
+#define INTF_SDM845_MASK (0)
+
+#define INTF_SC7180_MASK BIT(DPU_INTF_INPUT_CTRL) | BIT(DPU_INTF_TE)
+
 #define DEFAULT_PIXEL_RAM_SIZE		(50 * 1024)
 #define DEFAULT_DPU_LINE_WIDTH		2048
 #define DEFAULT_DPU_OUTPUT_LINE_WIDTH	2560
@@ -398,26 +402,26 @@ static struct dpu_pingpong_cfg sc7180_pp[] = {
 /*************************************************************
  * INTF sub blocks config
  *************************************************************/
-#define INTF_BLK(_name, _id, _base, _type, _ctrl_id) \
+#define INTF_BLK(_name, _id, _base, _type, _ctrl_id, _features) \
 	{\
 	.name = _name, .id = _id, \
 	.base = _base, .len = 0x280, \
-	.features = BIT(DPU_CTL_ACTIVE_CFG), \
+	.features = _features, \
 	.type = _type, \
 	.controller_id = _ctrl_id, \
 	.prog_fetch_lines_worst_case = 24 \
 	}
 
 static const struct dpu_intf_cfg sdm845_intf[] = {
-	INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, 0),
-	INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0),
-	INTF_BLK("intf_2", INTF_2, 0x6B000, INTF_DSI, 1),
-	INTF_BLK("intf_3", INTF_3, 0x6B800, INTF_DP, 1),
+	INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, 0, INTF_SDM845_MASK),
+	INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0, INTF_SDM845_MASK),
+	INTF_BLK("intf_2", INTF_2, 0x6B000, INTF_DSI, 1, INTF_SDM845_MASK),
+	INTF_BLK("intf_3", INTF_3, 0x6B800, INTF_DP, 1, INTF_SDM845_MASK),
 };
 
 static const struct dpu_intf_cfg sc7180_intf[] = {
-	INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, 0),
-	INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0),
+	INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, 0, INTF_SC7180_MASK),
+	INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0, INTF_SC7180_MASK),
 };
 
 /*************************************************************
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index a6221fdc02d2..e9458c85e20c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -186,6 +186,19 @@ enum {
 	DPU_CTL_MAX
 };
 
+/**
+ * INTF sub-blocks
+ * @DPU_INTF_INPUT_CTRL         Supports the setting of pp block from which
+ *                              pixel data arrives to this INTF
+ * @DPU_INTF_TE                 INTF block has TE configuration support
+ * @DPU_INTF_MAX
+ */
+enum {
+	DPU_INTF_INPUT_CTRL = 0x1,
+	DPU_INTF_TE,
+	DPU_INTF_MAX
+};
+
 /**
  * VBIF sub-blocks and features
  * @DPU_VBIF_QOS_OTLIM        VBIF supports OT Limit
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index efe9a5719c6b..64f556d693dd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -225,14 +225,9 @@ static void dpu_hw_intf_bind_pingpong_blk(
 		bool enable,
 		const enum dpu_pingpong pp)
 {
-	struct dpu_hw_blk_reg_map *c;
+	struct dpu_hw_blk_reg_map *c = &intf->hw;
 	u32 mux_cfg;
 
-	if (!intf)
-		return;
-
-	c = &intf->hw;
-
 	mux_cfg = DPU_REG_READ(c, INTF_MUX);
 	mux_cfg &= ~0xf;
 
@@ -280,7 +275,7 @@ static void _setup_intf_ops(struct dpu_hw_intf_ops *ops,
 	ops->get_status = dpu_hw_intf_get_status;
 	ops->enable_timing = dpu_hw_intf_enable_timing_engine;
 	ops->get_line_count = dpu_hw_intf_get_line_count;
-	if (cap & BIT(DPU_CTL_ACTIVE_CFG))
+	if (cap & BIT(DPU_INTF_INPUT_CTRL))
 		ops->bind_pingpong_blk = dpu_hw_intf_bind_pingpong_blk;
 }
 
-- 
2.26.1

