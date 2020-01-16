Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D3BC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061E52073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198983;
	bh=PFQWB6yhTiykWY+nO5wBabV+FH2+zy+I/JKuaKCtjec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XSczZcyTMZdgumql7bJnnG588ATv/pip58uK5IMWv/6oO39QuSL/mSu9eyT+aT/Ju
	 OwXBw12sDWdCgRJtW6NinI9Q4IB0PQ0+XsRsP6zoe1LHwRQrl4rdEdUYPuPPgPzB36
	 5yZWS6Lt70b+uqUf33YzOUHcf9n/y09h0bZy4Fv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgAPR1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:27:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392417AbgAPR1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:27:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14059246D3;
        Thu, 16 Jan 2020 17:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195630;
        bh=PFQWB6yhTiykWY+nO5wBabV+FH2+zy+I/JKuaKCtjec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0YzvyhaJFjLqtLm8YZrzczSOtjXijCMiyt/9T61eo0k39YLGB1YGOh7MVSru++Sw
         KsqW9SvIFVFoeotndmgtxdzodiTvqAHt9PtlOJSs2tHhRdQssT+VnFLSMEdvrcZHO/
         lBH+9+5CYmm+IxK+1wwy7Td7BrH5WEnMJRzbLi00=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 198/371] pwm: meson: Consider 128 a valid pre-divider
Date:   Thu, 16 Jan 2020 12:21:10 -0500
Message-Id: <20200116172403.18149-141-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 51496e4446875726d50a5617a6e0e0dabbc2e6da ]

The pre-divider allows configuring longer PWM periods compared to using
the input clock directly. The pre-divider is 7 bit wide, meaning it's
maximum value is 128 (the register value is off-by-one: 0x7f or 127).

Change the loop to also allow for the maximum possible value to be
considered valid.

Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 9b79cbc7a715..9551f896dd6f 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -188,7 +188,7 @@ static int meson_pwm_calc(struct meson_pwm *meson,
 	do_div(fin_ps, fin_freq);
 
 	/* Calc pre_div with the period */
-	for (pre_div = 0; pre_div < MISC_CLK_DIV_MASK; pre_div++) {
+	for (pre_div = 0; pre_div <= MISC_CLK_DIV_MASK; pre_div++) {
 		cnt = DIV_ROUND_CLOSEST_ULL((u64)period * 1000,
 					    fin_ps * (pre_div + 1));
 		dev_dbg(meson->chip.dev, "fin_ps=%llu pre_div=%u cnt=%u\n",
@@ -197,7 +197,7 @@ static int meson_pwm_calc(struct meson_pwm *meson,
 			break;
 	}
 
-	if (pre_div == MISC_CLK_DIV_MASK) {
+	if (pre_div > MISC_CLK_DIV_MASK) {
 		dev_err(meson->chip.dev, "unable to get period pre_div\n");
 		return -EINVAL;
 	}
-- 
2.20.1

