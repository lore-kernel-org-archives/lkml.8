Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8061C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A625C20759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgG0FaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:30:04 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29546 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbgG0FaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:30:04 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06R5ThkN004102;
        Mon, 27 Jul 2020 01:30:03 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 32gek65jhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 01:30:03 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 06R5U1PM047688
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Jul 2020 01:30:01 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 26 Jul 2020 22:30:00 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 26 Jul 2020 22:29:51 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 26 Jul 2020 22:29:59 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06R5TksS007624;
        Mon, 27 Jul 2020 01:29:56 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v6 6/9] hwmon: pmbus: adm1266: Add group command support
Date:   Mon, 27 Jul 2020 08:31:18 +0300
Message-ID: <20200727053121.23288-7-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727053121.23288-1-alexandru.tachici@analog.com>
References: <20200727053121.23288-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_03:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

The Group Command Protocol is used to send commands
to more than one PMBus device. Some devices working
together require that they must execute some commands
all at once.

The commands are sent in one continuous transmission.
When the devices detect the STOP condition that ends
the sending of commands, they all begin executing
the command they received.

This patch adds support for the group command protocol.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/adm1266.c | 50 +++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index c06465100320..34bd4e652729 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -73,6 +73,56 @@ static const struct nvmem_cell_info adm1266_nvmem_cells[] = {
 
 DECLARE_CRC8_TABLE(pmbus_crc_table);
 
+/* PMBus Group command. */
+static int adm1266_pmbus_group_command(struct adm1266_data *data, struct i2c_client **clients,
+				       u8 nr_clients, u8 cmd, u8 w_len, u8 *data_w)
+{
+	struct i2c_msg *msgs;
+	u8 addr;
+	int ret;
+	int i;
+
+	msgs = kcalloc(nr_clients, sizeof(struct i2c_msg), GFP_KERNEL);
+	if (!msgs)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_clients; i++) {
+		msgs[i].addr = clients[i]->addr;
+		msgs[i].len = w_len + 1;
+
+		msgs[i].buf = kcalloc(ADM1266_PMBUS_BLOCK_MAX + 2, sizeof(u8), GFP_KERNEL);
+		if (!msgs[i].buf) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+
+		msgs[i].buf[0] = cmd;
+		memcpy(&msgs[i].buf[1], data_w, w_len);
+
+		if (clients[i]->flags & I2C_CLIENT_PEC) {
+			u8 crc = 0;
+
+			addr = i2c_8bit_addr_from_msg(&msgs[i]);
+			crc = crc8(pmbus_crc_table, &addr, 1, crc);
+			crc = crc8(pmbus_crc_table, msgs[i].buf, msgs[i].len,
+				   crc);
+
+			msgs[i].buf[msgs[i].len] = crc;
+			msgs[i].len++;
+		}
+	};
+
+	ret = i2c_transfer(data->client->adapter, msgs, nr_clients);
+
+cleanup:
+	for (i = i - 1; i >= 0; i--)
+		kfree(msgs[i].buf);
+
+	kfree(msgs);
+
+	return ret;
+}
+
 /*
  * Different from Block Read as it sends data and waits for the slave to
  * return a value dependent on that data. The protocol is simply a Write Block
-- 
2.20.1

