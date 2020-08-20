Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9E4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA8F207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597922748;
	bh=HhvuGrhIoMOLBd1KuBa1rj5Gqz6wjjeu2yg+vgrPcn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dCkU3v2P0ZzA03dYbKYels5D4Fo6pD49tH0c3cxOkKSAFdg4owOSFc1Ub3+lV2/02
	 KFa1E2VYsgiXmQp4uT1vam4S/2XUE+eqkPwpDATzfML1Xd8Ygq0xXVGqX0Yaueq+Y/
	 jD+GNYxe3LeaFCBzb5xblifl+QOBeZgD2dEQz890=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgHTLZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730411AbgHTKGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:06:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86A6A2075E;
        Thu, 20 Aug 2020 10:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917999;
        bh=HhvuGrhIoMOLBd1KuBa1rj5Gqz6wjjeu2yg+vgrPcn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFk5Q/UcH+mDLlFjYpW7qDT5LzABg71l5DBrhCGs2DI7gnsQwsijEZDUVbv4b03fI
         m/mGp+MkSMH9xNyTlaHrMuKq4B6mtxQq8WzcmDOirHk4ZtxCt3Ir3QP6hN73ifM3lP
         ejQdWextRplrAKEsn5/GY2TiELDhFfWEfMcz+JgI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amitoj Kaur Chawla <amitoj1606@gmail.com>,
        Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 4.14 018/228] leds: 88pm860x: fix use-after-free on unbind
Date:   Thu, 20 Aug 2020 11:19:53 +0200
Message-Id: <20200820091608.446136115@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
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


