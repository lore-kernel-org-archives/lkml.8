Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D2AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C76207F9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WLriwvQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgE2PWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:22:21 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:20634 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726907AbgE2PWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:22:21 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TFBqic028326;
        Fri, 29 May 2020 10:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=QEYbg2+Ahs1TNWlsutMPnvo9AK2POBWtyD3yCVoZr4M=;
 b=WLriwvQVmnt6gcRbtuKh3c4ierLOSf/0307Vwp230IRgiycCgvYcWHwGUxQvRgQfLjLS
 z5olqdf7AJQ+m/MsvpVAPBrZU41gyvQqcdXjHbm8ogfbWFWpBd/vqvZy232jrIwX7Dow
 dpqHrarBBrmXTUK1PfAkdR6uPpq0BayzFhHuS9cC70ZGs3XJUuZzPvtdvkHz3w4Qz8y4
 EHpMNcVLWltE71+e8lD6qJukVooVCBDqlwMzdq8PpHwFo5N3iO7TZquzbwnAYH6K5OBz
 DyZ7UC6lW2dsamgi/awomyHZUOGH+nffwiXpxqZFuolltmjiSopzEBxzVd06nG8Oiuyw KA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 31708q113g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 May 2020 10:22:18 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 29 May
 2020 16:22:17 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 29 May 2020 16:22:16 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E07E42C8;
        Fri, 29 May 2020 15:22:16 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] regulator: core: Add regulator bypass trace points
Date:   Fri, 29 May 2020 16:22:16 +0100
Message-ID: <20200529152216.9671-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 spamscore=0 mlxlogscore=951 cotscore=-2147483648
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new trace points for the start and end of enabling bypass on a
regulator, to allow monitoring of when regulators are moved into bypass
and how long that takes.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/regulator/core.c         |  9 +++++++++
 include/trace/events/regulator.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 941783a14b454..ec04fe8ece475 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4312,6 +4312,7 @@ EXPORT_SYMBOL_GPL(regulator_set_load);
 int regulator_allow_bypass(struct regulator *regulator, bool enable)
 {
 	struct regulator_dev *rdev = regulator->rdev;
+	const char *name = rdev_get_name(rdev);
 	int ret = 0;
 
 	if (!rdev->desc->ops->set_bypass)
@@ -4326,18 +4327,26 @@ int regulator_allow_bypass(struct regulator *regulator, bool enable)
 		rdev->bypass_count++;
 
 		if (rdev->bypass_count == rdev->open_count) {
+			trace_regulator_bypass_enable(name);
+
 			ret = rdev->desc->ops->set_bypass(rdev, enable);
 			if (ret != 0)
 				rdev->bypass_count--;
+			else
+				trace_regulator_bypass_enable_complete(name);
 		}
 
 	} else if (!enable && regulator->bypass) {
 		rdev->bypass_count--;
 
 		if (rdev->bypass_count != rdev->open_count) {
+			trace_regulator_bypass_disable(name);
+
 			ret = rdev->desc->ops->set_bypass(rdev, enable);
 			if (ret != 0)
 				rdev->bypass_count++;
+			else
+				trace_regulator_bypass_disable_complete(name);
 		}
 	}
 
diff --git a/include/trace/events/regulator.h b/include/trace/events/regulator.h
index b70583c32c08c..72b3ba93b0a5a 100644
--- a/include/trace/events/regulator.h
+++ b/include/trace/events/regulator.h
@@ -70,6 +70,38 @@ DEFINE_EVENT(regulator_basic, regulator_disable_complete,
 
 );
 
+DEFINE_EVENT(regulator_basic, regulator_bypass_enable,
+
+	TP_PROTO(const char *name),
+
+	TP_ARGS(name)
+
+);
+
+DEFINE_EVENT(regulator_basic, regulator_bypass_enable_complete,
+
+	TP_PROTO(const char *name),
+
+	TP_ARGS(name)
+
+);
+
+DEFINE_EVENT(regulator_basic, regulator_bypass_disable,
+
+	TP_PROTO(const char *name),
+
+	TP_ARGS(name)
+
+);
+
+DEFINE_EVENT(regulator_basic, regulator_bypass_disable_complete,
+
+	TP_PROTO(const char *name),
+
+	TP_ARGS(name)
+
+);
+
 /*
  * Events that take a range of numerical values, mostly for voltages
  * and so on.
-- 
2.11.0

