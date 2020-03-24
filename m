Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECB6C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AFE20719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgCXB4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 21:56:46 -0400
Received: from [58.211.163.100] ([58.211.163.100]:49791 "EHLO
        mail.advantech.com.cn" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727050AbgCXB4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 21:56:46 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Mar 2020 21:56:44 EDT
Received: from ACNMB2.ACN.ADVANTECH.CORP (unverified [172.21.128.148]) by ACN-SWEEPER01.ACN.ADVANTECH.CORP
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tde185875d0ac1580301704@ACN-SWEEPER01.ACN.ADVANTECH.CORP>;
 Tue, 24 Mar 2020 09:46:30 +0800
Received: from ADVANTECH.CORP (172.17.10.74) by ACNMB2.ACN.ADVANTECH.CORP
 (172.21.128.148) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 24 Mar
 2020 09:46:30 +0800
From:   <yuechao.zhao@advantech.com.cn>
To:     <345351830@qq.com>
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, <shengkui.leng@advantech.com.cn>,
        Yuechao Zhao <yuechao.zhao@advantech.com.cn>
Subject: [v1,1/1] hwmon: (nct7904) Add watchdog function
Date:   Tue, 24 Mar 2020 01:46:19 +0000
Message-ID: <20200324014619.14276-1-yuechao.zhao@advantech.com.cn>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.74]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 ACNMB2.ACN.ADVANTECH.CORP (172.21.128.148)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>

implement watchdong functionality into the "hwmon/nct7904.c"

Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
---
 drivers/hwmon/nct7904.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 1f5743d..137199c 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -8,6 +8,9 @@
  * Copyright (c) 2019 Advantech
  * Author: Amy.Shih <amy.shih@advantech.com.tw>
  *
+ * Copyright (c) 2020 Advantech
+ * Author: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
+ *
  * Supports the following chips:
  *
  * Chip        #vin  #fan  #pwm  #temp  #dts  chip ID
@@ -20,6 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/mutex.h>
 #include <linux/hwmon.h>
+#include <linux/watchdog.h>
 
 #define VENDOR_ID_REG		0x7A	/* Any bank */
 #define NUVOTON_ID		0x50
@@ -87,18 +91,39 @@
 #define FANCTL1_FMR_REG		0x00	/* Bank 3; 1 reg per channel */
 #define FANCTL1_OUT_REG		0x10	/* Bank 3; 1 reg per channel */
 
+#define WDT_LOCK_REG		0xE0	/* W/O Lock Watchdog Register */
+#define WDT_EN_REG		0xE1	/* R/O Watchdog Enable Register */
+#define WDT_STS_REG		0xE2	/* R/O Watchdog Status Register */
+#define WDT_TIMER_REG		0xE3	/* R/W Watchdog Timer Register */
+#define WDT_SOFT_EN		0x55	/* Enable soft watchdog timer */
+#define WDT_SOFT_DIS		0xAA	/* Disable soft watchdog timer */
+
 #define VOLT_MONITOR_MODE	0x0
 #define THERMAL_DIODE_MODE	0x1
 #define THERMISTOR_MODE		0x3
 
 #define ENABLE_TSI	BIT(1)
 
