Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D251BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EFE20639
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHLOUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:20:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12792 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbgHLOUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:20:11 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07CEAGmH027033;
        Wed, 12 Aug 2020 10:19:57 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32snw5du9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Aug 2020 10:19:57 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 07CEJubG013662
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 12 Aug 2020 10:19:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 12 Aug
 2020 10:19:55 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 12 Aug 2020 10:19:55 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07CEJoSv020255;
        Wed, 12 Aug 2020 10:19:53 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v8 2/6] hwmon: pmbus: adm1266: Add Block process call
Date:   Wed, 12 Aug 2020 17:20:51 +0300
Message-ID: <20200812142055.9213-3-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812142055.9213-1-alexandru.tachici@analog.com>
References: <20200812142055.9213-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-12_06:2020-08-11,2020-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008120101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

PmBus devices support Block Write-Block Read Process
Call described in SMBus specification v 2.0 with the
exception that Block writes and reads are permitted to
have up 255 data bytes instead of max 32 bytes (SMBus).

This patch adds Block WR process call support for ADM1266.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/Kconfig   |  1 +
 drivers/hwmon/pmbus/adm1266.c | 78 +++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index da34083e1ffd..c04068b665e6 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -28,6 +28,7 @@ config SENSORS_PMBUS
 
 config SENSORS_ADM1266
 	tristate "Analog Devices ADM1266 Sequencer"
+	select CRC8
 	help
 	  If you say yes here you get hardware monitoring support for Analog
 	  Devices ADM1266 Cascadable Super Sequencer.
diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 79e8d90886b8..9db1c317029b 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -6,6 +6,7 @@
  * Copyright 2020 Analog Devices Inc.
  */
 
+#include <linux/crc8.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -13,11 +14,85 @@
 #include "pmbus.h"
 #include <linux/slab.h>
 
+#define ADM1266_PMBUS_BLOCK_MAX		255
+
 struct adm1266_data {
 	struct pmbus_driver_info info;
 	struct i2c_client *client;
+	struct mutex buf_mutex;
+	u8 write_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
+	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
 };
 
+DECLARE_CRC8_TABLE(pmbus_crc_table);
+
+/*
+ * Different from Block Read as it sends data and waits for the slave to
+ * return a value dependent on that data. The protocol is simply a Write Block
+ * followed by a Read Block without the Read-Block command field and the
+ * Write-Block STOP bit.
+ */
+static int adm1266_pmbus_block_xfer(struct adm1266_data *data, u8 cmd, u8 w_len, u8 *data_w,
+				    u8 *data_r)
+{
+	struct i2c_client *client = data->client;
+	struct i2c_msg msgs[2] = {
+		{
+			.addr = client->addr,
+			.flags = I2C_M_DMA_SAFE,
+			.buf = data->write_buf,
+			.len = w_len + 2,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD | I2C_M_DMA_SAFE,
+			.buf = data->read_buf,
+			.len = ADM1266_PMBUS_BLOCK_MAX + 2,
+		}
+	};
+	u8 addr;
+	u8 crc;
+	int ret;
+
+	mutex_lock(&data->buf_mutex);
+
+	msgs[0].buf[0] = cmd;
+	msgs[0].buf[1] = w_len;
+	memcpy(&msgs[0].buf[2], data_w, w_len);
+
+	ret = i2c_transfer(client->adapter, msgs, 2);
+	if (ret != 2) {
+		if (ret >= 0)
+			ret = -EPROTO;
+
+		mutex_unlock(&data->buf_mutex);
+
+		return ret;
+	}
+
+	if (client->flags & I2C_CLIENT_PEC) {
+		addr = i2c_8bit_addr_from_msg(&msgs[0]);
+		crc = crc8(pmbus_crc_table, &addr, 1, 0);
+		crc = crc8(pmbus_crc_table, msgs[0].buf,  msgs[0].len, crc);
+
+		addr = i2c_8bit_addr_from_msg(&msgs[1]);
+		crc = crc8(pmbus_crc_table, &addr, 1, crc);
+		crc = crc8(pmbus_crc_table, msgs[1].buf,  msgs[1].buf[0] + 1, crc);
+
+		if (crc != msgs[1].buf[msgs[1].buf[0] + 1]) {
+			mutex_unlock(&data->buf_mutex);
+			return -EBADMSG;
+		}
+	}
+
+	memcpy(data_r, &msgs[1].buf[1], msgs[1].buf[0]);
+
+	ret = msgs[1].buf[0];
+	mutex_unlock(&data->buf_mutex);
+
+	return ret;
+}
+
 static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct adm1266_data *data;
@@ -33,6 +108,9 @@ static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *
 	for (i = 0; i < data->info.pages; i++)
 		data->info.func[i] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
 
+	crc8_populate_msb(pmbus_crc_table, 0x7);
+	mutex_init(&data->buf_mutex);
+
 	return pmbus_do_probe(client, id, &data->info);
 }
 
-- 
2.20.1

