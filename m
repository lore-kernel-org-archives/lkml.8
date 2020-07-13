Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522E3C43460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D0920791
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hhS/XVom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgGMGJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbgGMGJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:09:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EA4C08C5DD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:09:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e18so5584209pgn.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=il4DpcD/apPDl2cTCXc8/jfWcqySO11EC2m8fJv5U88=;
        b=hhS/XVomC66uSGacbR44AJu4XX8RglVUnHbYRQFol+JOwVlyO4zmLPxjZJVS2QAdPG
         f5e0TK74oOqb0gaxzYWjWU7yYwwdWiPjdfvbvDKizkxbdcHPi5xoVRDGXk7gTs4fly6H
         ULSsSLkR05CHdOA7/iNUCTpSeSaZU/O2iRGl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=il4DpcD/apPDl2cTCXc8/jfWcqySO11EC2m8fJv5U88=;
        b=ali3ESZ6ZwIxRXdXCQqn22chABm8fKiHJefPa2fhLoyLk3hqasb+YMTG+UZx8DjCny
         zLUwY5M1CrawPyX4dn3VshTqK3c8YI5/tdtawPcN8hlJPNvt73H0PKDKpEQKOCvYWNTT
         ZT4wOtnl6SWRL3wUYUOaDI6N+WP6j9HfMGmXgb9pWV0Gu8sPpehNReCY2WtGJjYRJQwL
         Vj+7BOm+dXtmr+8uILRK9RYdgxEWf3VhPE7L/paH9jM0YR4Zpa4H6ZFI48OUP8fqILfs
         7rYd5UtbUYR6UVsLNJ3FFxQn0yN+fiN10D6W54+qIE8nAoNLgiaoUbF9eEKw//4ec/HS
         vNeQ==
X-Gm-Message-State: AOAM530oo+6q9RQZ8b46btuXsM7K4M7EXzfzAuZi0PCvq7HQWScY/zCy
        VJuAt0DiZJuCSpeTinipcG+NAQ==
X-Google-Smtp-Source: ABdhPJw4BuEKfXc1u9J80dnCet+O2HF62eLmMroTE4/+eQtDNPiyJisvtCiuH9Xyms3zgoFcD2wLwA==
X-Received: by 2002:a62:1610:: with SMTP id 16mr8378715pfw.113.1594620587680;
        Sun, 12 Jul 2020 23:09:47 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id c134sm13134934pfc.115.2020.07.12.23.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:09:47 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v3 12/16] media: mtk-vcodec: venc: set OUTPUT buffers field to V4L2_FIELD_NONE
Date:   Mon, 13 Jul 2020 15:08:38 +0900
Message-Id: <20200713060842.471356-13-acourbot@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200713060842.471356-1-acourbot@chromium.org>
References: <20200713060842.471356-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A default value of 0 means V4L2_FIELD_ANY, which is not correct.
Reported by v4l2-compliance.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index f833aee4a06f..1a981d842c19 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -893,8 +893,17 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 	ctx->state = MTK_STATE_FREE;
 }
 
+static int vb2ops_venc_buf_out_validate(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+
+	vbuf->field = V4L2_FIELD_NONE;
+	return 0;
+}
+
 static const struct vb2_ops mtk_venc_vb2_ops = {
 	.queue_setup		= vb2ops_venc_queue_setup,
+	.buf_out_validate	= vb2ops_venc_buf_out_validate,
 	.buf_prepare		= vb2ops_venc_buf_prepare,
 	.buf_queue		= vb2ops_venc_buf_queue,
 	.wait_prepare		= vb2_ops_wait_prepare,
-- 
2.27.0.383.g050319c2ae-goog

