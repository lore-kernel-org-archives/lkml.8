Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A5CC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5146E22B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YIweNER3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgBRTN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:13:28 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49009 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgBRTN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:13:27 -0500
Received: by mail-pl1-f202.google.com with SMTP id d20so10690258pls.15
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LCLnkWXoXz9OcghUi3epooWnoZGfpAtSgZMaGiJOKu8=;
        b=YIweNER3ez6cX4gaq18ciHLsjwesfuzsnzZUVkEWb1usGcYqij6EvEOSioq9vbcNLG
         uKFvYE3Xk/a7jQig8xL9EBlN9i8+ihe4RKWXgdJ5nKCYgJXND+u2ZetufpqA9KDrCIFv
         lvjBXDYLfHfGTMQaLOdbQa87yxio9rdG/JGD07S3w7NgAbjgfOYqzYx7GMRbP9D7GG4x
         bhpfm915Ho/+44e8OjsBgqnCJILJ5MPkaQ2xBqFr7qkEre01WuEZS4SgALakc2fxFPk+
         4xhXijqyKnjj0ycBtuXsCdykIer2P2yWy4PgU1uyxuGZR5QyvRmmRGM1UdoUmBpUDcdD
         EFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LCLnkWXoXz9OcghUi3epooWnoZGfpAtSgZMaGiJOKu8=;
        b=V1bBKWtzXworvrPuG95+Ugp4zB9srHGGn2T1Zkvp0pHXXP1je73J2ylkAijOctc5Nd
         gg7pXCmxtQIBgY0jS0FKD71bUaeUeoiaV4S6d8vFg/M0UcO8iUwaxkWCDgzb34NFjN77
         BpOe0Jepxky78x+PQqVa3frATY1Cme4atF6HptuoqDpfm0n7KoppGGGDZLooVzoWzD+U
         N4wMtnBeEhjlmRB4iw+/hltRo35CMFoZ1hgpSPTvo0Esj5qstWGgsShf5cCir/2FS+tq
         zYlz7/gkNm8UDNG0aBO6kuFZdDI0Awn1+Oz0ENJAQd5hwpUbBsXu6XRS/wZeQpktzdXB
         i6Lw==
X-Gm-Message-State: APjAAAX2sJ7Xn/Dxm3WaWzKru0gUo7VXEkuR7phljQv2nY+BAaOwmtZS
        UkDGOmH72n0NFmxwxIWCgGK1yKbR/ZRQMLw=
X-Google-Smtp-Source: APXvYqw9YyGXQE/cL94lSoCe4U1L2Ew9nOOYDNGW+B885moEiafTKrGvfabznypD6GeZYgyW48nJ3NAelWnoIpaX
X-Received: by 2002:a63:2a02:: with SMTP id q2mr23581913pgq.198.1582053205231;
 Tue, 18 Feb 2020 11:13:25 -0800 (PST)
Date:   Tue, 18 Feb 2020 11:13:14 -0800
In-Reply-To: <20200213213007.17023-1-jkardatzke@google.com>
Message-Id: <20200218191314.157285-1-jkardatzke@google.com>
Mime-Version: 1.0
References: <20200213213007.17023-1-jkardatzke@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] media: venus: support frame rate control
From:   Jeffrey Kardatzke <jkardatzke@google.com>
To:     linux-media@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Mauro Carvalho Chehab )" <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Kardatzke <jkardatzke@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frame rate control is always enabled in this driver, so make it silently
support the V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE.

Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
---
 drivers/media/platform/qcom/venus/venc_ctrls.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index 877c0b3299e9..15852bc26231 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -199,6 +199,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 		}
 		mutex_unlock(&inst->lock);
 		break;
+	case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:
+		/* Silently ignore, it's always enabled. */
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -214,7 +217,7 @@ int venc_ctrl_init(struct venus_inst *inst)
 {
 	int ret;
 
-	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 30);
+	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 31);
 	if (ret)
 		return ret;
 
@@ -351,6 +354,9 @@ int venc_ctrl_init(struct venus_inst *inst)
 	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
 			  V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME, 0, 0, 0, 0);
 
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE, 0, 1, 1, 1);
+
 	ret = inst->ctrl_handler.error;
 	if (ret)
 		goto err;
-- 
2.25.0.265.gbab2e86ba0-goog

