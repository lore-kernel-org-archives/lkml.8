Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6D0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC602063A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ZU2pVzId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgFOPH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:07:27 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:35236 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729875AbgFOPHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:07:25 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FEpMFg014369;
        Mon, 15 Jun 2020 10:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=PODMain02222019;
 bh=gUyddzAs7v14zyMh/f7mEeuz5DmqI0hsy+b9vsJ0dts=;
 b=ZU2pVzIdps4VewCAt9339qi+j3ot9mO2GsQ8miBUj8FK+qEgaSnwgqAHTahqjkNpaBOB
 JADlPYUP9JURdHOa0CXwEas4ycmDdVU6anj/JB6KNUBzW1zr8tbBpNegf22X23W4szcq
 vrm6+EvGUvAW2wjjMs1trSKGdXPFtrSDQD+yDFKAuX57mXdQE9BC1gCeVRS7IwiTn2Bu
 ntnUwyStrlJ2E2En7y08/sAZvYOiZmW3qvTZJZBgAmEp0ucKvmc0uAKhBksw5xbmynVw
 Bhk+NAZ2zI6TxkCh6tcQfTq3dJKCLugXIyWcEZP7lMZ3csxQEHASekoCn1/bp0UbD0nO mg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 31mu7p2tj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Jun 2020 10:07:23 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 15 Jun
 2020 16:07:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 15 Jun 2020 16:07:22 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2159E2D4;
        Mon, 15 Jun 2020 15:07:22 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v2 1/2] mfd: mfd-core: Add mechanism for removal of a subset of children
Date:   Mon, 15 Jun 2020 16:07:21 +0100
Message-ID: <20200615150722.5249-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=933
 malwarescore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006150121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the only way to remove MFD children is with a call to
mfd_remove_devices, which will remove all the children. Under
some circumstances it is useful to remove only a subset of the
child devices. For example if some additional clean up is required
between removal of certain child devices.

To accomplish this a tag field is added to mfd_cell, and a
corresponding mfd_remove_devices_by_tag function is added to
remove children with a specific tag. This allows a good amount of
flexibility in which child devices a driver wishes to remove, as a
driver could target specific drivers or a large group. Allowing other
use-cases such as removing drivers for functionality that is no longer
required.

Some investigation was done of using the mfd_cell name and id fields,
but it is hard to achieve a good level of flexibility there, at least
without significant complexity. Since the id gets modified by the core
and can even by automatically generated. Using the name alone would
work for my usecase but it is not hard to imagine a situation where it
wouldn't.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Following on from our discussions here:                                                                                                                                                                                                        │··················
                                                                                                                                                                                                                                               │··················
https://lore.kernel.org/lkml/20200122110842.10702-2-ckeepax@opensource.cirrus.com/#t                                                                                                                                                           │··················
                                                                                                                                                                                                                                               │··················
Happy to discuss other approaches as well, but this one was quite                                                                                                                                                                              │··················
appealing as it was very simple but affords quite a lot of flexibility.                                                                                                                                                                        │··················


Changes since v1:
 - Use a pointer to pass the tag to mfd_remove_devices_fn

Thanks,
Charles

 drivers/mfd/mfd-core.c   | 10 ++++++++++
 include/linux/mfd/core.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index f5a73af60dd40..5cfff376051e1 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -287,6 +287,7 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 {
 	struct platform_device *pdev;
 	const struct mfd_cell *cell;
+	int *tag = data;
 
 	if (dev->type != &mfd_dev_type)
 		return 0;
@@ -294,6 +295,9 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	pdev = to_platform_device(dev);
 	cell = mfd_get_cell(pdev);
 
+	if (tag && cell->tag != *tag)
+		return 0;
+
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
 
@@ -301,6 +305,12 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	return 0;
 }
 
+void mfd_remove_devices_by_tag(struct device *parent, int tag)
+{
+	device_for_each_child_reverse(parent, &tag, mfd_remove_devices_fn);
+}
+EXPORT_SYMBOL(mfd_remove_devices_by_tag);
+
 void mfd_remove_devices(struct device *parent)
 {
 	device_for_each_child_reverse(parent, NULL, mfd_remove_devices_fn);
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index ab76cdd061993..47d1b257461ab 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -58,6 +58,7 @@ struct mfd_cell_acpi_match {
 struct mfd_cell {
 	const char		*name;
 	int			id;
+	int			tag;
 
 	int			(*enable)(struct platform_device *dev);
 	int			(*disable)(struct platform_device *dev);
@@ -135,6 +136,7 @@ static inline int mfd_add_hotplug_devices(struct device *parent,
 }
 
 extern void mfd_remove_devices(struct device *parent);
+extern void mfd_remove_devices_by_tag(struct device *parent, int tag);
 
 extern int devm_mfd_add_devices(struct device *dev, int id,
 				const struct mfd_cell *cells, int n_devs,
-- 
2.11.0

