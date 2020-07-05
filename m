Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709ACC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 12:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EADA20739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 12:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/7rA4K4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgGEMMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 08:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgGEMMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 08:12:08 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9191CC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 05:12:08 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n2so23105895edr.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PCNLmGR8sMtBYV74iVoiny++gKyFU6QKve9J6ft8KaU=;
        b=K/7rA4K4EI8hH3WgLD9Nf1fvOjaQ2N3MAe9A9/Q+DJx/2ssL1Qe4HiABlOUCSkqgWw
         JAlYHMnQbaZkFA1GCxToq1heUQvMw4zBb1asjEsuCMT7CyN/hpN4eFNbkGR3uMO6NVyV
         KmSWfYWLxCVEipYByTksOCBLMyMtwvaLO1xmibJFqSdDo45h5/2bNFh7mE8epKXLn5M1
         UX7W4uTFx38idvXGt1L1olIZTTv3YXLtyeqTNxrJ8rbQseZwicHF6JvvrMkldIazkioa
         +UObmDI13lhx1SB+NXQBsWu/Qh7Wqe2DblVQ2aOiUw5R3qu1kb/QSyoQMo42cXONv2Oz
         A1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PCNLmGR8sMtBYV74iVoiny++gKyFU6QKve9J6ft8KaU=;
        b=UaOkgD+bvOw2aRxNBMnlkS6mOLXMC6P2qWaJtqTxEYi2ixJitE3CJe53WFPOnHBnNE
         tgiGGwfa6w7woStYHIfnvum7K+VnVMx3666TC0KH73FY90GO+CpxnbZ9w1IlCmKi41ee
         BjltN+CW+0ngeHIOPOQwuYkpFdOZINaOgtS5tXJAlOhXVWM36jpLGdDVz6uSlEdBPa68
         aYv5XSkaTbLo9NnZ/8UXKKWq5IH9vgzohvcha7gSBbiUfo6s0kYZ+YPGt0d5iUlDpDEN
         S1nda7qdpwucJ+AFLIsKbsaVg+rw9TeJywzPcV/JTOVlTS8lfSS/jfwNl+hdIzlWIYtf
         jujQ==
X-Gm-Message-State: AOAM530BX4ivwF1Pf73d4EwlkmRN9tDUSABhcKP9mVsuo1t7fTuMTdNc
        yaMULVy2cF8WO7zPa9gHyd9RNQ==
X-Google-Smtp-Source: ABdhPJxUphOOcj51GIKZWPtS46QmBw6AGzkKHIdyv2GSwmDoikz7HE47hcK37iqB3e+CWv/7FyxzEw==
X-Received: by 2002:aa7:c2cf:: with SMTP id m15mr25321916edp.27.1593951127381;
        Sun, 05 Jul 2020 05:12:07 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-133.ip.btc-net.bg. [212.5.158.133])
        by smtp.gmail.com with ESMTPSA id j64sm1517458edd.61.2020.07.05.05.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 05:12:06 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 3/4] media: s5p-mfc: Use standard frame skip mode control
Date:   Sun,  5 Jul 2020 15:11:27 +0300
Message-Id: <20200705121128.5250-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200705121128.5250-1-stanimir.varbanov@linaro.org>
References: <20200705121128.5250-1-stanimir.varbanov@linaro.org>
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

