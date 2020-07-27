Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697C0C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABEE20759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgG0FaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:30:16 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40002 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726946AbgG0FaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:30:13 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06R5StRa011949;
        Mon, 27 Jul 2020 01:29:57 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32ghn5da4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 01:29:57 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 06R5TuFp017805
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Jul 2020 01:29:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 27 Jul
 2020 01:29:55 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 27 Jul 2020 01:29:55 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06R5TksQ007624;
        Mon, 27 Jul 2020 01:29:53 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v6 4/9] hwmon: pmbus: adm1266: add debugfs for states
Date:   Mon, 27 Jul 2020 08:31:16 +0300
Message-ID: <20200727053121.23288-5-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727053121.23288-1-alexandru.tachici@analog.com>
References: <20200727053121.23288-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_03:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add a debugfs entry which prints the current state
of the adm1266 sequencer.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/adm1266.c | 42 ++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index be911de02cf6..dbffc6d12e87 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 
 #define ADM1266_PDIO_CONFIG	0xD4
+#define ADM1266_READ_STATE	0xD9
 #define ADM1266_GPIO_CONFIG	0xE1
 #define ADM1266_PDIO_STATUS	0xE9
 #define ADM1266_GPIO_STATUS	0xEA
@@ -43,6 +44,7 @@ struct adm1266_data {
 	struct gpio_chip gc;
 	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
 	struct i2c_client *client;
+	struct dentry *debugfs_dir;
 	struct mutex buf_mutex;
 	u8 write_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
 	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
@@ -287,6 +289,38 @@ static int adm1266_config_gpio(struct adm1266_data *data)
 	return ret;
 }
 
+static int adm1266_state_read(struct seq_file *s, void *pdata)
+{
+	struct device *dev = s->private;
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret;
+
+	ret = i2c_smbus_read_word_data(client, ADM1266_READ_STATE);
+	if (ret < 0)
+		return ret;
+
+	seq_printf(s, "%d\n", ret);
+
+	return 0;
+}
+
+static void adm1266_init_debugfs(struct adm1266_data *data)
+{
+	struct dentry *entry;
+	struct dentry *root;
+
+	root = pmbus_get_debugfs_dir(data->client);
+	if (!root)
+		return;
+
+	data->debugfs_dir = debugfs_create_dir(data->client->name, root);
+	if (!data->debugfs_dir)
+		return;
+
+	entry = debugfs_create_devm_seqfile(&data->client->dev, "sequencer_state",
+					    data->debugfs_dir, adm1266_state_read);
+}
+
 static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct adm1266_data *data;
@@ -310,7 +344,13 @@ static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *
 	if (ret < 0)
 		return ret;
 
-	return pmbus_do_probe(client, id, &data->info);
+	ret = pmbus_do_probe(client, id, &data->info);
+	if (ret)
+		return ret;
+
+	adm1266_init_debugfs(data);
+
+	return 0;
 }
 
 static const struct of_device_id adm1266_of_match[] = {
-- 
2.20.1

