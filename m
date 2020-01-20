Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1A2C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC697217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgATQIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:08:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:12598 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729225AbgATQIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:08:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 08:08:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="426796852"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jan 2020 08:08:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2475934C; Mon, 20 Jan 2020 18:08:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 7/9] platform/x86: surface3_wmi: Switch DMI table match to a test of variable
Date:   Mon, 20 Jan 2020 18:07:59 +0200
Message-Id: <20200120160801.53089-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120160801.53089-1-andriy.shevchenko@linux.intel.com>
References: <20200120160801.53089-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have a common x86 quirk that provides an exported variable,
use it instead of local DMI table match.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/surface3-wmi.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/surface3-wmi.c b/drivers/platform/x86/surface3-wmi.c
index 130b6f52a600..5eeedc4ddb8a 100644
--- a/drivers/platform/x86/surface3-wmi.c
+++ b/drivers/platform/x86/surface3-wmi.c
@@ -11,9 +11,9 @@
 #include <linux/slab.h>
 
 #include <linux/acpi.h>
-#include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/mutex.h>
+#include <linux/platform_data/x86/machine.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
@@ -29,18 +29,6 @@ MODULE_LICENSE("GPL");
 
 MODULE_ALIAS("wmi:" SURFACE3_LID_GUID);
 
-static const struct dmi_system_id surface3_dmi_table[] = {
-#if defined(CONFIG_X86)
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
-		},
-	},
-#endif
-	{ }
-};
-
 struct surface3_wmi {
 	struct acpi_device *touchscreen_adev;
 	struct acpi_device *pnp0c0d_adev;
@@ -201,7 +189,7 @@ static int __init s3_wmi_probe(struct platform_device *pdev)
 {
 	int error;
 
-	if (!dmi_check_system(surface3_dmi_table))
+	if (!x86_microsoft_surface_3_machine)
 		return -ENODEV;
 
 	memset(&s3_wmi, 0, sizeof(s3_wmi));
-- 
2.24.1

