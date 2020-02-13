Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779B7C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A3D217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZy9rV7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387395AbgBMVaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:30:14 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:40044 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgBMVaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:30:14 -0500
Received: by mail-pl1-f202.google.com with SMTP id y2so3863971plt.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 13:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Zm5HmfQ08ScCng/zTBgIQ4r/Dsxq2SkuLGsGUlmZSkY=;
        b=FZy9rV7Klz9GDbl/2sdmUC/UJ/RAnihDFexPPquCcX7fA5myeQhOvB6yQbtB0DYzp8
         AHlnNLF6EHrPz+sdVv3oBVeJEE/PAosTHcZxnAOFF39O1ISUEyz4Bu5wHyGQyD3S+uyi
         Xec11iom33bDLtPhPCkzUgrbPooIQTdUE5E0+48ajYN1svFa7eX66g8+tdvllvLmCG8l
         RtBr0LKPOaY2xzET9klNKXlSJerTWzW4dunSlsqhSTzYLPx1WDhQNnw/cgkDSie6oN3c
         i06hiDP+jTigYs154mYeCq/yJK6n0w0H7S+QxdocB+QGVn69vSYW5Dj53FNUykILtAK+
         6/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Zm5HmfQ08ScCng/zTBgIQ4r/Dsxq2SkuLGsGUlmZSkY=;
        b=ThIITJoNkVqDLB6kc4JPYqwAp9wZ9OopO64cEMPi/ZDGy8NirdIigm8hPuFIPmPbWh
         2qCIsA1J1nSkiBAuW6jbGr+f3UGGziiPbPb5h2P+a/7VemvbTNdluLTbfrTciaFv1wGg
         XKsvFb5+GzAyNsmBn3WGXeigaWhi6DGuuWLXmZsRtBtR+tmgcCc7A0fs8NNIS0IXsgyO
         1b9crk1qssLJawCn3XYHMO0E/hxEQYJh4AwKby1Z0m3whRCDaqcNnheNFvzzSksjUhfk
         tGnWt6trqaXFbS14AewSprKMwkJorxDm/5faf7ADnaTbc0gWzWwx1UVrjZoPU3qswgIE
         pqcA==
X-Gm-Message-State: APjAAAV679kkX3gboC3ZzVyaxxkfbHnZl25dHh0EdkN3b6cTuy5n3lQC
        tX4C42bMxxvYs0r6tZiORFU1tr1xi3B4lBA=
X-Google-Smtp-Source: APXvYqxrnq4hOQ9yBYQtQJnm2++rP8XeKrGAyPFqtvw14576pDXWbHeTVzEyW97kxq423Tf9eiilGCGhoMx0u0yE
X-Received: by 2002:a63:2309:: with SMTP id j9mr20056541pgj.54.1581629413468;
 Thu, 13 Feb 2020 13:30:13 -0800 (PST)
Date:   Thu, 13 Feb 2020 13:30:07 -0800
Message-Id: <20200213213007.17023-1-jkardatzke@google.com>
Mime-Version: 1.0
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
 drivers/media/platform/qcom/venus/venc_ctrls.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index 877c0b3299e9..9ede692f77c5 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -199,6 +199,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 		}
 		mutex_unlock(&inst->lock);
 		break;
+	case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:
+		// Silently ignore, it's always enabled.
+		break;
 	default:
 		return -EINVAL;
 	}
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
2.25.0.225.g125e21ebc7-goog

