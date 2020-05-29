Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F3DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0AF420B80
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgE2NGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:06:25 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28620 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbgE2NGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:06:23 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TCxknv028510;
        Fri, 29 May 2020 09:06:04 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 316wp8c20y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 May 2020 09:06:03 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04TD62HD004107
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 29 May 2020 09:06:02 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 29 May 2020 06:06:00 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 29 May 2020 06:06:00 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04TD5pKQ026894;
        Fri, 29 May 2020 09:05:57 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v3 4/6] hwmon: pmbus: adm1266: add debugfs attr for states
Date:   Fri, 29 May 2020 16:05:04 +0300
Message-ID: <20200529130506.73511-5-alexandru.tachici@analog.com>
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

Add debugfs files for go_command and read_state.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/adm1266.c | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 190170300ef1..85d6795b79d3 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -19,6 +19,8 @@
 #include "pmbus.h"
 
 #define ADM1266_PDIO_CONFIG	0xD4
+#define ADM1266_GO_COMMAND	0xD8
+#define ADM1266_READ_STATE	0xD9
 #define ADM1266_GPIO_CONFIG	0xE1
 #define ADM1266_PDIO_STATUS	0xE9
 #define ADM1266_GPIO_STATUS	0xEA
@@ -41,6 +43,7 @@ struct adm1266_data {
 	struct gpio_chip gc;
 	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
 	struct i2c_client *client;
+	struct dentry *debugfs_dir;
 };
 
 #if IS_ENABLED(CONFIG_GPIOLIB)
@@ -234,6 +237,48 @@ static inline int adm1266_config_gpio(struct adm1266_data *data)
 }
 #endif
 
+static int adm1266_get_state_op(void *pdata, u64 *state)
+{
+	struct adm1266_data *data = pdata;
+	int ret;
+
+	ret = i2c_smbus_read_word_data(data->client, ADM1266_READ_STATE);
+	if (ret < 0)
+		return ret;
+
+	*state = ret;
+
+	return 0;
+}
+
+static int adm1266_set_go_command_op(void *pdata, u64 val)
+{
+	struct adm1266_data *data = pdata;
+	u8 reg;
+
+	reg = FIELD_GET(GENMASK(4, 0), val);
+
+	return i2c_smbus_write_word_data(data->client, ADM1266_GO_COMMAND, reg);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(go_command_fops, NULL, adm1266_set_go_command_op,
+			 "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(read_state_fops, adm1266_get_state_op, NULL, "%llu\n");
+
+static void adm1266_debug_init(struct adm1266_data *data)
+{
+	struct dentry *root;
+	char dir_name[30];
+
+	sprintf(dir_name, "adm1266-%x_debugfs", data->client->addr);
+	root = debugfs_create_dir(dir_name, NULL);
+	data->debugfs_dir = root;
+	debugfs_create_file_unsafe("go_command", 0200, root, data,
+				   &go_command_fops);
+	debugfs_create_file_unsafe("read_state", 0400, root, data,
+				   &read_state_fops);
+}
+
 static int adm1266_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -254,6 +299,8 @@ static int adm1266_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	adm1266_debug_init(data);
+
 	info = &data->info;
 	info->pages = 17;
 	info->format[PSC_VOLTAGE_OUT] = linear;
-- 
2.20.1

