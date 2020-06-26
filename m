Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61ADC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A717020836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gM1di/XS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgFZIG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbgFZIGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:20 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2788BC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:06:21 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d12so4009279ply.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F6U2kLLRCj0NVNw/QlFArT2QiCEFka/0C4bkaDQjPqM=;
        b=gM1di/XSYvnZe1PpTYoZ7dmbK5xqrvIjVpb6pD0IL5cxvE1X4a2CDs8/pYofq+9/FG
         LpTplu9ZcMLWF3PXIw80f93CwQ69vPwn6p3MSIq9DuYOx3mi+eH8P8SstoyjxNZE4Y5z
         Yu5WMC7PyeIDZZwUyWbUsiarYd9a84UU0zX9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6U2kLLRCj0NVNw/QlFArT2QiCEFka/0C4bkaDQjPqM=;
        b=XVVgH63RvcQDL+GgJXuIASYGY2LKwaZAIsmFjZSPqsgeTu0NwEkDejlV78/GnY+NQZ
         OIkg1C1BK732fN88lNO/r4TOPQN2+fLrDfsANgzxysuRUyIFB3yl/4LVTHtroqIrvUYC
         iaR0AdZuS/cgTOg2PNnYsJfMHuutokRu8dwDJ4dlwwTjhgc5098iRi5MvvabbcdKWO+O
         ZyzF319sQJvf2IZRRA5ipjoQoePE9rCB8oDR06AswyUyHm9n+54Go3gb5Ety7+olJ1xT
         SLiNYsZ//RwPNnScKN89kZKibagwjY96K2OHvpitcxpns7wTv2TRf/92K69yAGJKV332
         sSxA==
X-Gm-Message-State: AOAM530WPfs41nl0UqKy1KsvAgtetpvatObBMcngkTDnLUifmYOG7/vL
        4q6919gLEa/LDwOi4y725EM8Lg==
X-Google-Smtp-Source: ABdhPJyG5OutRcLxxs/czs3n6d1rqJf8k0E9DH0hoHXoW2R21CXvKW4LIRQcUAye8Aeh/mDbigVRRQ==
X-Received: by 2002:a17:90a:5c85:: with SMTP id r5mr2188895pji.40.1593158780782;
        Fri, 26 Jun 2020 01:06:20 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id 137sm21809843pgg.72.2020.06.26.01.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 01:06:20 -0700 (PDT)
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
Subject: [PATCH v2 16/18] media: mtk-vcodec: venc: make S_PARM return -ENOTTY for CAPTURE queue
Date:   Fri, 26 Jun 2020 17:04:40 +0900
Message-Id: <20200626080442.292309-17-acourbot@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200626080442.292309-1-acourbot@chromium.org>
References: <20200626080442.292309-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4l2-compliance expects ENOTTY to be returned when a given queue does
not support S_PARM.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index aae610e6d4e8..346a33c6869d 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -200,7 +200,7 @@ static int vidioc_venc_s_parm(struct file *file, void *priv,
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
 
 	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
-		return -EINVAL;
+		return -ENOTTY;
 
 	ctx->enc_params.framerate_num =
 			a->parm.output.timeperframe.denominator;
-- 
2.27.0.212.ge8ba1cc988-goog

