Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF51BC43460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B8D22519
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594737606;
	bh=XEytakMRbTXVdAm6n/F8+1DevYQ/bp7DXiBxFb2pgbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A1eY7OPu5cmChBgRcRpAvI0R7Bdsx1W2MLfPrwPEaELLVu7RmJUoWfFDIQBSQEPkz
	 S83LPY9l4NaOhqMn+q2UZ2tV5LkyDgRoTh5VKpSlzQwE/MPmd1b1I0JOLv2q0M6ovo
	 jsMMxr0ZZ+/4R3JGNO79ItQdaEOmy6F1APPiLFhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgGNOkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgGNOj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:39:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12A42251F;
        Tue, 14 Jul 2020 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594737597;
        bh=XEytakMRbTXVdAm6n/F8+1DevYQ/bp7DXiBxFb2pgbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e3l8vatE9gsebhnBO1hOZVYEBUDepQN+s9mBSf2uykqawdDm+lPnI81AgmCrO75LR
         CGOfPgzAOol+9CFHBeVq7P6fGqYi41owupGI3U+Q+OuwAooBlDtzwYBuXRhfYsL0On
         ACijYSgTPmemOAreQE+hHff5uSm5Jre4DC+3yvig=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com,
        linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 02/12] gpio: arizona: put pm_runtime in case of failure
Date:   Tue, 14 Jul 2020 10:39:44 -0400
Message-Id: <20200714143954.4035840-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714143954.4035840-1-sashal@kernel.org>
References: <20200714143954.4035840-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 861254d826499944cb4d9b5a15f5a794a6b99a69 ]

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count if pm_runtime_put is not called in
error handling paths. Call pm_runtime_put if pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20200605030052.78235-1-navid.emamdoost@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-arizona.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
index e09834b91ea52..694674dfbf82a 100644
--- a/drivers/gpio/gpio-arizona.c
+++ b/drivers/gpio/gpio-arizona.c
@@ -69,6 +69,7 @@ static int arizona_gpio_get(struct gpio_chip *chip, unsigned offset)
 		ret = pm_runtime_get_sync(chip->parent);
 		if (ret < 0) {
 			dev_err(chip->parent, "Failed to resume: %d\n", ret);
+			pm_runtime_put_autosuspend(chip->parent);
 			return ret;
 		}
 
@@ -77,12 +78,15 @@ static int arizona_gpio_get(struct gpio_chip *chip, unsigned offset)
 		if (ret < 0) {
 			dev_err(chip->parent, "Failed to drop cache: %d\n",
 				ret);
+			pm_runtime_put_autosuspend(chip->parent);
 			return ret;
 		}
 
 		ret = regmap_read(arizona->regmap, reg, &val);
-		if (ret < 0)
+		if (ret < 0) {
+			pm_runtime_put_autosuspend(chip->parent);
 			return ret;
+		}
 
 		pm_runtime_mark_last_busy(chip->parent);
 		pm_runtime_put_autosuspend(chip->parent);
-- 
2.25.1

