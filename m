Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8CCC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761CB20722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgCZVLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:11:16 -0400
Received: from sauhun.de ([88.99.104.3]:54484 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbgCZVKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:10:11 -0400
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
        by pokefinder.org (Postfix) with ESMTPSA id 1D4D22C1F96;
        Thu, 26 Mar 2020 22:10:10 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mfd: htc-i2cpld: convert to use i2c_new_client_device()
Date:   Thu, 26 Mar 2020 22:10:09 +0100
Message-Id: <20200326211009.13411-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326211009.13411-1-wsa+renesas@sang-engineering.com>
References: <20200326211009.13411-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mfd/htc-i2cpld.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/htc-i2cpld.c b/drivers/mfd/htc-i2cpld.c
index 8ad6768bd7a2..247f9849e54a 100644
--- a/drivers/mfd/htc-i2cpld.c
+++ b/drivers/mfd/htc-i2cpld.c
@@ -355,12 +355,12 @@ static int htcpld_register_chip_i2c(
 	info.platform_data = chip;
 
 	/* Add the I2C device.  This calls the probe() function. */
-	client = i2c_new_device(adapter, &info);
-	if (!client) {
+	client = i2c_new_client_device(adapter, &info);
+	if (IS_ERR(client)) {
 		/* I2C device registration failed, contineu with the next */
 		dev_warn(dev, "Unable to add I2C device for 0x%x\n",
 			 plat_chip_data->addr);
-		return -ENODEV;
+		return PTR_ERR(client);
 	}
 
 	i2c_set_clientdata(client, chip);
-- 
2.20.1

