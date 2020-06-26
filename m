Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD28C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1AB12076E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gtJRqCnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgFZIHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbgFZIGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB91BC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:06:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u9so387684pls.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ju0O0uW2865hksycznBHtUgpNV8XHzR5v3KuNKXnRKE=;
        b=gtJRqCnKsJ7/KtReGeGFmX9uU+fkClb7UaCFvZefifel5YcVKVLpWKbR16XTcL0KRi
         SQ+p8Jz/SCeYDidoYtVOAdmKT9XYAGrNT62/6Oue3mSLR//N4fXbDX/Oqff+IujpBrdO
         StyqeprKYLFhaELA+T+86DyaTYfyzKeOH4AEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ju0O0uW2865hksycznBHtUgpNV8XHzR5v3KuNKXnRKE=;
        b=qSvUDeApvAv8wz34BKCUPeoTbW1dMbNVZPEQNOSTVQq47XC1bCU3C4BpmWXXRMCJvd
         IQ0NnlxhFeGCcVz2hhVU0gOZegcW0Z52QDdO2Mpns0opy8ALsvQ1jSf1Ko/tU6+XfE4l
         UdmrRpq131CnsSbSjjeRR9Q2YNjqdz48xoTEkPV+wBbQ+FDy6bBV4Oj0hbcZOLyep6yH
         uqHmEsO/OYi3njuWxeSCExmh6u69UV10aZDioO2idIiPIA9WHKUwBbrQnrepdrYdYuc2
         sZMXZaAMMn4TR5IR1vKwb/sTSsxWchQKiKqcPH2Fqne1xFqZt4UophB2BFrb63ski39U
         L5pw==
X-Gm-Message-State: AOAM532tUP/+9ruIObj/iX17sNp1v+idv+ZMQ/IcXLorRMmBDdZC7sCx
        LQfQP1k9JDAzGRdgAM6vIUzGsg==
X-Google-Smtp-Source: ABdhPJzOkAYsZviFsY47s6Pz1QDXY2VPFW39j2s8prpRXPcCwJzDLMkX9tyA9JPFxd8HTFev1aMWYQ==
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr1669811pll.18.1593158768403;
        Fri, 26 Jun 2020 01:06:08 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id 137sm21809843pgg.72.2020.06.26.01.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 01:06:07 -0700 (PDT)
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
Subject: [PATCH v2 12/18] media: mtk-vcodec: venc: set OUTPUT buffers field to V4L2_FIELD_NONE
Date:   Fri, 26 Jun 2020 17:04:36 +0900
Message-Id: <20200626080442.292309-13-acourbot@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200626080442.292309-1-acourbot@chromium.org>
References: <20200626080442.292309-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A default value of 0 means V4L2_FIELD_ANY, which is not correct.
Reported by v4l2-compliance.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
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
2.27.0.212.ge8ba1cc988-goog

