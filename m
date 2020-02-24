Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4182C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A893620838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgBXRmi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:42:38 -0500
Received: from mail-oln040092253021.outbound.protection.outlook.com ([40.92.253.21]:42816
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727421AbgBXRmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:42:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOzHRtiyyzEOoqk15S1a+RHMuZtaeIzLfft7oYXw9QLfUQ3NI+YZOz521XbHxJR3aFvPDMg5x2wrTp52JxruAty/YOrhcxRqQPVP+X4LSIOnh6idUhTm+S6W4C+Z7HujqwzBZx5kJWvmvsXAq2fSPa1RrK/Z2FPVooGZdnzFssc9ahi5HThZRU+VKOgZDCFTbMQyNGZX1KjNzC8lvVHMaA1ZbH1PXv0qWCpZUyuDil+R1ECPXnTAnSCVG4HnfuwdL4WZZ+rgAOk0ouXVCd+85N4n7Ar3vO1nFwpMCye7eXa6OM7R/2n1i8VWuPFy1sbiMkwJS6SkujNhMmFgGchmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQQ1MbgzLk6OJjXQXg1CEV1Ps3++1JxUMkTZHDJ2GQo=;
 b=WzKgNkSMfPDoBY6HVT+OtSG19KTL9b/7mfg6Uu8fz++KA/YSPHw7g+57NdmQVkaBPSmb5cqBNT87ADDr21WVsCA2ER/9sXqmPGHQPw0q9aXM5kzyBccjOAQ6NuTVaN9Sn1gUURByCHaagtyyO7X4K9uD8opPTkZyCFrZyZF5eBOa8doYKho3tdypDWxyhTmPsCASnCVTGGEtoyt3fsiZ9o3sf6FaYFQZ+MK+0wO1NybZ2KKQ7QBEu6Jsk3HHTGa/p6SCsq9XoezK9HdCRXs1BYQF8j8o0YuQELnJywkrLyjM6W8lHgxYhWvrf0vgsuqWs2eFiZvgpGNT6dzhD4f63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT063.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::3b) by
 SG2APC01HT026.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::446)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.19; Mon, 24 Feb
 2020 17:42:33 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.56) by
 SG2APC01FT063.mail.protection.outlook.com (10.152.251.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 17:42:33 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 17:42:33 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by ME2PR01CA0155.ausprd01.prod.outlook.com (2603:10c6:201:2f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 17:42:32 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 1/3] nvmem: Add support for write-only instances
Thread-Topic: [PATCH v1 1/3] nvmem: Add support for write-only instances
Thread-Index: AQHV6znL/WLrUn36h0+sGzQwuak0Ig==
Date:   Mon, 24 Feb 2020 17:42:33 +0000
Message-ID: <PSXP216MB043820B6E11AE4E78374C7F980EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0155.ausprd01.prod.outlook.com
 (2603:10c6:201:2f::23) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:5E2FEE37FDD5DBC3ABD9FF28531A504030A152DF49A88C9F3411F8777106DFE4;UpperCasedChecksum:81D698B80E6501CD21FDBD010919E50DB12BA1D85BE0506073BEAEC941344C5D;SizeAsReceived:7813;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [HXA3aeNpUxRW5fWZlM+I9kQvTPW0+zj+waUDl8Hx8PYZoN/EWVDoeiCssNsrzZSI]
x-microsoft-original-message-id: <20200224174227.GA3675@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 8c7ffb3a-6591-4684-a4c8-08d7b950eda8
x-ms-exchange-slblob-mailprops: gjx25WM8ZNX0Yn+GlkLgg++2GZLLkjhCtcYbHZF+SDLj8eNSPN3zOxvIdyHQAF62T0H6zFM2Ngz/5yAbnZNin+HDUbD0SZQILMsfGQjivIUElptlq4sX8DeFW1C3RogBSN7NK43zqoDmKaxyALocYmuJeUVS2dvThHiYoN8iPEsale/GrQ6LmBbNCsAd7YuVWxG0BadwxpessBYNYi8CdB+ffghG3aO3lY1PIrBOnW/qld/teXTj6kRXF5U8NvgEVcJyksiJl38Dtyoy3TmhPLP5JMzSQlv3OkCFI2RVL0fmzGftSrZOE8BqARgnDlR1ugyI2lPk7/5IJ0MK/HWzf2Eq6ys5PnvJtPdJ3L/7o+gXJO9emWVoipeytoWisyrPBSDRb2ZmYbfCdD+NNJnUPK1HhPsD2DiwzfdVcVtz99+k8dUY9eSdQOLZVzxav1HDgcHOQgUmc8dKqGDphm42naNh/Ds/XoshtDvsGUUCw8DBNq92bebOLqzZxmZtfcOznaKjAGCwEcmhAgIbA7xj65iywvGFEX+sE7l0+GhbtckMK3bafNfuBYiG4Kfj/CkaYJjsK2C8g3gQRIexVcfA/E+kCfWpabL/wSxtpRUJNabCtLhkuTS6wJVC/bfdDvJIwYpZEQ4gJCIb20cw9vifzvhzioqEG8qp6/wPVS4lZBKwTwSYDdNnIDHLnc8hEie9jkX/ON6hDt/nIVMvB1jPCJGkC2zMbNVwgoNWoy705VU=
x-ms-traffictypediagnostic: SG2APC01HT026:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yuh0iaSpjQsBqHTVBHgni+XEOUws3g6zhrsJKKnWc2yBy/M5Rd4fxQ3ecMurr+vrCxsG0JnqnRcR1t6BXr43i1584jESt5Bn3COg5DdzAVGJfmNPeYXVU5vKGfRTW1F04hTua9PWJaT2chYTnoG8kYPcvnCGPcQGC0JQQoy0AdRL5hm+t1GSm7VIBtJvB1di
x-ms-exchange-antispam-messagedata: VRlLUtag0mHuJ7sg0Egw4Fi8mWShd5nc6w8mozaElIJCSvrFp8OKQ/6IESWAPYpSfVhJ/so9EF9HOJ0BLtYX/FWSvdlUJ6L3IHzLavTevnJa+OKURi5j/y/6ZoSxQblk9DRTzPTAW3MJaiBaD5X0QJIQFJK0CiDt17iCRkJDK3mm2m/S1Ekljc3IMtO/Ab+Q0Yt78Ywq32Gr+4kmc3Tw3A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <77564AC01D391D448B0A457D220B70A5@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7ffb3a-6591-4684-a4c8-08d7b950eda8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 17:42:33.5667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Westerberg requires write-only nvmem for the Thunderbolt driver.
Refer to 03cd45d2e219 ("thunderbolt: Prevent crash if non-active NVMem
file is read"). Hence, there is at least one real-world use for
write-only nvmem instances.

Add support for write-only nvmem instances by changing the nvmem attrs
to 0222 if the .reg_read callback is not populated.

Add a WARN_ON in case a driver populates neither .reg_read nor
.reg_write because this behaviour should clearly never occur.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/nvmem/nvmem-sysfs.c | 77 +++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
index 9e0c429cd..be3b94f0b 100644
--- a/drivers/nvmem/nvmem-sysfs.c
+++ b/drivers/nvmem/nvmem-sysfs.c
@@ -147,6 +147,30 @@ static const struct attribute_group *nvmem_ro_dev_groups[] = {
 	NULL,
 };
 
+/* write only permission */
+static struct bin_attribute bin_attr_wo_nvmem = {
+	.attr	= {
+		.name	= "nvmem",
+		.mode	= 0222,
+	},
+	.write	= bin_attr_nvmem_write,
+};
+
+static struct bin_attribute *nvmem_bin_wo_attributes[] = {
+	&bin_attr_wo_nvmem,
+	NULL,
+};
+
+static const struct attribute_group nvmem_bin_wo_group = {
+	.bin_attrs	= nvmem_bin_wo_attributes,
+	.attrs		= nvmem_attrs,
+};
+
+static const struct attribute_group *nvmem_wo_dev_groups[] = {
+	&nvmem_bin_wo_group,
+	NULL,
+};
+
 /* default read/write permissions, root only */
 static struct bin_attribute bin_attr_rw_root_nvmem = {
 	.attr	= {
@@ -196,16 +220,50 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
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
-
-	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
+	/*
+	 * If neither reg_read nor reg_write are provided, we cannot use this
+	 * nvmem entry, as any operation will cause kernel mode NULL reference.
+	 */
+	WARN_ON(!nvmem->reg_read && !nvmem->reg_write);
+
+	if (nvmem->reg_read && nvmem->reg_write)
+		return config->root_only ?
+			nvmem_rw_root_dev_groups : nvmem_rw_dev_groups;
+
+	if (nvmem->reg_read && !nvmem->reg_write)
+		return config->root_only ?
+			nvmem_ro_root_dev_groups : nvmem_ro_dev_groups;
+
+	return config->root_only ?
+		nvmem_wo_root_dev_groups : nvmem_wo_dev_groups;
 }
 
 /*
@@ -224,11 +282,16 @@ int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
 	if (!config->base_dev)
 		return -EINVAL;
 
-	if (nvmem->read_only) {
+	if (nvmem->reg_read && !nvmem->reg_write) {
 		if (config->root_only)
 			nvmem->eeprom = bin_attr_ro_root_nvmem;
 		else
 			nvmem->eeprom = bin_attr_ro_nvmem;
+	} else if (!nvmem->reg_read && nvmem->reg_write) {
+		if (config->root_only)
+			nvmem->eeprom = bin_attr_wo_root_nvmem;
+		else
+			nvmem->eeprom = bin_attr_wo_nvmem;
 	} else {
 		if (config->root_only)
 			nvmem->eeprom = bin_attr_rw_root_nvmem;
-- 
2.25.1

