Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E011DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE581207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597925244;
	bh=72cAI67VtDDZt1mKfeA6RIpba9BunW+7lZj51ljgIhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PRvtj2O9INsTZRmySPCajVnS2xMkDb2u2/fkp7iFOW5X6jjShzJDlBHGnoJxEqvI8
	 T/mqWGwrQek+eQwlqV5c9+Fe3thniWtN7mLMIiLmSepssmKQsOnQzPxxIcoQUkKXjr
	 9jPCCEdFvu3Oo7qcisc0hNXdl0ixLHrdBbgTy0xU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgHTMGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729619AbgHTJ6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:58:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8764208DB;
        Thu, 20 Aug 2020 09:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917525;
        bh=72cAI67VtDDZt1mKfeA6RIpba9BunW+7lZj51ljgIhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2M/Qe/rXixwA+nZEwzh4pipo7aao21ISjGWWPHbH5AB1yVUbyzM1dii/xB4VDoX/C
         kgiqsSKjhStJ95xwFJWtI6Ic2Yfd+YfLasW1Uxy12q9dK+gYRX0EQhxlhQ14mve60U
         3gGB95nQwxbgVpEPTjOriV8KIrzEi+Q/sW7xFY2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amitoj Kaur Chawla <amitoj1606@gmail.com>,
        Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 4.9 061/212] leds: da903x: fix use-after-free on unbind
Date:   Thu, 20 Aug 2020 11:20:34 +0200
Message-Id: <20200820091605.450174433@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 6f4aa35744f69ed9b0bf5a736c9ca9b44bc1dcea upstream.

Several MFD child drivers register their class devices directly under
the parent device. This means you cannot blindly do devres conversions
so that deregistration ends up being tied to the parent device,
something which leads to use-after-free on driver unbind when the class
device is released while still being registered.

Fixes: eed16255d66b ("leds: da903x: Use devm_led_classdev_register")
Cc: stable <stable@vger.kernel.org>     # 4.6
Cc: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/leds/leds-da903x.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/leds/leds-da903x.c
+++ b/drivers/leds/leds-da903x.c
@@ -113,12 +113,23 @@ static int da903x_led_probe(struct platf
 	led->flags = pdata->flags;
 	led->master = pdev->dev.parent;
 
-	ret = devm_led_classdev_register(led->master, &led->cdev);
+	ret = led_classdev_register(led->master, &led->cdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register LED %d\n", id);
 		return ret;
 	}
 
+	platform_set_drvdata(pdev, led);
+
+	return 0;
+}
+
+static int da903x_led_remove(struct platform_device *pdev)
+{
+	struct da903x_led *led = platform_get_drvdata(pdev);
+
+	led_classdev_unregister(&led->cdev);
+
 	return 0;
 }
 
@@ -127,6 +138,7 @@ static struct platform_driver da903x_led
 		.name	= "da903x-led",
 	},
 	.probe		= da903x_led_probe,
+	.remove		= da903x_led_remove,
 };
 
 module_platform_driver(da903x_led_driver);


