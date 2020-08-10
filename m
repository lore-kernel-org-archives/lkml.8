Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56DAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6322D207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073627;
	bh=72cAI67VtDDZt1mKfeA6RIpba9BunW+7lZj51ljgIhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RS/d5SYaesMjI/CS5iJIDgirjnt2zR1qRDWKnb8q8ca15jlWkAi2krnQSwMb0VW9T
	 g4HP0La2xJF/Jswrnp1Vs7LAenb/NFsyGm4s5AfthgYe/2R29zk50zYldJzm7kDSlQ
	 rpLTehSYGZaHHec/IMSByfkhpKk3EorbOzQocvYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgHJPdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbgHJP3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:29:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1252222D06;
        Mon, 10 Aug 2020 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073375;
        bh=72cAI67VtDDZt1mKfeA6RIpba9BunW+7lZj51ljgIhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGjoNRP2emTIjuR3C9RHSwWu1nivOZUtabZCko2m9l18ZihOr07ssChp+cfpf8YBM
         xNY3IxIVl2WiItfC7okKPLCH5qAod/x/A+2Fu6yhncwbeo3LPQP5zTadpZDXCrK9WL
         4CaxFX1KbvSVnYQvopqFXQcyYl73GawIkQY4xsy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amitoj Kaur Chawla <amitoj1606@gmail.com>,
        Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 4.19 16/48] leds: da903x: fix use-after-free on unbind
Date:   Mon, 10 Aug 2020 17:21:38 +0200
Message-Id: <20200810151805.006523413@linuxfoundation.org>
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


