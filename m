Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8D4C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78EC206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgDVC5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 22:57:39 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:9490 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbgDVC5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 22:57:30 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Apr 2020 19:57:28 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg02-sd.qualcomm.com with ESMTP; 21 Apr 2020 19:57:27 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 0C6664C78; Tue, 21 Apr 2020 19:57:27 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v13 09/11] backlight: pwm_bl: Use 64-bit division function
Date:   Tue, 21 Apr 2020 19:57:21 -0700
Message-Id: <429c18e1e1461d7cd3ccb93f9093a6719744f6b0.1587523702.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1587523702.git.gurus@codeaurora.org>
References: <cover.1587523702.git.gurus@codeaurora.org>
In-Reply-To: <cover.1587523702.git.gurus@codeaurora.org>
References: <cover.1587523702.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the PWM framework is switching struct pwm_state.period's datatype
to u64, prepare for this transition by using div_u64 to handle a 64-bit
dividend instead of a straight division operation.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-pwm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/pwm_bl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 82b8d75..464baad 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -606,7 +606,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		pb->scale = data->max_brightness;
 	}
 
-	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
+	pb->lth_brightness = data->lth_brightness * (div_u64(state.period,
+				pb->scale));
 
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = data->max_brightness;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

