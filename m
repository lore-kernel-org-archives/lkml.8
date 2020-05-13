Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA48C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C50C20769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbgEMAju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:39:50 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:62897 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729215AbgEMAjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:39:49 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 May 2020 17:39:47 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg02-sd.qualcomm.com with ESMTP; 12 May 2020 17:39:47 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 824FE4D8E; Tue, 12 May 2020 17:39:47 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [RESEND PATCH v14 03/11] ir-rx51: Use 64-bit division macro
Date:   Tue, 12 May 2020 17:39:37 -0700
Message-Id: <68f17a69e1c818ee80d6c29c852df35a126b47c6.1589330178.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1589330178.git.gurus@codeaurora.org>
References: <cover.1589330178.git.gurus@codeaurora.org>
In-Reply-To: <cover.1589330178.git.gurus@codeaurora.org>
References: <cover.1589330178.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the PWM framework is switching struct pwm_state.period's datatype
to u64, prepare for this transition by using DIV_ROUND_CLOSEST_ULL to
handle a 64-bit dividend.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Acked-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/ir-rx51.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
index 8574eda..9a5dfd7 100644
--- a/drivers/media/rc/ir-rx51.c
+++ b/drivers/media/rc/ir-rx51.c
@@ -241,7 +241,8 @@ static int ir_rx51_probe(struct platform_device *dev)
 	}
 
 	/* Use default, in case userspace does not set the carrier */
-	ir_rx51.freq = DIV_ROUND_CLOSEST(pwm_get_period(pwm), NSEC_PER_SEC);
+	ir_rx51.freq = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm),
+			NSEC_PER_SEC);
 	pwm_put(pwm);
 
 	hrtimer_init(&ir_rx51.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

