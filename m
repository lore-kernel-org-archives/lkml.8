Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DBEC433FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76EC922B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLYbNeJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgGTNYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgGTNYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:24:19 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BB9C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:24:18 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b11so7284919lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PCNLmGR8sMtBYV74iVoiny++gKyFU6QKve9J6ft8KaU=;
        b=YLYbNeJbyBIaAQ8rb/3znbvrfWAkG4bvqP1j/gNRpW2GRjAqCS3c57lHyprI9vcUVy
         CFYb6/y0MWLSE9CSw6JnkGdtlKiGuenOa6djBdXOcXB5EZe4wJ/G7oXvQ7cCPaNamTef
         cnXYLGAHpAjq/bOaUfi4sP9VWdQu3vzn/aG6Fjt2+/ybVS/Cf4NRtH/7inpbltWwLXvx
         9M9lYOOvRcrBJ++S/+qt8xMlSOTOCTGXb83x40QVyzfzokshHKrV6DUZODmIrA9GXWim
         bMophe4N3uJwQBu0Sr/9uv2THyxTHEDF5bsZ6Dd3yM9YBKQwikBqCqYtNwc9pWARjKHq
         vGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PCNLmGR8sMtBYV74iVoiny++gKyFU6QKve9J6ft8KaU=;
        b=Gza1AP6m0AcFTT+knaGyS1ltdCEjHJ6Uhd4pY2dtx+VaLG/0MoeDX34yfpgH+LIS38
         NZibvMyWxqxgeAqOFSi8VVq/0naWsCvuFghizpOkA/ZENjr8AsA7sOMiV/bS3uckyFrS
         s2DXRpKbCzSXTbrrTqSnEZE1UfO1ChasrUWmSCKarxtytVyre0F/VqnI1NKn60aub+sG
         /EeSInytLVwog96CGk2g6WLsxr27btH8CMTLHdIiSNUZDqSp5wncAOY6EgCDUmXW44It
         cnIrozj4CYu53t5YwIpRpSdB5aAAGzmuNOmi/8/1Tbtp1kTbminf8gFfUtGjBYWDCfGl
         /nOA==
X-Gm-Message-State: AOAM530BOBnirSMRkG2V6uT2mUeWinkXF/zvxFAZqgPdpc4cRD3mVCiI
        Aeiaiengc8JKgDAsf6P1uhDR4g==
X-Google-Smtp-Source: ABdhPJytG2Zgu+Ki97e5vuTKx8cSPSuv8MmaZXlz3NwLFdPuLR5QOLyNERbVvYpBHWPXrKtnKiUjVg==
X-Received: by 2002:a19:f80e:: with SMTP id a14mr811645lff.49.1595251457123;
        Mon, 20 Jul 2020 06:24:17 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id h6sm867829lfc.84.2020.07.20.06.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 06:24:16 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 5/6] media: s5p-mfc: Use standard frame skip mode control
Date:   Mon, 20 Jul 2020 16:23:12 +0300
Message-Id: <20200720132313.4810-6-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200720132313.4810-1-stanimir.varbanov@linaro.org>
References: <20200720132313.4810-1-stanimir.varbanov@linaro.org>
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

