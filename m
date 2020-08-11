Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A28BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7ACB20734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="B0D3oQSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgHKBHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:07:53 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:1488 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbgHKBHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:07:42 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQZSX5HVlzfN;
        Tue, 11 Aug 2020 03:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597108060; bh=eXLNbW9Ivy3pD8Py+AuHYcCa1pegGO6FO3h5Gange9c=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=B0D3oQSW2i2W3C4Sm3cKiGnrOlDbdUG0UOhmvSHn24mAGVRVpoxZGMuRycJMVXb6h
         +CfHqvSUTLhC4FTCUviOtCVMAa7zBMpjLFktUW0Fo3/+OPwk8/fkHQUHioVW/K5RkS
         EklCRWd7JfE/epefzu3/kl+oP1VZmXkkJckgPoKqXxvRRWhVl33/hk1LX2ejaGeq6B
         +63eXKJCVA5FQgZm310KTtSxwraxfXyA9sM67eNUI6s6DiwZhUu9m1IPSovfyFazHV
         rPD4mHq2jUxYWyY3pypeDhcUQKOIP3JDFFeDXDLiJk/U3yQGo0XF4sctA4WP2PTjrJ
         KmOyDWMOB26nA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Tue, 11 Aug 2020 03:07:40 +0200
Message-Id: <f106ae5b37612b36cb817691fb690e5456aea0ee.1597107682.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 5/7] regulator: plug of_node leak in regulator_register()'s
 error path
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By calling device_initialize() earlier and noting that kfree(NULL) is
ok, we can save a bit of code in error handling and plug of_node leak.
Fixed commit already did part of the work.

Cc: stable@vger.kernel.org
Fixes: 9177514ce349 ("regulator: fix memory leak on error path of regulator_register()")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 0408c4e1d9a8..a9ff2ad55ee7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5137,6 +5137,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		ret = -ENOMEM;
 		goto rinse;
 	}
+	device_initialize(&rdev->dev);
 
 	/*
 	 * Duplicate the config so the driver could override it after
@@ -5144,9 +5145,8 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	 */
 	config = kmemdup(cfg, sizeof(*cfg), GFP_KERNEL);
 	if (config == NULL) {
-		kfree(rdev);
 		ret = -ENOMEM;
-		goto rinse;
+		goto clean;
 	}
 
 	init_data = regulator_of_get_init_data(dev, regulator_desc, config,
@@ -5158,10 +5158,8 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	 * from a gpio extender or something else.
 	 */
 	if (PTR_ERR(init_data) == -EPROBE_DEFER) {
-		kfree(config);
-		kfree(rdev);
 		ret = -EPROBE_DEFER;
-		goto rinse;
+		goto clean;
 	}
 
 	/*
@@ -5214,7 +5212,6 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	}
 
 	/* register with sysfs */
-	device_initialize(&rdev->dev);
 	rdev->dev.class = &regulator_class;
 	rdev->dev.parent = dev;
 	dev_set_name(&rdev->dev, "regulator.%lu",
@@ -5292,13 +5289,11 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	mutex_lock(&regulator_list_mutex);
 	regulator_ena_gpio_free(rdev);
 	mutex_unlock(&regulator_list_mutex);
-	put_device(&rdev->dev);
-	rdev = NULL;
 clean:
 	if (dangling_of_gpiod)
 		gpiod_put(config->ena_gpiod);
-	kfree(rdev);
 	kfree(config);
+	put_device(&rdev->dev);
 rinse:
 	if (dangling_cfg_gpiod)
 		gpiod_put(cfg->ena_gpiod);
-- 
2.20.1

