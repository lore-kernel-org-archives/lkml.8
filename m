Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CEFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B90A207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597925162;
	bh=KaxY1NvNPtD69tQs/t0IdTuYAOTR+KNMEfLbGZkbrm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KIEJtyeWNZ4jde9Kwj4EfVmIVoSR8laPmHuJEFttInhiBC5IEufPpws81kY3429Ch
	 d34P5tcnB5K6wDcSCpWXdDWcgpMqcE69Dw7RLmL+yS+8P0sjJ0TlAfo21Qt6k41QYf
	 pF12CnrPZ3X3t8+tgJK0N3ZhUvlk2Ads/jkxl3RM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgHTMGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730354AbgHTJ6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:58:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD6332173E;
        Thu, 20 Aug 2020 09:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917530;
        bh=KaxY1NvNPtD69tQs/t0IdTuYAOTR+KNMEfLbGZkbrm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cem9mQI/ORaSVuxNkVuqwrd5wVjmmR1ZNaRWKg/HyzO7lKGjifHV8OW+chfZbrC8D
         iH99P+brm9rA5FOVXkFBLbe7bMMN47ZYuzxWYDa2878KEHoZLX0K3xjIlzMiEXycOT
         uOKeEhXSSe1uUN6G5WDofVSzmNJdU+vZX7nlwtyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amitoj Kaur Chawla <amitoj1606@gmail.com>,
        Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 4.9 062/212] leds: lm3533: fix use-after-free on unbind
Date:   Thu, 20 Aug 2020 11:20:35 +0200
Message-Id: <20200820091605.504108480@linuxfoundation.org>
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

commit d584221e683bbd173738603b83a315f27d27d043 upstream.

Several MFD child drivers register their class devices directly under
the parent device. This means you cannot blindly do devres conversions
so that deregistration ends up being tied to the parent device,
something which leads to use-after-free on driver unbind when the class
device is released while still being registered.

Fixes: 50154e29e5cc ("leds: lm3533: Use devm_led_classdev_register")
Cc: stable <stable@vger.kernel.org>     # 4.6
Cc: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/leds/leds-lm3533.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -698,7 +698,7 @@ static int lm3533_led_probe(struct platf
 
 	platform_set_drvdata(pdev, led);
 
-	ret = devm_led_classdev_register(pdev->dev.parent, &led->cdev);
+	ret = led_classdev_register(pdev->dev.parent, &led->cdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register LED %d\n", pdev->id);
 		return ret;
@@ -708,13 +708,18 @@ static int lm3533_led_probe(struct platf
 
 	ret = lm3533_led_setup(led, pdata);
 	if (ret)
-		return ret;
+		goto err_deregister;
 
 	ret = lm3533_ctrlbank_enable(&led->cb);
 	if (ret)
-		return ret;
+		goto err_deregister;
 
 	return 0;
+
+err_deregister:
+	led_classdev_unregister(&led->cdev);
+
+	return ret;
 }
 
 static int lm3533_led_remove(struct platform_device *pdev)
@@ -724,6 +729,7 @@ static int lm3533_led_remove(struct plat
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
 	lm3533_ctrlbank_disable(&led->cb);
+	led_classdev_unregister(&led->cdev);
 
 	return 0;
 }


