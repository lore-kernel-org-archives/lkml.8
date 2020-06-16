Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F6CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CB8208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gy3NOO0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgFPUPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731679AbgFPUPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:15:45 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868B9C061794
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:15:43 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m21so97276eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AZqdoAEGz2z2dhDjwXWaMZ24wdl6oc5L+Rca1tEh8dc=;
        b=gy3NOO0TVFbQO8JeVz50/yi9A6AS7UoNAvAWS0yUYYqBasL4KYmzd6LX0YSCcoYzih
         WZAXIMLWxXdlpY/bvSoQGSycZqpuRHWIneQo9OcdzFjNUomCLSSqIOPp+mszgZqoPk58
         11vlXMHdE8MlJ4HgS2M268UOIQg/vg94l2gEPrHYgzwAlfNPcT+aLo+uzZqgkLwSOejQ
         7pTvUWtbeRhK8owv8gttck7ySAvgy2te3vvK1RRACY0AitSSke1l+HqJN1XmObrNj9pk
         9Gt8EA3JTwxuKVwPRdbirVeQDhKiVXmFX2yjEqB5roJ5YX8jD5XeOYouqsyg4Mbq/taa
         zXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AZqdoAEGz2z2dhDjwXWaMZ24wdl6oc5L+Rca1tEh8dc=;
        b=raF3bcDrstnQ3CdA06cd0HoYELiKataWINYzKlYHszvWYTp+cQEzjpM0nfuG7zdGaQ
         myFqr3ODFr/MBd1VwAXwB90XCRpPyWewj4qPnaM6i4yGy635aagORxPJq3rpsVMvAy2f
         U4vbRYStVqaD2gJ4J3mA8ARmDR3vR352eooblEJbERNBV5lqpjaPJpHT2XMpdJQ80gO9
         qM93NOgh2PWUF1y+tZiyc5vfqbIbjIEvpKz9bMgddB0iJWSPC0TMyjmS7CaLVeIHssGn
         K91dgPgJU9WHMXNw3iKSS+JeBvpT32NI0RB5sOJpgpehc5HcMQwwqap6d+r1j90yAmWT
         1f4w==
X-Gm-Message-State: AOAM530qDJrV810O2Psmk0st9p6wmHtW2NYJSFp9bpGRJ6hFSL//rPdL
        S5IyyHCn/+Bpc6u8Mmp7wRzf/0D+7yjM6Q==
X-Google-Smtp-Source: ABdhPJxIsyuMwyfFK+YWY/8UN0ykI79Dmd+IfHF88uSKNdHy2vmbGNi43R1JVapD/sonJonUkmDEIg==
X-Received: by 2002:aa7:da8c:: with SMTP id q12mr4234503eds.385.1592338542217;
        Tue, 16 Jun 2020 13:15:42 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-38.ip.btc-net.bg. [212.5.158.38])
        by smtp.gmail.com with ESMTPSA id b14sm11602658ejq.105.2020.06.16.13.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 13:15:41 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 4/4] venus: vdec: Add support for decode intra frames only
Date:   Tue, 16 Jun 2020 23:14:46 +0300
Message-Id: <20200616201446.15996-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616201446.15996-1-stanimir.varbanov@linaro.org>
References: <20200616201446.15996-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support in the decoder for intra frames only decode. The
implementation in the Venus use HFI property for thumbnail
generation to lower memory usage and when the control is enabled
the number of decoder output buffers for progressive stream
will be one (for interlace two). We assume that the client will
queue on the decoder input intra frames only but this is not
mandatory. If the client queue non-intra frames on decoder input
they will be returned on decoder output with an error.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h       | 1 +
 drivers/media/platform/qcom/venus/vdec.c       | 7 +++++++
 drivers/media/platform/qcom/venus/vdec_ctrls.c | 9 ++++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 1bac30d4cf50..b9a3b9ca6ae1 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -191,6 +191,7 @@ struct vdec_controls {
 	u32 post_loop_deb_mode;
 	u32 profile;
 	u32 level;
+	bool intra_only;
 };
 
 struct venc_controls {
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 7c4c483d5438..aa68cefcae96 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -625,6 +625,13 @@ static int vdec_set_properties(struct venus_inst *inst)
 			return ret;
 	}
 
+	if (ctr->intra_only) {
+		ptype = HFI_PROPERTY_PARAM_VDEC_THUMBNAIL_MODE;
+		ret = hfi_session_set_property(inst, ptype, &en);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/media/platform/qcom/venus/vdec_ctrls.c b/drivers/media/platform/qcom/venus/vdec_ctrls.c
index 3a963cbd342a..96ca8d9dd22e 100644
--- a/drivers/media/platform/qcom/venus/vdec_ctrls.c
+++ b/drivers/media/platform/qcom/venus/vdec_ctrls.c
@@ -28,6 +28,9 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL:
 		ctr->level = ctrl->val;
 		break;
+	case V4L2_CID_MPEG_VIDEO_DECODE_INTRA_FRAMES_ONLY:
+		ctr->intra_only = ctrl->val;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -86,7 +89,7 @@ int vdec_ctrl_init(struct venus_inst *inst)
 	struct v4l2_ctrl *ctrl;
 	int ret;
 
-	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 7);
+	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 8);
 	if (ret)
 		return ret;
 
@@ -141,6 +144,10 @@ int vdec_ctrl_init(struct venus_inst *inst)
 	if (ctrl)
 		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
 
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &vdec_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_DECODE_INTRA_FRAMES_ONLY,
+			  0, 1, 1, 0);
+
 	ret = inst->ctrl_handler.error;
 	if (ret) {
 		v4l2_ctrl_handler_free(&inst->ctrl_handler);
-- 
2.17.1

