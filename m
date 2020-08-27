Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313F9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D05B2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dolX/Oj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgH0JZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbgH0JZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:25:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6362AC06123B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:25:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so4638699wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IFNMyaH4C8tyb/mJTWrzTTwDqXVQt+oIKxEwk0xfFcs=;
        b=dolX/Oj/ruvZXAdY9Awn2EFLCyhybVa7noGABscD4AETJE40yPNweFzjsbch+7oNWD
         E9nAAOpcJUgp9Zeqgha+dssMpvo6RwBkMdKQr1/shKrQb0Y4cHWz0ezv+I0u83obAvvs
         bxIIDWcO3SxyVq+9yL4RT0eclQmQCeE61H2Le1JzT6LZEjHn8FIOK2vXK5RGTu9VzPcR
         WlhWpzHcuySlhhcZMMW1BJw56yMBEgmOpH8MrD85+vdLpTWukcT7HwdGUEZDK9qEuGzE
         EEvUN3FdcV2SjAR3UvcnQyjrQkSL1X9pwPfyfVrHiU1yoYtiTJg8HyGXsdwT/G9xnbHr
         KRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IFNMyaH4C8tyb/mJTWrzTTwDqXVQt+oIKxEwk0xfFcs=;
        b=sr+YQN4nszCs7hTeVTVeCf5Er+n6B/BjKzE7ZgdPvjXP2bPF4B6367lFJEoQ6HSsGt
         eQpPiPiHvMrVguEV+wM9jjMC7AUcz7bVc6Bz0yykQwrMB58T6VrnF48jrh7ZIQRds/Eo
         0Ws40A2WKHefSWCB1b8BOy+ikmR2q+n3oBWKN79B9JeOzUN2n1VAy2SJfzUh37bDFGHP
         9sc9DiY7Ju3GUOTWJ+/Qk9vtRHDlArLGYhNsSYXgrbnW+bv5syEBX9vqNVak3IcTtZ5y
         0c1kAVWXZl8EY+lkwpQ/ys0TiFminoA+J3Nilb8B4WP2MVIpZ0mgCKRE8NkyMUfbEkEC
         rf4Q==
X-Gm-Message-State: AOAM531QyShzkVNECAb5wIptbXSXtoTS/2hTyZZs1OXGl6uBQfpDrsvH
        YBPwUbvd8uFcwwjJCCDsKOfV9g23VYmHMHxW
X-Google-Smtp-Source: ABdhPJwT8tpl+fd43qiB4cxkLEEDXd73CQlEGtZK4m11dQ+acs5TwfsJbOHxWMvs/63SDdvUq4pcBA==
X-Received: by 2002:a5d:6505:: with SMTP id x5mr18875316wru.336.1598520322734;
        Thu, 27 Aug 2020 02:25:22 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id z203sm4357330wmc.31.2020.08.27.02.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 02:25:22 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Dikshita Agarwal <dikshita@codeaurora.org>,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 13/13] venus: helpers: Wire up hfi platform buffer requirements
Date:   Thu, 27 Aug 2020 12:24:17 +0300
Message-Id: <20200827092417.16040-14-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827092417.16040-1-stanimir.varbanov@linaro.org>
References: <20200827092417.16040-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now when everything is in place wire up buffer requirements
from hfi platform buffers to the buffer requirements helper.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c   | 50 +++++++++++++++++++
 .../media/platform/qcom/venus/hfi_parser.h    |  5 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index cd06a6998f52..a3e59b3791eb 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -15,6 +15,7 @@
 #include "hfi_helper.h"
 #include "pm_helpers.h"
 #include "hfi_platform.h"
+#include "hfi_parser.h"
 
 struct intbuf {
 	struct list_head list;
@@ -552,6 +553,51 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
 	return 0;
 }
 
+static int platform_get_bufreq(struct venus_inst *inst, u32 buftype,
+			       struct hfi_buffer_requirements *req)
+{
+	enum hfi_version version = inst->core->res->hfi_version;
+	const struct hfi_platform *hfi_plat;
+	struct hfi_plat_buffers_params params;
+	bool is_dec = inst->session_type == VIDC_SESSION_TYPE_DEC;
+	struct venc_controls *enc_ctr = &inst->controls.enc;
+
+	hfi_plat = hfi_platform_get(version);
+
+	if (!hfi_plat || !hfi_plat->bufreq)
+		return -EINVAL;
+
+	params.version = version;
+	params.num_vpp_pipes = hfi_platform_num_vpp_pipes(version);
+
+	if (is_dec) {
+		params.width = inst->width;
+		params.height = inst->height;
+		params.codec = inst->fmt_out->pixfmt;
+		params.hfi_color_fmt = to_hfi_raw_fmt(inst->fmt_cap->pixfmt);
+		params.dec.max_mbs_per_frame = mbs_per_frame_max(inst);
+		params.dec.buffer_size_limit = 0;
+		params.dec.is_secondary_output =
+			inst->opb_buftype == HFI_BUFFER_OUTPUT2;
+		params.dec.is_interlaced =
+			inst->pic_struct != HFI_INTERLACE_FRAME_PROGRESSIVE ?
+				true : false;
+	} else {
+		params.width = inst->out_width;
+		params.height = inst->out_height;
+		params.codec = inst->fmt_cap->pixfmt;
+		params.hfi_color_fmt = to_hfi_raw_fmt(inst->fmt_out->pixfmt);
+		params.enc.work_mode = VIDC_WORK_MODE_2;
+		params.enc.rc_type = HFI_RATE_CONTROL_OFF;
+		if (enc_ctr->bitrate_mode == V4L2_MPEG_VIDEO_BITRATE_MODE_CQ)
+			params.enc.rc_type = HFI_RATE_CONTROL_CQ;
+		params.enc.num_b_frames = enc_ctr->num_b_frames;
+		params.enc.is_tenbit = inst->bit_depth == VIDC_BITDEPTH_10;
+	}
+
+	return hfi_plat->bufreq(&params, inst->session_type, buftype, req);
+}
+
 int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
 			    struct hfi_buffer_requirements *req)
 {
@@ -563,6 +609,10 @@ int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
 	if (req)
 		memset(req, 0, sizeof(*req));
 
+	ret = platform_get_bufreq(inst, type, req);
+	if (!ret)
+		return 0;
+
 	ret = hfi_session_get_property(inst, ptype, &hprop);
 	if (ret)
 		return ret;
diff --git a/drivers/media/platform/qcom/venus/hfi_parser.h b/drivers/media/platform/qcom/venus/hfi_parser.h
index 7f59d82110f9..5751d0140700 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.h
+++ b/drivers/media/platform/qcom/venus/hfi_parser.h
@@ -112,4 +112,9 @@ static inline u32 core_num_max(struct venus_inst *inst)
 	return cap_max(inst, HFI_CAPABILITY_MAX_VIDEOCORES);
 }
 
+static inline u32 mbs_per_frame_max(struct venus_inst *inst)
+{
+	return cap_max(inst, HFI_CAPABILITY_MBS_PER_FRAME);
+}
+
 #endif
-- 
2.17.1

