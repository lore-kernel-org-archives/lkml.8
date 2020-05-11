Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B462AC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB2A20714
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VWotyhs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgEKPxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:53:38 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:46878 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbgEKPxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:53:38 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BFpaMA011362;
        Mon, 11 May 2020 10:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=t8/6a9cE+7oEin+6y+ogXtOUTDjHx8K5ZIqGw9pID8s=;
 b=VWotyhs0f4zRkwDavn30vv/Q7ge2S7yVjDXPzpm9+fuVfDeq/OVcXyqFhtAO35i6hFuU
 SjLNLd7wmkYNm/g1IcPiqhe2E8upB7dRJmkgPDK4YB+mtoMsEodjL+QhCdHSp4jFd847
 rLaCJhNSEwa+GG5IXzdmGsh1PJSshXdj46e7dakeiAWnx9iapAyukCVaB6XJ9KCC8qNj
 KDBFmQqVFf4Bn6nERnx80Gmkxs0vBNpTFj+dsBezQQ0Cpln8TrlPgO96pcNV8FfnXjVa
 jktLV9x4Vd/r2bKvDVEiwD12gDJBjsDR4s4Eq45mHNHqyBcEBF5UkjZiBtZJGWzBqcoc lw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30wrxq2ynd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 May 2020 10:53:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 11 May
 2020 16:53:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 11 May 2020 16:53:33 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 815572C5;
        Mon, 11 May 2020 15:53:33 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <broonie@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] mfd: mfd-core: Add mechanism for removal of a subset of children
Date:   Mon, 11 May 2020 16:53:32 +0100
Message-ID: <20200511155333.2183-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 mlxlogscore=921 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110125
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

Following on from our discussions here:

https://lore.kernel.org/lkml/20200122110842.10702-2-ckeepax@opensource.cirrus.com/#t

Happy to discuss other approaches as well, but this one was quite
appealing as it was very simple but affords quite a lot of flexibility.

Thanks,
Charles


 drivers/mfd/mfd-core.c   | 11 +++++++++++
 include/linux/mfd/core.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index f5a73af60dd40..83a57186169de 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -287,6 +287,7 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 {
 	struct platform_device *pdev;
 	const struct mfd_cell *cell;
+	int tag = (int)data;
 
 	if (dev->type != &mfd_dev_type)
 		return 0;
@@ -294,6 +295,9 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	pdev = to_platform_device(dev);
 	cell = mfd_get_cell(pdev);
 
+	if (tag && cell->tag != tag)
+		return 0;
+
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
 
@@ -301,6 +305,13 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	return 0;
 }
 
+void mfd_remove_devices_by_tag(struct device *parent, int tag)
+{
+	device_for_each_child_reverse(parent, (void *)tag,
+				      mfd_remove_devices_fn);
+}
+EXPORT_SYMBOL(mfd_remove_devices_by_tag);
+
 void mfd_remove_devices(struct device *parent)
 {
 	device_for_each_child_reverse(parent, NULL, mfd_remove_devices_fn);
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index d01d1299e49dc..f68d668b2cb7c 100644
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

