Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95325C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75CE721702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajU56Grs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgGUHwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 03:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbgGUHwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 03:52:06 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DF7C0619D7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 00:52:06 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i80so11134732lfi.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PCNLmGR8sMtBYV74iVoiny++gKyFU6QKve9J6ft8KaU=;
        b=ajU56GrsuzhVrOlNfLRWp8gS9xgN5nLCwulEk19YM/GaWszzUOzXZsUttzaFR+kYBd
         a3WblZS8HsXjcOC+06HIMV/LfkYXcZpbGarrKZegHGsFyAEj/801vqo3iMBEB/GbSAfu
         5G8PlNSKeeoRAyWoCTQUtqRvvOpPsdyur+CMiLPDYZyvMhtv9uWYiDmN756EBkuZADpN
         2Kyo38Mvtv/2H8ivHQdBv83rtP1KNSTNZwjTHa0dNZqyXHixtKsGNiZc7WycJks8M/Xe
         Kng05ZGPmPIK/PAuxYzSmLffC8oh+0kR8WmHRM6j5HJg+pSXYsO/xDEvgGfhr+4Xf1tC
         09tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PCNLmGR8sMtBYV74iVoiny++gKyFU6QKve9J6ft8KaU=;
        b=WsDqEezxoTY/ueMzmHo4FMucza/T1t2DNElPddaWclZ8G30Ka25DmcNuQbYAPvJNhD
         S1Aegz969BA1hyTqIwb/ePSZovEgYR3ieeFki/UrQtBy7LwEN8gi4YJcF3AlZ1wIy6H6
         JOZj+W0jIxD8fwbhxtG3QJ1sxC1Fnx6AqmWF1yDU5zZq7STzX71Ouufll/9VUqavBoeF
         zz6X5I6x1ciq1g3+wA/YcK4I4jTKaUsuGFFPFIFK6uDGQsycwWG5905vwHtz73B1B6fR
         bjfulLq/xO2V/5lNKavs6iH9NdM0milVhRMcVdK/UhUwqDKgZDEbJR8hGIZK7fmQkuRG
         BXmg==
X-Gm-Message-State: AOAM530nIVSqRUAymDEyBqtPW3t5TFfIljtbRykxvy86OMaAvLMEFt0y
        rGpTWjXjHK5CwMd+OkzzijGM+A==
X-Google-Smtp-Source: ABdhPJy2qjOFre89D/XJ6t8nL6rNdprR8dDkMF1M23qAA64/hgv3xri/5CIiQNouo4dhr2d7ayG8ww==
X-Received: by 2002:a19:e45:: with SMTP id 66mr9554217lfo.82.1595317924966;
        Tue, 21 Jul 2020 00:52:04 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id d2sm4045334ljg.6.2020.07.21.00.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 00:52:04 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 5/6] media: s5p-mfc: Use standard frame skip mode control
Date:   Tue, 21 Jul 2020 10:45:37 +0300
Message-Id: <20200721074538.505-6-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721074538.505-1-stanimir.varbanov@linaro.org>
References: <20200721074538.505-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard menu control for frame skip mode in the MFC
driver. The legacy private menu control is kept for backward
compatibility.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
index 912fe0c5ab18..3092eb6777a5 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
@@ -261,6 +261,11 @@ static struct mfc_control controls[] = {
 		.menu_skip_mask = 0,
 		.default_value = V4L2_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE_DISABLED,
 	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_FRAME_SKIP_MODE,
+		.maximum = V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_BUF_LIMIT,
+		.default_value = V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_DISABLED,
+	},
 	{
 		.id = V4L2_CID_MPEG_MFC51_VIDEO_RC_FIXED_TARGET_BIT,
 		.type = V4L2_CTRL_TYPE_BOOLEAN,
@@ -1849,6 +1854,7 @@ static int s5p_mfc_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 		p->seq_hdr_mode = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE:
+	case V4L2_CID_MPEG_VIDEO_FRAME_SKIP_MODE:
 		p->frame_skip_mode = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_MFC51_VIDEO_RC_FIXED_TARGET_BIT:
-- 
2.17.1

