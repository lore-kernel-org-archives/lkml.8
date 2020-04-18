Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F58C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC8E2072B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221195;
	bh=AGKLFnC1a8h9EivGVGdZwlGA7sQHTtmKrKlA+P2Uesc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zpa67f22dqKJA+7dFlJUQMCYPNFLY5UbhX2eQHbiJhHEbwLz4a7Gl1RFW4oBVVmXO
	 K8LTffhC+ZLj7oo1XL7kGHQSwp78XUyMT+ZphVm383lXlkAwkLUjwa2KzzEiHrAcB8
	 gHgGqM6Unx6C1GkYNcacwBdkaMoIFRQC0gQk+7YI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgDROob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728806AbgDROoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:44:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614BB2220A;
        Sat, 18 Apr 2020 14:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221065;
        bh=AGKLFnC1a8h9EivGVGdZwlGA7sQHTtmKrKlA+P2Uesc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKt33I96fub6zpzV3b4WfOOiIwrST0cJeJzIU1cWWRj5p1ueHpMUEm7yJDcO0BK/8
         xn7kHVqU/irrKGkxeto5mfTAzdjZ4MRH2J2Fp1D79r/iGwXPs9X7Ar9nX5FTQUW2r+
         HRIcGMaH/neYXNwTLAjqXDSnxxw4jAL8UaxpSIwY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 15/23] pwm: bcm2835: Dynamically allocate base
Date:   Sat, 18 Apr 2020 10:43:57 -0400
Message-Id: <20200418144405.10565-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144405.10565-1-sashal@kernel.org>
References: <20200418144405.10565-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 2c25b07e5ec119cab609e41407a1fb3fa61442f5 ]

The newer 2711 and 7211 chips have two PWM controllers and failure to
dynamically allocate the PWM base would prevent the second PWM
controller instance being probed for succeeding with an -EEXIST error
from alloc_pwms().

Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-bcm2835.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index c5dbf16d810ba..aeed963f827bd 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -166,6 +166,7 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
+	pc->chip.base = -1;
 	pc->chip.npwm = 2;
 
 	platform_set_drvdata(pdev, pc);
-- 
2.20.1

