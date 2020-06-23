Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C705C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D9C206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbgFWRfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:35:34 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34038 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733168AbgFWRf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:35:28 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NHNTru031510;
        Tue, 23 Jun 2020 13:35:11 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 31uk3grq2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 13:35:11 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 05NHZ9JP002019
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 23 Jun 2020 13:35:10 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 23 Jun
 2020 10:35:08 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 23 Jun 2020 10:35:08 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05NHYxMU017521;
        Tue, 23 Jun 2020 13:35:06 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v4 5/7] hwmon: pmbus: adm1266: read blackbox
Date:   Tue, 23 Jun 2020 20:36:57 +0300
Message-ID: <20200623173659.41358-6-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623173659.41358-1-alexandru.tachici@analog.com>
References: <20200623173659.41358-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_11:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Use the nvmem kernel api to expose the black box
chip functionality to userspace.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/adm1266.c | 134 ++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 0960ead8d96a..b9e92ab1e39a 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -15,6 +15,8 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -22,10 +24,13 @@
 #include <linux/adm1266.h>
 #include "pmbus.h"
 
+#define ADM1266_BLACKBOX_CONFIG	0xD3
 #define ADM1266_PDIO_CONFIG	0xD4
 #define ADM1266_GO_COMMAND	0xD8
 #define ADM1266_READ_STATE	0xD9
+#define ADM1266_READ_BLACKBOX	0xDE
 #define ADM1266_GPIO_CONFIG	0xE1
+#define ADM1266_BLACKBOX_INFO	0xE6
 #define ADM1266_PDIO_STATUS	0xE9
 #define ADM1266_GPIO_STATUS	0xEA
 
@@ -42,6 +47,9 @@
 #define ADM1266_PDIO_GLITCH_FILT(x)	FIELD_GET(GENMASK(12, 9), x)
 #define ADM1266_PDIO_OUT_CFG(x)		FIELD_GET(GENMASK(2, 0), x)
 
+#define ADM1266_BLACKBOX_OFFSET		0x7F700
+#define ADM1266_BLACKBOX_SIZE		64
+
 #define ADM1266_PMBUS_BLOCK_MAX		255
 
 DECLARE_CRC8_TABLE(pmbus_crc_table);
@@ -52,6 +60,17 @@ struct adm1266_data {
 	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
 	struct i2c_client *client;
 	struct mutex ioctl_mutex; /* lock ioctl access */
+	struct nvmem_config nvmem_config;
+	struct nvmem_device *nvmem;
+	u8 *dev_mem;
+};
+
+static const struct nvmem_cell_info adm1266_nvmem_cells[] = {
+	{
+		.name           = "blackbox",
+		.offset         = ADM1266_BLACKBOX_OFFSET,
+		.bytes          = 2048,
+	},
 };
 
 /* Different from Block Read as it sends data and waits for the slave to
@@ -404,6 +423,117 @@ static int adm1266_init_procfs(struct adm1266_data *data)
 	return 0;
 }
 
+static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *buf)
+{
+	u8 read_buf[5];
+	char index;
+	int record_count;
+	int ret;
+
+	ret = i2c_smbus_read_block_data(data->client, ADM1266_BLACKBOX_INFO,
+					read_buf);
+	if (ret < 0)
+		return ret;
+
+	record_count = read_buf[3];
+
+	for (index = 0; index < record_count; index++) {
+		ret = pmbus_block_xfer(data->client, ADM1266_READ_BLACKBOX, 1,
+				       &index, buf);
+		if (ret < 0)
+			return ret;
+
+		buf += ADM1266_BLACKBOX_SIZE;
+	}
+
+	return 0;
+}
+
+static bool adm1266_cell_is_accessed(const struct nvmem_cell_info *mem_cell,
+				     unsigned int offset, size_t bytes)
+{
+	unsigned int start_addr = offset;
+	unsigned int end_addr = offset + bytes;
+	unsigned int cell_start = mem_cell->offset;
+	unsigned int cell_end = mem_cell->offset + mem_cell->bytes;
+
+	if (start_addr <= cell_end && cell_start <= end_addr)
+		return true;
+
+	return false;
+}
+
+static int adm1266_read_mem_cell(struct adm1266_data *data,
+				 const struct nvmem_cell_info *mem_cell)
+{
+	u8 *mem_offset;
+	int ret;
+
+	switch (mem_cell->offset) {
+	case ADM1266_BLACKBOX_OFFSET:
+		mem_offset = data->dev_mem + mem_cell->offset;
+		ret = adm1266_nvmem_read_blackbox(data, mem_offset);
+		if (ret)
+			dev_err(&data->client->dev, "Could not read blackbox!");
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adm1266_nvmem_read(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
+{
+	const struct nvmem_cell_info *mem_cell;
+	struct adm1266_data *data = priv;
+	int ret;
+	int i;
+
+	for (i = 0; i < data->nvmem_config.ncells; i++) {
+		mem_cell = &adm1266_nvmem_cells[i];
+		if (!adm1266_cell_is_accessed(mem_cell, offset, bytes))
+			continue;
+
+		ret = adm1266_read_mem_cell(data, mem_cell);
+		if (ret < 0)
+			return ret;
+	}
+
+	memcpy(val, data->dev_mem + offset, bytes);
+
+	return 0;
+}
+
+static int adm1266_config_nvmem(struct adm1266_data *data)
+{
+	data->nvmem_config.name = dev_name(&data->client->dev);
+	data->nvmem_config.dev = &data->client->dev;
+	data->nvmem_config.root_only = true;
+	data->nvmem_config.read_only = true;
+	data->nvmem_config.owner = THIS_MODULE;
+	data->nvmem_config.reg_read = adm1266_nvmem_read;
+	data->nvmem_config.cells = adm1266_nvmem_cells;
+	data->nvmem_config.ncells = ARRAY_SIZE(adm1266_nvmem_cells);
+	data->nvmem_config.priv = data;
+	data->nvmem_config.stride = 1;
+	data->nvmem_config.word_size = 1;
+	data->nvmem_config.size = 0x80000;
+
+	data->nvmem = nvmem_register(&data->nvmem_config);
+	if (IS_ERR(data->nvmem)) {
+		dev_err(&data->client->dev, "Could not register nvmem!");
+		return PTR_ERR(data->nvmem);
+	}
+
+	data->dev_mem = devm_kzalloc(&data->client->dev,
+				     data->nvmem_config.size,
+				     GFP_KERNEL);
+	if (!data->dev_mem)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int adm1266_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -430,6 +560,10 @@ static int adm1266_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	ret = adm1266_config_nvmem(data);
+	if (ret < 0)
+		return ret;
+
 	info = &data->info;
 	info->pages = 17;
 	info->format[PSC_VOLTAGE_OUT] = linear;
-- 
2.20.1

