Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121D8C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36FB20663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193433;
	bh=TxwKOVFcE2pzmB8eSzLGTN684D6ahhL2WTGB0irJpMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uprlT0v2OgeDG7PTn0V/i3bHBJ1uOZj6QnacqI0JFbZ6kP0NYaPyXBsTkcPPpr2a9
	 z8fJ6pKBxMGN8tfJ5/N1X6zAmghqlJR/N/UBpFd60T9s9xGwjnn3W/0EFqHQpSEtgW
	 hTjH190P9uYu+UvFsR8LkRVcotiX7FVyR2aGfX98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgAPQrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:47:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729464AbgAPQrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:47:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24CA32073A;
        Thu, 16 Jan 2020 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193244;
        bh=TxwKOVFcE2pzmB8eSzLGTN684D6ahhL2WTGB0irJpMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PzMZa/1uCMHSCpC8q61Q87mU/WI8XW++I8IRZK8R6OG6M/fjAnHH1DtNvJ7RhNO77
         YUZCPYnFwehTxKJeHrLefpglJ9eVT9fn98CPCzcXf7p1qRaMX+YqCU314Eli8w3H/z
         /HNCLxLp8g8mIAeLtTBjpSYVdTPSFJ253T+i254I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 053/205] pwm: sun4i: Fix incorrect calculation of duty_cycle/period
Date:   Thu, 16 Jan 2020 11:40:28 -0500
Message-Id: <20200116164300.6705-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

[ Upstream commit 50cc7e3e4f26e3bf5ed74a8d061195c4d2161b8b ]

Since 5.4-rc1, pwm_apply_state calls ->get_state after ->apply
if available, and this revealed an issue with integer precision
when calculating duty_cycle and period for the currently set
state in ->get_state callback.

This issue manifested in broken backlight on several Allwinner
based devices.

Previously this worked, because ->apply updated the passed state
directly.

Fixes: deb9c462f4e53 ("pwm: sun4i: Don't update the state for the caller of pwm_apply_state")
Signed-off-by: Ondrej Jirman <megous@megous.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-sun4i.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 6f5840a1a82d..05273725a9ff 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -137,10 +137,10 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
 
 	val = sun4i_pwm_readl(sun4i_pwm, PWM_CH_PRD(pwm->hwpwm));
 
-	tmp = prescaler * NSEC_PER_SEC * PWM_REG_DTY(val);
+	tmp = (u64)prescaler * NSEC_PER_SEC * PWM_REG_DTY(val);
 	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
 
-	tmp = prescaler * NSEC_PER_SEC * PWM_REG_PRD(val);
+	tmp = (u64)prescaler * NSEC_PER_SEC * PWM_REG_PRD(val);
 	state->period = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
 }
 
-- 
2.20.1

