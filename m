Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D5EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5A12080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgHLO5F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:57:05 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:41074 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLO5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:57:04 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2020 10:57:03 EDT
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 9226567A7D3;
        Wed, 12 Aug 2020 16:50:22 +0200 (CEST)
Received: from sntmail10s.snt-is.com (10.203.32.183) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 12 Aug
 2020 16:50:22 +0200
Received: from sntmail10s.snt-is.com ([fe80::ad9b:dbfd:621d:166f]) by
 sntmail10s.snt-is.com ([fe80::ad9b:dbfd:621d:166f%6]) with mapi id
 15.01.1913.007; Wed, 12 Aug 2020 16:50:22 +0200
From:   Michael Brunner <Michael.Brunner@kontron.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "dvhart@linux.intel.com" <dvhart@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>
Subject: [PATCH] mfd: Add ACPI support to Kontron PLD driver
Thread-Topic: [PATCH] mfd: Add ACPI support to Kontron PLD driver
Thread-Index: AQHWcLfnyQQDC2IYfEqK/svjxogCEQ==
Date:   Wed, 12 Aug 2020 14:50:22 +0000
Message-ID: <1e5ff295eacd5cb9eb2d888e1b0175fea62cf2ae.camel@kontron.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3-0ubuntu1 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <307F3267C7C19446BAE44972F391EFB5@snt-world.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 9226567A7D3.AAAD3
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: michael.brunner@kontron.com
X-SnT-MailScanner-To: dvhart@linux.intel.com, kevin.strasser@linux.intel.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, mibru@gmx.de, sameo@linux.intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent Kontron COMe modules identify the PLD device using the hardware
id KEM0001 in the ACPI table.
This patch adds support for probing the device using the HID and also
retrieving the resources.

As this is not available for all products, the DMI based detection still
needs to be around for older systems. It is executed if no matching ACPI
HID is found during registering the platform driver or no specific
device id is forced.
If a device is detected using ACPI and no resource information is
available, the default io resource is used.

Forcing a device id with the force_device_id parameter and therefore
manually generating a platform device takes precedence over ACPI during
probing.

Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
---
 drivers/mfd/kempld-core.c | 97 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index f48e21d8b97c..408cad1958d9 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -13,6 +13,7 @@
 #include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/acpi.h>
 
 #define MAX_ID_LEN 4
 static char force_device_id[MAX_ID_LEN + 1] = "";
@@ -132,6 +133,7 @@ static const struct kempld_platform_data kempld_platform_data_generic = {
 };
 
 static struct platform_device *kempld_pdev;
+static bool kempld_acpi_mode;
 
 static int kempld_create_platform_device(const struct dmi_system_id *id)
 {
@@ -434,13 +436,87 @@ static int kempld_detect_device(struct kempld_device_data *pld)
 	return ret;
 }
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id kempld_acpi_table[] = {
+	{ "KEM0001", (kernel_ulong_t)&kempld_platform_data_generic },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, kempld_acpi_table);
+
+static int kempld_get_acpi_data(struct platform_device *pdev)
+{
+	struct list_head resource_list;
+	struct resource *resources;
+	struct resource_entry *rentry;
+	struct device *dev = &pdev->dev;
+	struct acpi_device *acpi_dev = ACPI_COMPANION(dev);
+	const struct kempld_platform_data *pdata;
+	int ret;
+	int count;
+
+	pdata = acpi_device_get_match_data(dev);
+	ret = platform_device_add_data(pdev, pdata,
+				       sizeof(struct kempld_platform_data));
+	if (ret)
+		return ret;
+
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(acpi_dev, &resource_list, NULL, NULL);
+	if (ret < 0)
+		goto out;
+
+	count = ret;
+
+	if (count > 0) {
+		resources = devm_kcalloc(&acpi_dev->dev, count,
+					  sizeof(struct resource), GFP_KERNEL);
+		if (!resources) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		count = 0;
+		list_for_each_entry(rentry, &resource_list, node) {
+			memcpy(&resources[count], rentry->res,
+			       sizeof(*resources));
+			count++;
+		}
+		ret = platform_device_add_resources(pdev, resources, count);
+		if (ret)
+			goto out;
+	} else
+		ret = platform_device_add_resources(pdev, pdata->ioresource, 1);
+
+out:
+	acpi_dev_free_resource_list(&resource_list);
+
+	return ret;
+}
+#else
+static int kempld_get_acpi_data(struct platform_device *pdev)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_ACPI */
+
 static int kempld_probe(struct platform_device *pdev)
 {
-	const struct kempld_platform_data *pdata =
-		dev_get_platdata(&pdev->dev);
+	const struct kempld_platform_data *pdata;
 	struct device *dev = &pdev->dev;
 	struct kempld_device_data *pld;
 	struct resource *ioport;
+	int ret;
+
+	if (kempld_pdev == NULL) {
+		ret = kempld_get_acpi_data(pdev);
+		if (ret < 0)
+			return ret;
+		kempld_acpi_mode = true;
+	} else if (kempld_pdev != pdev) {
+		dev_notice(dev, "platform device exists - not using ACPI\n");
+		return -ENODEV;
+	}
+	pdata = dev_get_platdata(dev);
 
 	pld = devm_kzalloc(dev, sizeof(*pld), GFP_KERNEL);
 	if (!pld)
@@ -482,6 +558,7 @@ static int kempld_remove(struct platform_device *pdev)
 static struct platform_driver kempld_driver = {
 	.driver		= {
 		.name	= "kempld",
+		.acpi_match_table = ACPI_PTR(kempld_acpi_table),
 	},
 	.probe		= kempld_probe,
 	.remove		= kempld_remove,
@@ -800,6 +877,7 @@ MODULE_DEVICE_TABLE(dmi, kempld_dmi_table);
 static int __init kempld_init(void)
 {
 	const struct dmi_system_id *id;
+	int ret;
 
 	if (force_device_id[0]) {
 		for (id = kempld_dmi_table;
@@ -809,12 +887,19 @@ static int __init kempld_init(void)
 					break;
 		if (id->matches[0].slot == DMI_NONE)
 			return -ENODEV;
-	} else {
-		if (!dmi_check_system(kempld_dmi_table))
-			return -ENODEV;
 	}
 
-	return platform_driver_register(&kempld_driver);
+	ret = platform_driver_register(&kempld_driver);
+	if (ret)
+		return ret;
+
+	if (!kempld_pdev && !kempld_acpi_mode)
+		if (!dmi_check_system(kempld_dmi_table)) {
+			platform_driver_unregister(&kempld_driver);
+			return -ENODEV;
+		}
+
+	return 0;
 }
 
 static void __exit kempld_exit(void)
-- 
2.25.1

