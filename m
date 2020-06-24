Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B04C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF5A2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404552AbgFXPQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:16:28 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7318 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404523AbgFXPQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:16:08 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05OEtLat019662;
        Wed, 24 Jun 2020 11:15:52 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 31uurjjgbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 11:15:52 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 05OFFoSU044808
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 24 Jun 2020 11:15:51 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 24 Jun 2020 08:15:49 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 24 Jun 2020 08:15:49 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 24 Jun 2020 08:15:49 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05OFFdRv023607;
        Wed, 24 Jun 2020 11:15:47 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v5 6/7] hwmon: pmbus: adm1266: debugfs for blackbox info
Date:   Wed, 24 Jun 2020 18:17:35 +0300
Message-ID: <20200624151736.95785-7-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624151736.95785-1-alexandru.tachici@analog.com>
References: <20200624151736.95785-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_08:2020-06-24,2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 cotscore=-2147483648 bulkscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add a debugfs file to print information in the
BLACKBOX_INFORMATION register. Contains information
about the number of stored records, logic index and id
of the latest record.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/adm1266.c | 56 ++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index b9e92ab1e39a..ea2dc481094b 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -60,6 +60,7 @@ struct adm1266_data {
 	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
 	struct i2c_client *client;
 	struct mutex ioctl_mutex; /* lock ioctl access */
+	struct dentry *debugfs_dir;
 	struct nvmem_config nvmem_config;
 	struct nvmem_device *nvmem;
 	u8 *dev_mem;
@@ -406,6 +407,28 @@ static const struct proc_ops adm1266_proc_ops = {
 	.proc_ioctl	= adm1266_ioctl,
 };
 
+static int adm1266_blackbox_information_read(struct seq_file *s, void *pdata)
+{
+	struct device *dev = s->private;
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 read_buf[5];
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
+	seq_printf(s, "Black box ID: %u\n", latest_id);
+	seq_printf(s, "Logic index: %u\n", read_buf[2]);
+	seq_printf(s, "Record count: %u\n", read_buf[3]);
+
+	return 0;
+}
+
 static int adm1266_init_procfs(struct adm1266_data *data)
 {
 	struct proc_dir_entry *proc_dir;
@@ -423,6 +446,29 @@ static int adm1266_init_procfs(struct adm1266_data *data)
 	return 0;
 }
 
+static int adm1266_init_debugfs(struct adm1266_data *data)
+{
+	struct dentry *entry;
+	struct dentry *root;
+
+	root = pmbus_get_debugfs_dir(data->client);
+	if (!root)
+		return -ENOENT;
+
+	data->debugfs_dir = debugfs_create_dir(data->client->name, root);
+	if (!data->debugfs_dir)
+		return -ENOENT;
+
+	entry = debugfs_create_devm_seqfile(&data->client->dev,
+					    "blackbox_information",
+					    data->debugfs_dir,
+					    adm1266_blackbox_information_read);
+	if (!entry)
+		return -ENOENT;
+
+	return 0;
+}
+
 static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *buf)
 {
 	u8 read_buf[5];
@@ -571,7 +617,15 @@ static int adm1266_probe(struct i2c_client *client,
 	for (i = 0; i < info->pages; i++)
 		info->func[i] = funcs;
 
-	return pmbus_do_probe(client, id, info);
+	ret = pmbus_do_probe(client, id, info);
+	if (ret)
+		return ret;
+
+	ret = adm1266_init_debugfs(data);
+	if (ret)
+		dev_warn(&client->dev, "Failed to register debugfs: %d\n", ret);
+
+	return 0;
 }
 
 static const struct of_device_id adm1266_of_match[] = {
-- 
2.20.1

