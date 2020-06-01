Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9590DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E59206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="o7DdYqEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgFADpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 23:45:55 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:12612 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgFADpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:45:55 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49b1Kn0gCmz5Y;
        Mon,  1 Jun 2020 05:45:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1590983152; bh=pndK1FjAmFq0047oc3zSn4GkaXw9CpwjFxLaj77UgdE=;
        h=Date:From:Subject:To:Cc:From;
        b=o7DdYqEd4GUixVvSOrNrzZ2bHeU3/zAx4a9D11aQnZZdwYuQbIz69ifVRrCznbUKj
         GedeU9z/s5zMyfk+UQ0FpH53JtIh6ATUEHh8TryM6us92ncaETH0PyrYpKCha03ywH
         EGSA7CrnlsjT13sq+eNEMyoZXBIkj1pqeugPUkArTNcj1OvYdmxgPlwzilJ+X/lN6I
         PC6vabPd48+S+TqkluikcHeRakVoLhu37DOWiJs4MpK22/XiBmd2TSNXuQME9llTna
         KqW4Sf2hx94O2qh1OxmFEAr8CXF1JfnuvG1zRQA2Dn6TgfxDbh76o3KCbGgXgV0Hh0
         M/tYiCqtqeRYQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 01 Jun 2020 05:45:48 +0200
Message-Id: <c18a68b3b7c25593c9b6db4bcea1d53de469f6e0.1590983023.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] misc: atmel-ssc: lock with mutex instead of spinlock
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
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/misc/atmel-ssc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index 1322e29bc37a..5cc032097476 100644
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
@@ -246,9 +246,9 @@ static int ssc_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	spin_lock(&user_lock);
+	mutex_lock(&user_lock);
 	list_add_tail(&ssc->list, &ssc_list);
-	spin_unlock(&user_lock);
+	mutex_unlock(&user_lock);
 
 	platform_set_drvdata(pdev, ssc);
 
@@ -267,9 +267,9 @@ static int ssc_remove(struct platform_device *pdev)
 
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

