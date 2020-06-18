Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D1CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19CF420720
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447534;
	bh=xODUwP+pKGwpOOquRo4U9paun0RVhTtwWAE4H6SFik4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N+0DlHvTG6pGl1OIr+hxw++N0LCVFT0/AYlaGho1dET6poJrlk6AZtti12+HBKBUX
	 5wtQa5GqdA223fzoU7L8xcNLDOvHTvwLSgM4SPdTn/nK1xTaanlxhKjro8LqwWWji4
	 LUORWgRnUL1C2K5GlJOhuYzQ/8Buqt7WUkOZ1y0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbgFRCcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbgFRBPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:15:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22329206D7;
        Thu, 18 Jun 2020 01:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442915;
        bh=xODUwP+pKGwpOOquRo4U9paun0RVhTtwWAE4H6SFik4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzLDeNGj6klx5WQEIoYbzB+BBo+UWPCElLyZT+ZOQiGFATIb7q9zR0kfafw3k+1Wl
         jT8jhex6AK+2LVw35Ma0Htt4OmhVwaUfqoB1o6WR+d79154e0FaqQf53H5hDZGx/3O
         GaYNGYH5uKoAlJDNQEOUW1IvWxfPi5yplKJ1D6oE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 333/388] pwm: Add missing "CONFIG_" prefix
Date:   Wed, 17 Jun 2020 21:07:10 -0400
Message-Id: <20200618010805.600873-333-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit f5641d053d46a9a18fe13f2ecb4a7b4a66d9cdf7 ]

The IS_ENABLED() use was missing the CONFIG_ prefix which would have
lead to skipping this code.

Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9973c442b455..6b3cbc0490c6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -121,7 +121,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
 		trace_pwm_get(pwm, &pwm->state);
 
-		if (IS_ENABLED(PWM_DEBUG))
+		if (IS_ENABLED(CONFIG_PWM_DEBUG))
 			pwm->last = pwm->state;
 	}
 
-- 
2.25.1

