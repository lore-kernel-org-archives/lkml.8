Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B66C52D3A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CED82469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811868;
	bh=Wt3NAeACM4K4qNvn/QVuLHb67CRV4buzK2nKtMV9C+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zrjpDOIXtPG52h15Dvoe8B4znoedqGtfgihEivmggIrBFhSu4tBG6uze22+4nrtnf
	 omtv9J/nRhYq+Y4EoP5gnaNW2nG/P87zMjHEDCoXRBYYSipTxJlk1c0ZqCRhQpPQk/
	 Agy1gnrWKGtleVvz5W0orY1LYQHYeJsPGsf0izR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbgB0N5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:57:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732329AbgB0N5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:57:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DABE24691;
        Thu, 27 Feb 2020 13:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811862;
        bh=Wt3NAeACM4K4qNvn/QVuLHb67CRV4buzK2nKtMV9C+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K26fIWBNGS1vaLIHeWkjKSaHSpUkkSYAyq7nYBZLYkV/U6GvDPdsVtie31TKQ1tji
         mhBGXks++R/ty+PxZjGHAypYiQdIpZy2r0p5uV+r3IWPT8fDQ4D7hrYu3FNml0sIZL
         4g0C+6ye/Wto+XhHVu5/jYu5QiFim5DySZaINGEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yu kuai <yukuai3@huawei.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 131/237] pwm: Remove set but not set variable pwm
Date:   Thu, 27 Feb 2020 14:35:45 +0100
Message-Id: <20200227132306.369036217@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yu kuai <yukuai3@huawei.com>

[ Upstream commit 9871abffc81048e20f02e15d6aa4558a44ad53ea ]

Fixes gcc '-Wunused-but-set-variable' warning:

	drivers/pwm/pwm-pca9685.c: In function ‘pca9685_pwm_gpio_free’:
	drivers/pwm/pwm-pca9685.c:162:21: warning: variable ‘pwm’ set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed. In that case, hold and release
the lock 'pca->lock' can be removed since nothing will be done between
them.

Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-pca9685.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 567f5e2771c47..e1e5dfcb16f36 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -170,13 +170,9 @@ static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
 static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 {
 	struct pca9685 *pca = gpiochip_get_data(gpio);
-	struct pwm_device *pwm;
 
 	pca9685_pwm_gpio_set(gpio, offset, 0);
 	pm_runtime_put(pca->chip.dev);
-	mutex_lock(&pca->lock);
-	pwm = &pca->chip.pwms[offset];
-	mutex_unlock(&pca->lock);
 }
 
 static int pca9685_pwm_gpio_get_direction(struct gpio_chip *chip,
-- 
2.20.1



