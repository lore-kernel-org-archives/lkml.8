Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415CFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E71206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mb0vm7TH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgETI2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgETI17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:27:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74679C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:27:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so913244pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ac7V/sUfRNLpfMuOaTpdWcguR6PzK7tIy5O2XB2td3o=;
        b=mb0vm7THmbMkGIlT+BNV0Bdzt1EA5w/RCS6CHt4KC/+sQTXBdtcjiA3Q42mDlecffi
         xp5pybxLQn//gWp2qvkUNFotnb/QzwLoYdwkA5Bjiaxs34eBcCJ8mulwRWyIeDBGgsMf
         lS6Lm/MXj5NCeJTXxjiEWta1ylKRXrQw2m/CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ac7V/sUfRNLpfMuOaTpdWcguR6PzK7tIy5O2XB2td3o=;
        b=LczdcrLS5qTEocjOeCU1/73Guc/711pqC8w94HRG3v1f4Qel9Pbfvbye0srtxYaRx9
         b0RBxYZjr+heGJ0SCkwa0cexASgqOeImY75oT4poyweuv6UJdGpC6NV+mPb7GbFCUbwj
         QzOmNw7bxPNTqypvWt5Fz9E8yvwOliu+P9//i79I08AcJFKyhJIg2dBChsaySQO2IGGb
         n1qVdXYiiUOhwZA7XA9CpYEcqvMrp01feVO0YK2ivD2ZDw/jnBU5EeCb5X8q68xVYjq3
         nQGsvR30K7rEFKJPKd+DMjF519s3nUuLmvOs3rnbPT6o3+PY1UQLXzyjfLl5wSk2ZPoY
         RjRA==
X-Gm-Message-State: AOAM5334uwrB03/x9EoT3wPdbRi7eB2o3o2w3dxejrkheveYEWCQ2pQj
        0GWnBIB3MHzmG14G4tBd/vGsbQ==
X-Google-Smtp-Source: ABdhPJzu7eB23OTwyBGbvS8Qm1mtpFj6KgSq8osEOzgiMFnzgKjLmUcoUhObMrSrUqAHbCvzHIG19A==
X-Received: by 2002:a17:90a:150:: with SMTP id z16mr4175297pje.37.1589963279012;
        Wed, 20 May 2020 01:27:59 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id gg8sm1447775pjb.39.2020.05.20.01.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 01:27:58 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rui Wang <gtk_ruiwang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH 05/10] media: mtk-vcodec: venc: specify bitrate range per-chip
Date:   Wed, 20 May 2020 17:27:18 +0900
Message-Id: <20200520082723.96136-6-acourbot@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
In-Reply-To: <20200520082723.96136-1-acourbot@chromium.org>
References: <20200520082723.96136-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different chips have different supported bitrate ranges. Move the min
and max supported bitrates to the platform data.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h     | 4 ++++
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c     | 3 ++-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index e7b155e7432e..b8f913de8d80 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -311,12 +311,16 @@ enum mtk_chip {
  *
  * @uses_ext: whether the encoder uses the extended firmware messaging format
  * @has_lt_irq: whether the encoder uses the LT irq
+ * @min_birate: minimum supported encoding bitrate
+ * @max_bitrate: maximum supported encoding bitrate
  */
 struct mtk_vcodec_enc_pdata {
 	enum mtk_chip chip;
 
 	bool uses_ext;
 	bool has_lt_irq;
+	unsigned long min_bitrate;
+	unsigned long max_bitrate;
 };
 
 /**
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index d469ff6464b2..50ba9da59153 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -1232,7 +1232,8 @@ int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 	v4l2_ctrl_handler_init(handler, MTK_MAX_CTRLS_HINT);
 
 	v4l2_ctrl_new_std(handler, ops, V4L2_CID_MPEG_VIDEO_BITRATE,
-			1, 4000000, 1, 4000000);
+			  ctx->dev->venc_pdata->min_bitrate,
+			  ctx->dev->venc_pdata->max_bitrate, 1, 4000000);
 	v4l2_ctrl_new_std(handler, ops, V4L2_CID_MPEG_VIDEO_B_FRAMES,
 			0, 2, 1, 0);
 	v4l2_ctrl_new_std(handler, ops, V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE,
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index c1365209263e..221fa0303075 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -380,6 +380,8 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 static const struct mtk_vcodec_enc_pdata mt8173_pdata = {
 	.chip = MTK_MT8173,
 	.has_lt_irq = true,
+	.min_bitrate = 1,
+	.max_bitrate = 4000000,
 };
 
 static const struct of_device_id mtk_vcodec_enc_match[] = {
-- 
2.26.2.761.g0e0b3e54be-goog

