Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84877C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C33207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugYmjN2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbgIHQwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732089AbgIHQwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:52:12 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E937DC06134F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:33:37 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e23so22260867eja.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sN4+mZ5uhIAG0/WLkYctbIQcbAJtPn6Wi3GZq31qSIg=;
        b=ugYmjN2xSHhF+21F3d6hVWxMmiUDsryJHIXuwRUHRfhQ4TYfF/9IpxodOQvAjPwnrN
         KYGdkGCLqQgm9tAA6RaKgQALDbF1Y+Cn+PsB/1XAaBeUMoTNKilxf92q7/WiZxmXyO3n
         yR9eS3xfO/9Pg8zEzTGnoj59wcp+w/zE4FztcOxZhmW6/74rwJ4GapCfZ2wzJnSLmPFP
         StSHAYcGuP0QuR96/3HVpfU1mGfHnbHCXPHLCXN/Mrdf/g+22eWx5vM0gfLgQme42lB+
         BgXWfzPbr0Ip5OzxRgOsw6ywurxu4bv2EyqV3k6B5UiNvbYCYsW7TNOwS+WH7skgLnrZ
         4t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sN4+mZ5uhIAG0/WLkYctbIQcbAJtPn6Wi3GZq31qSIg=;
        b=T0HxawWjRs09UJEFrE5mC4sIRlkP4M9JvKYRO0H8qjps0P7eZF8svrgw8Cgpw8HUEg
         C6LdNHkHDFzPxa+0rFsekLrPc/nW9T9T1na4MSFcnYc+e9AAEwQYqbOhqKN7vNS2rExj
         T9MSvLvsBxRrOibVCLIOWsrm+Tbz68Xrs36+UjYtoAMZAyGP015BQ5NarrgW0WqkPZZ2
         Hq39eTTsStPZSwcXEwQZMhz0uEL2k2BfOOMXef8n68q9l1Ilp79WxykLt+O0ulwrXY9U
         gJv4ps822VqJGj59rQaCs2r5DNbcSGO9FBOg6Bish+DQ4D9vxoINoSTSFOoXwsG1xHhh
         3HTQ==
X-Gm-Message-State: AOAM533wa1eiwMwJWq2qoLf2fCk2JOsDB6SyBbIoDo1JP8xeTWphFDyh
        pPDCJ1L2WvDA5eWXKoFGgW7mpQ==
X-Google-Smtp-Source: ABdhPJxHtd4i992YKOwmkNVnGZRsMiLfUfV15eGwYacP2ySW3da2CW4AtHELAQrxAQUN07P6vV4aUA==
X-Received: by 2002:a17:906:e103:: with SMTP id gj3mr25132826ejb.153.1599568416595;
        Tue, 08 Sep 2020 05:33:36 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id y9sm17499744edo.37.2020.09.08.05.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:33:35 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        nicolas.dufresne@collabora.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 5/6] venus: vdec: Use helper to get profile and level
Date:   Tue,  8 Sep 2020 15:32:20 +0300
Message-Id: <20200908123221.2793-6-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908123221.2793-1-stanimir.varbanov@linaro.org>
References: <20200908123221.2793-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the returned profile and level is not aligned with
v4l2 ctrl id. Correct that by use the helpers which translate
the v4l2 <-> hfi mapping internally.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/vdec_ctrls.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec_ctrls.c b/drivers/media/platform/qcom/venus/vdec_ctrls.c
index f3f41c1baa6e..974110b75b93 100644
--- a/drivers/media/platform/qcom/venus/vdec_ctrls.c
+++ b/drivers/media/platform/qcom/venus/vdec_ctrls.c
@@ -42,9 +42,8 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 	struct venus_inst *inst = ctrl_to_inst(ctrl);
 	struct vdec_controls *ctr = &inst->controls.dec;
 	struct hfi_buffer_requirements bufreq;
-	union hfi_get_property hprop;
 	enum hfi_version ver = inst->core->res->hfi_version;
-	u32 ptype = HFI_PROPERTY_PARAM_PROFILE_LEVEL_CURRENT;
+	u32 profile, level;
 	int ret;
 
 	switch (ctrl->id) {
@@ -52,17 +51,17 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE:
 	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:
 	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:
-		ret = hfi_session_get_property(inst, ptype, &hprop);
+		ret = venus_helper_get_profile_level(inst, &profile, &level);
 		if (!ret)
-			ctr->profile = hprop.profile_level.profile;
+			ctr->profile = profile;
 		ctrl->val = ctr->profile;
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_LEVEL:
 	case V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL:
 	case V4L2_CID_MPEG_VIDEO_VP9_LEVEL:
-		ret = hfi_session_get_property(inst, ptype, &hprop);
+		ret = venus_helper_get_profile_level(inst, &profile, &level);
 		if (!ret)
-			ctr->level = hprop.profile_level.level;
+			ctr->level = level;
 		ctrl->val = ctr->level;
 		break;
 	case V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER:
-- 
2.17.1

