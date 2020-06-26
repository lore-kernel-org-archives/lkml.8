Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A884C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D3B20857
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f8w7ucx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgFZIGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbgFZIGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD2CC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:06:05 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e9so4615907pgo.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sui+aE36W22DqtS2fgsG54iRuVi4BhJkSmMBR5vkIvo=;
        b=f8w7ucx1BwENgxJR/Rc1pSalVXftgwFc0KkcZbAs/TcppB9xRQDLPkJNPWLBHngmxf
         +I/rAXJjvWJX37+ZaQHg0f1px3DVH8/oo6ANHkBcm9F3LrqCUIkTvKyMC78TcLHx02lB
         YSwHRp+hLpwilQul5ijJegqktK8N6qIeJ+TPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sui+aE36W22DqtS2fgsG54iRuVi4BhJkSmMBR5vkIvo=;
        b=hAxiKvhkWQdomk+fRJKETZKts2GNkFcahW/Vvr+jC4m96C+WgSXhA9DJ7QbU9JftvO
         tqtLftZxCoLgKAkpFH+VwntDwbn/1VxNwXzn0Kte/K3esgAmmBPz9jyXP6Jj5g5AlGW4
         umrwjdVrmp7anNWqgzL8YignDpsK346ETHjuEv1pilEMHMIMNwL0dGrmdw4DALQS3EQX
         OackPByi1+5RgV67nC9EKLY6qOzwAj9eVTJc5TCccDI0bzQua3f8fNQWfSwCK8ebpn4O
         JNseQWHx/KRBEEy5znJz++GenQ0X2kQx3LszRQD2dzOlg7uvOpjmh93aTMOHjtWBhcCP
         uofA==
X-Gm-Message-State: AOAM531cijg+YnRc/FDWHzAx9PxBeZ8JzqKjtqFvmVbxhtRk3gDy1CKO
        D/wlDIzxZOWBFhFPAJbuH2jPgg==
X-Google-Smtp-Source: ABdhPJzZ7MWGk9jvC+DPhRc7+KTbwzgKCEciabh8q+jgkASL1WbRsleAMj3y90vF2Ou1wTEbTB2X+Q==
X-Received: by 2002:aa7:8dc1:: with SMTP id j1mr1625300pfr.194.1593158765373;
        Fri, 26 Jun 2020 01:06:05 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id 137sm21809843pgg.72.2020.06.26.01.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 01:06:04 -0700 (PDT)
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
Subject: [PATCH v2 11/18] media: mtk-vcodec: venc support MIN_OUTPUT_BUFFERS control
Date:   Fri, 26 Jun 2020 17:04:35 +0900
Message-Id: <20200626080442.292309-12-acourbot@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200626080442.292309-1-acourbot@chromium.org>
References: <20200626080442.292309-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This control is required by v4l2-compliance for encoders. A value of 1
should be suitable for all scenarios.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index f2ba19c32400..f833aee4a06f 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -1206,6 +1206,8 @@ int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 
 	v4l2_ctrl_handler_init(handler, MTK_MAX_CTRLS_HINT);
 
+	v4l2_ctrl_new_std(handler, ops, V4L2_CID_MIN_BUFFERS_FOR_OUTPUT,
+			  1, 1, 1, 1);
 	v4l2_ctrl_new_std(handler, ops, V4L2_CID_MPEG_VIDEO_BITRATE,
 			  ctx->dev->venc_pdata->min_bitrate,
 			  ctx->dev->venc_pdata->max_bitrate, 1, 4000000);
-- 
2.27.0.212.ge8ba1cc988-goog

