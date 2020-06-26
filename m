Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D106AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1CD62076E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mVW/w9EZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgFZIGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbgFZIGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CDAC08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:06:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id m2so4625927pjv.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yhsc5/BUf/rFJ1jmIyJumR2Pa1+ibsatUEuysY587tw=;
        b=mVW/w9EZZM2gM29UIWmTj5kifZrnNr/AGahncLj2c1rD4kIL0j54MCHg7/IjDa+M4o
         CyoT5V0ch6z/f2vnShvOAbZGcJXVbjAzj5nWmUbSKFVm1OGOeKEwUV7eI0H6BXguljsJ
         t7eElD7Wu43wMxC0C5FQCal0yh5spWDkPmnPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yhsc5/BUf/rFJ1jmIyJumR2Pa1+ibsatUEuysY587tw=;
        b=QQGwmne27ntA8gwPkSH63yvyWqaNmXJYOaKantlgRn5rxKTX2nYkGSwj/BpLjQPxOm
         Pa70vzbSx6ZooqQ/z75FcxeI1P04QLZXEe6MJ6V0oCsDDhNsyecmiUHdgdO+1MU7N8l/
         1ZDzicD0qWyr2VWYohM5yhcc1+QjBmdGw6xrvbiRIungSW0vkr4I3EjHiL5AkYFdkyb4
         +9/Al+wp6vzCBEKukhqxaEzPM6L30M5RxnO8uwG1GX9CAdF4ooy2It+pMLLWh0X2wnTM
         RoG/U9anwcM0URiqXkn4TBhUbBL3XgvkVbJ2ZwPSuejXiuHOz+RwQ6W8y1mwwHYwMi8t
         iocA==
X-Gm-Message-State: AOAM5301ZgHhRpc3ItEbfw6//v4emO91v3fGU5FVeHN04e5Fx878EbTd
        7b9NieUsY22vKgCJTpaN8cubpg==
X-Google-Smtp-Source: ABdhPJzdWYD3IizlnYuYZNEJGr/sH0TUNx37MN3eJzxNFXZl1S8sJE0ynLh2SdmqqaMrRIj84W4sFg==
X-Received: by 2002:a17:90a:3749:: with SMTP id u67mr2045818pjb.129.1593158777720;
        Fri, 26 Jun 2020 01:06:17 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id 137sm21809843pgg.72.2020.06.26.01.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 01:06:17 -0700 (PDT)
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
Subject: [PATCH v2 15/18] media: mtk-vcodec: venc: support G_PARM on CAPTURE queue
Date:   Fri, 26 Jun 2020 17:04:39 +0900
Message-Id: <20200626080442.292309-16-acourbot@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200626080442.292309-1-acourbot@chromium.org>
References: <20200626080442.292309-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4l2-compliance requires this.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 6cef61cb7883..aae610e6d4e8 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -218,7 +218,8 @@ static int vidioc_venc_g_parm(struct file *file, void *priv,
 {
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
 
-	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE &&
+	    a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
 		return -EINVAL;
 
 	a->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
-- 
2.27.0.212.ge8ba1cc988-goog

