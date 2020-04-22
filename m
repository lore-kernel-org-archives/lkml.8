Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EE7C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022622076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552514;
	bh=I2uUxjHtJ2Bl5V9iG8w5PAC575AFfnuGItHBb/Skifc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dcwU3BYSpkdM76UJlGZ5PYy2ZN/svD857n06FR1d+Gtob0nnopugrvbt7Wxx8W5qq
	 CsToBE50ifgDauEbrPAGO+Ob1Tp2YykipbOAvW+rWEY3QkNIOmTM2beCkcL6XORMwP
	 2MLg0UCHfz2LE3LvVfxKlxVt2IP1HbgGI5DAycDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbgDVKsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbgDVKOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:14:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0C2E2070B;
        Wed, 22 Apr 2020 10:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550470;
        bh=I2uUxjHtJ2Bl5V9iG8w5PAC575AFfnuGItHBb/Skifc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhxnLAN0gXAyW6akHRUfHsMwiEfMQdKJsrDyvqkIwBXxsM13l2kgrLsr0FyMNEDNJ
         r65yz7SNVRL6FNVpIEh0Xc4lsNmdrsszD9sj33aogol/mR1Gk5qZAIDM0y/zItmaIu
         v6p4CLId79BT9FHLIghA8/PY9Zn9ubD1Jy9WEZ1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 30/64] rtc: 88pm860x: fix possible race condition
Date:   Wed, 22 Apr 2020 11:57:14 +0200
Message-Id: <20200422095018.322238837@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095008.799686511@linuxfoundation.org>
References: <20200422095008.799686511@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 9cf4789e6e4673d0b2c96fa6bb0c35e81b43111a ]

The RTC IRQ is requested before the struct rtc_device is allocated,
this may lead to a NULL pointer dereference in the IRQ handler.

To fix this issue, allocating the rtc_device struct before requesting
the RTC IRQ using devm_rtc_allocate_device, and use rtc_register_device
to register the RTC device.

Also remove the unnecessary error message as the core already prints the
info.

Link: https://lore.kernel.org/r/20200311223956.51352-1-alexandre.belloni@bootlin.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-88pm860x.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-88pm860x.c b/drivers/rtc/rtc-88pm860x.c
index 73697e4b18a9d..9d4a59aa29a1a 100644
--- a/drivers/rtc/rtc-88pm860x.c
+++ b/drivers/rtc/rtc-88pm860x.c
@@ -341,6 +341,10 @@ static int pm860x_rtc_probe(struct platform_device *pdev)
 	info->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, info);
 
+	info->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(info->rtc_dev))
+		return PTR_ERR(info->rtc_dev);
+
 	ret = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
 					rtc_update_handler, IRQF_ONESHOT, "rtc",
 					info);
@@ -382,13 +386,11 @@ static int pm860x_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
-	info->rtc_dev = devm_rtc_device_register(&pdev->dev, "88pm860x-rtc",
-					    &pm860x_rtc_ops, THIS_MODULE);
-	ret = PTR_ERR(info->rtc_dev);
-	if (IS_ERR(info->rtc_dev)) {
-		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
+	info->rtc_dev->ops = &pm860x_rtc_ops;
+
+	ret = rtc_register_device(info->rtc_dev);
+	if (ret)
 		return ret;
-	}
 
 	/*
 	 * enable internal XO instead of internal 3.25MHz clock since it can
-- 
2.20.1



