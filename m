Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96371C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D2224676
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgAVQql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:46:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:42798 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbgAVQq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:46:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 08:46:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="221278206"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jan 2020 08:46:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 42B204DB; Wed, 22 Jan 2020 18:46:20 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] platform/x86: intel_pmc_ipc: Switch to use driver->dev_groups
Date:   Wed, 22 Jan 2020 19:46:19 +0300
Message-Id: <20200122164619.73563-10-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122164619.73563-1-mika.westerberg@linux.intel.com>
References: <20200122164619.73563-1-mika.westerberg@linux.intel.com>
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
 drivers/platform/x86/intel_pmc_ipc.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 7b180ead064a..2433bf73f1ed 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -539,6 +539,11 @@ static const struct attribute_group intel_ipc_group = {
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
@@ -879,18 +884,10 @@ static int ipc_plat_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	ret = sysfs_create_group(&pdev->dev.kobj, &intel_ipc_group);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to create sysfs group %d\n",
-			ret);
-		goto err_sys;
-	}
-
 	ipcdev.has_gcr_regs = true;
 
 	return 0;
-err_sys:
-	devm_free_irq(&pdev->dev, ipcdev.irq, &ipcdev);
+
 err_irq:
 	platform_device_unregister(ipcdev.tco_dev);
 	platform_device_unregister(ipcdev.punit_dev);
@@ -901,7 +898,6 @@ static int ipc_plat_probe(struct platform_device *pdev)
 
 static int ipc_plat_remove(struct platform_device *pdev)
 {
-	sysfs_remove_group(&pdev->dev.kobj, &intel_ipc_group);
 	devm_free_irq(&pdev->dev, ipcdev.irq, &ipcdev);
 	platform_device_unregister(ipcdev.tco_dev);
 	platform_device_unregister(ipcdev.punit_dev);
@@ -916,6 +912,7 @@ static struct platform_driver ipc_plat_driver = {
 	.driver = {
 		.name = "pmc-ipc-plat",
 		.acpi_match_table = ACPI_PTR(ipc_acpi_ids),
+		.dev_groups = intel_ipc_groups,
 	},
 };
 
-- 
2.24.1

