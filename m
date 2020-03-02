Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0E8C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E41B222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCBPml convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:42:41 -0500
Received: from mail-oln040092253011.outbound.protection.outlook.com ([40.92.253.11]:6182
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727407AbgCBPmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:42:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eu96xXdnGNXvr6IdVLKrcNo/dL6IKd6Qj5mG3kZxtJMcRilW5dvoyO4X9znWtgdRKkh+159dK96SdUSWdDL5G2or1eA9p/3Z2Lqtvmnm6ZrRxTYaZJ6BR8udRW7aMcJsPPK1YZ4ssQ9k/DbGJnn+IA8rfBzGngZE4f555LUcxMIP9oAoLwsoVRoX90mMgVwHjRQxgtVN2HAxTIbe5aMvmpMCS5ra9Nc51G556eu1+IEw/HolqCymb6kk5PEhjzw1tahnkViefNjR6UiC0a7nMkzAY27Ch+fJYDHPks52HDx+9nV+euDgXqYvH/JKi7wqBDVPp0EAohzUd096PCC4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYtowb9+Ullj2M1uv1jXOw4L+VWGtADYKz7o6ZvE75I=;
 b=LVzKr7mxjuniuF2o/SWig0dMSrS+sn6WomkXFSsNMn/RRC8KsjzORzf+f86+GfqYfWmAaj+Mm8n/56gEcNSJ5y2Z6gmK8Av6VQ1T2wTw03iBup+ctKg9Ii7UZHBFZ70ZYCSlmv6focyWqV7s5qnpgIwEDz+8v8qAIkI9s2812WKAoQ/l5ljrEqS2xlwswXhOR0RJS7QPG40LjF6L2vZQzAOuMt+kB7abLb8Z8UZl0A3f0FJH0sV8jP9ysoXcClaSmzlS3ZYyPw4NuwBnV5HmHy1BaD370A/lDc0mEBBcwSNiW7vt/UaoradfTmG0gUdPcR42kphAuplYsUNyWfbUbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT111.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::3c) by
 PU1APC01HT238.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::449)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 15:42:34 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.54) by
 PU1APC01FT111.mail.protection.outlook.com (10.152.252.236) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 15:42:34 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 15:42:34 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:44cc:a624:8145:fa79) by ME2PR01CA0066.ausprd01.prod.outlook.com (2603:10c6:201:2b::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 15:42:32 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 1/3] nvmem: Add support for write-only instances
Thread-Topic: [PATCH v2 1/3] nvmem: Add support for write-only instances
Thread-Index: AQHV8KkxXdrLTxYhU0iNsiLC1KLatw==
Date:   Mon, 2 Mar 2020 15:42:34 +0000
Message-ID: <PSXP216MB0438930B1FC30EF79F15FD1780E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0438FE68DAAFC23CB9AAD5E180E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0066.ausprd01.prod.outlook.com
 (2603:10c6:201:2b::30) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:1D69E5E86D08E5CE96CC82BAC60CFBA750E491E14BCD01DFCC7294E6CE8F875A;UpperCasedChecksum:3FD8DA9CFFC61089773B005CA77A50849166B5D5E68AA0783AF424B738FD7A0D;SizeAsReceived:7800;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [pfYjh1WR1BZS+6mZwieJqUMAJ+HXqvRdUwVUbCwrjccnshfHVq29yOlFAZpQP3gG]
