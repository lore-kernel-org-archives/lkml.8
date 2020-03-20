Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D971C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BED20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgCTBlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:41:39 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:61050 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727526AbgCTBlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 21:41:31 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Mar 2020 18:41:26 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 19 Mar 2020 18:41:26 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 111E723CD; Thu, 19 Mar 2020 18:41:26 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v11 11/12] clk: pwm: Assign u64 divisor to unsigned int before use
Date:   Thu, 19 Mar 2020 18:41:22 -0700
Message-Id: <ab7b568b1d287949276b3b1c9efdb1cad1f92004.1584667964.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584667964.git.gurus@codeaurora.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
In-Reply-To: <cover.1584667964.git.gurus@codeaurora.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the PWM framework is switching struct pwm_args.period's datatype
to u64, prepare for this transition by assigning the 64-bit divisor to
an unsigned int variable to use as the divisor. This is being done
because the divisor is a 32-bit constant and the quotient will be zero
if the divisor exceeds 2^32.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: David Laight <David.Laight@ACULAB.COM>

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/clk/clk-pwm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index 87fe0b0e..c0b5da3 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -72,6 +72,7 @@ static int clk_pwm_probe(struct platform_device *pdev)
 	struct pwm_device *pwm;
 	struct pwm_args pargs;
 	const char *clk_name;
+	unsigned int period;
 	int ret;
 
 	clk_pwm = devm_kzalloc(&pdev->dev, sizeof(*clk_pwm), GFP_KERNEL);
@@ -88,8 +89,9 @@ static int clk_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	period = pargs.period;
 	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
-		clk_pwm->fixed_rate = NSEC_PER_SEC / pargs.period;
+		clk_pwm->fixed_rate = NSEC_PER_SEC / period;
 
 	if (pargs.period != NSEC_PER_SEC / clk_pwm->fixed_rate &&
 	    pargs.period != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

