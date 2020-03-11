Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7386DC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D1A2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbgCKRno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:43:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730389AbgCKRnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:43:43 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BHeX9H068783;
        Wed, 11 Mar 2020 13:43:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ypxbkbwgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 13:43:21 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02BHetiC069720;
        Wed, 11 Mar 2020 13:43:19 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ypxbkbwgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 13:43:19 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02BHfPuL003571;
        Wed, 11 Mar 2020 17:43:17 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 2ypjxqxkus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 17:43:17 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02BHhHLk15532886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 17:43:17 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28AD9112061;
        Wed, 11 Mar 2020 17:43:17 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACC23112062;
        Wed, 11 Mar 2020 17:43:16 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.103.158])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Mar 2020 17:43:16 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, bjwyman@gmail.com,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] hwmon: (pmbus/ibm-cffps) Add another PSU CCIN to version detection
Date:   Wed, 11 Mar 2020 12:43:10 -0500
Message-Id: <1583948590-17220-1-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_08:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an additional CCIN for the IBM CFFPS that may be classifed as
either version one or version two, based upon the rest of the bits of
the CCIN. Add support for it in the version detection.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/pmbus/ibm-cffps.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index b9bfa43..7d300f2 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -33,9 +33,12 @@
 #define CFFPS_INPUT_HISTORY_CMD			0xD6
 #define CFFPS_INPUT_HISTORY_SIZE		100
 
+#define CFFPS_CCIN_REVISION			GENMASK(7, 0)
+#define  CFFPS_CCIN_REVISION_LEGACY		 0xde
 #define CFFPS_CCIN_VERSION			GENMASK(15, 8)
 #define CFFPS_CCIN_VERSION_1			 0x2b
 #define CFFPS_CCIN_VERSION_2			 0x2e
+#define CFFPS_CCIN_VERSION_3			 0x51
 
 /* STATUS_MFR_SPECIFIC bits */
 #define CFFPS_MFR_FAN_FAULT			BIT(0)
@@ -486,11 +489,14 @@ static int ibm_cffps_probe(struct i2c_client *client,
 		vs = (enum versions)id->driver_data;
 
 	if (vs == cffps_unknown) {
+		u16 ccin_revision = 0;
 		u16 ccin_version = CFFPS_CCIN_VERSION_1;
 		int ccin = i2c_smbus_read_word_swapped(client, CFFPS_CCIN_CMD);
 
-		if (ccin > 0)
+		if (ccin > 0) {
+			ccin_revision = FIELD_GET(CFFPS_CCIN_REVISION, ccin);
 			ccin_version = FIELD_GET(CFFPS_CCIN_VERSION, ccin);
+		}
 
 		switch (ccin_version) {
 		default:
@@ -500,6 +506,12 @@ static int ibm_cffps_probe(struct i2c_client *client,
 		case CFFPS_CCIN_VERSION_2:
 			vs = cffps2;
 			break;
+		case CFFPS_CCIN_VERSION_3:
+			if (ccin_revision == CFFPS_CCIN_REVISION_LEGACY)
+				vs = cffps1;
+			else
+				vs = cffps2;
+			break;
 		}
 
 		/* Set the client name to include the version number. */
-- 
1.8.3.1

