Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D5FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AB424691
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgAUQBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:01:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:18291 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729501AbgAUQBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:01:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 08:01:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="221744525"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jan 2020 08:01:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3CBF91182; Tue, 21 Jan 2020 18:01:16 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 35/38] platform/x86: intel_pmc_ipc: Switch to use driver->dev_groups
Date:   Tue, 21 Jan 2020 19:01:11 +0300
Message-Id: <20200121160114.60007-36-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core provides support for adding additional attributes for
devices via new ->dev_groups member of struct device_driver. Convert the
driver to use that instead of adding the attributes manually.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index eb4d65768531..c006609ef74b 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -253,6 +253,11 @@ static const struct attribute_group intel_ipc_group = {
 	.attrs = intel_ipc_attrs,
 };
 
+static const struct attribute_group *intel_ipc_groups[] = {
+	&intel_ipc_group,
+	NULL
+};
+
 static struct resource punit_res_array[] = {
 	/* Punit BIOS */
 	{
@@ -597,28 +602,13 @@ static int ipc_plat_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = sysfs_create_group(&pdev->dev.kobj, &intel_ipc_group);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to create sysfs group %d\n",
-			ret);
-		goto err_devs;
-	}
-
 	ipcdev.has_gcr_regs = true;
 
 	return 0;
-
-err_devs:
-	platform_device_unregister(ipcdev.tco_dev);
-	platform_device_unregister(ipcdev.punit_dev);
-	platform_device_unregister(ipcdev.telemetry_dev);
-
-	return ret;
 }
 
 static int ipc_plat_remove(struct platform_device *pdev)
 {
-	sysfs_remove_group(&pdev->dev.kobj, &intel_ipc_group);
 	platform_device_unregister(ipcdev.tco_dev);
 	platform_device_unregister(ipcdev.punit_dev);
 	platform_device_unregister(ipcdev.telemetry_dev);
@@ -632,6 +622,7 @@ static struct platform_driver ipc_plat_driver = {
 	.driver = {
 		.name = "pmc-ipc-plat",
 		.acpi_match_table = ACPI_PTR(ipc_acpi_ids),
+		.dev_groups = intel_ipc_groups,
 	},
 };
 
-- 
2.24.1

