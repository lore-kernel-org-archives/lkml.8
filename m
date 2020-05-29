Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DC0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C4D206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgE2NGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:06:31 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:36840 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727089AbgE2NG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:06:27 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TCxZSr028194;
        Fri, 29 May 2020 09:06:01 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 316wp8c20n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 May 2020 09:06:00 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 04TD5xxv003727
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 29 May 2020 09:05:59 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 06:05:57 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 29 May 2020 06:05:57 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04TD5pKO026894;
        Fri, 29 May 2020 09:05:54 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v3 2/6] hwmon: (pmbus/core) Add Block WR
Date:   Fri, 29 May 2020 16:05:02 +0300
Message-ID: <20200529130506.73511-3-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529130506.73511-1-alexandru.tachici@analog.com>
References: <20200529130506.73511-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_07:2020-05-28,2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 lowpriorityscore=0 cotscore=-2147483648
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

PmBus devices support Block Write-Block Read Process
Call described in SMBus specification v 2.0 with the
exception that Block writes and reads are permitted to
have up 255 data bytes instead of max 32 bytes (SMBus).

This patch adds Block WR process call support for PMBus.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/Kconfig      |  2 +-
 drivers/hwmon/pmbus/pmbus.h      |  4 ++
 drivers/hwmon/pmbus/pmbus_core.c | 88 ++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 6949483aa732..f11712fdcea8 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -5,7 +5,7 @@
 
 menuconfig PMBUS
 	tristate "PMBus support"
-	depends on I2C
+	depends on I2C && CRC8
 	help
 	  Say yes here if you want to enable PMBus support.
 
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 18e06fc6c53f..ae4e15c5dff2 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -392,6 +392,8 @@ enum pmbus_sensor_classes {
 #define PMBUS_PHASE_VIRTUAL	BIT(30)	/* Phases on this page are virtual */
 #define PMBUS_PAGE_VIRTUAL	BIT(31)	/* Page is virtual */
 
+#define PMBUS_BLOCK_MAX		255
+
 enum pmbus_data_format { linear = 0, direct, vid };
 enum vrm_version { vr11 = 0, vr12, vr13, imvp9, amd625mv };
 
@@ -467,6 +469,8 @@ int pmbus_read_word_data(struct i2c_client *client, int page, int phase,
 			 u8 reg);
 int pmbus_write_word_data(struct i2c_client *client, int page, u8 reg,
 			  u16 word);
+int pmbus_block_wr(struct i2c_client *client, u8 cmd, u8 w_len, u8 *data_w,
+		   u8 *data_r);
 int pmbus_read_byte_data(struct i2c_client *client, int page, u8 reg);
 int pmbus_write_byte(struct i2c_client *client, int page, u8 value);
 int pmbus_write_byte_data(struct i2c_client *client, int page, u8 reg,
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 8d321bf7d15b..ef63468da3b5 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2012 Guenter Roeck
  */
 
+#include <linux/crc8.h>
 #include <linux/debugfs.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
@@ -44,6 +45,8 @@
 
 #define PMBUS_NAME_SIZE		24
 
+DECLARE_CRC8_TABLE(pmbus_crc_table);
+
 struct pmbus_sensor {
 	struct pmbus_sensor *next;
 	char name[PMBUS_NAME_SIZE];	/* sysfs sensor name */
@@ -184,6 +187,89 @@ int pmbus_set_page(struct i2c_client *client, int page, int phase)
 }
 EXPORT_SYMBOL_GPL(pmbus_set_page);
 
+/* Block Write/Read command.
+ * @client: Handle to slave device
+ * @cmd: Byte interpreted by slave
+ * @w_len: Size of write data block; PMBus allows at most 255 bytes
+ * @data_w: byte array which will be written.
+ * @data_r: Byte array into which data will be read; big enough to hold
+ *	the data returned by the slave. PMBus allows at most 255 bytes.
+ *
+ * Different from Block Read as it sends data and waits for the slave to
+ * return a value dependent on that data. The protocol is simply a Write Block
+ * followed by a Read Block without the Read-Block command field and the
+ * Write-Block STOP bit.
+ *
+ * Returns number of bytes read or negative errno.
+ */
+int pmbus_block_wr(struct i2c_client *client, u8 cmd, u8 w_len,
+		   u8 *data_w, u8 *data_r)
+{
+	u8 write_buf[PMBUS_BLOCK_MAX + 1];
+	struct i2c_msg msgs[2] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.buf = write_buf,
+			.len = w_len + 2,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = PMBUS_BLOCK_MAX,
+		}
+	};
+	u8 addr = 0;
+	u8 crc = 0;
+	int ret;
+
+	msgs[0].buf[0] = cmd;
+	msgs[0].buf[1] = w_len;
+	memcpy(&msgs[0].buf[2], data_w, w_len);
+
+	msgs[0].buf = i2c_get_dma_safe_msg_buf(&msgs[0], 1);
+	if (!msgs[0].buf)
+		return -ENOMEM;
+
+	msgs[1].buf = i2c_get_dma_safe_msg_buf(&msgs[1], 1);
+	if (!msgs[1].buf) {
+		i2c_put_dma_safe_msg_buf(msgs[0].buf, &msgs[0], false);
+		return -ENOMEM;
+	}
+
+	ret = i2c_transfer(client->adapter, msgs, 2);
+	if (ret != 2) {
+		dev_err(&client->dev, "I2C transfer error.");
+		goto cleanup;
+	}
+
+	if (client->flags & I2C_CLIENT_PEC) {
+		addr = i2c_8bit_addr_from_msg(&msgs[0]);
+		crc = crc8(pmbus_crc_table, &addr, 1, crc);
+		crc = crc8(pmbus_crc_table, msgs[0].buf,  msgs[0].len, crc);
+
+		addr = i2c_8bit_addr_from_msg(&msgs[1]);
+		crc = crc8(pmbus_crc_table, &addr, 1, crc);
+		crc = crc8(pmbus_crc_table, msgs[1].buf,  msgs[1].buf[0] + 1,
+			   crc);
+
+		if (crc != msgs[1].buf[msgs[1].buf[0] + 1]) {
+			ret = -EBADMSG;
+			goto cleanup;
+		}
+	}
+
+	memcpy(data_r, &msgs[1].buf[1], msgs[1].buf[0]);
+	ret = msgs[1].buf[0];
+
+cleanup:
+	i2c_put_dma_safe_msg_buf(msgs[0].buf, &msgs[0], true);
+	i2c_put_dma_safe_msg_buf(msgs[1].buf, &msgs[1], true);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pmbus_block_wr);
+
 int pmbus_write_byte(struct i2c_client *client, int page, u8 value)
 {
 	int rv;
@@ -2522,6 +2608,8 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	if (!data->groups)
 		return -ENOMEM;
 
+	crc8_populate_msb(pmbus_crc_table, 0x7);
+
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 	data->dev = dev;
-- 
2.20.1

