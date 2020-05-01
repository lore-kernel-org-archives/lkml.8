Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201C4C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 070FE216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgEAPJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:09:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729340AbgEAPJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:09:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041F4616089148;
        Fri, 1 May 2020 11:08:40 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r828uvnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 11:08:38 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 041F5FrW005535;
        Fri, 1 May 2020 15:08:37 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 30mcu764j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 15:08:37 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 041F8aV460752210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 15:08:36 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F4067805C;
        Fri,  1 May 2020 15:08:36 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3A387805E;
        Fri,  1 May 2020 15:08:35 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.211.128.179])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 15:08:35 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        alistair@popple.id.au, joel@jms.id.au, jk@ozlabs.org,
        robh+dt@kernel.org, eajames@linux.ibm.com
Subject: [PATCH 3/3] hwmon: (occ) Add new temperature sensor type
Date:   Fri,  1 May 2020 10:08:33 -0500
Message-Id: <20200501150833.5251-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200501150833.5251-1-eajames@linux.ibm.com>
References: <20200501150833.5251-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_08:2020-05-01,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=1
 adultscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version of the On-Chip Controller (OCC) has a different
format for the temperature sensor data. Add a new temperature sensor
version to handle this data.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.c | 75 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 30e18eb60da7..52af0e728232 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -41,6 +41,14 @@ struct temp_sensor_2 {
 	u8 value;
 } __packed;
 
+struct temp_sensor_10 {
+	u32 sensor_id;
+	u8 fru_type;
+	u8 value;
+	u8 throttle;
+	u8 reserved;
+} __packed;
+
 struct freq_sensor_1 {
 	u16 sensor_id;
 	u16 value;
@@ -307,6 +315,60 @@ static ssize_t occ_show_temp_2(struct device *dev,
 	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
 }
 
+static ssize_t occ_show_temp_10(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u32 val = 0;
+	struct temp_sensor_10 *temp;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	temp = ((struct temp_sensor_10 *)sensors->temp.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be32(&temp->sensor_id);
+		break;
+	case 1:
+		val = temp->value;
+		if (val == OCC_TEMP_SENSOR_FAULT)
+			return -EREMOTEIO;
+
+		/*
+		 * VRM doesn't return temperature, only alarm bit. This
+		 * attribute maps to tempX_alarm instead of tempX_input for
+		 * VRM
+		 */
+		if (temp->fru_type != OCC_FRU_TYPE_VRM) {
+			/* sensor not ready */
+			if (val == 0)
+				return -EAGAIN;
+
+			val *= 1000;
+		}
+		break;
+	case 2:
+		val = temp->fru_type;
+		break;
+	case 3:
+		val = temp->value == OCC_TEMP_SENSOR_FAULT;
+		break;
+	case 4:
+		val = temp->throttle * 1000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
+}
+
 static ssize_t occ_show_freq_1(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -745,6 +807,10 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 		num_attrs += (sensors->temp.num_sensors * 4);
 		show_temp = occ_show_temp_2;
 		break;
+	case 0x10:
+		num_attrs += (sensors->temp.num_sensors * 5);
+		show_temp = occ_show_temp_10;
+		break;
 	default:
 		sensors->temp.num_sensors = 0;
 	}
@@ -844,6 +910,15 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
 						     show_temp, NULL, 3, i);
 			attr++;
+
+			if (sensors->temp.version == 0x10) {
+				snprintf(attr->name, sizeof(attr->name),
+					 "temp%d_max", s);
+				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+							     show_temp, NULL,
+							     4, i);
+				attr++;
+			}
 		}
 	}
 
-- 
2.24.0

