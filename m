Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A12C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8AB62080C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943917;
	bh=L4qoi+nTtn4NKMiuR5FflOUF7Hc2GNRxPspsMjra/GU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zT5HKFZ2S/dbXl9UafU31CW7HJKUUtNf7cOfnysp7WlMfSQIbmvEfE/XCAbtcT0Sc
	 7EvOeBUbuvKy4EU1yEunMRmQQD5sqpHCF8Pmw9kVL7PWLXM8y6wDJINp8yBnYHfoCZ
	 RHxL7CSGncku2b+AF50x4NvSn4riyyBz91sZZpQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390499AbgFWUZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390548AbgFWUZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:25:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A8982080C;
        Tue, 23 Jun 2020 20:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943909;
        bh=L4qoi+nTtn4NKMiuR5FflOUF7Hc2GNRxPspsMjra/GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U33lwmrSUdTFZuwwEDOTbQQXHHC/HGgIKlfNmgcjbcvegJpW6xh9Igq1okQrPSQo1
         31gnDfgl+vwtL+jjGqrEAgrUbfltK4N0Og3SQ178mbARIPWA8Zc1XloCs5kjbwoS4m
         Uq0M6QRznk26qQMxH/Uq30UG5ZWmVIdP8g4zxkHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 068/314] pwm: img: Call pm_runtime_put() in pm_runtime_get_sync() failed case
Date:   Tue, 23 Jun 2020 21:54:23 +0200
Message-Id: <20200623195342.089084072@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit ca162ce98110b98e7d97b7157328d34dcfdd40a9 ]

Even in failed case of pm_runtime_get_sync(), the usage_count is
incremented. In order to keep the usage_count with correct value call
appropriate pm_runtime_put().

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-img.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index c9e57bd109fbf..599a0f66a3845 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -129,8 +129,10 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty = DIV_ROUND_UP(timebase * duty_ns, period_ns);
 
 	ret = pm_runtime_get_sync(chip->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(chip->dev);
 		return ret;
+	}
 
 	val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
 	val &= ~(PWM_CTRL_CFG_DIV_MASK << PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm));
@@ -331,8 +333,10 @@ static int img_pwm_remove(struct platform_device *pdev)
 	int ret;
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(&pdev->dev);
 		return ret;
+	}
 
 	for (i = 0; i < pwm_chip->chip.npwm; i++) {
 		val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
-- 
2.25.1



