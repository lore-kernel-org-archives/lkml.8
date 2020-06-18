Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD4FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEC321924
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592442722;
	bh=fxCOpNL5PzHIllp2b2ox6kGkdS74HuH27Q+yujg1qMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FIKcZjEdQ1OTbXiBwRHlQ6YtxNX2oD5Rmpz2SsSqM83oiXP4HqO2pFfduesltVu2z
	 dpZwTXg/Sqsl9Jt569/6jfACY1dErTRuBWBwsIuhu2w5ZgEHdyISVAZDV3fduQb7hP
	 IVp/kO6QLpMwwhOYVVVMxWY68hLPcyzmfVqlwZ5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgFRBMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbgFRBLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:11:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AA7921D7E;
        Thu, 18 Jun 2020 01:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442680;
        bh=fxCOpNL5PzHIllp2b2ox6kGkdS74HuH27Q+yujg1qMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8/LkF6lS3Xt0ARQica5gkuwBxbOVC2+f/r0pW4pzrThIBGOP6s9eCY4kUNbBgcNn
         dkg/ePpehI7ILK3ey2Wjr7gVc/bC9tO2lu+fOJUxFKHgBYxU38ho3NUfguCAWH/L3w
         TvgAOBNyv0SBmhVtWo1OuxNeO//0Nwx1novJ253I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 148/388] gpio: mlxbf2: fix return value check in mlxbf2_gpio_get_lock_res()
Date:   Wed, 17 Jun 2020 21:04:05 -0400
Message-Id: <20200618010805.600873-148-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 66d8ad67aab3bc6f55e7de81565cd0d4875bd851 ]

In case of error, the function devm_ioremap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Link: https://lore.kernel.org/r/20200427110829.154785-1-weiyongjun1@huawei.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mlxbf2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
index da570e63589d..cc0dd8593a4b 100644
--- a/drivers/gpio/gpio-mlxbf2.c
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -110,8 +110,8 @@ static int mlxbf2_gpio_get_lock_res(struct platform_device *pdev)
 	}
 
 	yu_arm_gpio_lock_param.io = devm_ioremap(dev, res->start, size);
-	if (IS_ERR(yu_arm_gpio_lock_param.io))
-		ret = PTR_ERR(yu_arm_gpio_lock_param.io);
+	if (!yu_arm_gpio_lock_param.io)
+		ret = -ENOMEM;
 
 exit:
 	mutex_unlock(yu_arm_gpio_lock_param.lock);
-- 
2.25.1

