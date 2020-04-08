Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CECC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC322082D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t31m+68I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgDHVeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:34:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41614 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730725AbgDHVeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:34:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id n17so9266089lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 14:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mt9OBIj0ykBafNH/9trvGlSeMEJzqQmkZCMhh/GB4oU=;
        b=t31m+68I3U983sirf6zcS6e9xeVWoUaxTp9krnrbio2KDHZgVrxIe7uqLphilktHFp
         MDx7Az0j+gxYhyBpKNXOp8Hro+V700/mS+ZDDkuVx63BrbFJvFe/hllVStC81XRcfPxM
         jNfIu8ewZKQbxq0la02ESkd7HPjGJepHLioqqkhi7ebGAvJhTaOpZJ10dTG/DVKpWVwf
         0AqLpPgggy9xqRHuGe8vJSGuAk1AxZJORxF4iKgmytx+oDE2X7ubCnyxKl8Ag5J6hv9a
         i0Turjc0XfnaDZIepqUsut6p/CwiC9OlZ2UnhUNuPJ4BcSqD61k2Ile6WKCnaX3SeZij
         upWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mt9OBIj0ykBafNH/9trvGlSeMEJzqQmkZCMhh/GB4oU=;
        b=bxznbnlo8XtpIHe3tjZvbhE1l10H15w+lSPxdZ3S2WPeSavyhkIWLpka5O/WDMh2kq
         aSaUyPR0vZrOPFrDD29B4gNajKQABps3vzy999rN+UsZQmFTqxy0ifCNVsPv10VvU9nQ
         JPg/UmCNCq6M3TLKS8uZX7KRWEhd1U7U2RLGdMw1+kyLVuDhcxdma03rxbtCp8pKsBH0
         2TY0MYI/scUWEA5lzrK3gYCkqroURLnx7IEr2HRGOIZSekrrFMLY1oTM2Q3DE2D3kEfR
         34F0YMRLV6nkNWQv2W7cdA/JwbTw7jkCibjolnYNfbW670TfynW9sI1rbqJ7UGVCyKOh
         ZU9w==
X-Gm-Message-State: AGi0PuYi/nHYnzQaLnzPAOOSnpiwO4yXErZwnS7f9+nNy5jy+Wp+tJ0q
        i+rxAYBruQY0tk2UpxBRA7lzDg==
X-Google-Smtp-Source: APiQypLFbtG20kBPRjrMvbSnxkPIJuRxVgxuATQnnRzzI6NprTKvBrrkBcaA+fi4G4LdQEEFQ/QWSg==
X-Received: by 2002:a2e:8e3a:: with SMTP id r26mr6347426ljk.233.1586381645983;
        Wed, 08 Apr 2020 14:34:05 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-138.ip.btc-net.bg. [212.5.158.138])
        by smtp.gmail.com with ESMTPSA id t6sm15746688lfb.55.2020.04.08.14.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:34:05 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 4/7] venus: helpers: Done buffers per queue type
Date:   Thu,  9 Apr 2020 00:33:27 +0300
Message-Id: <20200408213330.27665-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408213330.27665-1-stanimir.varbanov@linaro.org>
References: <20200408213330.27665-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently calling venus_helper_buffers_done() will return buffers to
user for both capture and output queues in the same call. This is
wrong because both queues are really separate and calling
stop_streaming on one queue shouldn't return buffers for the other.
Solve this by add a new queue type argument and fix the clients of
the helper function.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 18 ++++++++++++------
 drivers/media/platform/qcom/venus/helpers.h |  2 +-
 drivers/media/platform/qcom/venus/vdec.c    |  5 ++---
 drivers/media/platform/qcom/venus/venc.c    |  2 +-
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index bcc603804041..0143af7822b2 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -1129,15 +1129,18 @@ void venus_helper_vb2_buf_queue(struct vb2_buffer *vb)
 }
 EXPORT_SYMBOL_GPL(venus_helper_vb2_buf_queue);
 
