Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1480FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E854C21527
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgE2NGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:06:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40478 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727771AbgE2NG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:06:29 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TD2BKO006308;
        Fri, 29 May 2020 09:06:08 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 31ax1pgt35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 May 2020 09:06:08 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 04TD63BE003739
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 29 May 2020 09:06:03 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 29 May
 2020 09:06:02 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 29 May 2020 09:06:02 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04TD5pKR026894;
        Fri, 29 May 2020 09:05:59 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v3 5/6] hwmon: pmbus: adm1266: read blackbox
Date:   Fri, 29 May 2020 16:05:05 +0300
Message-ID: <20200529130506.73511-6-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529130506.73511-1-alexandru.tachici@analog.com>
References: <20200529130506.73511-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_07:2020-05-28,2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 cotscore=-2147483648 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Use the nvmem kernel api to expose the black box
chip functionality to userspace.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/adm1266.c | 160 ++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 85d6795b79d3..831156004087 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -14,14 +14,19 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
 #include <linux/slab.h>
 
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
 
@@ -38,12 +43,26 @@
 #define ADM1266_PDIO_GLITCH_FILT(x)	FIELD_GET(GENMASK(12, 9), x)
 #define ADM1266_PDIO_OUT_CFG(x)		FIELD_GET(GENMASK(2, 0), x)
 
+#define ADM1266_BLACKBOX_OFFSET		0x7F700
+#define ADM1266_BLACKBOX_SIZE		64
+
 struct adm1266_data {
 	struct pmbus_driver_info info;
 	struct gpio_chip gc;
 	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
 	struct i2c_client *client;
 	struct dentry *debugfs_dir;
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
 
 #if IS_ENABLED(CONFIG_GPIOLIB)
@@ -261,6 +280,28 @@ static int adm1266_set_go_command_op(void *pdata, u64 val)
 	return i2c_smbus_write_word_data(data->client, ADM1266_GO_COMMAND, reg);
 }
 
+static int adm1266_blackbox_information_read(struct seq_file *s, void *pdata)
+{
+	struct device *dev = s->private;
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 read_buf[PMBUS_BLOCK_MAX + 1];
+	unsigned int latest_id;
+	int ret;
+
+	ret = i2c_smbus_read_block_data(client, ADM1266_BLACKBOX_INFO,
+					read_buf);
+	if (ret < 0)
+		return ret;
+
+	seq_puts(s, "BLACKBOX_INFORMATION:\n");
+	latest_id = read_buf[0] + (read_buf[1] << 8);
+	seq_printf(s, "Black box ID: %x\n", latest_id);
+	seq_printf(s, "Logic index: %x\n", read_buf[2]);
+	seq_printf(s, "Record count: %x\n", read_buf[3]);
+
+	return 0;
+}
+
 DEFINE_DEBUGFS_ATTRIBUTE(go_command_fops, NULL, adm1266_set_go_command_op,
 			 "%llu\n");
 DEFINE_DEBUGFS_ATTRIBUTE(read_state_fops, adm1266_get_state_op, NULL, "%llu\n");
@@ -277,6 +318,121 @@ static void adm1266_debug_init(struct adm1266_data *data)
 				   &go_command_fops);
 	debugfs_create_file_unsafe("read_state", 0400, root, data,
 				   &read_state_fops);
+	debugfs_create_devm_seqfile(&data->client->dev, "blackbox_information",
+				    root, adm1266_blackbox_information_read);
+}
+
+static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *buf)
+{
+	u8 write_buf[PMBUS_BLOCK_MAX + 1];
+	u8 read_buf[PMBUS_BLOCK_MAX + 1];
+	int record_count;
+	int ret;
+	int i;
+
+	ret = i2c_smbus_read_block_data(data->client, ADM1266_BLACKBOX_INFO,
+					read_buf);
+	if (ret < 0)
+		return ret;
+
+	record_count = read_buf[3];
+
+	for (i = 0; i < record_count; i++) {
+		write_buf[0] = i;
+		ret = pmbus_block_wr(data->client, ADM1266_READ_BLACKBOX, 1,
+				     write_buf, buf);
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
 }
 
 static int adm1266_probe(struct i2c_client *client,
@@ -299,6 +455,10 @@ static int adm1266_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	ret = adm1266_config_nvmem(data);
+	if (ret < 0)
+		return ret;
+
 	adm1266_debug_init(data);
 
 	info = &data->info;
-- 
2.20.1

