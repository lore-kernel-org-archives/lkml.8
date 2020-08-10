Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFF5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02DAB2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597072884;
	bh=wkqj1qoeprJlvfQN9/RlfNpdpvKWXthNynLbTT69KSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VV/TyzMQuyBsg4tdZqSKOCncOqRQEb1IgSPBm10uhwZKH/AzaqkUMv/MH3k4xIwpk
	 z//vqHfimE7OOqOZdh/C1AB4qgifNT5+dJ4ui8WmvpfGPL4mpOZ0dkimzm13dlapJH
	 ECQPkKyAq6dfJ/fCJ51xKHXJcv9SFDnWv78HM3Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgHJPVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbgHJPVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:21:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C93522065D;
        Mon, 10 Aug 2020 15:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597072864;
        bh=wkqj1qoeprJlvfQN9/RlfNpdpvKWXthNynLbTT69KSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWDFcW8ylnkGtc9+FykMh4HI5I844QhFvC+NpIOpkjOfVywG5OVMDLOVIFWQwpBSd
         UPfxpR6emS3TMgQmL9PgoJj3k0SjVO9CKgYCuL+VGerVQ22syNFTjVsCm7UapHMBac
         tTYKSt4k69fEhJN0vNsCgTTC01ajoIxkCcSvaqZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amitoj Kaur Chawla <amitoj1606@gmail.com>,
        Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 5.8 25/38] leds: wm831x-status: fix use-after-free on unbind
Date:   Mon, 10 Aug 2020 17:19:15 +0200
Message-Id: <20200810151805.135568635@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151803.920113428@linuxfoundation.org>
References: <20200810151803.920113428@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 47a459ecc800a17109d0c496a4e21e478806ee40 upstream.

Several MFD child drivers register their class devices directly under
the parent device. This means you cannot blindly do devres conversions
so that deregistration ends up being tied to the parent device,
something which leads to use-after-free on driver unbind when the class
device is released while still being registered.

Fixes: 8d3b6a4001ce ("leds: wm831x-status: Use devm_led_classdev_register")
Cc: stable <stable@vger.kernel.org>     # 4.6
Cc: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/leds/leds-wm831x-status.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/leds/leds-wm831x-status.c
+++ b/drivers/leds/leds-wm831x-status.c
@@ -269,12 +269,23 @@ static int wm831x_status_probe(struct pl
 	drvdata->cdev.blink_set = wm831x_status_blink_set;
 	drvdata->cdev.groups = wm831x_status_groups;
 
-	ret = devm_led_classdev_register(wm831x->dev, &drvdata->cdev);
+	ret = led_classdev_register(wm831x->dev, &drvdata->cdev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register LED: %d\n", ret);
 		return ret;
 	}
 
+	platform_set_drvdata(pdev, drvdata);
+
+	return 0;
+}
+
+static int wm831x_status_remove(struct platform_device *pdev)
+{
+	struct wm831x_status *drvdata = platform_get_drvdata(pdev);
+
+	led_classdev_unregister(&drvdata->cdev);
+
 	return 0;
 }
 
@@ -283,6 +294,7 @@ static struct platform_driver wm831x_sta
 		   .name = "wm831x-status",
 		   },
 	.probe = wm831x_status_probe,
+	.remove = wm831x_status_remove,
 };
 
 module_platform_driver(wm831x_status_driver);