x-microsoft-original-message-id: <20200302154227.GA480962@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 6c240aa6-3173-41b5-3cc2-08d7bec05386
x-ms-exchange-slblob-mailprops: gjx25WM8ZNWYKaTQvYk/UtONeFal8oaUNZI/HkFRNrR33q31c7duxzaGctdAwA3O8vIIzArerEUbX+TFZHYzxFxqvxOlA+iZoNoCmOGtbrMqgFkTC+lJ4/EIwl0RNKVzhpsAzDQgeBR3F5Y/eQqSJp/vsImnpPKEIfsjxtV3v5OAsPeFdgy8+Jy5IrmposNAiDCo2iHCeY9y0onNNg/gx0Ctp1smdmcHPo0G5//Y2T0Mic9781KfX8nj6ksbf5o3avhvPn8yHf8pee+lFHivrTqOkZrkoOFiCqliWRIW9Eif3bbFNkqoXlrn9QE01EShYxCw/9maqL9XWWTXfXNbCMgDC1mCAL0JXfMPYfVBKQSL2ilUK1DhOUmakERqsFgMeYDRSqlicPc7txCXvXFlUgBsU0qCVp+txrKoO+EFOrDi4Wg50X8e6eAkPwYUX8KE7wnYCpHkGJ0eW9bQjXKz6Dq7jdUDY9uR1W+lwI2Ex5/WCsvkuo704g8DSfTgxqWvcwKdOC/UhZ2frl771b2k4YvKnAcJPC76UPe4A2d9FbCzxWFerBue7+wLdL21ag7eZr76ksPOqJ6PbIulgOqbetyfnjulnaQQ8u1O0u8Bj7+B+ClcApB9FGYA3kSExfejdTgHmAdAzVwU4US5fo0IQeBdJngjeo3leJkimMsDc/uhO6YgaRU5qycrO/49CKf/HMMzEiDznEPtCMJT+EanDzHa70nkRytgjigLu+wLlBo=
x-ms-traffictypediagnostic: PU1APC01HT238:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fUB4sd2iqfnk780PFibW5IEQGZNbuBT83AYMRxFZqAmyv3Iw9typxQIiN4wFYD7VnooM/SLv6q/VT1LK8dD8ovUhsWboZuifK3amjqQ6FFpLi1evLrb5GNMsRGeOVzQuZk79IqKBdEFM2NgVJdabT4OJpKgYJIQM4Ulm4Q273nTfESR5dtF1RdCD0+WyiT8h
x-ms-exchange-antispam-messagedata: AcKr+nV2rbjlNwBCrWdn5HrRc+OGTOuS3WiDgy+3+KUBdeacUVhkSdhpw0KZWCeWydqREKEFDJ5+uaI7vqkOW47lvGe5PIfBR1uvavEh8oxbxUC6U7puR2T1tI1ocARZauIP8XgNqXZ4ew56a59m5MJZ/60kw1xrCssYlbd0AjwhP5qYxKkikbtbrMt2b3JIvEm/FqjtQhrcRdD3yKlseQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <258C4A77CD0E704DA0F560BB3459A2CA@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c240aa6-3173-41b5-3cc2-08d7bec05386
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 15:42:34.3797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT238
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
 drivers/nvmem/core.c        |  2 ++
 drivers/nvmem/nvmem-sysfs.c | 53 ++++++++++++++++++++++++++++++++-----
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ef326f243..27bd4c4e3 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -388,6 +388,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			   config->read_only || !nvmem->reg_write;
 
 	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
+	if (!nvmem->dev.groups)
+		return NULL;
 
 	device_initialize(&nvmem->dev);
 
diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
index 9e0c429cd..00d3259ea 100644
--- a/drivers/nvmem/nvmem-sysfs.c
+++ b/drivers/nvmem/nvmem-sysfs.c
@@ -196,16 +196,50 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
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
+	/* Read-only */
+	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only))
+		return config->root_only ?
+			nvmem_ro_root_dev_groups : nvmem_ro_dev_groups;
+
+	/* Read-write */
+	if (nvmem->reg_read && nvmem->reg_write)
+		return config->root_only ?
+			nvmem_rw_root_dev_groups : nvmem_rw_dev_groups;
+
+	/* Write-only, do not honour request for global writable entry */
+	if (!nvmem->reg_read && nvmem->reg_write)
+		return config->root_only ? nvmem_wo_root_dev_groups : NULL;
+
+	/* Neither reg_read nor reg_write are provided, abort */
+	return NULL;
 }
 
 /*
@@ -224,11 +258,16 @@ int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
 	if (!config->base_dev)
 		return -EINVAL;
 
-	if (nvmem->read_only) {
+	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only)) {
 		if (config->root_only)
 			nvmem->eeprom = bin_attr_ro_root_nvmem;
 		else
 			nvmem->eeprom = bin_attr_ro_nvmem;
+	} else if (!nvmem->reg_read && nvmem->reg_write) {
+		if (config->root_only)
+			nvmem->eeprom = bin_attr_wo_root_nvmem;
+		else
+			return -EPERM;
 	} else {
 		if (config->root_only)
 			nvmem->eeprom = bin_attr_rw_root_nvmem;
-- 
2.25.1

