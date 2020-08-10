Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84971C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3EC22D06
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073392;
	bh=HhvuGrhIoMOLBd1KuBa1rj5Gqz6wjjeu2yg+vgrPcn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ca2dNIAgoDTeF0U7stUxwAv9Bqhta8hLJ0/ox5dGOQNoHjW5m2g898pw8W/k+f9rh
	 atp5u/NVdsBmorS91hUveXLeHojjvZhwRbhJuw9QlC8t7leNEVV197P/VZZjWl/fpB
	 U95HdYEvB26ujsQBvwKTM/6tXbe4CPuRgggOs+8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgHJP3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbgHJP3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:29:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FD0F22D02;
        Mon, 10 Aug 2020 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073380;
        bh=HhvuGrhIoMOLBd1KuBa1rj5Gqz6wjjeu2yg+vgrPcn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OcqOwsrVK28NTdnSAI5yEH21CL9nTZ5XZFD6AnPW1BxELnFAMapV4UZECxEJITRpp
         UhEjMLQCyW77399MD3nrO6mcOfkdbCTJ3M+y1Fv3HDVsnxAkenWiOG2RDyxjHpyR2c
         fneGa1lRt7BZI2U5iAHTL6dcMt4XAobQvPDwmKwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amitoj Kaur Chawla <amitoj1606@gmail.com>,
        Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 4.19 18/48] leds: 88pm860x: fix use-after-free on unbind
Date:   Mon, 10 Aug 2020 17:21:40 +0200
Message-Id: <20200810151805.114105793@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151804.199494191@linuxfoundation.org>
References: <20200810151804.199494191@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit eca21c2d8655387823d695b26e6fe78cf3975c05 upstream.

Several MFD child drivers register their class devices directly under
the parent device. This means you cannot blindly do devres conversions
so that deregistration ends up being tied to the parent device,
something which leads to use-after-free on driver unbind when the class
device is released while still being registered.

Fixes: 375446df95ee ("leds: 88pm860x: Use devm_led_classdev_register")
Cc: stable <stable@vger.kernel.org>     # 4.6
Cc: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/leds/leds-88pm860x.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/leds/leds-88pm860x.c
+++ b/drivers/leds/leds-88pm860x.c
@@ -207,21 +207,33 @@ static int pm860x_led_probe(struct platf
 	data->cdev.brightness_set_blocking = pm860x_led_set;
 	mutex_init(&data->lock);
 
-	ret = devm_led_classdev_register(chip->dev, &data->cdev);
+	ret = led_classdev_register(chip->dev, &data->cdev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register LED: %d\n", ret);
 		return ret;
 	}
 	pm860x_led_set(&data->cdev, 0);
+
+	platform_set_drvdata(pdev, data);
+
 	return 0;
 }
 
+static int pm860x_led_remove(struct platform_device *pdev)
+{
+	struct pm860x_led *data = platform_get_drvdata(pdev);
+
+	led_classdev_unregister(&data->cdev);
+
+	return 0;
+}
 
 static struct platform_driver pm860x_led_driver = {
 	.driver	= {
 		.name	= "88pm860x-led",
 	},
 	.probe	= pm860x_led_probe,
+	.remove	= pm860x_led_remove,
 };
 
 module_platform_driver(pm860x_led_driver);


