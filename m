Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC03C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FA020873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgCIRuW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:50:22 -0400
Received: from mail-oln040092255014.outbound.protection.outlook.com ([40.92.255.14]:9111
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbgCIRuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:50:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B72Q3TcKTQT6lwv8cuwLzDLkMSHPGL8skN3ueut3wdg/dn1kt4i6s1cdAiQZA1ZNvFiXPj8gCyy4qzkgoUXtnZQToimMMKYUXUqNbjuKM+ovORc+SD5gbWxpGo8t+qEF2IRoAx0zDk2DqIi08CmBbV1o5Us2oniRJ78ZoSpWQJS6DrpTaGcaCz87Bh/Mja5LUf8WY0OFtgRMgIUKyzsaWXcCcaj3WCaPoCAFtblJ0RS6TKdjxH//6k644rh37shz9YNWzrHh8aBWzk5VY+GiFjTxmZvgP7h/KxqewWVMT9f8BL4fn4NXcvetqLKX6loP8RUr/Yme7/WtKtzvUQbBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSlpoxBrB+sPO8hefRLhzDfeT1m8GIaA/JJ6+0upxIA=;
 b=k1glzX/xjUug9Xk6HANfJaF+1GEn7E9aGXQoLzN8PWxg5zl1/k6yM8sU0dwyIDOtHVwfaPqqK9z6qQQ+kCLW5TD0Mbn2jktDHXhSrNv13vzUUYQXQCr88nh0eClg+UQNxnqMmC3L9afAqv8mXJ2Po9Vub/Yj459lpdce9SNYv7CuLg6W5ofYxd4k2yCf+Wd6MC8WDtIqYnZjTCFf22ZSmro6HIMOCeugJLrepUgKtX/qvcJZPbk5V8JX0qa/nu2sO1fltAJtzoYqjzYwSGvXZhBl5fjuJlGWH6Sp71zXZPA49X9gNwJ14ht73C0Hf09dV1aJrBosYRr70WNsoXzljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT045.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::37) by
 HK2APC01HT131.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::313)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Mon, 9 Mar
 2020 17:50:17 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.57) by
 HK2APC01FT045.mail.protection.outlook.com (10.152.249.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Mon, 9 Mar 2020 17:50:17 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 17:50:17 +0000
Received: from nicholas-dell-linux (2001:44b8:605f:11:6375:33df:328c:d925) by MEAPR01CA0028.ausprd01.prod.outlook.com (2603:10c6:201::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend Transport; Mon, 9 Mar 2020 17:50:15 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v3 2/2] nvmem: Add support for write-only instances
Thread-Topic: [PATCH v3 2/2] nvmem: Add support for write-only instances
Thread-Index: AQHV9jsxJuscDJGSJEm8fhjJto18yA==
Date:   Mon, 9 Mar 2020 17:50:17 +0000
Message-ID: <PSXP216MB0438EF52E2F4E58264ADBB8A80FE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0438614877E3559E155F12AF80FE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEAPR01CA0028.ausprd01.prod.outlook.com (2603:10c6:201::16)
 To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:6A2524395A83F96FBF0513AD96EB6CF9282099E5125CC17FC95D449A569BC91D;UpperCasedChecksum:7CEC5552BAB2AD28747E753BB290D00BE1F878063D02DA75232AFD04C73BA2CA;SizeAsReceived:7784;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [6ePlG3xGP4IHsIgg5wawgYDEsTCOgPfddZqqZmhVh7E/k6mV0fy8BO2nCTATIh9u]
x-microsoft-original-message-id: <20200309175009.GA1910@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: f5a8c521-4c01-4fda-f9d5-08d7c45253bc
x-ms-exchange-slblob-mailprops: q+fD6XS3/UJ22ZsMdvjPR/nPh8/NcaD7oKXiUwFPnvhizUR3QYJi4Rk50l1uZMR6WdIrJgrqxuSN/NFqMcoE/paos01f59sUM25/aKNsxPVyx1o7PcNyJlZPzK7gaBjlqXeh3QnzXBuZ4drwAW/Qe+VNTuy7oIcTS/tkfGyno7q0kcAMKJHejH2nYMoQdV9nHafagTECq1uekByYb/l0qwo+TTZWrx70lvrMH3q35Ul8A1QfyptV/9EyvkKWDFW+KBT2nNr7J1niBn5WHr1Kh/TYamsmk2r64k5kBf5oUN6UAnw0JmpesYLQmFvz0Pus/P0PLn/wOkrCN2rdyAve9eZU0TAQbrdnb4oEAAB3uHP19P2MR9/yUpVxJ08MB/pB5MpkEOW/2UJG17Y/RRNSP4wt/dQv4JgNmZbe+PPaSS0URaxA8uUdQAZ955wIQ/qYFwV/bWbYHjiHqu8ysVvEPOn9c+Xpnom3A7yJdBr2FWvryKtM7MNbRWnCK1LMvbEGN3Qusohxc9bMUQvei7lbqqBbwc9+ZV5d5R+qbJqO5pE8Wlxw/jo2e2yiyP0nkEFy+jhkzYo2sCj7UjzlQeJczOLvViRx8QrGevAAdfjHclMzaFj2cIjwPRIHoYCvKwSc42JYzpHdsHqaiJSb1Vgo8QCs7PYRdgREYBPi83I5jkmlzJ4stXNcDtrZrCxr+QlwGjvf519JjIwKOBwWecA02g==
x-ms-traffictypediagnostic: HK2APC01HT131:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JPG29gphA/xSV9smhu1OOEajTjLCJsN0MX2AGk7pYUAceS4kJkqHoRPQkkGui/LOn/Xqb6KyElYfkN/E/Gr7jXfIOG7f1pMjADSQ18BbOnZW20aV3C8EhB2oNw/+TgJ+J4fN6JpW5wqilFyAk3SmBoq9A/nSCHZuFK298NasbdfNtZ2hdSxI5t41jQtGOzDp
x-ms-exchange-antispam-messagedata: 9y+6La7fKfYPMaBJhWVBhQj8uS4jZw/Lskk8yNQMNI8wp2rVRx8h0bX1GaZF5Q0J6GPNnjy7g6Sffi4nVM2p89c9ipFkMFyQTyRiQuqh2XwDKsc4fEKYQw8S+u5E2wvvb0xZQ/KVD9e+sJgypwywY8DAtrEoD8FQ+K3+/fXgSQmhigevmD48ty4v31Id01T/gdJG9N2FkdEHIEZpuhc5fA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBA5ECDEAE85444CAFA42782FC970AF7@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a8c521-4c01-4fda-f9d5-08d7c45253bc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 17:50:17.1078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is at least one real-world use-case for write-only nvmem
instances. Refer to 03cd45d2e219 ("thunderbolt: Prevent crash if
non-active NVMem file is read").

Add support for write-only nvmem instances by adding attrs for 0200.

Change nvmem_register() to abort if NULL group is returned from
nvmem_sysfs_get_groups().

Return NULL from nvmem_sysfs_get_groups() in invalid cases.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
index 9e0c429cd..846112786 100644
--- a/drivers/nvmem/nvmem-sysfs.c
+++ b/drivers/nvmem/nvmem-sysfs.c
@@ -196,16 +196,49 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
 	NULL,
 };
 
+/* write only permission, root only */
+static struct bin_attribute bin_attr_wo_root_nvmem = {
+	.attr	= {
+		.name	= "nvmem",
+		.mode	= 0200,
+	},
+	.write	= bin_attr_nvmem_write,
+};
+
+static struct bin_attribute *nvmem_bin_wo_root_attributes[] = {
+	&bin_attr_wo_root_nvmem,
+	NULL,
+};
+
+static const struct attribute_group nvmem_bin_wo_root_group = {
+	.bin_attrs	= nvmem_bin_wo_root_attributes,
+	.attrs		= nvmem_attrs,
+};
+
+static const struct attribute_group *nvmem_wo_root_dev_groups[] = {
+	&nvmem_bin_wo_root_group,
+	NULL,
+};
+
 const struct attribute_group **nvmem_sysfs_get_groups(
 					struct nvmem_device *nvmem,
 					const struct nvmem_config *config)
 {
-	if (config->root_only)
-		return nvmem->read_only ?
-			nvmem_ro_root_dev_groups :
-			nvmem_rw_root_dev_groups;
+	/* Read-only */
+	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only))
+		return config->root_only ?
+			nvmem_ro_root_dev_groups : nvmem_ro_dev_groups;
+
+	/* Read-write */
+	if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
+		return config->root_only ?
+			nvmem_rw_root_dev_groups : nvmem_rw_dev_groups;
 
-	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
+	/* Write-only, do not honour request for global writable entry */
+	if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
+		return config->root_only ? nvmem_wo_root_dev_groups : NULL;
+
+	return NULL;
 }
 
 /*
@@ -224,17 +257,24 @@ int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
 	if (!config->base_dev)
 		return -EINVAL;
 
-	if (nvmem->read_only) {
+	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only)) {
 		if (config->root_only)
 			nvmem->eeprom = bin_attr_ro_root_nvmem;
 		else
 			nvmem->eeprom = bin_attr_ro_nvmem;
-	} else {
+	} else if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only) {
+		if (config->root_only)
+			nvmem->eeprom = bin_attr_wo_root_nvmem;
+		else
+			return -EPERM;
+	} else if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only) {
 		if (config->root_only)
 			nvmem->eeprom = bin_attr_rw_root_nvmem;
 		else
 			nvmem->eeprom = bin_attr_rw_nvmem;
-	}
+	} else
+		return -EPERM;
+
 	nvmem->eeprom.attr.name = "eeprom";
 	nvmem->eeprom.size = nvmem->size;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.25.1

