Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DA3C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECCE206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbgG1P0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:26:19 -0400
Received: from mail.prodrive-technologies.com ([212.61.153.67]:59094 "EHLO
        mail.prodrive-technologies.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730669AbgG1P0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:26:19 -0400
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jul 2020 11:26:17 EDT
Received: from mail.prodrive-technologies.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 784D732EBC_F20423AB;
        Tue, 28 Jul 2020 15:20:26 +0000 (GMT)
Received: from mail.prodrive-technologies.com (mdb-dag.prodrive.nl [10.1.1.212])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.prodrive-technologies.com", Issuer "GlobalSign RSA OV SSL CA 2018" (verified OK))
        by mail.prodrive-technologies.com (Sophos Email Appliance) with ESMTPS id E7900303C1_F20422AF;
        Tue, 28 Jul 2020 15:20:10 +0000 (GMT)
Received: from lnxclnt2222.Prodrive.nl (10.130.5.194) by EXC03.bk.prodrive.nl
 (10.1.1.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Tue, 28
 Jul 2020 17:20:10 +0200
From:   Roy van Doormaal <roy.van.doormaal@prodrive-technologies.com>
To:     <linux-hwmon@vger.kernel.org>
CC:     Roy van Doormaal <roy.van.doormaal@prodrive-technologies.com>,
        "Jean Delvare" <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon: (adc128d818) Fix advanced configuration register init
Date:   Tue, 28 Jul 2020 17:18:45 +0200
Message-ID: <20200728151846.231785-1-roy.van.doormaal@prodrive-technologies.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: EXC03.bk.prodrive.nl (10.1.1.212) To EXC03.bk.prodrive.nl
 (10.1.1.212)
X-SASI-RCODE: 200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the operation mode is non-zero and an external reference voltage is set,
first the operation mode is written to the advanced configuration register,
followed by the externel reference enable bit,
resetting the configuration mode to 0.

To fix this, first compose the value of the advanced configuration register
based on the configuration mode and the external reference voltage.
The advanced configuration register is then written to the device,
if it is different from the default register value (0x0).

Signed-off-by: Roy van Doormaal <roy.van.doormaal@prodrive-technologies.com>
---
 drivers/hwmon/adc128d818.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
index f9edec195c35..571d5454c6b2 100644
--- a/drivers/hwmon/adc128d818.c
+++ b/drivers/hwmon/adc128d818.c
@@ -393,6 +393,7 @@ static int adc128_init_client(struct adc128_data *data)
 {
 	struct i2c_client *client = data->client;
 	int err;
+	u8 regval = 0x0;
 
 	/*
 	 * Reset chip to defaults.
@@ -403,10 +404,17 @@ static int adc128_init_client(struct adc128_data *data)
 		return err;
 
 	/* Set operation mode, if non-default */
-	if (data->mode != 0) {
-		err = i2c_smbus_write_byte_data(client,
-						ADC128_REG_CONFIG_ADV,
-						data->mode << 1);
+	if (data->mode != 0)
+		regval |= data->mode << 1;
+
+	/* If external vref is selected, configure the chip to use it */
+	if (data->regulator)
+		regval |= 0x01;
+
+	/* Write advanced configuration register */
+	if (regval != 0x0) {
+		err = i2c_smbus_write_byte_data(client, ADC128_REG_CONFIG_ADV,
+						regval);
 		if (err)
 			return err;
 	}
@@ -416,14 +424,6 @@ static int adc128_init_client(struct adc128_data *data)
 	if (err)
 		return err;
 
-	/* If external vref is selected, configure the chip to use it */
-	if (data->regulator) {
-		err = i2c_smbus_write_byte_data(client,
-						ADC128_REG_CONFIG_ADV, 0x01);
-		if (err)
-			return err;
-	}
-
 	return 0;
 }
 
-- 
2.20.1

