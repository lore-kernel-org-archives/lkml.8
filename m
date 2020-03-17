Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322F8C0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A352051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbgCQBB3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 21:01:29 -0400
Received: from mail-oln040092255079.outbound.protection.outlook.com ([40.92.255.79]:6178
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733182AbgCQBB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 21:01:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkRS+v/u7qvwoOIh32E2WQL+f9+Pncu/1zYlA8bOyHk1I33RhkaS/he5ie0ZnSrSpSCa0O3uLuyzUiY2O6Cd5FvLKJpy9a+0fgD/p8wTKLnYGe2Zbm2nGoRHvBb+JJp57TvQucQz1icTWTpv2jDye+LwXBV1ZskZCWRLXPV8YOwdQNIhgkv0IDLaljxt1tYgmSFDwpPJLURp2+e6SrbZa/rjg9qovayfeFuDkWUiQxNx6AdRGrsAYGKVDp3XrB0kE2mWI9MksJ7UVncXSVU/pI6fo40khBDhaaqLV6fsY2QYvbBzh/nS6Mo+5s9AAj+Vo5EpoGD1xktY/aW1RkBKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C02RGu7cXDNwWaHUKiJI5wGaSdRt2guaLYrC6g56Nic=;
 b=fyEHiidSrRB5cEOheVSDHgaer0jO0Qu/HhW9W61t01sMrRogcDTufJl5v/TkWFyQR9Skor+KWSBz0PD7+XXEW6oHktQGEMw/1QP0jXY5poowuBZMinhdGqsCCHyVNpOfv9LvlbUhp4jzo8flGwNpCTO1fFFw9hgW1qHGaEHC9EPf+gAMrtFoWtmj5Ja9G3qeqcJdyNjtQVE3JsPQkeSD+IJXWhc4jVOIZhm1SMAWYff1vD6eyUt2W9TuvgbgfgCTgr4r3m98KsL7U4tRoQKppZ+49qqelYdFKGihkR2+dTbb/148yptG8JWYTqlQ43gRV8fkFlrBuo+80IB+6I2xdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT007.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::33) by
 PU1APC01HT015.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::401)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Tue, 17 Mar
 2020 01:01:22 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.51) by
 PU1APC01FT007.mail.protection.outlook.com (10.152.252.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 17 Mar 2020 01:01:22 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 01:01:22 +0000
Received: from nicholas-dell-linux (49.196.2.18) by ME2PR01CA0170.ausprd01.prod.outlook.com (2603:10c6:220:20::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13 via Frontend Transport; Tue, 17 Mar 2020 01:01:19 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v4 1/1] nvmem: Add support for write-only instances
Thread-Topic: [PATCH v4 1/1] nvmem: Add support for write-only instances
Thread-Index: AQHV+/eT1ILhhjOOiEKwHZ5sJhGkRg==
Date:   Tue, 17 Mar 2020 01:01:22 +0000
Message-ID: <PSXP216MB0438A934627303A4A0E2D96280F60@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0438DB7146E07670FCDC1A7280F60@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0170.ausprd01.prod.outlook.com
 (2603:10c6:220:20::14) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:959D4E28DC01424C06159A36CC99934C9B4F8D7D26CCC8570B805E76CC8F53F9;UpperCasedChecksum:A7AE4B7B60FEDAF4FF7FBFF0B0BFE05C4BE68A3039ABAFCB93AB060B3A61581A;SizeAsReceived:7693;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [FOEONMnbAQi8xxCn+WKydn8Mn/zReOyW]
x-microsoft-original-message-id: <20200317010113.GA3657@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: c8317731-648b-4ca5-7c19-08d7ca0eb54a
x-ms-exchange-slblob-mailprops: S/btQ8cKWiT4+P6zBac8z+2ZAfaAV2LWTDu+jEfDO/lqYDt8e96RilGgyrTv7luR8FEIY1L2MEIXSiMGYIKnfRoqq9huYzfMdvPYwH+7zKwlHc9RBWCkQJhJB8pd8ETF9cTY2C4NLm5OY8o5o89lOs6SD/7kfFY3opUiZqLxzAPNDjb7e1HiWhCnzg7RjLVFLRWMiFregmcaiHYz3aISEsYy2fc6antHWXQZF6wG90caKJ2y/niYjNIUJw/84+R7p4v64mYC/fptZdV7txW6mbaNB5/0xGAVkA4uKf3talEkkM0kkWdWvji3rDvTJoHAOueHQU4B1YGaRaUGTCo3s5CJCtm3gcCg2re+HlhcRO9qQzbXvL4P2G4XbrKqJ2OzbTY7hEE2ew81mBln1xJQX9l3Jfrg7pbghH0ZYD5Fj6pcExqsnoDnDaSb91oUvK7J3YE0ClTZf7Dt+Cq/JscXwH8O3DCH2mapf3vt+ispGCikCU+99BKlnQpPiDIu0fQxOYigcCwO8PnLxo3wpgNyEShOOTVHi9pgT3CBQ0jB2tcZZ11Q00Apf/l3q/7SyHhaEC6f1KOfEuDEMS2vXNVJ3ExyJA865/1FK9n5M/D3jBMSdJ5OVeNt2lrBzLbLEWFa9YghCX0mNRivpRIm+dlYiONW2rEGpFodBk5m78SD2rInX2eE2HHgtU8zk8nTVoi4M0dg6p7Mrnyir7AJwKIscFFO/VsJMyQTASNjTuuCsV7YUV9eBGiCdAQS5JHYQTeAANXV9U81Pyk=
x-ms-traffictypediagnostic: PU1APC01HT015:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lBeHve/AeTIRpGhWtbQGyyurnSvh9xSQU8z1nBq7EWtesk9FwpI2C5UFyunGN9c6DnRT86tSbT7MGNfo1w8ZfTgeLOoGG8WKxew7Z4cGjBzinFugZyp16W6OApwOr4DVWZp0vsI8NnldilEE0UgJ+nkpdgRcU8sFDM4+eVpAlSSpEeOtQjUlrRf4bpPEAMIv
x-ms-exchange-antispam-messagedata: iLl+vsU0CeVhyIwsyc4nf/wG/hC8HjqunUe9PHV2lDEeROAfv4MULhg21GMWcgla9TGMnpimgcVfkECabnaWiuHoWJyXXBBMKVlIbV/gz1J21gQj+UObe264FzjF/mFCffgveMbOm2BNjFAFz3Bd+g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9438F17E605CC840A47244F1FD2F6BC7@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c8317731-648b-4ca5-7c19-08d7ca0eb54a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 01:01:22.1512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT015
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
 drivers/nvmem/core.c        |  9 ++++--
 drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
 2 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ef326f243..95ea9a3b2 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -373,6 +373,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
+	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
+	if (!nvmem->dev.groups) {
+		kfree(nvmem);
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (!config->no_of_node)
 		nvmem->dev.of_node = config->dev->of_node;
 
@@ -387,8 +393,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->read_only = device_property_present(config->dev, "read-only") ||
 			   config->read_only || !nvmem->reg_write;
 
-	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
-
 	device_initialize(&nvmem->dev);
 
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
@@ -430,7 +434,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	device_del(&nvmem->dev);
 err_put_device:
 	put_device(&nvmem->dev);
-
 	return ERR_PTR(rval);
 }
 EXPORT_SYMBOL_GPL(nvmem_register);
diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
index 9e0c429cd..4ceac8680 100644
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
+
+	/* Write-only, do not honour request for global writable entry */
+	if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
+		return config->root_only ? nvmem_wo_root_dev_groups : NULL;
 
-	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
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
+			return -EINVAL;
+	} else if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only) {
 		if (config->root_only)
 			nvmem->eeprom = bin_attr_rw_root_nvmem;
 		else
 			nvmem->eeprom = bin_attr_rw_nvmem;
-	}
+	} else
+		return -EINVAL;
+
 	nvmem->eeprom.attr.name = "eeprom";
 	nvmem->eeprom.size = nvmem->size;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.25.1