+#define WATCHDOG_TIMEOUT	1	/* 1 minute default timeout */
+static int ping_timeout = WATCHDOG_TIMEOUT; /* default feeding timeout */
+
+static int timeout = WATCHDOG_TIMEOUT;
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in minutes. 1 <= timeout <= 255, default="
+			__MODULE_STRING(WATCHODOG_TIMEOUT) ".");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started once started (default="
+			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
 static const unsigned short normal_i2c[] = {
 	0x2d, 0x2e, I2C_CLIENT_END
 };
 
 struct nct7904_data {
 	struct i2c_client *client;
+	struct watchdog_device wdt;
 	struct mutex bank_lock;
 	int bank_sel;
 	u32 fanin_mask;
@@ -889,6 +914,91 @@ static int nct7904_detect(struct i2c_client *client,
 	.info = nct7904_info,
 };
 
+/*
+ * Wathcdog Function
+ */
+static int nct7904_wdt_start(struct watchdog_device *wdt)
+{
+	int ret;
+	struct nct7904_data *data = watchdog_get_drvdata(wdt);
+
+	/* Disable soft watchdog timer first */
+	ret = nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_DIS);
+	if (ret < 0)
+		return ret;
+
+	/* Enable soft watchdog timer */
+	ret = nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_EN);
+	return ret;
+}
+
+static int nct7904_wdt_stop(struct watchdog_device *wdt)
+{
+	struct nct7904_data *data = watchdog_get_drvdata(wdt);
+	int ret;
+
+	ret = nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_DIS);
+
+	return ret;
+}
+
+static int nct7904_wdt_set_timeout(struct watchdog_device *wdt,
+				   unsigned int timeout)
+{
+	struct nct7904_data *data = watchdog_get_drvdata(wdt);
+
+	ping_timeout = timeout / 60;
+
+	return nct7904_write_reg(data, BANK_0, WDT_TIMER_REG, ping_timeout);
+}
+
+static int nct7904_wdt_ping(struct watchdog_device *wdt)
+{
+	/*
+	 * Note:
+	 * NCT7904 is not supported refresh WDT_TIMER_REG register when the
+	 * watchdog is actiove. Please disable watchdog before fedding the
+	 * watchdog and enable it again.
+	 */
+	struct nct7904_data *data = watchdog_get_drvdata(wdt);
+	int ret;
+
+	/* Disable soft watchdog timer */
+	ret = nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_DIS);
+	if (ret < 0)
+		goto ping_err;
+
+	/* feed watchdog */
+	ret = nct7904_write_reg(data, BANK_0, WDT_TIMER_REG, ping_timeout);
+	if (ret < 0)
+		goto ping_err;
+
+	/* Enable soft watchdog timer */
+	ret = nct7904_write_reg(data, BANK_0, WDT_TIMER_REG, WDT_SOFT_EN);
+	if (ret < 0)
+		goto ping_err;
+
+	return 0;
+
+ping_err:
+	pr_err("nct7904 ping error\n");
+	return ret;
+}
+
+static const struct watchdog_info nct7904_wdt_info = {
+	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
+				WDIOF_MAGICCLOSE,
+	.identity	= "nct7904 watchdog",
+};
+
+static const struct watchdog_ops nct7904_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= nct7904_wdt_start,
+	.stop		= nct7904_wdt_stop,
+	.ping		= nct7904_wdt_ping,
+	.set_timeout	= nct7904_wdt_set_timeout,
+};
+
 static int nct7904_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1012,7 +1122,51 @@ static int nct7904_probe(struct i2c_client *client,
 	hwmon_dev =
 		devm_hwmon_device_register_with_info(dev, client->name, data,
 						     &nct7904_chip_info, NULL);
-	return PTR_ERR_OR_ZERO(hwmon_dev);
+	ret = PTR_ERR_OR_ZERO(hwmon_dev);
+	if (ret)
+		return ret;
+
+	/* Watchdog initialization */
+	data->wdt.ops = &nct7904_wdt_ops;
+	data->wdt.info = &nct7904_wdt_info;
+
+	data->wdt.timeout = timeout * 60; /* in seconds */
+	data->wdt.min_timeout = 1;
+	data->wdt.max_timeout = 15300;
+	data->wdt.parent = &client->dev;
+
+	watchdog_init_timeout(&data->wdt, timeout, &client->dev);
+	watchdog_set_nowayout(&data->wdt, nowayout);
+	watchdog_set_drvdata(&data->wdt, data);
+
+	i2c_set_clientdata(client, data);
+
+	ret = watchdog_register_device(&data->wdt);
+	if (ret)
+		return ret;
+
+	dev_info(&client->dev, "NCT7904 HWMON and Watchdog device probed\n");
+
+	return ret;
+}
+
+static int nct7904_remove(struct i2c_client *client)
+{
+	/*
+	 * HWMON use devm_hwmon_device_register_with_info() register. So, do
+	 * not need unregister it manually.
+	 */
+	struct nct7904_data *data = i2c_get_clientdata(client);
+
+	/* disable watchdog */
+	if (!nowayout)
+		nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_DIS);
+
+	watchdog_unregister_device(&data->wdt);
+
+	dev_info(&client->dev, "NCT7904 driver removed\n");
+
+	return 0;
 }
 
 static const struct i2c_device_id nct7904_id[] = {
@@ -1030,6 +1184,7 @@ static int nct7904_probe(struct i2c_client *client,
 	.id_table = nct7904_id,
 	.detect = nct7904_detect,
 	.address_list = normal_i2c,
+	.remove = nct7904_remove,
 };
 
 module_i2c_driver(nct7904_driver);
-- 
1.8.3.1

