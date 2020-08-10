Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3545C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E972075D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597072876;
	bh=317EpMwDFiRhWwkPj/R6GWOmMwQrCN5rBjTVaLkskPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=imaGKZOiJ1ae56+IE8wUA063RCiKlgEQgmrjihJfQe+J1WxKxHUqEgVxQy/m3ugFl
	 Olj7chieC5hYjwNypnf1B8BJi+EacEeTleC/SUwEtEgOfiUsZE5g2X6+zqBq3mMm+f
	 cYQz4kQ3xR0QIOBCt8T+Jy7xvpBCSbM772a3rXSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgHJPVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbgHJPVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:21:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C89BD20768;
        Mon, 10 Aug 2020 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597072867;
        bh=317EpMwDFiRhWwkPj/R6GWOmMwQrCN5rBjTVaLkskPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5srTFp9lsv3Nt7IZ/DQ/4nRba2NrKGT6WgoP2zJ3yhlaWoRgwtdnS85IfkQXYpat
         gpAMlZl8FBd99w8FhZtbpwCqI1jOVPkv0ATtZ6MdPuL2h5z5XXbjl3HAKOM/ZomMCn
         OBJ9WnwJj+ynyMHbOExqTEFWyn+M96R66+fn61pA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 5.8 26/38] leds: lm36274: fix use-after-free on unbind
Date:   Mon, 10 Aug 2020 17:19:16 +0200
Message-Id: <20200810151805.185190710@linuxfoundation.org>
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

commit a0972fff09479dd09b731360a3a0b09e4fb4d415 upstream.

Several MFD child drivers register their class devices directly under
the parent device. This means you cannot use devres so that
deregistration ends up being tied to the parent device, something which
leads to use-after-free on driver unbind when the class device is
released while still being registered.

Fixes: 11e1bbc116a7 ("leds: lm36274: Introduce the TI LM36274 LED driver")
Cc: stable <stable@vger.kernel.org>     # 5.3
Cc: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/leds/leds-lm36274.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/leds/leds-lm36274.c
+++ b/drivers/leds/leds-lm36274.c
@@ -133,7 +133,7 @@ static int lm36274_probe(struct platform
 	lm36274_data->pdev = pdev;
 	lm36274_data->dev = lmu->dev;
 	lm36274_data->regmap = lmu->regmap;
-	dev_set_drvdata(&pdev->dev, lm36274_data);
+	platform_set_drvdata(pdev, lm36274_data);
 
 	ret = lm36274_parse_dt(lm36274_data);
 	if (ret) {
@@ -147,8 +147,16 @@ static int lm36274_probe(struct platform
 		return ret;
 	}
 
-	return devm_led_classdev_register(lm36274_data->dev,
-					 &lm36274_data->led_dev);
+	return led_classdev_register(lm36274_data->dev, &lm36274_data->led_dev);
+}
+
+static int lm36274_remove(struct platform_device *pdev)
+{
+	struct lm36274 *lm36274_data = platform_get_drvdata(pdev);
+
+	led_classdev_unregister(&lm36274_data->led_dev);
+
+	return 0;
 }
 
 static const struct of_device_id of_lm36274_leds_match[] = {
@@ -159,6 +167,7 @@ MODULE_DEVICE_TABLE(of, of_lm36274_leds_
 
 static struct platform_driver lm36274_driver = {
 	.probe  = lm36274_probe,
+	.remove = lm36274_remove,
 	.driver = {
 		.name = "lm36274-leds",
 	},


