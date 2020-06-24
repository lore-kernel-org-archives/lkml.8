Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476DEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E845F2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="hXopi1yH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390689AbgFXLfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:35:46 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:20004 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388925AbgFXLfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:35:45 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49sLgL05fdz78;
        Wed, 24 Jun 2020 13:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1592998543; bh=wjpWIWEP1hkY8svUlhleFLTk7ObRZTWAWpqhbdFBczc=;
        h=Date:From:Subject:To:Cc:From;
        b=hXopi1yH9bPrHFT2dyLe9HH7FVO6vzTRw2ya/Qizr5b8TonRsWBiLeosVkYkJfBwR
         x1rd4DJ+MsejoEUpPyRoMKheaaSf8nHJZKkwhPj3e+Bxwnmez82RxBu2dUeSor8ZY5
         yZZTgrPfCNxKyvDprOUFHQsRxMbBZbhK16aKmBhefHwTWpwg3NFsB2EmdYMZ2DDtTp
         4QxxG/myoy2A4IwtizKLU2iGHVIuLVcBCkRdOXwhJBqjIl28dCVwAMvTpxIWNmQWcU
         IEHTDlz5SXnRHCXIJxmXbkhImJIUSQNJSxkAusgv16xQWccYTOJMYYnnt7gTXmZBpX
         L2FxOFgF8LiZg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.3 at mail
Date:   Wed, 24 Jun 2020 13:35:41 +0200
Message-Id: <50f0d7fa107f318296afb49477c3571e4d6978c5.1592998403.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2] misc: atmel-ssc: lock with mutex instead of spinlock
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uninterruptible context is not needed in the driver and causes lockdep
warning because of mutex taken in of_alias_get_id(). Convert the lock to
mutex to avoid the issue.

Cc: stable@vger.kernel.org
Fixes: 099343c64e16 ("ARM: at91: atmel-ssc: add device tree support")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 v2: rebased onto v5.7.5, added Fixes tag
---
 drivers/misc/atmel-ssc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index ab4144ea1f11..d6cd5537126c 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -10,7 +10,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/atmel-ssc.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -20,7 +20,7 @@
 #include "../../sound/soc/atmel/atmel_ssc_dai.h"
 
 /* Serialize access to ssc_list and user count */
-static DEFINE_SPINLOCK(user_lock);
+static DEFINE_MUTEX(user_lock);
 static LIST_HEAD(ssc_list);
 
 struct ssc_device *ssc_request(unsigned int ssc_num)
@@ -28,7 +28,7 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
 	int ssc_valid = 0;
 	struct ssc_device *ssc;
 
-	spin_lock(&user_lock);
+	mutex_lock(&user_lock);
 	list_for_each_entry(ssc, &ssc_list, list) {
 		if (ssc->pdev->dev.of_node) {
 			if (of_alias_get_id(ssc->pdev->dev.of_node, "ssc")
@@ -44,18 +44,18 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
 	}
 
 	if (!ssc_valid) {
-		spin_unlock(&user_lock);
+		mutex_unlock(&user_lock);
 		pr_err("ssc: ssc%d platform device is missing\n", ssc_num);
 		return ERR_PTR(-ENODEV);
 	}
 
 	if (ssc->user) {
-		spin_unlock(&user_lock);
+		mutex_unlock(&user_lock);
 		dev_dbg(&ssc->pdev->dev, "module busy\n");
 		return ERR_PTR(-EBUSY);
 	}
 	ssc->user++;
-	spin_unlock(&user_lock);
+	mutex_unlock(&user_lock);
 
 	clk_prepare(ssc->clk);
 
@@ -67,14 +67,14 @@ void ssc_free(struct ssc_device *ssc)
 {
 	bool disable_clk = true;
 
-	spin_lock(&user_lock);
+	mutex_lock(&user_lock);
 	if (ssc->user)
 		ssc->user--;
 	else {
 		disable_clk = false;
 		dev_dbg(&ssc->pdev->dev, "device already free\n");
 	}
-	spin_unlock(&user_lock);
+	mutex_unlock(&user_lock);
 
 	if (disable_clk)
 		clk_unprepare(ssc->clk);
@@ -237,9 +237,9 @@ static int ssc_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	spin_lock(&user_lock);
+	mutex_lock(&user_lock);
 	list_add_tail(&ssc->list, &ssc_list);
-	spin_unlock(&user_lock);
+	mutex_unlock(&user_lock);
 
 	platform_set_drvdata(pdev, ssc);
 
@@ -258,9 +258,9 @@ static int ssc_remove(struct platform_device *pdev)
 
 	ssc_sound_dai_remove(ssc);
 
-	spin_lock(&user_lock);
+	mutex_lock(&user_lock);
 	list_del(&ssc->list);
-	spin_unlock(&user_lock);
+	mutex_unlock(&user_lock);
 
 	return 0;
 }
-- 
2.20.1

