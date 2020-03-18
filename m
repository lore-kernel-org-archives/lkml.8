Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570C8C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DA120757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCRPUU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:20:20 -0400
Received: from mail-oln040092253104.outbound.protection.outlook.com ([40.92.253.104]:56672
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgCRPUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMa3BMMAdor6V6AIBbW0O9otcb+MPJEiCNFt5S9ZaCamKVkccikgIUrFvOo5+4q/YYxp/1HX9Z70R06LK9tTtglu6qfk6/Sic3/xQEpUXGZZmSELY7XPvDucwocQ1mm1DyZUxb7ecdHvDZwliBFQqBcQaqo8H1dvZIH+oIhEyeDy3lq1bQA4dmas+t6p6s0VZ/gF0DctwvoNJa0JIPkd/GZneOJlxDllvz5SPsFhDNEpNCmHNmNL9twZZPBoAvvrHrPPw01yWMDG4la/G0ViuPsGPI9wDRIVDsXIUZ7+fmZ60q4F1HwmfcttavBxpHCOhEwosrmPB3ss5Q1FoT7NWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhT2QzgTw+SZY1tfB19iiVUOoYEZbNhfwgPh65646Og=;
 b=bywXrRanJHdTzEmnmLcpB7UjVJwZueMfXM7Gvohms/iAxv5FVXQzGqVlTZADdddPN1bKiotMu/6N6laENN3fmTScCchZo59epdSXuKjAKoxr87Zf/SND0ByHzLupJQFAjQOS4sNYIplcqDis52VsaYjL2IwQdTv6UWuWXhpt2SM+zEzVhpM5wSbQIRX/twDBukkSo2LIyicp4nGXwj35FikNEAHY6D2LoRvwoXoN0FLMXcxfG5hfY5tlWTT6fhEsstLIzDBSNLfBmr/pDn25xsKTenJcNzSVHlCR7lHCw9LX+aNivHG4eGJevhzcRn95WAFKXZuVAZa+HYoUlkvvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT043.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::38) by
 SG2APC01HT223.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::455)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Wed, 18 Mar
 2020 15:20:14 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.52) by
 SG2APC01FT043.mail.protection.outlook.com (10.152.251.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Wed, 18 Mar 2020 15:20:14 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 15:20:14 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by SYAPR01CA0032.ausprd01.prod.outlook.com (2603:10c6:1:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Wed, 18 Mar 2020 15:20:12 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v5 1/1] nvmem: Add support for write-only instances
Thread-Topic: [PATCH v5 1/1] nvmem: Add support for write-only instances
Thread-Index: AQHV/Ti5/5HmN58Klk+BmJ/8dKaxkg==
Date:   Wed, 18 Mar 2020 15:20:14 +0000
Message-ID: <PSXP216MB0438D2F2D9B648BAF9A007A580F70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0438BB51FBB5964FAD7E180F80F70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYAPR01CA0032.ausprd01.prod.outlook.com (2603:10c6:1:1::20)
 To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:A917091032D81CEA7161B9DBB5D4D12B892983B3099EA5B62CBE9EF556397F95;UpperCasedChecksum:1D95521DBE0B5E117C9DF5FDF336D546A02FC1B3E3994C5667CE16E29E43AFEA;SizeAsReceived:7791;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [h1wa7IFlac0dKRx9tKJLdvpPdOgrF6m3CjmDs9iLh+aWzzyaUK0d4uSb977by4VZ]
x-microsoft-original-message-id: <20200318152007.GA11592@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: bd8f60e9-f6e6-404d-7ef0-08d7cb4fdb49
x-ms-exchange-slblob-mailprops: gjx25WM8ZNUV2AKzJQ6OV4uUyVXNy2PhljYSKzdk+nqjZV1PDIm9Kjd8bFFdJjlP9hVJBoEizv4EyJsSVlr706Tx4f4AX89iE+dM+On+JNYEqjtqTYd/EQ7IciklBBmKF53SAAKOBeu17MeHE5IXNL8R6ry3EqcBqp/x+eZz+BM1fnXrGljNqtPCjoZKlFbDkkwgslYKAm/yzqnnNRrXs6aV2IB/rBdLABAOAHEm4aHBYNW6/aCSDw5RXf2ZLkxH6NqODam9ZHp9HLzxGlkzvY7H9toMStlT7UTrXuyBpfxakobm5WH4IWJDwZuApXxEktT8rxkO46zrBgmLpfMSoGwaFZA8/0khaRRzn0Cg4PTnPnZFuKZ/UGdoApIY0KGdDmRqar8v5hx91zxcAQTptvb9jmkjV5aZK4zPwTLAB16TshFwDdFdrxt/Y2tGDQLzp7hy1+9px0NVrvpqVxbikjwgSvXh5B58G0fF/c7Skg61XkdN8pnW2Lf4flQXNRn1yy/2T9dkhy15n5GjT6RDvYf47tfebB+WnyHTgnP2Da+o5b8z23hjW2wqb4onSatb+A96bFOPK7RGRR1WRPLb3kOL3+RFXT30bWQNlfNb6eSzQGI8VNdNujzWN8SujGZ/kxPleaSODVC2SjE8Ximy1Tci+VRnUolVmIfvv+d2QXYkIlm1UKwTZuDzWeC4VSUWrnxqWkGWwvtqs+nL8gY1pp7yb/OKvTX9S+tII5J+vXY=
x-ms-traffictypediagnostic: SG2APC01HT223:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: inG4he+NSgjP5pOn6gIi5N6SdL5pF0lS9cM/pOLcxCJBnzkRoZnqtd8Yz09U4ghPx6oDKKnB0qm0UqMNT8EIm3+TNW8Pyf3yyYijsbHx4kX76BwZ0SfcV0kcNvzGjhQm1Jy6QwV/c+MwqKvPDZy7ZyJVGizNm64RKIfLA3tB2avFkR8HPbqv6XOuHL8UQLin
x-ms-exchange-antispam-messagedata: jWsNppZsbvdbLPjoLV0fn6aM26NQaCkjHJ8pKTfQlkxxWnPTmALubxoFcX9lnGlRaFcAtbQCFX5vKT+S37J+OqdNbkbu2b779GBx/LGoVCeNvvy8pf52nh7y+Hu28ToaBGn9fQOEB9WJh5xplyMlH0coZvlRRCtK7MqzMrDEEikme7M6tI4RzOzEJDu26YdioUMFm1MB7sXjEw3Guu2hsw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3FAC74599C2575479A869AA3928D93A5@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8f60e9-f6e6-404d-7ef0-08d7cb4fdb49
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 15:20:14.3084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT223
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
 drivers/nvmem/core.c        | 10 +++++--
 drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
 2 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 77d890d36..ddc7be514 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -381,6 +381,14 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
+	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
+	if (!nvmem->dev.groups) {
+		ida_simple_remove(&nvmem_ida, nvmem->id);
+		gpiod_put(nvmem->wp_gpio);
+		kfree(nvmem);
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (!config->no_of_node)
 		nvmem->dev.of_node = config->dev->of_node;
 
@@ -395,8 +403,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->read_only = device_property_present(config->dev, "read-only") ||
 			   config->read_only || !nvmem->reg_write;
 
-	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
-
 	device_initialize(&nvmem->dev);
 
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
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