-void venus_helper_buffers_done(struct venus_inst *inst,
+void venus_helper_buffers_done(struct venus_inst *inst, unsigned int type,
 			       enum vb2_buffer_state state)
 {
 	struct vb2_v4l2_buffer *buf;
 
-	while ((buf = v4l2_m2m_src_buf_remove(inst->m2m_ctx)))
-		v4l2_m2m_buf_done(buf, state);
-	while ((buf = v4l2_m2m_dst_buf_remove(inst->m2m_ctx)))
-		v4l2_m2m_buf_done(buf, state);
+	if (type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		while ((buf = v4l2_m2m_src_buf_remove(inst->m2m_ctx)))
+			v4l2_m2m_buf_done(buf, state);
+	} else if (type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
+		while ((buf = v4l2_m2m_dst_buf_remove(inst->m2m_ctx)))
+			v4l2_m2m_buf_done(buf, state);
+	}
 }
 EXPORT_SYMBOL_GPL(venus_helper_buffers_done);
 
@@ -1168,7 +1171,10 @@ void venus_helper_vb2_stop_streaming(struct vb2_queue *q)
 		INIT_LIST_HEAD(&inst->registeredbufs);
 	}
 
-	venus_helper_buffers_done(inst, VB2_BUF_STATE_ERROR);
+	venus_helper_buffers_done(inst, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+				  VB2_BUF_STATE_ERROR);
+	venus_helper_buffers_done(inst, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+				  VB2_BUF_STATE_ERROR);
 
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		inst->streamon_out = 0;
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index b64875564064..8fbbda12a4fe 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -14,7 +14,7 @@ struct venus_core;
 bool venus_helper_check_codec(struct venus_inst *inst, u32 v4l2_pixfmt);
 struct vb2_v4l2_buffer *venus_helper_find_buf(struct venus_inst *inst,
 					      unsigned int type, u32 idx);
-void venus_helper_buffers_done(struct venus_inst *inst,
+void venus_helper_buffers_done(struct venus_inst *inst, unsigned int type,
 			       enum vb2_buffer_state state);
 int venus_helper_vb2_buf_init(struct vb2_buffer *vb);
 int venus_helper_vb2_buf_prepare(struct vb2_buffer *vb);
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index e8e1ecf7cf4a..7d093accbd59 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1044,7 +1044,7 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 put_power:
 	vdec_pm_put(inst, false);
 error:
-	venus_helper_buffers_done(inst, VB2_BUF_STATE_QUEUED);
+	venus_helper_buffers_done(inst, q->type, VB2_BUF_STATE_QUEUED);
 	mutex_unlock(&inst->lock);
 	return ret;
 }
@@ -1071,7 +1071,6 @@ static int vdec_stop_capture(struct venus_inst *inst)
 		break;
 	case VENUS_DEC_STATE_DRC:
 		ret = hfi_session_flush(inst, HFI_FLUSH_OUTPUT);
-		vdec_cancel_dst_buffers(inst);
 		inst->codec_state = VENUS_DEC_STATE_CAPTURE_SETUP;
 		INIT_LIST_HEAD(&inst->registeredbufs);
 		venus_helper_free_dpb_bufs(inst);
@@ -1117,7 +1116,7 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 	else
 		ret = vdec_stop_output(inst);
 
-	venus_helper_buffers_done(inst, VB2_BUF_STATE_ERROR);
+	venus_helper_buffers_done(inst, q->type, VB2_BUF_STATE_ERROR);
 
 	if (ret)
 		goto unlock;
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 9981a2a27c90..3d8431dc14c4 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1018,7 +1018,7 @@ static int venc_start_streaming(struct vb2_queue *q, unsigned int count)
 deinit_sess:
 	hfi_session_deinit(inst);
 bufs_done:
-	venus_helper_buffers_done(inst, VB2_BUF_STATE_QUEUED);
+	venus_helper_buffers_done(inst, q->type, VB2_BUF_STATE_QUEUED);
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		inst->streamon_out = 0;
 	else
-- 
2.17.1

