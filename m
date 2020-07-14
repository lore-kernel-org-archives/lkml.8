Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807E9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B07221E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGNHPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:15:39 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:47740 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbgGNHPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:15:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2701682|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0469075-0.00178881-0.951304;FP=0|0|0|0|0|-1|-1|-1;HT=e01l04362;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.I1U1Yi2_1594710932;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I1U1Yi2_1594710932)
          by smtp.aliyun-inc.com(10.147.40.44);
          Tue, 14 Jul 2020 15:15:35 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     lee.jones@linaro.org, wens@csie.org
Cc:     linux-kernel@vger.kernel.org, tiny.windzz@gmail.com,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com,
        Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH v4 10/16] mfd: axp20x: Allow the AXP803 to be probed by I2C
Date:   Tue, 14 Jul 2020 15:15:25 +0800
Message-Id: <bd2b5ba093adba25dc1321cbdfb1532af7bd6047.1594708864.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1594708863.git.frank@allwinnertech.com>
References: <cover.1594708863.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

The AXP803 can be used both using the RSB proprietary bus, or a more
traditional I2C bus.

Let's add that possibility.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/mfd/axp20x-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index 14f9df74f855..446a7d0bbb47 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -63,6 +63,7 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
 	{ .compatible = "x-powers,axp209", .data = (void *)AXP209_ID },
 	{ .compatible = "x-powers,axp221", .data = (void *)AXP221_ID },
 	{ .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
+	{ .compatible = "x-powers,axp803", .data = (void *)AXP803_ID },
 	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
 	{ },
 };
@@ -74,6 +75,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
 	{ "axp209", 0 },
 	{ "axp221", 0 },
 	{ "axp223", 0 },
+	{ "axp803", 0 },
 	{ "axp806", 0 },
 	{ },
 };
-- 
2.24.0

