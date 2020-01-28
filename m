Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D3FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69372071E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221234;
	bh=kPyiXJbADDCV7SwEt+sLGPO1DG8hKF3YTf0rZi6pHr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iiR/IiJNVddwtOqIBEPbgVYNLWCB8ZxHKIXfFU7KCeRZoTEX/TWLmW0iuO/mKcEVF
	 9a3FJUrmsZOLpPjLazbv1yO8TKdFPfuU5a6FaBKVeQ/3edt/wq7b2994cMCNS/576C
	 S5sMd2sx1J/bUAs41kt+zrLvogonTfhVQUIvSgJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbgA1OUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:20:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730368AbgA1OU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:20:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2730E24688;
        Tue, 28 Jan 2020 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221228;
        bh=kPyiXJbADDCV7SwEt+sLGPO1DG8hKF3YTf0rZi6pHr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2neZGfPAnSIkQey2/8gH6pBUwZIP05zX7i3VzQY+lOhGSmYUwoiI93gjDUwFqZ5TG
         XOg1cRiwbyMPN9JjLkPOMvJ+Op0xsrGe9gaTVceqOYOYi8chehO6vCAPjodbYGlVPH
         iNOh3X/kDDb1xNYMhdcCYNo7LqPh2ZvNL0djSW1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bichao Zheng <bichao.zheng@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 139/271] pwm: meson: Dont disable PWM when setting duty repeatedly
Date:   Tue, 28 Jan 2020 15:04:48 +0100
Message-Id: <20200128135902.926407943@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bichao Zheng <bichao.zheng@amlogic.com>

[ Upstream commit a279345807e1e0ae79567a52cfdd9d30c9174a3c ]

There is an abnormally low about 20ms,when setting duty repeatedly.
Because setting the duty will disable PWM and then enable. Delete
this operation now.

Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
Signed-off-by: Bichao Zheng <bichao.zheng@amlogic.com>
[ Dropped code instead of hiding it behind a comment ]
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-meson.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index f58a4867b5194..a196439ee14c7 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -320,11 +320,6 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->period != channel->state.period ||
 	    state->duty_cycle != channel->state.duty_cycle ||
 	    state->polarity != channel->state.polarity) {
-		if (channel->state.enabled) {
-			meson_pwm_disable(meson, pwm->hwpwm);
-			channel->state.enabled = false;
-		}
-
 		if (state->polarity != channel->state.polarity) {
 			if (state->polarity == PWM_POLARITY_NORMAL)
 				meson->inverter_mask |= BIT(pwm->hwpwm);
-- 
2.20.1



