Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE70CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA662082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AeFZoIN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgFZIHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbgFZIGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:23 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A680C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:06:24 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w2so3823153pgg.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/SQkaIkQYThWAWodZ31ujagTBZlI1iDzzrB4vJVM6s=;
        b=AeFZoIN/fr4cIMvuYSHhq5dGMtYtBpPIl51KTcus8jLUWyrsd3bW/QasAwLiUnyKVY
         XZpKXuglmID8LOTPDjHjFNu2TwHeN1HZkNaV3zQfD9hr5pTYjtzScffE2nRLKxx6ik91
         TzRISkAX1ZMMqV6aGLGPlhHGNAFPFkw14UNIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/SQkaIkQYThWAWodZ31ujagTBZlI1iDzzrB4vJVM6s=;
        b=nUHcuC9BXn2ZW/o9VoVj3lrBtNptKhmqn34EbNzt0fKnl40dDlFHNtDzeD7it6j4Mx
         FH2rk0+TmtRrgJeQdVngLllaP2GqbAHxBSUG03vceTN5e64kZ3W9xpXMEwBpbrim3d9C
         AtlrsmwXVqwhvnj1qHDRRkh4C+Qgp8nzJVbnDP22l8jXYkCvDkDmuC03kvuraoz0P8aT
         4ifI1sosO/9G9MDTugUb8P9jhJbxAOWXJvznKYF8v9ODgtcC8SzgepB2Dbebt9JmibOY
         065gc329mMeyCmzKNnAJJYEnJuTI9aqmoxldfXb4QFmdYo5mZmuy09gTHzTL1xPdCbbS
         XtSQ==
X-Gm-Message-State: AOAM532EZoyzvbqHyG2qrIwOzUqwXOgQ95ErMNYH/4N6NaapGb5aT/4A
        kKCOb28KwqTiWWvf2Do37FygnQ==
X-Google-Smtp-Source: ABdhPJzcGcfKhOrU39qKlXLmxNs5YJdjrelLysgC2xeVATizxK3iWSsOEOtEmDWKAZT2UkkJEJdMbA==
X-Received: by 2002:a63:9246:: with SMTP id s6mr1658143pgn.22.1593158783791;
        Fri, 26 Jun 2020 01:06:23 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id 137sm21809843pgg.72.2020.06.26.01.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 01:06:23 -0700 (PDT)
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
Subject: [PATCH v2 17/18] media: mtk-vcodec: venc: set default time per frame
Date:   Fri, 26 Jun 2020 17:04:41 +0900
Message-Id: <20200626080442.292309-18-acourbot@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200626080442.292309-1-acourbot@chromium.org>
References: <20200626080442.292309-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time per frame was left initialized to 0/0, which make the driver
fail v4l2-compliance, and also leaves it potentially exposed to doing a
division by zero.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 346a33c6869d..c9756a4748ef 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -24,6 +24,9 @@
 #define DFT_CFG_HEIGHT	MTK_VENC_MIN_H
 #define MTK_MAX_CTRLS_HINT	20
 
+#define MTK_DEFAULT_FRAMERATE_NUM 1001
+#define MTK_DEFAULT_FRAMERATE_DENOM 30000
+
 static void mtk_venc_worker(struct work_struct *work);
 
 static const struct v4l2_frmsize_stepwise mtk_venc_framesizes = {
@@ -1199,6 +1202,8 @@ void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx)
 		DFT_CFG_WIDTH * DFT_CFG_HEIGHT;
 	ctx->q_data[MTK_Q_DATA_DST].bytesperline[0] = 0;
 
+	ctx->enc_params.framerate_num = MTK_DEFAULT_FRAMERATE_NUM;
+	ctx->enc_params.framerate_denom = MTK_DEFAULT_FRAMERATE_DENOM;
 }
 
 int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx)
-- 
2.27.0.212.ge8ba1cc988-goog

