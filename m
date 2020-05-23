Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B814C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 06:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22D72072C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 06:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbgEWGRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 02:17:41 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:64332 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387443AbgEWGRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 02:17:40 -0400
Received: from localhost.localdomain (unknown [222.205.77.158])
        by mail-app2 (Coremail) with SMTP id by_KCgA3H5L3v8heJgO4AQ--.35290S4;
        Sat, 23 May 2020 14:17:30 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] extcon: arizona: Fix runtime PM imbalance on error
Date:   Sat, 23 May 2020 14:17:26 +0800
Message-Id: <20200523061726.25903-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgA3H5L3v8heJgO4AQ--.35290S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4UtFy5tF45Wr15uFW3Wrg_yoW5XF4DpF
        4kXFW5tFW8u34I9340yrnYv3Z09r4Iyw1IgrW8Kw1xCryYqrWvqryrJFyYqF48CF9Yg347
        Ja17XFW8uF4Dur7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxG
        rwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x0JU-J5rUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgQJBlZdtORGcgAAsm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When arizona_request_irq() returns an error code, a
pairing runtime PM usage counter decrement is needed
to keep the counter balanced. For error paths after
this function, things are the same.

Also, remove calls to pm_runtime_disable() when
pm_runtime_enable() has not been executed.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Add a new label "err_pm" to balance refcount.
      Remove 3 calls to pm_runtime_disable().
      Move pm_runtime_put() from the front of
      input_register_device() to the back.
---
 drivers/extcon/extcon-arizona.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 7401733db08b..aae82db542a5 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -1460,7 +1460,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 	if (!info->input) {
 		dev_err(arizona->dev, "Can't allocate input dev\n");
 		ret = -ENOMEM;
-		goto err_register;
+		return ret;
 	}
 
 	info->input->name = "Headset";
@@ -1492,7 +1492,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 		if (ret != 0) {
 			dev_err(arizona->dev, "Failed to request GPIO%d: %d\n",
 				pdata->micd_pol_gpio, ret);
-			goto err_register;
+			return ret;
 		}
 
 		info->micd_pol_gpio = gpio_to_desc(pdata->micd_pol_gpio);
@@ -1515,7 +1515,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 			dev_err(arizona->dev,
 				"Failed to get microphone polarity GPIO: %d\n",
 				ret);
-			goto err_register;
+			return ret;
 		}
 	}
 
@@ -1672,7 +1672,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to get JACKDET rise IRQ: %d\n",
 			ret);
-		goto err_gpio;
+		goto err_pm;
 	}
 
 	ret = arizona_set_irq_wake(arizona, jack_irq_rise, 1);
@@ -1721,14 +1721,14 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 		dev_warn(arizona->dev, "Failed to set MICVDD to bypass: %d\n",
 			 ret);
 
-	pm_runtime_put(&pdev->dev);
-
 	ret = input_register_device(info->input);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't register input device: %d\n", ret);
 		goto err_hpdet;
 	}
 
+	pm_runtime_put(&pdev->dev);
+
 	return 0;
 
 err_hpdet:
@@ -1743,10 +1743,11 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 	arizona_set_irq_wake(arizona, jack_irq_rise, 0);
 err_rise:
 	arizona_free_irq(arizona, jack_irq_rise, info);
+err_pm:
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 err_gpio:
 	gpiod_put(info->micd_pol_gpio);
-err_register:
-	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
 
-- 
2.17.1

