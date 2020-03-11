Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3295C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A94D208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgCKBl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:41:27 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:26769 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727930AbgCKBlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:41:25 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Mar 2020 18:41:24 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg01-sd.qualcomm.com with ESMTP; 10 Mar 2020 18:41:24 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 2B2BC4559; Tue, 10 Mar 2020 18:41:24 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v8 06/12] pwm: pwm-imx-tpm: Use 64-bit division macro
Date:   Tue, 10 Mar 2020 18:41:15 -0700
Message-Id: <b47d7c25d24ef00275b73f0ea319d5bdbb5edfce.1583889178.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1583889178.git.gurus@codeaurora.org>
References: <cover.1583889178.git.gurus@codeaurora.org>
In-Reply-To: <cover.1583889178.git.gurus@codeaurora.org>
References: <cover.1583889178.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the PWM framework is switching struct pwm_state.period's datatype
to u64, prepare for this transition by using DIV64_U64_ROUND_CLOSEST to
handle a 64-bit divisor.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/pwm-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 9145f61..53bf364 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -126,7 +126,7 @@ static int pwm_imx_tpm_round_state(struct pwm_chip *chip,
 		real_state->duty_cycle = state->duty_cycle;
 
 	tmp = (u64)p->mod * real_state->duty_cycle;
-	p->val = DIV_ROUND_CLOSEST_ULL(tmp, real_state->period);
+	p->val = DIV64_U64_ROUND_CLOSEST(tmp, real_state->period);
 
 	real_state->polarity = state->polarity;
 	real_state->enabled = state->enabled;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

