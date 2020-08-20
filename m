Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DD5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0AD2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597917291;
	bh=Q9Nk+Ip/pL2MI3WbOFTTcfDsLTucVvUTK6hNb3XVb9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LmuO0dph9Q7QuqXwNcNJVmWDUuOGraYTBv9S+bhU+6sys1iJRoPUfQGnTA8v6vadO
	 pcJsDJ6LUfjTQd8MyrLSfPxnzPg3YUv+MZWonlGHATKS7gyAmISQ8ZUiiH4E4BxKZy
	 ZsqtTtzyN3P4FRcJdcGEetScJKM5MkWsFSFpFb/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgHTJyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730136AbgHTJym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:54:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A6652078D;
        Thu, 20 Aug 2020 09:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917281;
        bh=Q9Nk+Ip/pL2MI3WbOFTTcfDsLTucVvUTK6hNb3XVb9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1HqRfVW+hRENDtiyJFDVVtrP1JV55/j6gl//M9RVrzb2yeBCxTQhcBbzsbCeKTed
         ZD6Roq2yHLKY0hVwVMlpMOqSuDFy9iogLZEeni6ZDXjKDRNRxe2JTNfpD9tISBVDMw
         LJabfjby5PSmZ13RwACPz1MwGqneQNRNou45q2Lo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 67/92] pwm: bcm-iproc: handle clk_get_rate() return
Date:   Thu, 20 Aug 2020 11:21:52 +0200
Message-Id: <20200820091541.103132788@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

[ Upstream commit 6ced5ff0be8e94871ba846dfbddf69d21363f3d7 ]

Handle clk_get_rate() returning 0 to avoid possible division by zero.

Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-bcm-iproc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 31b01035d0ab3..8cfba3614e601 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -85,8 +85,6 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	u64 tmp, multi, rate;
 	u32 value, prescale;
 
-	rate = clk_get_rate(ip->clk);
-
 	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
 
 	if (value & BIT(IPROC_PWM_CTRL_EN_SHIFT(pwm->hwpwm)))
@@ -99,6 +97,13 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		state->polarity = PWM_POLARITY_INVERSED;
 
+	rate = clk_get_rate(ip->clk);
+	if (rate == 0) {
+		state->period = 0;
+		state->duty_cycle = 0;
+		return;
+	}
+
 	value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
 	prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
 	prescale &= IPROC_PWM_PRESCALE_MAX;
-- 
2.25.1



