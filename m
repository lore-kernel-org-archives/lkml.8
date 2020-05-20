Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536A5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32833206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kma0Y327"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgETI2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgETI2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:28:05 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB57C05BD43
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:28:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id a13so1020823pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/LfOfRQ1BQiwphHrNRte6xw/jEYRf+xz3oVTVJPPG2I=;
        b=kma0Y327Haqr7NQBAqM02NV6gKGJitb40eCxnMZm2FrKpq41cEwYS+lyzibfqdMWik
         w24DvxRBEmGxKioRETpD0bt8cQkeXHl0SBrOvv/rmMAK4t2/vCxn3x2leTbDBbevNZ1W
         KvGxgBM5JR3rOzCILBJONf9fsWPqU4205zxNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/LfOfRQ1BQiwphHrNRte6xw/jEYRf+xz3oVTVJPPG2I=;
        b=A4n26eYt6msx7PyIP0UzoLtmsOgsCR5nrs75U0jkyDZkcupKCckEvGH8/EwlV6Bu0V
         Anj9GjP8ZIyae6H+MMon91il6T6dROte+7R9RJLqlOpI3bwC+WWxMRlWM3eW9hjoq9Td
         nAPaEork8obgvmbhITQ1sNEZD61cteI5+EmENGgovR+D6GJnBRFrIT527hgKD057ika7
         txYHTG1NCAGeIWyK6S40cG8nexF9EfDvprVxNe5oYKyyIxWOzidHWDHiRXvYb++raKy/
         9Wpts3q+fprcQMxhvVNSNqXFgXfNf3x58osTErRS2/BiWUWF5FObNXUzS8rV91x+qLCG
         le0g==
X-Gm-Message-State: AOAM532leKj9kw3FeaAgH+uIcPFt4iGGvCePC/hpD/hSjPq6aWObq6de
        PcerjbDQemSsRZgqQx2v/kYTBg==
X-Google-Smtp-Source: ABdhPJzfHlsA4AU1IC84+T8wm6dXklFNwcq+ZgPisV0Y/ZadLwFlgQTchs4DKWy322j4P3LiBQROSQ==
X-Received: by 2002:a17:902:684f:: with SMTP id f15mr3537657pln.237.1589963285367;
        Wed, 20 May 2020 01:28:05 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id gg8sm1447775pjb.39.2020.05.20.01.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 01:28:04 -0700 (PDT)
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
Subject: [PATCH 07/10] media: mtk-vcodec: venc: remove redundant code
Date:   Wed, 20 May 2020 17:27:20 +0900
Message-Id: <20200520082723.96136-8-acourbot@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
In-Reply-To: <20200520082723.96136-1-acourbot@chromium.org>
References: <20200520082723.96136-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vidioc_try_fmt() does clamp height and width when called on the OUTPUT
queue, so clamping them prior to calling this function is redundant. Set
the queue's parameters after calling vidioc_try_fmt() so we can use the
values it computed.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 .../media/platform/mtk-vcodec/mtk_vcodec_enc.c   | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 05743a745a11..f0af78f112db 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -449,7 +449,6 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
 	struct mtk_q_data *q_data;
 	int ret, i;
 	const struct mtk_video_fmt *fmt;
-	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
 
 	vq = v4l2_m2m_get_vq(ctx->m2m_ctx, f->type);
 	if (!vq) {
@@ -474,20 +473,13 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
 		f->fmt.pix.pixelformat = fmt->fourcc;
 	}
 
-	pix_fmt_mp->height = clamp(pix_fmt_mp->height,
-				MTK_VENC_MIN_H,
-				MTK_VENC_MAX_H);
-	pix_fmt_mp->width = clamp(pix_fmt_mp->width,
-				MTK_VENC_MIN_W,
-				MTK_VENC_MAX_W);
-
-	q_data->visible_width = f->fmt.pix_mp.width;
-	q_data->visible_height = f->fmt.pix_mp.height;
-	q_data->fmt = fmt;
-	ret = vidioc_try_fmt(f, q_data->fmt);
+	ret = vidioc_try_fmt(f, fmt);
 	if (ret)
 		return ret;
 
+	q_data->fmt = fmt;
+	q_data->visible_width = f->fmt.pix_mp.width;
+	q_data->visible_height = f->fmt.pix_mp.height;
 	q_data->coded_width = f->fmt.pix_mp.width;
 	q_data->coded_height = f->fmt.pix_mp.height;
 
-- 
2.26.2.761.g0e0b3e54be-goog

