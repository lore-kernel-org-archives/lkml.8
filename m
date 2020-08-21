Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4504C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8065A20738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="baUyyaPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgHUKiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbgHUKhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:37:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD89DC061388
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:37:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 128so812885pgd.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTmGXWmoAkqQ//i02Xxg3wsdKsf3MX10rBoHCy6DAbE=;
        b=baUyyaPk4NuuofUuSsVJuHgmGDxxanAd0ZY79R+lMaJcZ9CfNOz6gM7k2a/r0LdAUL
         O7FOXH/vRZBl6sFZEa0rbk4P/3LxT0sDb2Wwr/UrVdYmcyznnXe9Th62EW4EUnMRCPTc
         7NyEY1qRj8kFjlNlIthQsFEwMk6uKrSSyZ2O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTmGXWmoAkqQ//i02Xxg3wsdKsf3MX10rBoHCy6DAbE=;
        b=azVvaBtVvB7Eoi7X8TpxoaHT10qaGCp6kgh2DjXDK691TpjkXHX6xWNNOC5ss/3ljv
         6nW2x0L1D/geX+fnWTlBEB6NnEFe1XTN/dIJBnpEPhSdwFujN5vlvwscyxA8b+gt6yTy
         UgNEbMnmoQFfB6X889EyOlsunPawjKH54GkUyOfar3t4zbTzhbwe2DEmJReZB0CakoMc
         RWvdfSWdPLUjKCgciI3azM8VQlgp594EyV1KKSM0X4l+dUg33KTguTXHHlGlHeme9Ewv
         1r4+SF7AcHbcYCgCc3Mu4s2khoaEb20ohqug6a5hBM0k1nNZ5MxnN9xV9YrGNtEmOgnI
         ZZKg==
X-Gm-Message-State: AOAM533BaZw86u4ru+QRdkwYyutQf6Y227jPY8lXnt9csbCz2IwdPDuT
        gxt6tcCNLFVzKGrrW7b8s/gqww==
X-Google-Smtp-Source: ABdhPJyF/baDtWFr/TfueZNpoHPnrddg19+ju6pSWd/HAlX12nToqpklR0u9IZ/HlwBZRtPLTiMw4Q==
X-Received: by 2002:a63:5049:: with SMTP id q9mr1897800pgl.219.1598006236301;
        Fri, 21 Aug 2020 03:37:16 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id y20sm2081525pfn.183.2020.08.21.03.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:37:15 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v4 13/17] media: mtk-vcodec: venc: set OUTPUT buffers field to V4L2_FIELD_NONE
Date:   Fri, 21 Aug 2020 19:36:04 +0900
Message-Id: <20200821103608.2310097-14-acourbot@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821103608.2310097-1-acourbot@chromium.org>
References: <20200821103608.2310097-1-acourbot@chromium.org>
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
2.28.0.297.g1956fa8f8d-goog

