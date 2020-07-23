Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8CDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549B52080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="k7sYziWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgGWKzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:55:04 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:13886 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728408AbgGWKzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:55:03 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NAiI97003765;
        Thu, 23 Jul 2020 05:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=iYPOhlbAQrslvPoq2zdj9t8JKBjaXig009r3OUnE3UY=;
 b=k7sYziWWaz05wqvWHKf9qWmhKtEGX4QRV3m2rUuk0RXlbYokgdLUadl/G47dBlaaDqwt
 5lldyMTADxLsM2dl4pSnWSeB1ixEbaJkhnHg0YGSFte6abP8p5qRXSaGPcuMg9MaC05O
 a3j7bZx0YhKerYOLj8hPTNLJ18hrl49paSF4PtEZ3aIwHhPgE9KsWN1CFdn7FkPLDeOj
 H7zXAcyAhHOCY+VSqZEyFCloq5vJvkfL2Pb66Q2IlCexsB8jiOsqHfQaBrG8uZSPFRrF
 kh4nUvTkn8dFboAoea8l+3IVEpckabu8EtpJufLkbQ752Xd1/BBloHqSUWNIHJLClEH1 AQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 32bxg1fd81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jul 2020 05:55:02 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 23 Jul
 2020 11:55:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 23 Jul 2020 11:55:00 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 12AED45;
        Thu, 23 Jul 2020 10:55:00 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [RESEND PATCH v3 1/2] mfd: mfd-core: Add mechanism for removal of a subset of children
Date:   Thu, 23 Jul 2020 11:54:58 +0100
Message-ID: <20200723105459.5530-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007230082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the only way to remove MFD children is with a call to
mfd_remove_devices, which will remove all the children. Under
some circumstances it is useful to remove only a subset of the
child devices. For example if some additional clean up is required
between removal of certain child devices.

To accomplish this a level field is added to mfd_cell, the normal
mfd_remove_devices is modified to not remove devices that are set
to a higher level and a corresponding mfd_remove_devices_late
function is added to remove those children.

See further discussion at:
https://lore.kernel.org/lkml/20200616075834.GF2608702@dell/

Suggested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/mfd-core.c   | 16 +++++++++++++++-
 include/linux/mfd/core.h |  5 +++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index c51183209f82c..c3ef58a802bee 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -357,6 +357,7 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	struct platform_device *pdev;
 	const struct mfd_cell *cell;
 	struct mfd_of_node_entry *of_entry, *tmp;
+	int *level = data;
 
 	if (dev->type != &mfd_dev_type)
 		return 0;
@@ -364,6 +365,9 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	pdev = to_platform_device(dev);
 	cell = mfd_get_cell(pdev);
 
+	if (level && cell->level > *level)
+		return 0;
+
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
 
@@ -380,9 +384,19 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	return 0;
 }
 
+void mfd_remove_devices_late(struct device *parent)
+{
+	int level = MFD_DEP_LEVEL_HIGH;
+
+	device_for_each_child_reverse(parent, &level, mfd_remove_devices_fn);
+}
+EXPORT_SYMBOL(mfd_remove_devices_late);
+
 void mfd_remove_devices(struct device *parent)
 {
-	device_for_each_child_reverse(parent, NULL, mfd_remove_devices_fn);
+	int level = MFD_DEP_LEVEL_NORMAL;
+
+	device_for_each_child_reverse(parent, &level, mfd_remove_devices_fn);
 }
 EXPORT_SYMBOL(mfd_remove_devices);
 
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 6d68f44a26a1c..4b35baa14d308 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -46,6 +46,9 @@
 #define MFD_CELL_NAME(_name) \
 	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, 0, false, NULL)
 
+#define MFD_DEP_LEVEL_NORMAL 0
+#define MFD_DEP_LEVEL_HIGH 1
+
 struct irq_domain;
 struct property_entry;
 
@@ -63,6 +66,7 @@ struct mfd_cell_acpi_match {
 struct mfd_cell {
 	const char		*name;
 	int			id;
+	int			level;
 
 	int			(*enable)(struct platform_device *dev);
 	int			(*disable)(struct platform_device *dev);
@@ -150,6 +154,7 @@ static inline int mfd_add_hotplug_devices(struct device *parent,
 }
 
 extern void mfd_remove_devices(struct device *parent);
+extern void mfd_remove_devices_late(struct device *parent);
 
 extern int devm_mfd_add_devices(struct device *dev, int id,
 				const struct mfd_cell *cells, int n_devs,
-- 
2.11.0

